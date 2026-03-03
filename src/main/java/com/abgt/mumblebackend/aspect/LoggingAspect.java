package com.abgt.mumblebackend.aspect;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.*;
import org.hibernate.mapping.Join;
import org.springframework.stereotype.Component;

import java.util.Arrays;

@Aspect
@Component
public class LoggingAspect {

    @Before("execution(* com.abgt.mumblebackend.service.*.*(..))")
    public void logBefore(JoinPoint jp){
        System.out.println("Method Called: "+jp.getSignature().getName());
        System.out.println("Arguments: "+Arrays.toString(jp.getArgs()));
    }

    @AfterReturning(pointcut = "execution(* com.abgt.mumblebackend.service.*.*(..))",
            returning = "result")
    public void logAfterReturning(JoinPoint joinPoint, Object result) {
        System.out.println("Method Completed: " + joinPoint.getSignature().getName());
        System.out.println("Returned Value: " + result);
    }

}
