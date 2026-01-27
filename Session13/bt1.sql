-- [Giỏi 3] Thực hành với các loại chỉ mục

-- 2) Tạo chỉ mục phức hợp (Composite Index)
-- Tạo một truy vấn để tìm tất cả các bài viết (posts) trong năm 2026 của người dùng có user_id là 1. Trả về các cột post_id, content, và created_at.
SELECT * FROM posts
WHERE user_id = 1 AND YEAR(created_at) = 2026;

-- Tạo chỉ mục phức hợp với tên idx_created_at_user_id trên bảng posts sử dụng các cột created_at và user_id.
CREATE INDEX idx_created_at_user_id
ON posts (user_id, created_at);

-- Sử dụng EXPLAIN ANALYZE để kiểm tra kế hoạch thực thi của truy vấn trên trước và sau khi tạo chỉ mục idx_created_at_user_id. So sánh kết quả thực thi giữa hai lần này.
EXPLAIN ANALYZE
SELECT * FROM posts
WHERE user_id = 1 AND YEAR(created_at) = 2026;

-- 3) Tạo chỉ mục duy nhất (Unique Index)
-- Tạo một truy vấn để tìm tất cả các người dùng (users) có email là 'an@gmail.com'. Trả về các cột user_id, username, và email.
SELECT user_id, username, email
FROM users
WHERE email = 'an@gmail.com';

-- Tạo chỉ mục duy nhất với tên idx_email trên cột email trong bảng users.
CREATE UNIQUE INDEX idx_email
ON users (email);
/*
	Trước và sau khi tạo index thì câu truy vấn vẫn y hệt nhau bởi vì email được gán UNIQUE 
    -> MySQL tự tạo INDEX cho email ngay khi tạo bảng
*/

-- Sử dụng EXPLAIN ANALYZE để kiểm tra kế hoạch thực thi của truy vấn trên trước và sau khi tạo chỉ mục idx_email. So sánh kết quả thực thi giữa hai lần này.
EXPLAIN ANALYZE
SELECT user_id, username, email
FROM users
WHERE email = 'an@gmail.com';

-- 4) Xóa chỉ mục
-- Xóa chỉ mục idx_created_at_user_id khỏi bảng posts.
SHOW INDEX FROM posts;
SHOW INDEX FROM users;

-- Bước 1: Gỡ bỏ ràng buộc khóa ngoại trước
ALTER TABLE posts 
DROP FOREIGN KEY posts_fk_users;

-- Bước 2: Giờ thì bạn có thể xóa Index thoải mái
ALTER TABLE posts 
DROP INDEX idx_created_at_user_id;

-- Bước 3: Tạo lại khóa ngoại (MySQL sẽ tự động tạo lại index mặc định cho nó)
ALTER TABLE posts
ADD CONSTRAINT posts_fk_users 
FOREIGN KEY (user_id) REFERENCES users(user_id);

-- Xóa chỉ mục idx_email khỏi bảng users.
DROP INDEX idx_email ON users;

