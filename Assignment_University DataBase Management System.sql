CREATE DATABASE KSOM

--TASK-1--

CREATE TABLE College (
    College_ID INT PRIMARY KEY,
    College_Name VARCHAR(100),
    College_Area VARCHAR(100)
);

CREATE TABLE Department (
    Dept_ID INT PRIMARY KEY,
    Dept_Name VARCHAR(100),
    Dept_Facility VARCHAR(100),
    College_ID INT,
    FOREIGN KEY (College_ID) REFERENCES College(College_ID)
);

CREATE TABLE Professor (
    Professor_ID INT PRIMARY KEY,
    Professor_Name VARCHAR(100),
    Professor_Subject VARCHAR(100)
);

CREATE TABLE Student (
    Student_ID INT PRIMARY KEY,
    Student_Name VARCHAR(100),
    Student_Stream VARCHAR(100),
    Professor_ID INT,
    FOREIGN KEY (Professor_ID) REFERENCES Professor(Professor_ID)
);

INSERT INTO College VALUES
(1, 'Greenfield College', 'North Zone'),
(2, 'Blue River University', 'East Zone'),
(3, 'Hilltop Institute', 'South Zone'),
(4, 'Oceanview College', 'West Zone'),
(5, 'TechVille University', 'Central Zone'),
(6, 'Sunrise College', 'North Zone'),
(7, 'Valley Academy', 'South Zone'),
(8, 'Riverbank Institute', 'East Zone'),
(9, 'Skyline College', 'West Zone'),
(10, 'Lakeside University', 'Central Zone');

INSERT INTO Department VALUES
(101, 'Computer Science', 'Lab & Wi-Fi', 1),
(102, 'Mechanical Engg', 'Workshop', 2),
(103, 'Electrical Engg', 'High Voltage Lab', 3),
(104, 'Civil Engg', 'Survey Instruments', 4),
(105, 'Biotech', 'Bio Lab', 5),
(106, 'Physics', 'Research Lab', 6),
(107, 'Chemistry', 'Fume Hoods', 7),
(108, 'Mathematics', 'Smart Boards', 8),
(109, 'Economics', 'Data Analysis Tools', 9),
(110, 'Psychology', 'Counseling Lab', 10);

INSERT INTO Professor VALUES
(201, 'Dr. A Sharma', 'Algorithms'),
(202, 'Prof. B Mehta', 'Thermodynamics'),
(203, 'Dr. C Iyer', 'Circuits'),
(204, 'Prof. D Rao', 'Structural Engg'),
(205, 'Dr. E Nair', 'Genetics'),
(206, 'Dr. F Roy', 'Quantum Physics'),
(207, 'Prof. G Sinha', 'Organic Chemistry'),
(208, 'Dr. H Singh', 'Linear Algebra'),
(209, 'Prof. I Patel', 'Microeconomics'),
(210, 'Dr. J Kapoor', 'Human Behavior');

INSERT INTO Student VALUES
(301, 'Ananya Gupta', 'CS', 201),
(302, 'Ravi Verma', 'Mechanical', 202),
(303, 'Priya Singh', 'EEE', 203),
(304, 'Suresh Kumar', 'Civil', 204),
(305, 'Ritika Jain', 'Biotech', 205),
(306, 'Aman Sethi', 'Physics', 206),
(307, 'Neha Rana', 'Chemistry', 207),
(308, 'Tarun Mehra', 'Math', 208),
(309, 'Megha Shah', 'Economics', 209),
(310, 'Vikas Bansal', 'Psychology', 210);

SELECT * FROM College
SELECT * FROM Department
SELECT * FROM Professor
SELECT * FROM Student

--TASK-2--

--1. Give the information of College_ID and College_name from College

SELECT College_ID,College_Name
FROM College

--2. Show Top 5 rows from Student table.

SELECT TOP 5 * 
FROM Student

--3. What is the name of professor whose ID is 205

SELECT Professor_ID,Professor_Name
FROM Professor
WHERE Professor_ID = 205

--5. Show me the names of those students whose name is start with A

SELECT Student_ID,Student_Name
FROM Student
WHERE Student_Name LIKE 'A%'

--6. Give the name of those colleges whose end with E

SELECT College_ID,College_Name
FROM College
WHERE College_Name LIKE '%E'

--7. Add one Salary Column in Professor_Table

ALTER TABLE Professor
ADD Salary DECIMAL(10, 2);

SELECT * FROM Professor

UPDATE Professor SET Salary = 85000.00 WHERE Professor_ID = 201;
UPDATE Professor SET Salary = 79000.00 WHERE Professor_ID = 202;
UPDATE Professor SET Salary = 81000.00 WHERE Professor_ID = 203;
UPDATE Professor SET Salary = 83000.00 WHERE Professor_ID = 204;
UPDATE Professor SET Salary = 87000.00 WHERE Professor_ID = 205;
UPDATE Professor SET Salary = 92000.00 WHERE Professor_ID = 206;
UPDATE Professor SET Salary = 80000.00 WHERE Professor_ID = 207;
UPDATE Professor SET Salary = 76000.00 WHERE Professor_ID = 208;
UPDATE Professor SET Salary = 74000.00 WHERE Professor_ID = 209;
UPDATE Professor SET Salary = 89000.00 WHERE Professor_ID = 210;

