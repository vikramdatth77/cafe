package com.example.studentapi;

import java.util.Map;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class RootController {

	@GetMapping("/")
	public Map<String, Object> home() {
		return Map.of(
				"service", "student-api",
				"students", "/students");
	}

}
