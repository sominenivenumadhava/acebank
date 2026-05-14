package com.acebank.lite.util;

import lombok.extern.java.Log;

import java.net.URI;
import java.net.URLEncoder;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.nio.charset.StandardCharsets;
import java.util.Base64;
import java.util.concurrent.CompletableFuture;

@Log
public class SmsUtil {

    public static void sendSmsAsync(String toPhoneNumber, String messageBody) {
        CompletableFuture.runAsync(() -> {
            try {
                sendSms(toPhoneNumber, messageBody);
            } catch (Exception e) {
                log.warning("Background SMS failed: " + e.getMessage());
            }
        });
    }

    public static boolean sendSms(String toPhoneNumber, String messageBody) {
        String accountSid = ConfigLoader.getProperty(ConfigKeys.TWILIO_ACCOUNT_SID);
        String authToken = ConfigLoader.getProperty(ConfigKeys.TWILIO_AUTH_TOKEN);
        String fromPhoneNumber = ConfigLoader.getProperty(ConfigKeys.TWILIO_PHONE_NUMBER);

        if (accountSid == null || accountSid.isEmpty() || accountSid.contains("your_twilio")) {
            log.warning("Twilio credentials not configured in application-dev.properties. Simulating SMS to " + toPhoneNumber + ": " + messageBody);
            return false; // Skip actual sending if not configured
        }

        try {
            // Assume Indian number if no country code provided
            if (!toPhoneNumber.startsWith("+")) {
                toPhoneNumber = "+91" + toPhoneNumber;
            }

            String url = "https://api.twilio.com/2010-04-01/Accounts/" + accountSid + "/Messages.json";

            String formData = "To=" + URLEncoder.encode(toPhoneNumber, StandardCharsets.UTF_8)
                    + "&From=" + URLEncoder.encode(fromPhoneNumber, StandardCharsets.UTF_8)
                    + "&Body=" + URLEncoder.encode(messageBody, StandardCharsets.UTF_8);

            String authString = accountSid + ":" + authToken;
            String encodedAuth = Base64.getEncoder().encodeToString(authString.getBytes(StandardCharsets.UTF_8));

            HttpClient client = HttpClient.newHttpClient();
            HttpRequest request = HttpRequest.newBuilder()
                    .uri(URI.create(url))
                    .header("Authorization", "Basic " + encodedAuth)
                    .header("Content-Type", "application/x-www-form-urlencoded")
                    .POST(HttpRequest.BodyPublishers.ofString(formData))
                    .build();

            HttpResponse<String> response = client.send(request, HttpResponse.BodyHandlers.ofString());

            if (response.statusCode() == 201) {
                log.info("SMS sent successfully to " + toPhoneNumber);
                return true;
            } else {
                log.severe("Failed to send SMS. Status: " + response.statusCode() + ", Response: " + response.body());
                return false;
            }
        } catch (Exception e) {
            log.severe("Exception while sending SMS: " + e.getMessage());
            return false;
        }
    }
}
