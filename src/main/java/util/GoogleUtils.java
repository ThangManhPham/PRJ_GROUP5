/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package util;


import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import entity.GoogleAccount;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
/**
 *
 * @author HP
 */
public class GoogleUtils {

    public GoogleAccount verifyToken(String idToken) {

        try {

            String link = "https://oauth2.googleapis.com/tokeninfo?id_token=" + idToken;

            URL url = new URL(link);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();

            conn.setRequestMethod("GET");

            BufferedReader reader = new BufferedReader(
                    new InputStreamReader(conn.getInputStream())
            );

            StringBuilder response = new StringBuilder();
            String line;

            while ((line = reader.readLine()) != null) {
                response.append(line);
            }

            ObjectMapper mapper = new ObjectMapper();
            JsonNode node = mapper.readTree(response.toString());

            GoogleAccount account = new GoogleAccount();

            account.setId(node.get("sub").asText());
            account.setEmail(node.get("email").asText());
            account.setName(node.get("name").asText());
            account.setPicture(node.get("picture").asText());

            return account;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }
}
