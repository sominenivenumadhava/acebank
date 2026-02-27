package com.acebank.lite.models;

public record User(
                Integer userId,
                String firstName,
                String lastName,
                String aadhaarNo,
                String email,
                String phoneNumber,
                String passwordHash,
                String transactionPin,
                java.time.LocalDateTime createdAt) {
}