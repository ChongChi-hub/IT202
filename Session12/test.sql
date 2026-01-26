-- Tạo và sử dụng Database
CREATE DATABASE IF NOT EXISTS QLSinhVien;
USE QLSinhVien;

-- Bảng Department
CREATE TABLE Department (
    DeptID CHAR(5) PRIMARY KEY,
    DeptName VARCHAR(50) NOT NULL
);

-- Bảng Student
CREATE TABLE Student (
    StudentID CHAR(6) PRIMARY KEY,
    FullName VARCHAR(50),
    Gender VARCHAR(10),
    BirthDate DATE,
    DeptID CHAR(5),
    FOREIGN KEY (DeptID) REFERENCES Department(DeptID)
);

-- Bảng Course
CREATE TABLE Course (
    CourseID CHAR(6) PRIMARY KEY,
    CourseName VARCHAR(50),
    Credits INT
);

-- Bảng Enrollment
CREATE TABLE Enrollment (
    StudentID CHAR(6),
    CourseID CHAR(6),
    Score FLOAT,
    PRIMARY KEY (StudentID, CourseID),
    FOREIGN KEY (StudentID) REFERENCES Student(StudentID),
    FOREIGN KEY (CourseID) REFERENCES Course(CourseID)
);

-- Chèn dữ liệu mẫu
INSERT INTO Department VALUES
('IT','Information Technology'),
('BA','Business Administration'),
('ACC','Accounting');

INSERT INTO Student VALUES
('S00001','Nguyen An','Male','2003-05-10','IT'),
('S00002','Tran Binh','Male','2003-06-15','IT'),
('S00003','Le Hoa','Female','2003-08-20','BA'),
('S00004','Pham Minh','Male','2002-12-12','ACC'),
('S00005','Vo Lan','Female','2003-03-01','IT'),
('S00006','Do Hung','Male','2002-11-11','BA'),
('S00007','Nguyen Mai','Female','2003-07-07','ACC'),
('S00008','Tran Phuc','Male','2003-09-09','IT');

INSERT INTO Course VALUES
('C00001','Database Systems',3),
('C00002','C Programming',3),
('C00003','Microeconomics',2),
('C00004','Financial Accounting',3);

INSERT INTO Enrollment VALUES
('S00001','C00001',8.5),
('S00001','C00002',7.0),
('S00002','C00001',6.5),
('S00003','C00003',7.5),
('S00004','C00004',8.0),
('S00005','C00001',9.0),
('S00006','C00003',6.0),
('S00007','C00004',7.0),
('S00008','C00001',5.5),
('S00008','C00002',6.5);


CREATE VIEW View_StudentBasic AS
SELECT
    S.StudentID,
    S.FullName,
    D.DeptName
FROM
    Student S
JOIN
    Department D ON S.DeptID = D.DeptID;

SELECT * FROM View_StudentBasic;


-- Tạo Regular Index cho cột FullName
CREATE INDEX IX_FullName ON Student (FullName);


-- Viết và Gọi Stored Procedure GetStudentsIT
DELIMITER $$

-- Tạo Stored Procedure GetStudentsIT
CREATE PROCEDURE GetStudentsIT()
BEGIN
    SELECT
        S.StudentID,
        S.FullName,
        S.Gender,
        S.BirthDate,
        D.DeptName
    FROM
        Student S
    JOIN
        Department D ON S.DeptID = D.DeptID
    WHERE
        D.DeptName = 'Information Technology';
END$$

DELIMITER ;

-- Gọi Stored Procedure GetStudentsIT
CALL GetStudentsIT();


CREATE VIEW View_StudentCountByDept AS
SELECT
    D.DeptName,
    COUNT(S.StudentID) AS TotalStudents
FROM
    Department D
LEFT JOIN
    Student S ON D.DeptID = S.DeptID
GROUP BY
    D.DeptName;

-- Truy vấn hiển thị khoa có nhiều sinh viên nhất
SELECT
    DeptName,
    TotalStudents
FROM
    View_StudentCountByDept
ORDER BY
    TotalStudents DESC
LIMIT 1;


-- Thiết lập dấu phân cách cho Stored Procedure
DELIMITER $$

-- Viết Stored Procedure GetTopScoreStudent
CREATE PROCEDURE GetTopScoreStudent(
    IN p_CourseID CHAR(6)
)
BEGIN
    SELECT
        S.StudentID,
        S.FullName,
        E.Score,
        C.CourseName
    FROM
        Student S
    JOIN
        Enrollment E ON S.StudentID = E.StudentID
    JOIN
        Course C ON E.CourseID = C.CourseID
    WHERE
        E.CourseID = p_CourseID
    ORDER BY
        E.Score DESC
    LIMIT 1;
END$$

-- Khôi phục dấu phân cách
DELIMITER ;

-- Gọi thủ tục để tìm sinh viên có điểm cao nhất môn Database Systems (C00001)
CALL GetTopScoreStudent('C00001');

-- Quản lý cập nhật điểm môn Database Systems (C00001)

-- Tạo VIEW View_IT_Enrollment_DB với WITH CHECK OPTION
-------------------------------------------------------
CREATE VIEW View_IT_Enrollment_DB AS
SELECT
    E.StudentID,
    E.CourseID,
    E.Score
FROM
    Enrollment E
JOIN
    Student S ON E.StudentID = S.StudentID
WHERE
    S.DeptID = 'IT'         -- Sinh viên thuộc khoa IT
    AND E.CourseID = 'C00001' -- Đăng ký môn C00001
WITH CHECK OPTION; -- Đảm bảo dữ liệu cập nhật không vi phạm điều kiện của View
DELIMITER $$

-- Viết Stored Procedure UpdateScore_IT_DB
CREATE PROCEDURE UpdateScore_IT_DB(
    IN p_StudentID CHAR(6),
    INOUT p_NewScore FLOAT
)
BEGIN
    -- Xử lý: Nếu p_NewScore > 10 -> gán lại = 10
    IF p_NewScore > 10.0 THEN
        SET p_NewScore = 10.0;
    END IF;

    -- Cập nhật điểm thông qua View View_IT_Enrollment_DB
    UPDATE View_IT_Enrollment_DB
    SET Score = p_NewScore
    WHERE StudentID = p_StudentID;
END$$

DELIMITER ;

-- Khai báo biến để nhận giá trị INOUT và truyền giá trị điểm mới
SET @newScore = 10.5;
SET @studentID = 'S00005'; -- Chọn một sinh viên Khoa IT đang học C00001

-- Gọi thủ tục để cập nhật điểm. @newScore sẽ được cập nhật thành 10.0
CALL UpdateScore_IT_DB(@studentID, @newScore);

-- Hiển thị lại giá trị điểm mới
SELECT CONCAT('Điểm mới đã cập nhật cho ', @studentID, ' là: ', @newScore) AS Result;

-- Kiểm tra dữ liệu trong View View_IT_Enrollment_DB
SELECT * FROM View_IT_Enrollment_DB WHERE StudentID = @studentID;