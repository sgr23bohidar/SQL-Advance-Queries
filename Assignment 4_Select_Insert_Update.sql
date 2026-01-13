CREATE DATABASE STUDENT_LIBRARY

CREATE TABLE Students (
StudentId INT PRIMARY KEY,
Name VARCHAR(60),
Surname VARCHAR(60),
Birthdate DATE,
Gender CHAR(10),
Class VARCHAR(50),
Points INT
);

CREATE TABLE Books (
    BookId INT PRIMARY KEY,
    Name VARCHAR(100),
    Pagecount INT,
    Point INT,
    AuthorId INT,
    TypeId INT,
    FOREIGN KEY (AuthorId) REFERENCES Authors(AuthorId),
    FOREIGN KEY (TypeId) REFERENCES Types(TypeId)
);

CREATE TABLE Authors (
    AuthorId INT PRIMARY KEY,
    Name VARCHAR(50),
    Surname VARCHAR(50)
);

CREATE TABLE Types (
    TypeId INT PRIMARY KEY,
    Name VARCHAR(50)
);


CREATE TABLE Borrows (
    BorrowId INT PRIMARY KEY,
    StudentId INT,
    BookId INT,
    TakenDate DATE,
    BroughtDate DATE,
    FOREIGN KEY (StudentId) REFERENCES Students(StudentId),
    FOREIGN KEY (BookId) REFERENCES Books(BookId)
);

INSERT INTO students (studentId, name, surname,
birthdate, gender, class, Points) VALUES
(1, 'John', 'Doe', '2005-01-15', 'M', '10A', 85),
(2, 'Jane', 'Smith', '2006-03-22', 'F', '10B', 90),
(3, 'Alice', 'Johnson', '2005-07-12', 'F', '10A', 88),
(4, 'Bob', 'Brown', '2006-11-30', 'M', '10C', 76),
(5, 'Charlie', 'Davis', '2005-05-05', 'M', '10B', 92),
(6, 'Diana', 'Miller', '2006-06-25', 'F', '10C', 81),
(7, 'Eve', 'Wilson', '2005-09-18', 'F', '10A', 87),
(8, 'Frank', 'Moore', '2006-12-02', 'M', '10B', 80),
(9, 'Grace', 'Taylor', '2005-04-17', 'F', '10C', 83),
(10, 'Hank', 'Anderson', '2006-10-20', 'M', '10A', 78);

INSERT INTO types (typeId, name) VALUES
(1, 'Fiction'),
(2, 'Classic'),
(3, 'Dystopian'),
(4, 'Literature'),
(5, 'Fantasy'),
(6, 'Adventure'),
(7, 'Historical Fiction'),
(8, 'Science Fiction'),
(9, 'Mythology'),
(10, 'Philosophy');

INSERT INTO authors (authorId, name, surname) VALUES
(1, 'F. Scott', 'Fitzgerald'),
(2, 'Harper', 'Lee'),
(3, 'George', 'Orwell'),
(4, 'Jane', 'Austen'),
(5, 'J.D.', 'Salinger'),
(6, 'J.R.R.', 'Tolkien'),
(7, 'Herman', 'Melville'),
(8, 'Leo', 'Tolstoy'),
(9, 'James', 'Joyce'),
(10, 'Homer', '');

INSERT INTO borrows (borrowId, studentId, bookId,
takenDate, broughtDate) VALUES
(1, 1, 3, '2024-01-10', '2024-01-20'),
(2, 2, 5, '2024-01-12', '2024-01-22'),
(3, 3, 7, '2024-01-15', '2024-01-25'),
(4, 4, 2, '2024-01-18', '2024-01-28'),
(5, 5, 1, '2024-01-20', '2024-01-30'),
(6, 6, 4, '2024-01-22', '2024-02-01'),
(7, 7, 6, '2024-01-24', '2024-02-03'),
(8, 8, 8, '2024-01-26', '2024-02-05'),
(9, 9, 10, '2024-01-28', '2024-02-07'),
(10, 10, 9, '2024-01-30', '2024-02-09');

