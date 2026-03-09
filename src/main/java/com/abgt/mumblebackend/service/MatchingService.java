package com.abgt.mumblebackend.service;

import com.abgt.mumblebackend.model.MumbleModel;
import com.abgt.mumblebackend.repository.MumbleRepository;
import org.springframework.stereotype.Service;

@Service
public class MatchingService {

    private final MumbleRepository mumbleRepository;
    private final OllamaService ollamaService;

    public MatchingService(MumbleRepository mumbleRepository,
                           OllamaService ollamaService) {
        this.mumbleRepository = mumbleRepository;
        this.ollamaService = ollamaService;
    }

    public String calculateMatch(Long user1Id, Long user2Id) {

        MumbleModel user1 = mumbleRepository.findById(user1Id)
                .orElseThrow(() -> new RuntimeException("User 1 not found"));

        MumbleModel user2 = mumbleRepository.findById(user2Id)
                .orElseThrow(() -> new RuntimeException("User 2 not found"));

        return ollamaService.compareInterests(
                user1.getName(),
                user1.getInterests(),
                user2.getName(),
                user2.getInterests()
        );
    }
}