package com.example.Controllers;

import com.example.model.Student;
import com.example.repository.StudentRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
public class StudentController {

    private final StudentRepository studentRepository;

    @Autowired
    public StudentController(StudentRepository studentRepository) {
        this.studentRepository = studentRepository;
    }

    @GetMapping
    @RequestMapping("api/homescreen")
    public String homescreen() {
        System.out.println("Welcome to homescreen");
        return "Welcome to Student Managment System";
    }

    @GetMapping
    @RequestMapping("api/getall")
    public List<Student> single() {
        //to get all the rows from the database
        return studentRepository.findAll();
    }

    @PostMapping
    @RequestMapping("api/addstudents")
    public void addStudents() {
        //dummy objects
        Student shivam = new Student("Shivam", "Bhilarkar", "shivam@gmail.com", 23);
        Student vaishnavi = new Student("Vaishnavi", "Bhilarkar", "vaishnavi@gmail.com", 23);
        Student manish = new Student("Manish", "Jadhav", "manish@gmail.com", 23);

        //use the JPA inbuilt method to save list
        studentRepository.saveAll(List.of(shivam, vaishnavi, manish));
    }

    @GetMapping
    @RequestMapping("api/getsingle")
    public Object getsingle() {
        //find by Id inbuild method
        return studentRepository.findById((long) 1);
    }


}
