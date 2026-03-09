package com.abgt.mumblebackend.service;

import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import java.util.HashMap;
import java.util.Map;

@Service
public class OllamaService {

    private final RestTemplate restTemplate = new RestTemplate();

    public String compareInterests(String name1, String interest1,
                                   String name2, String interest2) {

        String prompt = """
            You are an AI that evaluates compatibility between two people based on their interests.

            Person 1:
            Name: %s
            Interests: %s

            Person 2:
            Name: %s
            Interests: %s

            Analyze their interests and determine their compatibility.

            Return the result in the format:

            Compatibility Score: <percentage>

            Explanation: Explain briefly why %s and %s are compatible or not.
            """.formatted(name1, interest1, name2, interest2, name1, name2);

        Map<String, Object> request = new HashMap<>();
        request.put("model", "llama3");
        request.put("prompt", prompt);
        request.put("stream", false);

        Map response = restTemplate.postForObject(
                "http://localhost:11434/api/generate",
                request,
                Map.class
        );

        return response.get("response").toString();
    }
}