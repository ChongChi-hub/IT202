-- [Khá 1] Thực hiện phép JOIN trong view
-- Tạo một view tên view_user_post hiển thị danh sách các User với các cột: user_id(mã người dùng) và total_user_post (Tổng số bài viết mà từng người dùng đã đăng).
CREATE OR REPLACE VIEW view_user_post AS
SELECT user_id, COUNT(post_id) AS total_user_post
FROM posts
GROUP BY user_id;

-- 3) Tiến hành hiển thị lại view_user_post để kiểm chứng
SELECT * FROM view_user_post;

-- Kết hợp view view_user_post với bảng users để hiển thị các cột: full_name(họ tên) và  total_user_post (Tổng số bài viết mà từng người dùng đã đăng).
CREATE OR REPLACE VIEW view_user_post AS
SELECT 
    u.user_id, 
    u.full_name, 
    COUNT(p.post_id) AS total_user_post
FROM users u               
LEFT JOIN posts p           
    ON u.user_id = p.user_id
GROUP BY u.user_id, u.full_name;