package com.abgt.mumblebackend.controller;

import com.abgt.mumblebackend.model.MumbleModel;
import com.abgt.mumblebackend.repository.MumbleRepository;
import com.abgt.mumblebackend.service.MatchingService;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/users")
public class MumbleController {

    private final MumbleRepository mumbleRepository;
    private final MatchingService matchingService;

    public MumbleController(MumbleRepository mumbleRepository,
                            MatchingService matchingService) {
        this.mumbleRepository = mumbleRepository;
        this.matchingService = matchingService;
    }

    @PostMapping
    public MumbleModel createUser(@RequestBody MumbleModel user) {
        return mumbleRepository.save(user);
    }

    @GetMapping
    public List<MumbleModel> getAllUsers() {
        return mumbleRepository.findAll();
    }

    @DeleteMapping("/{id}")
    public String deleteUser(@PathVariable Long id) {

        if (!mumbleRepository.existsById(id)) {
            throw new RuntimeException("User not found with id: " + id);
        }

        mumbleRepository.deleteById(id);

        return "User deleted successfully with id: " + id;
    }

    @GetMapping("/match")
    public String matchUsers(@RequestParam Long user1,
                             @RequestParam Long user2) {

        return matchingService.calculateMatch(user1, user2);
    }
}