EXEC sp_rename 'Professor.Salary','Professor_Salary', 'COLUMN';


--8. Add one Contact Column in Student_table

ALTER TABLE Student
ADD Contact VARCHAR(15)

UPDATE Student SET Contact = '9876543210' WHERE Student_ID = 301;
UPDATE Student SET Contact = '8765432109' WHERE Student_ID = 302;
UPDATE Student SET Contact = '7654321098' WHERE Student_ID = 303;
UPDATE Student SET Contact = '6543210987' WHERE Student_ID = 304;
UPDATE Student SET Contact = '5432109876' WHERE Student_ID = 305;
UPDATE Student SET Contact = '4321098765' WHERE Student_ID = 306;
UPDATE Student SET Contact = '3210987654' WHERE Student_ID = 307;
UPDATE Student SET Contact = '2109876543' WHERE Student_ID = 308;
UPDATE Student SET Contact = '1098765432' WHERE Student_ID = 309;
UPDATE Student SET Contact = '9988776655' WHERE Student_ID = 310;

EXEC sp_rename 'Student.Contact','Student_Contact', 'COLUMN';

--9. Find the total Salary of Professor

SELECT SUM(Professor_Salary) AS Total_Salary
FROM Professor

--10. Change datatype of any one column of any one Table

ALTER TABLE Student
ALTER COLUMN Student_Stream CHAR(100);

--TASK-3--

--1. Show first 5 records from Students table and Professor table Combine

SELECT TOP 5 * 
FROM Student
JOIN
Professor
ON
Student.Professor_ID = Professor.Professor_ID

--2. Apply Inner join on all 4 tables together(Syntax is mandatory)

SELECT 
    C.College_ID, C.College_Name, C.College_Area,
    D.Dept_ID, D.Dept_Name, D.Dept_Facility,
    P.Professor_ID, P.Professor_Name, P.Professor_Subject,
    S.Student_ID, S.Student_Name, S.Student_Stream
FROM College C
INNER JOIN Department D ON C.College_ID = D.College_ID
INNER JOIN Professor P ON 1=1 -- Dummy join condition that includes all combinations.
INNER JOIN Student S ON P.Professor_ID = S.Professor_ID;

ALTER TABLE Professor
ADD Dept_ID INT;

SELECT * FROM Professor

ALTER TABLE Professor
ADD FOREIGN KEY (Dept_ID) REFERENCES Department(Dept_ID);

UPDATE Professor SET Dept_ID = 101 WHERE Professor_ID = 201;
UPDATE Professor SET Dept_ID = 102 WHERE Professor_ID = 202;
UPDATE Professor SET Dept_ID = 103 WHERE Professor_ID = 203;
UPDATE Professor SET Dept_ID = 104 WHERE Professor_ID = 204;
UPDATE Professor SET Dept_ID = 105 WHERE Professor_ID = 205;
UPDATE Professor SET Dept_ID = 106 WHERE Professor_ID = 206;
UPDATE Professor SET Dept_ID = 107 WHERE Professor_ID = 207;
UPDATE Professor SET Dept_ID = 108 WHERE Professor_ID = 208;
UPDATE Professor SET Dept_ID = 109 WHERE Professor_ID = 209;
UPDATE Professor SET Dept_ID = 110 WHERE Professor_ID = 210;

SELECT 
    C.College_ID, C.College_Name, C.College_Area,
    D.Dept_ID, D.Dept_Name, D.Dept_Facility,
    P.Professor_ID, P.Professor_Name, P.Professor_Subject,
    S.Student_ID, S.Student_Name, S.Student_Stream
FROM College C
INNER JOIN Department D ON C.College_ID = D.College_ID
INNER JOIN Professor P ON D.Dept_ID = P.Dept_ID
INNER JOIN Student S ON P.Professor_ID = S.Professor_ID;


--3. Show Some null values from Department table and Professor table.

SELECT * 
FROM Department
JOIN
Professor
ON
Department.Dept_ID = Professor.Dept_ID
WHERE Department.Dept_ID IS NULL

--4. Create a View from College Table and give those records whose college name starts with C

CREATE VIEW View_College_C AS
SELECT *
FROM College
WHERE College_Name LIKE 'C%';

--5. Create Stored Procedure of Professor table whatever customer ID will be given by user it should show whole records of it.

CREATE PROCEDURE GetProfessorByID
    @ProfessorID INT
AS
BEGIN
    SELECT *
    FROM Professor
    WHERE Professor_ID = @ProfessorID;
END;

EXEC GetProfessorByID @ProfessorID = 202;

--6. Rename the College_Table to College_Tables_Data .


EXEC sp_rename 'College', 'College_Data';