package com.abgt.mumblebackend.aspect;

import com.abgt.mumblebackend.model.MumbleModel;
import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.*;
import org.springframework.stereotype.Component;

@Aspect
@Component
public class ValidationAspect {

    @Before("execution(* com.abgt.mumblebackend.controller.MumbleController.createUser(..))")
    public void validateUser(JoinPoint joinPoint) {

        Object[] args = joinPoint.getArgs();

        if (args.length > 0 && args[0] instanceof MumbleModel user) {

            if (user.getName() == null || user.getName().isBlank()) {
                throw new RuntimeException("Name cannot be empty");
            }

            if (user.getInterests() == null || user.getInterests().isBlank()) {
                throw new RuntimeException("Interests cannot be empty");
            }
        }
    }
}