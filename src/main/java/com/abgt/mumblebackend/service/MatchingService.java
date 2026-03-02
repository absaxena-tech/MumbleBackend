package com.abgt.mumblebackend.service;


import com.abgt.mumblebackend.repository.MumbleRepository;
import com.abgt.mumblebackend.model.MumbleModel;

import org.springframework.stereotype.Service;

import java.util.Arrays;
import java.util.HashSet;
import java.util.Set;

@Service
public class MatchingService {
    private final MumbleRepository mumbleRepository;
    public MatchingService(MumbleRepository mumbleRepository){
        this.mumbleRepository=mumbleRepository;
    }

    public double calculateMatch(Long user1Id, Long user2Id){
        MumbleModel user1 = mumbleRepository.findById(user1Id).orElseThrow();
        MumbleModel user2 = mumbleRepository.findById(user2Id).orElseThrow();

        Set<String> interests1 = new HashSet<>(Arrays.asList(user1.getInterests().split(",")));
        Set<String> interests2 = new HashSet<>(Arrays.asList(user2.getInterests().split(",")));

        Set<String> common = new HashSet<>(interests1);
        common.retainAll(interests2);

        Set<String> all = new HashSet<>(interests1);
        all.addAll(interests2);

        return ((double) common.size() / all.size()) * 100;
    }
}
