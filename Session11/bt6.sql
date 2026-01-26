-- [Xuất sắc 6] Procedure đăng bài viết mới và tự động gửi thông báo cho bạn bè

-- 5) Xóa thủ tục vừa khởi tạo trên
DROP PROCEDURE IF EXISTS NotifyFriendsOnNewPost;

/*
2)  Viết stored procedure tên NotifyFriendsOnNewPost nhận hai tham số IN:
	p_user_id (INT) – ID của người đăng bài
	p_content (TEXT) – Nội dung bài viết
    
	Procedure sẽ thực hiện hai việc:
	- Thêm một bài viết mới vào bảng posts với user_id và content được truyền vào.
	- Tự động gửi thông báo loại 'new_post' vào bảng notifications cho tất cả bạn bè đã accepted (cả hai chiều trong bảng friends).
	- Nội dung thông báo: “[full_name của người đăng] đã đăng một bài viết mới”.
	- Không gửi thông báo cho chính người đăng bài.
*/

DROP PROCEDURE IF EXISTS NotifyFriendsOnNewPost;

DELIMITER $$

CREATE PROCEDURE NotifyFriendsOnNewPost(
    IN p_user_id INT,
    IN p_content TEXT
)
BEGIN
    DECLARE v_poster_name VARCHAR(100);
    
    DECLARE v_friend_id INT;
    DECLARE done INT DEFAULT FALSE; 
    
    DECLARE cur_friends CURSOR FOR 
        SELECT user_id FROM friends WHERE user_id = p_user_id AND status = 'accepted'
        UNION
        SELECT user_id FROM friends WHERE user_id = p_user_id AND status = 'accepted';
        
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    INSERT INTO posts(user_id, content) 
    VALUES (p_user_id, p_content);

    SELECT full_name INTO v_poster_name 
    FROM users 
    WHERE user_id = p_user_id;

    OPEN cur_friends;

    read_loop: LOOP
        FETCH cur_friends INTO v_friend_id;
        
        IF done THEN
            LEAVE read_loop;
        END IF;

        IF v_friend_id != p_user_id THEN
            INSERT INTO notifications(user_id, message, type)
            VALUES (
                v_friend_id, 
                CONCAT(v_poster_name, ' đã đăng một bài viết mới'), 
                'new_post'
            );
        END IF;
        
    END LOOP;

    CLOSE cur_friends;
    
END $$

DELIMITER ;

-- 3) Gọi procedue trên và thêm bài viết mới 
CALL NotifyFriendsOnNewPost(1, 'tôi là siêu nhân gao');

-- 4) Select ra những thông báo của bài viết vừa đăng
SELECT * FROM notifications;


