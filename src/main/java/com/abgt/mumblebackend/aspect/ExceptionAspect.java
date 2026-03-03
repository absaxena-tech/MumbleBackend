package com.abgt.mumblebackend.aspect;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.*;
import org.springframework.stereotype.Component;

@Aspect
@Component
public class ExceptionAspect {

    @AfterThrowing(
            pointcut = "execution(* com.abgt.mumblebackend.service.*.*(..))",
            throwing = "ex")
    public void logException(JoinPoint joinPoint, Exception ex) {

        System.out.println("Exception in method: " +
                joinPoint.getSignature().getName());

        System.out.println("Exception message: " + ex.getMessage());
    }
}