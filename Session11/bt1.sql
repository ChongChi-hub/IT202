-- [Giỏi 3] Tham số INOUT trong thủ tục

-- 5) Xóa thủ tục mới khởi tạo trên 
DROP PROCEDURE IF EXISTS CalculateBonusPoints;

-- 2) Viết stored procedure tên CalculateBonusPoints nhận hai tham số:
DELIMITER $$

CREATE PROCEDURE CalculateBonusPoints(p_user_id INT, INOUT p_bonus_points INT)
BEGIN
	DECLARE v_post_count INT DEFAULT 0;
    
    SELECT COUNT(*) INTO v_post_count
    FROM posts
    WHERE user_id = p_user_id;
    
    IF v_post_count >= 20 THEN
		SET p_bonus_points = p_bonus_points + 100;
    ELSEIF v_post_count >= 10 THEN
        SET p_bonus_points = p_bonus_points + 50;
    END IF;
END $$

DELIMITER ;

SET @diem_hien_tai = 100;
CALL CalculateBonusPoints(1, @diem_hien_tai);
SELECT @diem_hien_tai AS 'Điểm sau khi thưởng';