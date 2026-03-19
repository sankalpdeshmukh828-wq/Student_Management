CREATE DATABASE IF NOT EXISTS studentMgmt;
USE studentMgmt;

create table department (
dept_id int auto_increment primary key ,
dept_name varchar(50) unique not null ,
hod_name varchar(120) 
);

-- alter table department
-- add column hod_name varchar(100)

insert into department (dept_name, hod_name)
values ('Information Technology', 'Ramesh');

select * from department;

insert into department (dept_name, hod_name)
values ('Administration', 'sankalp');

insert into department (dept_name, hod_name)
values ('Finance', 'Sarthak');

insert into department (dept_name, hod_name)
values ('CSE', 'Rahul'),
('Electronics', 'Dr. patil'),
('Mechanical', 'Dr. monika');

create table students (

student_id int primary key auto_increment ,
first_name varchar(100) ,
last_name varchar(100) ,
email varchar(100) ,
phone varchar(15),
dept_id int ,
admission_date date,

foreign key (dept_id) references department(dept_id)
);

insert into students (first_name, last_name, email, phone, dept_id, admission_date)
values ('Salman', 'Khan', 'salmankhan@gmail.com', '9445654765', 1, '2025-02-05'),
('Amir', 'Khan', 'amirkhan@gmail.com', '7543667890', 1, '2023-06-19'),
('Amjat', 'Khan', 'amjatkhan@gmail.com', '9826427568', 1, '2022-03-13'),
('Arbaz', 'Khan', 'arbazkhan@gmail.com', '987654335543', 2, '2024-09-08');

insert into students (first_name, last_name, email, phone, dept_id, admission_date)
values('Rahul', 'Sharma', 'rahul.sharma@gmail.com', '9123456780', 2, '2023-01-12'),
('Priya', 'Patil', 'priya.patil@gmail.com', '9876501234', 3, '2024-07-21'),
('Amit', 'Verma', 'amit.verma@gmail.com', '9988776655', 1, '2022-11-03');

select * from students;

create table results (
result_id int primary key auto_increment, 
student_id int,
subject varchar(100),
marks int,
grade char(2),
foreign key (student_id) references students(student_id)
);

insert into results (student_id, subject, marks, grade)
values (1, 'DBMS', 85, 'A'),
(1, 'OS', 79, 'A'),
(4, 'Thermodynamics', 65, 'C'),
(5, 'DBMS', 92, 'A+'),
(4, 'DBMS', 74, 'B'),
(2, 'OS', 68, 'B'),
(3, 'Mathematics', 88, 'A'),
(3, 'DBMS', 91, 'A+'),
(6, 'Operating Systems', 55, 'C'),
(6, 'Mathematics', 60, 'B');
 
select * from results;

update students set phone = '9359880546'  where student_id = 1;

select stud.first_name as fNAME, stud.last_name as lNAME, dept.dept_name, res.grade
from department dept
inner join students stud
on dept.dept_id = stud.dept_id
inner join results res
on stud.student_id = res.student_id;


SELECT first_name,last_name, email from students;

SELECT s.*
FROM students s
JOIN department d ON s.dept_id = d.dept_id
WHERE d.dept_name = 'Information Technology';


SELECT * FROM students WHERE admission_date > '2023-06-12';

SELECT * FROM results WHERE student_id = 1;

SELECT subject, marks FROM results WHERE marks > 80;
SELECT COUNT(*) AS total_students FROM students;

SELECT DISTINCT subject FROM results;

SELECT * FROM students ORDER BY first_name ASC;

SELECT * FROM results ORDER BY marks DESC LIMIT 3;

SELECT s.first_name, s.last_name, d.dept_name FROM students s JOIN department d ON s.dept_id = d.dept_id;

SELECT s.student_id, s.first_name, SUM(r.marks) AS total_marks
FROM students s
JOIN results r ON s.student_id = r.student_id
GROUP BY s.student_id, s.first_name;

SELECT s.student_id, s.first_name, AVG(r.marks) AS avg_marks
FROM students s
JOIN results r ON s.student_id = r.student_id
GROUP BY s.student_id, s.first_name;

SELECT DISTINCT s.*
FROM students s
JOIN results r ON s.student_id = r.student_id
WHERE r.marks > 90;

SELECT d.dept_name, COUNT(s.student_id) AS total_students
FROM department d
LEFT JOIN students s ON d.dept_id = s.dept_id
GROUP BY d.dept_name;

SELECT s.*
FROM students s
LEFT JOIN results r ON s.student_id = r.student_id
WHERE r.student_id IS NULL;

SELECT subject, AVG(marks) AS avg_marks
FROM results
GROUP BY subject;

SELECT d.dept_name, COUNT(s.student_id) AS total_students
FROM department d
JOIN students s ON d.dept_id = s.dept_id
GROUP BY d.dept_name
ORDER BY total_students DESC
LIMIT 1;

SELECT MAX(marks) AS second_highest
FROM results
WHERE marks < (SELECT MAX(marks) FROM results);

SELECT * FROM students WHERE first_name LIKE 'A%';


