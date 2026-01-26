-- [Giỏi 4] Procedure thêm bài viết với kiểm tra nội dung

-- 5) Xóa thủ tục vừa khởi tạo trên
DROP PROCEDURE IF EXISTS CreatePostWithValidation;

/*
2) Viết procedure tên CreatePostWithValidation nhận IN p_user_id (INT), 
IN p_content (TEXT). Nếu độ dài content < 5 ký tự thì không thêm bài viết và SET một biến thông báo lỗi (có thể dùng 
OUT result_message VARCHAR(255) để trả về thông báo “Nội dung quá ngắn” hoặc “Thêm bài viết thành công”).
*/

DELIMITER $$

CREATE PROCEDURE CreatePostWithValidation(p_user_id INT, p_content TEXT, OUT result_message VARCHAR(255))
BEGIN
	DECLARE content_length INT DEFAULT CHAR_LENGTH(p_content);
    
    IF content_length < 5 THEN
		SET result_message = 'Nội dung quá ngắn';
	ELSE
		INSERT INTO posts(user_id, content)
        VALUES (p_user_id, p_content);
        
		SET result_message = 'Thêm bài viết thành công';
        
	END IF;
END $$

DELIMITER ;

CALL CreatePostWithValidation(1, 'Lỗi', @ketQua);

SELECT @ketQua AS 'Trạng thái thực hiện';

SELECT post_id, content, created_at 
FROM posts 
WHERE user_id = 1 
ORDER BY created_at DESC 
LIMIT 5;

