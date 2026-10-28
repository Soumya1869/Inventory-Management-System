package com.example.dto;

import java.util.List;

public record InventoryDashboardResponse(
        int productCount,
        long totalStockUnits,
        int lowStockThreshold,
        int lowStockCount,
        List<ProductSummary> products
) {
    public record ProductSummary(
            int productId,
            String productName,
            String categoryName,
            double sellingPrice,
            long quantityOnHand,
            boolean lowStock
    ) {}
}
