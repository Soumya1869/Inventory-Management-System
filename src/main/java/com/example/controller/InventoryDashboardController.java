package com.example.controller;

import com.example.dto.InventoryDashboardResponse;
import com.example.service.InventoryDashboardService;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/dashboard")
public class InventoryDashboardController {
    private final InventoryDashboardService dashboardService;

    public InventoryDashboardController(InventoryDashboardService dashboardService) {
        this.dashboardService = dashboardService;
    }

    @GetMapping("/summary")
    public InventoryDashboardResponse getSummary() {
        return dashboardService.getSummary();
    }
}
