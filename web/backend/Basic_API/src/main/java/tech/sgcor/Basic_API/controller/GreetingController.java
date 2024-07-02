package tech.sgcor.Basic_API.controller;

import jakarta.servlet.http.HttpServletRequest;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import tech.sgcor.Basic_API.dto.GreetingResponse;
import tech.sgcor.Basic_API.service.GreetingService;

@RestController
@RequestMapping("/api/hello")
public class GreetingController {
    private final GreetingService greetingService;

    public GreetingController (GreetingService greetingService) {
        this.greetingService = greetingService;
    }
    @GetMapping()
    public ResponseEntity<GreetingResponse> sayHello(@RequestParam String visitors_name, HttpServletRequest request) {
        return ResponseEntity.ok(greetingService.sayHello(visitors_name, request));
    }
}
