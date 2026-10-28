package com.example.dto;

public record UserResponse(
        int userId,
        String userName,
        String userEmail,
        String userFname,
        String userLname) {
}
