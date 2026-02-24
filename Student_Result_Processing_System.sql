
-- ============================================
-- STUDENT RESULT PROCESSING SYSTEM (MySQL)
-- ============================================

CREATE DATABASE IF NOT EXISTS student_result_db;
USE student_result_db;

CREATE TABLE Students (
    student_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    department VARCHAR(50),
    admission_year INT
);

CREATE TABLE Courses (
    course_id INT PRIMARY KEY AUTO_INCREMENT,
    course_name VARCHAR(100),
    credits INT
);

CREATE TABLE Semesters (
    semester_id INT PRIMARY KEY AUTO_INCREMENT,
    semester_name VARCHAR(50)
);

CREATE TABLE Grades (
    grade_id INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT,
    course_id INT,
    semester_id INT,
    marks INT,
    FOREIGN KEY (student_id) REFERENCES Students(student_id),
    FOREIGN KEY (course_id) REFERENCES Courses(course_id),
    FOREIGN KEY (semester_id) REFERENCES Semesters(semester_id)
);

INSERT INTO Students (name, department, admission_year) VALUES
('Aaryan', 'BCA', 2022),
('Rahul', 'BCA', 2022),
('Sneha', 'BBA', 2021),
('Priya', 'BBA', 2021),
('Amit', 'BCA', 2022);

INSERT INTO Courses (course_name, credits) VALUES
('Database Systems', 4),
('Data Structures', 3),
('Operating Systems', 3),
('Mathematics', 4);

INSERT INTO Semesters (semester_name) VALUES
('Semester 1'),
('Semester 2');

INSERT INTO Grades (student_id, course_id, semester_id, marks) VALUES
(1,1,1,85),(1,2,1,78),(1,3,1,88),
(2,1,1,72),(2,2,1,69),(2,3,1,75),
(3,1,1,90),(3,2,1,92),(3,3,1,89),
(4,1,1,60),(4,2,1,65),(4,3,1,70),
(5,1,1,80),(5,2,1,85),(5,3,1,82);

SELECT s.name, ROUND(AVG(g.marks)/10,2) AS GPA
FROM Students s
JOIN Grades g ON s.student_id = g.student_id
GROUP BY s.name;

SELECT s.department, ROUND(AVG(g.marks),2) AS dept_avg
FROM Students s
JOIN Grades g ON s.student_id = g.student_id
GROUP BY s.department;

SELECT name, GPA,
RANK() OVER (ORDER BY GPA DESC) AS student_rank
FROM (
    SELECT s.name, ROUND(AVG(g.marks)/10,2) AS GPA
    FROM Students s
    JOIN Grades g ON s.student_id = g.student_id
    GROUP BY s.name
) AS result_table;

CREATE VIEW student_result_summary AS
SELECT s.name, s.department, ROUND(AVG(g.marks),2) AS average_marks
FROM Students s
JOIN Grades g ON s.student_id = g.student_id
GROUP BY s.name, s.department;
