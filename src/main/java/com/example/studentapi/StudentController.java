package com.example.studentapi;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/students")
public class StudentController {

	private final Map<Integer, Student> students = new ConcurrentHashMap<>();

	public StudentController() {
		// Sample rows so GET /students is not empty on a fresh run (in-memory only).
		students.put(1, new Student(1, "Ravi", 20));
		students.put(2, new Student(2, "Priya", 21));
		students.put(3, new Student(3, "Amit", 23));
	}

	@GetMapping
	public List<Student> getAll() {
		return new ArrayList<>(students.values());
	}

	@PostMapping
	public Student create(@RequestBody Student student) {
		students.put(student.id(), student);
		return student;
	}

}