INSERT INTO books (bookId, name, pagecount, point,
authorId, typeId) VALUES
(1, 'The Great Gatsby', 180, 95, 1, 1),
(2, 'To Kill a Mockingbird', 281, 90, 2, 2),
(3, '1984', 328, 88, 3, 3),
(4, 'Pride and Prejudice', 279, 93, 4, 4),
(5, 'The Catcher in the Rye', 214, 85, 5, 1),
(6, 'The Hobbit', 310, 91, 6, 2),
(7, 'Moby-Dick', 635, 80, 7, 3),
(8, 'War and Peace', 1225, 92, 8, 4),
(9, 'Ulysses', 730, 89, 9, 1),
(10, 'The Odyssey', 541, 87, 10, 2);

SELECT * FROM Books

SELECT * FROM Borrows

SELECT * FROM Authors

SELECT * FROM Types

SELECT * FROM Students

--Example 1: List all the records in the student table

SELECT * FROM Students

--Example 2: List the name surname and class of the student in the student table

SELECT Name,Surname,Class
FROM Students

--Example 3: List the gender Female (F) records in the student table

SELECT Name,Surname,Gender
FROM Students
WHERE Gender = 'F'

--Example 4 : List the names of each class in the way of being seen once in the student table

SELECT DISTINCT(Class)
FROM Students

--Example 5: List the students with Female gender and the class 10A th in the student table

SELECT Name,Gender,Class
FROM Students
WHERE Gender = 'F' AND Class = '10A'

--Example 6: List the names, surnames and classes of the students in the class 10Math or 10Sci in the student table

SELECT Name,Surname,Class
FROM Students
WHERE Class = '10A' OR CLASS = '10B'

--Example 7: List the students name surname and school number in the student table

SELECT StudentId,Name,Surname
FROM Students

--Example 8: List the students name and surname by combining them as name surname in the student table

SELECT CONCAT(Name,' ',Surname) AS Full_Name
FROM Students

--Example 9: List the students with the names starting with 'A' letter in the student table

SELECT StudentId,Name,Surname
FROM Students
WHERE Name LIKE 'A%'

--Example 10: List the book names and pages count with number of pages between 50 and 200 in the book table.

SELECT Name,Pagecount
FROM Books
WHERE Pagecount BETWEEN 50 AND 200

--Example 11: List the students with names Emma Sophia and Robert in the student table

SELECT *
FROM Students
WHERE Name IN ('Emma', 'Sophia', 'Robert')

--Example 12: List the students with names starting with A D and K in the student table

SELECT *
FROM Students
WHERE Name LIKE 'A%' 
OR Name LIKE 'D%'
OR Name LIKE 'K%'

--Example 13: List the names surnames classes and genders of males 10B or females in 10A in the student table

SELECT Name,Surname,Gender,Class
FROM Students
WHERE Gender = 'M' AND Class = '10B'
OR Gender = 'F' AND Class = '10A'

--Example 14: List the males whose classes are 10A or 10B

SELECT Name,Gender,Class
FROM Students
WHERE Gender = 'M' AND
Class IN ('10A','10B')

--Example 15: List the students with birth year 1989 in the student table

SELECT Name,Birthdate
FROM Students
WHERE YEAR(Birthdate) = 1989

--Example 16: List the female students with student numbers between 30 and 50

SELECT Name,Gender
FROM Students
WHERE Points BETWEEN 30 AND 50

--Example 17: List the students according to their names

SELECT *
FROM Students
ORDER BY Name

--Example 18: List the students by names for those with same names. List them by their surnames

SELECT *
FROM students
WHERE name IN (
    SELECT name
    FROM students
    GROUP BY name
    HAVING COUNT(*) > 1
)
ORDER BY name, surname;

--Example 19: List the students in 10A by decreasing school numbers

SELECT *
FROM Students
WHERE Class = '10A'
ORDER BY Points DESC

--Example 20: List the first 10 records in the student chart

SELECT TOP 10 *
FROM Students

