DROP DATABASE IF EXISTS StudentManagement;
CREATE DATABASE StudentManagement;
USE StudentManagement;

-- Bảng Students
CREATE TABLE Students (
    StudentID CHAR(5) PRIMARY KEY,
    FullName VARCHAR(50) NOT NULL,
    TotalDebt DECIMAL(10,2) DEFAULT 0
);

-- Bảng Subjects
CREATE TABLE Subjects (
    SubjectID CHAR(5) PRIMARY KEY,
    SubjectName VARCHAR(50) NOT NULL,
    Credits INT CHECK (Credits > 0)
);

-- Bảng Grades
CREATE TABLE Grades (
    StudentID CHAR(5),
    SubjectID CHAR(5),
    Score DECIMAL(4,2) CHECK (Score BETWEEN 0 AND 10),
    PRIMARY KEY (StudentID, SubjectID),
    CONSTRAINT FK_Grades_Students FOREIGN KEY (StudentID) REFERENCES Students(StudentID),
    CONSTRAINT FK_Grades_Subjects FOREIGN KEY (SubjectID) REFERENCES Subjects(SubjectID)
);

-- Bảng GradeLog
CREATE TABLE GradeLog (
    LogID INT PRIMARY KEY AUTO_INCREMENT,
    StudentID CHAR(5),
    OldScore DECIMAL(4,2),
    NewScore DECIMAL(4,2),
    ChangeDate DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Dữ liệu mẫu ban đầu
INSERT INTO Students (StudentID, FullName, TotalDebt) VALUES 
('SV01', 'Ho Khanh Linh', 5000000),
('SV03', 'Tran Thi Khanh Huyen', 0);

INSERT INTO Subjects (SubjectID, SubjectName, Credits) VALUES 
('SB01', 'Co so du lieu', 3),
('SB02', 'Lap trinh Java', 4),
('SB03', 'Lap trinh C', 3);

INSERT INTO Grades (StudentID, SubjectID, Score) VALUES 
('SV01', 'SB01', 8.5), -- Đã qua môn
('SV03', 'SB02', 3.0); -- Trượt môn

DELIMITER $$
CREATE TRIGGER tg_CheckScore
BEFORE INSERT ON Grades
FOR EACH ROW
BEGIN
    IF NEW.Score < 0 THEN
        SET NEW.Score = 0;
    ELSEIF NEW.Score > 10 THEN
        SET NEW.Score = 10;
    END IF;
END$$
START TRANSACTION;

-- Thêm sinh viên mới
INSERT INTO Students (StudentID, FullName)
VALUES ('SV02', 'Ha Bich Ngoc'); 

-- Cập nhật nợ học phí
UPDATE Students
SET TotalDebt = 5000000.00
WHERE StudentID = 'SV02'; 

COMMIT; -- Xác nhận Transaction
CREATE TRIGGER tg_LogGradeUpdate
AFTER UPDATE ON Grades
FOR EACH ROW
BEGIN
    -- Chỉ chèn log nếu điểm số thực sự thay đổi
    IF OLD.Score <> NEW.Score THEN
        INSERT INTO GradeLog (StudentID, OldScore, NewScore, ChangeDate)
        VALUES (OLD.StudentID, OLD.Score, NEW.Score, NOW());
    END IF;
END$$
CREATE PROCEDURE sp_PayTuition(
    IN p_StudentID CHAR(5),
    IN p_PaymentAmount DECIMAL(10,2) -- Số tiền đóng
)
BEGIN
    DECLARE v_new_debt DECIMAL(10,2);
    
    START TRANSACTION;
    
    -- Trừ tiền học phí
    UPDATE Students
    SET TotalDebt = TotalDebt - p_PaymentAmount
    WHERE StudentID = p_StudentID;
    
    -- Lấy TotalDebt mới
    SELECT TotalDebt INTO v_new_debt
    FROM Students
    WHERE StudentID = p_StudentID;
    
    -- Kiểm tra logic
    IF v_new_debt < 0 THEN
        ROLLBACK;
        -- Phát sinh lỗi để thông báo
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Lỗi: Số tiền thanh toán vượt quá nợ hiện tại. Giao dịch bị hủy.';
    ELSE
        COMMIT;
    END IF;
END$$
CREATE PROCEDURE sp_DeleteStudentGrade(
    IN p_StudentID CHAR(5),
    IN p_SubjectID CHAR(5)
)
BEGIN
    DECLARE v_CurrentScore DECIMAL(4,2);
    
    START TRANSACTION; -- Bắt đầu Transaction
    
    -- Lấy điểm hiện tại trước khi xóa để log (vì OLD/NEW không dùng được trong Stored Procedure)
    SELECT Score INTO v_CurrentScore
    FROM Grades
    WHERE StudentID = p_StudentID AND SubjectID = p_SubjectID;
    
    -- Nếu điểm tồn tại
    IF v_CurrentScore IS NOT NULL THEN
        -- Lưu điểm hiện tại vào bảng GradeLog (OldScore = điểm cũ, NewScore = NULL)
        INSERT INTO GradeLog (StudentID, OldScore, NewScore, ChangeDate)
        VALUES (p_StudentID, v_CurrentScore, NULL, NOW());
        
        -- Thực hiện lệnh xóa
        DELETE FROM Grades
        WHERE StudentID = p_StudentID AND SubjectID = p_SubjectID;
        
        -- Kiểm tra ROW_COUNT()
        IF ROW_COUNT() = 0 THEN
            -- Không tìm thấy dòng nào được xóa
            ROLLBACK;
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Lỗi: Xóa thất bại. Không tìm thấy dòng dữ liệu tương ứng.';
        ELSE
            -- Xóa thành công
            COMMIT;
        END IF;
    ELSE
        ROLLBACK;
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Lỗi: Không tìm thấy điểm để xóa. Giao dịch bị hủy.';
    END IF;
END$$