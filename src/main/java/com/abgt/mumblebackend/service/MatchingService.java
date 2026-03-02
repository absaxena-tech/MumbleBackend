package com.abgt.mumblebackend.service;

import com.abgt.mumblebackend.repository.MumbleRepository;
import com.abgt.mumblebackend.model.MumbleModel;

import org.springframework.stereotype.Service;

import java.util.Arrays;
import java.util.Set;
import java.util.stream.Collectors;

@Service
public class MatchingService {

    private final MumbleRepository mumbleRepository;

    public MatchingService(MumbleRepository mumbleRepository) {
        this.mumbleRepository = mumbleRepository;
    }

    public double calculateMatch(Long user1Id, Long user2Id) {

        MumbleModel user1 = mumbleRepository.findById(user1Id)
                .orElseThrow(() -> new RuntimeException("User1 not found"));

        MumbleModel user2 = mumbleRepository.findById(user2Id)
                .orElseThrow(() -> new RuntimeException("User2 not found"));

        // Convert interests into cleaned sets
        Set<String> interests1 = Arrays.stream(user1.getInterests().split(","))
                .map(String::trim)
                .map(String::toLowerCase)
                .filter(s -> !s.isEmpty())
                .collect(Collectors.toSet());

        Set<String> interests2 = Arrays.stream(user2.getInterests().split(","))
                .map(String::trim)
                .map(String::toLowerCase)
                .filter(s -> !s.isEmpty())
                .collect(Collectors.toSet());

        // Avoid division by zero
        if (interests1.isEmpty() && interests2.isEmpty()) {
            return 0.0;
        }

        // Find common interests
        Set<String> common = interests1.stream()
                .filter(interests2::contains)
                .collect(Collectors.toSet());

        // Create union set
        Set<String> union = interests1.stream()
                .collect(Collectors.toSet());
        union.addAll(interests2);

        double score = ((double) common.size() / union.size()) * 100;

        // Round to 2 decimal places
        return Math.round(score * 100.0) / 100.0;
    }
}