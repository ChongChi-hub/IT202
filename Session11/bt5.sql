-- [Xuất Sắc 5] Procedure tính điểm hoạt động của user

/*
2) 	Viết procedure tên CalculateUserActivityScore nhận IN p_user_id (INT), trả về OUT activity_score (INT). 
	Điểm được tính: mỗi post +10 điểm, mỗi comment +5 điểm, mỗi like nhận được +3 điểm. 
	Sử dụng CASE hoặc IF để phân loại mức hoạt động (ví dụ: >500 “Rất tích cực”, 200-500 “Tích cực”, <200 “Bình thường”) 
	và trả thêm OUT activity_level (VARCHAR(50)).
*/

DROP PROCEDURE IF EXISTS CalculateUserActivityScore;

DELIMITER $$

CREATE PROCEDURE CalculateUserActivityScore(
	IN p_user_id INT, 
    OUT activity_score INT, 
    OUT activity_level VARCHAR(50)
)
BEGIN
	DECLARE v_posts INT DEFAULT 0;
    DECLARE v_comments INT DEFAULT 0;
    DECLARE v_likes_received INT DEFAULT 0;
    
    SELECT
		(SELECT COUNT(*) FROM posts WHERE user_id = p_user_id),
        (SELECT COUNT(*) FROM comments WHERE user_id = p_user_id),
        (SELECT COUNT(*) FROM likes WHERE user_id = p_user_id)
	INTO v_posts, v_comments, v_likes_received;
	
	SET activity_score = (v_posts * 10) + (v_comments * 5) + (v_likes_received * 3);
    
    SET activity_level = CASE
		WHEN activity_score > 500 THEN 'Rất tích cực'
        WHEN activity_score >= 200 THEN 'Tích cực'
        ELSE 'Bình thường'
	END;
END $$

DELIMITER ;

-- 3) Gọi thủ tục trên select ra activity_score và activity_level
CALL CalculateUserActivityScore(1, @activityScore, @activityLevel);
SELECT @activityScore, @activityLevel;