SELECT dept_name, first_name, total_marks
FROM (
    SELECT d.dept_name,
           s.first_name,
           SUM(r.marks) AS total_marks,
           RANK() OVER (PARTITION BY s.dept_id ORDER BY SUM(r.marks) DESC) AS rnk
    FROM students s
    JOIN department d ON s.dept_id = d.dept_id
    JOIN results r ON s.student_id = r.student_id
    GROUP BY s.student_id, s.first_name, d.dept_name, s.dept_id
) t
WHERE rnk = 1;

SELECT s.student_id, s.first_name, AVG(r.marks) AS avg_marks
FROM students s
JOIN results r ON s.student_id = r.student_id
GROUP BY s.student_id, s.first_name, s.dept_id
HAVING avg_marks > (
    SELECT AVG(r2.marks)
    FROM students s2
    JOIN results r2 ON s2.student_id = r2.student_id
    WHERE s2.dept_id = s.dept_id
);

SELECT *
FROM students s
WHERE EXISTS (
    SELECT 1 
    FROM results r 
    WHERE r.student_id = s.student_id 
    AND r.marks < 40
);

-- SELECT s.student_id, s.first_name
-- FROM students s
-- JOIN results r ON s.student_id = r.student_id
-- GROUP BY s.student_id, s.first_name
-- HAVING COUNT(DISTINCT r.subject) = (
--     SELECT COUNT(DISTINCT subject) FROM results
-- );

SELECT email, COUNT(*) AS count FROM students GROUP BY email HAVING COUNT(*) > 1;

update students set email = 'salmankhan@gmail.com'  where student_id = 4;

insert into results (student_id, subject, marks, grade)
values (2, 'Computer Science', 39, 'F'),
(3,'M3','25','F');

insert into students (first_name, last_name, email, phone, dept_id, admission_date)
values('Patil', 'khan', 'khanpatil@gmail.com', '9123123', 2, '2023-01-15'),
('Radhey','patil','radhe@gmail.com','12345678','3','2022-02-12');


SELECT stud.student_id, stud.first_name
FROM students stud
JOIN results r ON stud.student_id = r.student_id
GROUP BY stud.student_id, stud.first_name
HAVING COUNT(DISTINCT r.subject) = (
    SELECT COUNT(DISTINCT subject) FROM results
);

INSERT INTO results (student_id, subject, marks)
VALUES 
(1, 'DBMS', 85),
(1, 'OS', 78),
(1, 'SOftware', 90);

SELECT s.student_id, s.first_name, 
       SUM(r.marks) AS total_marks,
       RANK() OVER (ORDER BY SUM(r.marks) DESC) AS rank_position
FROM students s
JOIN results r ON s.student_id = r.student_id
GROUP BY s.student_id, s.first_name;

SELECT s.student_id, s.first_name
FROM students s
JOIN results r ON s.student_id = r.student_id
GROUP BY s.student_id, s.first_name
HAVING MIN(r.marks) >= 70;

SELECT d.dept_name,
       ROUND(
           SUM(CASE WHEN r.marks >= 40 THEN 1 ELSE 0 END) * 100.0 
           / COUNT(r.marks), 2
       ) AS pass_percentage
FROM department d
JOIN students s ON d.dept_id = s.dept_id
JOIN results r ON s.student_id = r.student_id
GROUP BY d.dept_name;

SELECT last_name, COUNT(*) AS count
FROM students
GROUP BY last_name
HAVING COUNT(*) > 1;

SELECT s.student_id, s.first_name, r.marks
FROM students s
JOIN results r ON s.student_id = r.student_id
WHERE r.marks > (
    SELECT AVG(r2.marks)
    FROM students s2
    JOIN results r2 ON s2.student_id = r2.student_id
    WHERE s2.dept_id = s.dept_id
);

-- Replace N = 2, 3, etc.
SELECT DISTINCT marks
FROM results r1
WHERE 2 = (
    SELECT COUNT(DISTINCT marks)
    FROM results r2
    WHERE r2.marks > r1.marks
);

-- SELECT student_id, subject, marks, 
--        LAG(marks) OVER (PARTITION BY student_id, subject ORDER BY exam_date) AS prev_marks
-- FROM results
-- HAVING marks > prev_marks;

SELECT *
FROM (
    SELECT d.dept_name, s.first_name, SUM(r.marks) AS total_marks,
           RANK() OVER (PARTITION BY s.dept_id ORDER BY SUM(r.marks) DESC) AS rnk
    FROM students s
    JOIN department d ON s.dept_id = d.dept_id
    JOIN results r ON s.student_id = r.student_id
    GROUP BY s.student_id, s.first_name, d.dept_name, s.dept_id
) t
WHERE rnk <= 2;

SELECT student_id, subject, marks,
       SUM(marks) OVER (PARTITION BY student_id ORDER BY subject) AS cumulative_marks
FROM results;


SELECT s.student_id, s.first_name,
       CASE 
           WHEN MIN(r.marks) >= 40 THEN 'Pass'
           ELSE 'Fail'
       END AS result_status
FROM students s
JOIN results r ON s.student_id = r.student_id
GROUP BY s.student_id, s.first_name;

