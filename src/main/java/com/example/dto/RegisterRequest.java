package com.example.dto;

import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;

public record RegisterRequest(
        @NotBlank @Size(max = 50) String userName,
        @NotBlank @Size(min = 12, max = 72) String password,
        @NotBlank @Email @Size(max = 254) String userEmail,
        @Size(max = 100) String userFname,
        @Size(max = 100) String userLname) {
}