--Example 21: List the first 10 records name surname and date of birth information in the student table

SELECT TOP 10 Name,Surname,Birthdate
FROM Students

--Example 22: List the book with the most page number

SELECT * 
FROM Books
WHERE Pagecount = ( SELECT MAX(Pagecount) FROM Books)

--Example 23: List the youngest student in the student table

SELECT * 
FROM Students
WHERE Birthdate = ( SELECT MAX(Birthdate) FROM Students)

--Example 24: List the oldest student in the 10A class

SELECT * 
FROM Students
WHERE Birthdate = ( SELECT MIN(Birthdate) FROM Students) AND Class = '10A'

--Example 25: List the books with the second letter N

SELECT * 
FROM Books 
WHERE Name LIKE '_N%'

--Example 26: List the students by grouping according to their classes

SELECT Class,COUNT(Class) AS No_of_Student
FROM Students
GROUP BY Class
ORDER BY Class 

--Example 27: List the students to be different in each questioning randomly

SELECT *
FROM Students
ORDER BY NEWID();

--Example 28: Pick a random student from student table

SELECT TOP 1 *
FROM Students
ORDER BY NEWID()

--Example 29: Bring some random student’s name , surname and number from class 10A

SELECT TOP 1 StudentId,Name,Surname,Class,Points
FROM Students
WHERE Class = '10A'
ORDER BY NEWID()

--Example 30: Add the writer named Smith Allen to the authors table

INSERT INTO Authors(AuthorId,Name,Surname)
VALUES ( 11 ,'Smith','Allen')

SELECT * FROM Authors

--Example 31: Add the genre of biography to the genre table

INSERT INTO Types(TypeId,Name)
VALUES (11,'Biography')

--Example 32: Add 10A Class male named Thomas Nelson , 10B class female named Sally Allen and 10C Class female named Linda Sandra in one question

INSERT INTO Students (StudentId,Name,Surname,
Birthdate,Gender,Class, Points) VALUES
(11, 'Thomas', 'Nelson', '2012-05-11', 'M', '10A', 75),
(12, 'Sally', 'Allen', '2002-09-01', 'F', '10B', 99),
(13, 'Linda', 'Sandra', '2001-02-19', 'F', '10C', 91)

--Example 33: Add a random student in the students chart to the writers chart as an authors

INSERT INTO authors (AuthorId, Name, Surname)
SELECT 
    (SELECT MAX(AuthorId) FROM authors) + 1,
    Name,
    Surname
FROM students
ORDER BY NEWID()
OFFSET 0 ROWS FETCH NEXT 1 ROWS ONLY;

SELECT * FROM Authors

--Example 34: Add students with student numbers between 10 and 30 as authors

INSERT INTO Authors (AuthorId, Name, Surname)
SELECT 
    (SELECT MAX(AuthorId) FROM Authors) + ROW_NUMBER() OVER (ORDER BY StudentId),
    Name,
    Surname
FROM Students
WHERE StudentId BETWEEN 10 AND 30;

SELECT * FROM Students

--Example 35: Add the writer named Cindy Brown and make him write his writer number (Note: The last increased rate in automatic enhancing is hold in @@IDENTITY factor)



--Example 36: Change the class of the student whose school number is 3 from 10A to 10B

UPDATE Students
SET Class = '10B'
WHERE StudentId = 3;

--Example 37: Transfer all the students in 10C Class to 10D Class

UPDATE Students
SET Class = '10D'
WHERE Class = '10C'

--Example 38: Increase all of the students’ score by 5 points

UPDATE Students
SET Points = Points + 5;

--Example 39: Delete the author #17

DELETE FROM Authors
WHERE AuthorId = 17;

--Example 40: List the students whose birth dates are null

SELECT * 
FROM Students
WHERE Birthdate IS NULL

--Example 41: List the name ,surname and the dates of received books of the student

SELECT 
    S.Name,
    S.Surname,
    B.TakenDate
FROM 
    Students S
INNER JOIN 
    Borrows B ON S.StudentId = B.StudentId;