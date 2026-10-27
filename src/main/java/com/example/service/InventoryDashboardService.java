package com.example.service;

import com.example.dto.InventoryDashboardResponse;
import com.example.entity.Product;
import com.example.entity.Stock;
import com.example.repository.ProductRepository;
import com.example.repository.StockRepository;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class InventoryDashboardService {
    private final ProductRepository productRepository;
    private final StockRepository stockRepository;
    private final int lowStockThreshold;

    public InventoryDashboardService(
            ProductRepository productRepository,
            StockRepository stockRepository,
            @Value("${inventory.low-stock-threshold:10}") int lowStockThreshold
    ) {
        this.productRepository = productRepository;
        this.stockRepository = stockRepository;
        this.lowStockThreshold = Math.max(0, lowStockThreshold);
    }

    @Transactional(readOnly = true)
    public InventoryDashboardResponse getSummary() {
        List<Product> products = new java.util.ArrayList<>();
        productRepository.findAll().forEach(products::add);

        Map<Integer, Long> quantitiesByProduct = new HashMap<>();
        stockRepository.findAll().forEach(stock -> {
            if (stock.getProduct() != null) {
                quantitiesByProduct.merge(
                        stock.getProduct().getProductId(),
                        (long) stock.getQuantity(),
                        Long::sum
                );
            }
        });

        List<InventoryDashboardResponse.ProductSummary> summaries = products.stream()
                .filter(product -> product.getProductIsService() == 0)
                .map(product -> {
                    long quantity = quantitiesByProduct.getOrDefault(product.getProductId(), 0L);
                    String categoryName = product.getCategory() == null
                            ? "Uncategorized"
                            : product.getCategory().getCategoryName();
                    return new InventoryDashboardResponse.ProductSummary(
                            product.getProductId(),
                            product.getProductName(),
                            categoryName == null ? "Uncategorized" : categoryName,
                            product.getProductsellingPrice(),
                            quantity,
                            quantity < lowStockThreshold
                    );
                })
                .sorted(Comparator.comparing(InventoryDashboardResponse.ProductSummary::productName,
                        Comparator.nullsLast(String.CASE_INSENSITIVE_ORDER)))
                .toList();

        long totalStockUnits = summaries.stream()
                .mapToLong(InventoryDashboardResponse.ProductSummary::quantityOnHand)
                .sum();
        int lowStockCount = (int) summaries.stream()
                .filter(InventoryDashboardResponse.ProductSummary::lowStock)
                .count();

        return new InventoryDashboardResponse(
                summaries.size(),
                totalStockUnits,
                lowStockThreshold,
                lowStockCount,
                summaries
        );
    }
}