SELECT student_id,
       MAX(CASE WHEN subject = 'Math' THEN marks END) AS Math,
       MAX(CASE WHEN subject = 'DBMS' THEN marks END) AS DBMS,
       MAX(CASE WHEN subject = 'OS' THEN marks END) AS OS
FROM results
GROUP BY student_id;


START TRANSACTION;

UPDATE results
SET marks = marks - 10
WHERE student_id = 1;

-- Check condition
SELECT * FROM results WHERE marks < 0;

-- If any marks < 0 → rollback
ROLLBACK;

-- Otherwise
COMMIT;

select * from results;


-- Create index
CREATE INDEX idx_student_marks 
ON results(student_id, marks);

-- Optimized query
SELECT s.student_id, s.first_name, r.marks
FROM students s
JOIN results r ON s.student_id = r.student_id
WHERE r.marks > 80;

SELECT s.student_id, s.first_name, r.subject, r.marks
FROM students s
INNER JOIN results r 
ON s.student_id = r.student_id;

SELECT s.*
FROM students s
LEFT JOIN results r 
ON s.student_id = r.student_id
WHERE r.student_id IS NULL;


SELECT s.student_id, s.first_name, r.subject, r.marks
FROM students s
LEFT JOIN results r 
ON s.student_id = r.student_id

UNION

SELECT s.student_id, s.first_name, r.subject, r.marks
FROM students s
RIGHT JOIN results r 
ON s.student_id = r.student_id;

SELECT s1.first_name AS student1, s2.first_name AS student2, s1.dept_id
FROM students s1
JOIN students s2 
ON s1.dept_id = s2.dept_id 
AND s1.student_id <> s2.student_id;


SELECT s.student_id, s.first_name, d.dept_name, r.subject, r.marks
FROM students s
JOIN department d ON s.dept_id = d.dept_id
JOIN results r ON s.student_id = r.student_id;


INSERT INTO students (first_name, last_name, dept_id, admission_date)
SELECT 'John', 'Doe', 1, '2025-01-10'
WHERE NOT EXISTS (
    SELECT 1 FROM students 
    WHERE first_name = 'John' AND last_name = 'Doe'
);

UPDATE results r
SET marks = 85
WHERE student_id = 1
AND EXISTS (
    SELECT 1 FROM students s WHERE s.student_id = r.student_id
);



select * from students;

DELETE s
FROM students s
JOIN (
    SELECT student_id
    FROM results
    WHERE marks < 40
    GROUP BY student_id
    HAVING COUNT(*) > 2
) r ON s.student_id = r.student_id;

select * from results;

-- INSERT INTO students_archive
-- SELECT *
-- FROM students
-- WHERE admission_date < '2022-01-01';

-- DELETE FROM students
-- WHERE admission_date < '2022-01-01';


CREATE TRIGGER calculate_grade
BEFORE INSERT ON results
FOR EACH ROW
BEGIN
    IF NEW.marks >= 90 THEN
        SET NEW.grade = 'A',
    ELSEIF NEW.marks >= 75 THEN
        SET NEW.grade = 'B',
    ELSEIF NEW.marks >= 50 THEN
        SET NEW.grade = 'C',
    ELSE
        SET NEW.grade = 'F',
    END IF,
END$$

DELIMITER ;

SELECT subject, AVG(marks) AS avg_marks
FROM results
GROUP BY subject
ORDER BY avg_marks DESC
LIMIT 1;

SELECT student_id, VARIANCE(marks) AS consistency
FROM results
GROUP BY student_id
ORDER BY consistency ASC
LIMIT 1;

SELECT 
    MONTH(admission_date) AS month,
    COUNT(*) AS total_students
FROM students
GROUP BY MONTH(admission_date)
ORDER BY month;

SELECT 
    SUM(CASE WHEN marks >= 40 THEN 1 ELSE 0 END) AS pass_count,
    SUM(CASE WHEN marks < 40 THEN 1 ELSE 0 END) AS fail_count
FROM results;

SELECT d.dept_name, AVG(r.marks) AS avg_marks
FROM results r
JOIN students s ON r.student_id = s.student_id
JOIN department d ON s.dept_id = d.dept_id
GROUP BY d.dept_name
ORDER BY avg_marks DESC;

SELECT t1.student_id + 1 AS missing_id
FROM students t1
LEFT JOIN students t2 
ON t1.student_id + 1 = t2.student_id
WHERE t2.student_id IS NULL;

SELECT * FROM students WHERE dept_id IS NULL;

SELECT *
FROM students
WHERE (first_name = 'John' OR 'John' IS NULL)
AND (dept_id = 1 OR 1 IS NULL);

SELECT s.first_name, r.marks
FROM students s
JOIN results r ON s.student_id = r.student_id
WHERE r.marks > 80;


CREATE VIEW report_card AS
SELECT 
    s.student_id,
    s.first_name,
    s.last_name,
    d.dept_name,
    r.subject,
    r.marks
FROM students s
JOIN department d ON s.dept_id = d.dept_id
JOIN results r ON s.student_id = r.student_id;

SELECT * FROM report_card;