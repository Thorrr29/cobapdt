CREATE DATABASE IF NOT EXISTS cobapdt;
USE cobapdt;

CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50),
    password VARCHAR(100),
    role ENUM('admin','student') NOT NULL DEFAULT 'student'
);

CREATE TABLE courses (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(100)
);

CREATE TABLE enrollments (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    course_id INT,
    status ENUM('pending', 'paid') DEFAULT 'pending'
);

CREATE TABLE payments (
    id INT AUTO_INCREMENT PRIMARY KEY,
    enrollment_id INT,
    amount DECIMAL(10,2),
    paid_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
