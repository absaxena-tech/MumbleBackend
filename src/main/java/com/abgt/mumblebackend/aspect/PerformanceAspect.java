package com.abgt.mumblebackend.aspect;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.*;
import org.springframework.stereotype.Component;

@Aspect
@Component
public class PerformanceAspect {
    @Around("execution(* com.abgt.mumblebackend.service.*.*(..))")
    public Object measureExecutionTime(ProceedingJoinPoint jp) throws Throwable {
        long start = System.currentTimeMillis();
        Object result = jp.proceed(); //method call
        long end = System.currentTimeMillis();

        System.out.println(jp.getSignature().getName() + " Executed in " +(end - start) + "ms");

        return result;
    }
}
