-- [Khá 2] Kết hợp IN, OUT trong thao tác với thủ tục

-- 4) Xóa thủ tục vừa mới tạo trên
DROP PROCEDURE IF EXISTS CalculatePostLikes;

-- 2) Tính tổng like của bài viết
-- Viết stored procedure CalculatePostLikes nhận vào:
DELIMITER $$

CREATE PROCEDURE CalculatePostLikes(p_post_id INT, OUT total_likes INT)
BEGIN
	SELECT COUNT(*) INTO total_likes
    FROM likes
    WHERE post_id = p_post_id;
END $$

DELIMITER ;

-- 3) Thực hiện gọi stored procedure CalculatePostLikes với một post cụ thể và truy vấn giá trị của tham số OUT total_likes sau khi thủ tục thực thi.
CALL CalculatePostLikes(101, @my_total);
SELECT @my_total AS 'Tổng số like';