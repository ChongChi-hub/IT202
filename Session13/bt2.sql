-- [Giỏi 4] Kết hợp index vào truy vấn
-- Sử dụng EXPLAIN ANALYZE để kiểm tra lại kế hoạch thực thi trước và sau khi có chỉ mục.

-- 2) Tạo chỉ mục có tên idx_hometown trên cột hometown của bảng users
CREATE INDEX idx_hometown
ON users(hometown);

-- 3) Thực hiện truy vấn với các yêu cầu sau:

-- Viết một câu truy vấn để tìm tất cả các người dùng (users) có hometown là "Hà Nội"
EXPLAIN ANALYZE
SELECT * FROM users
WHERE hometown = 'Hà Nội';

-- Kết hợp với bảng posts để hiển thị thêm post_id và content về các lần đăng bài. 
EXPLAIN ANALYZE
SELECT
    u.user_id,
    u.username,
    p.post_id,
    p.content
FROM users u
JOIN posts p ON u.user_id = p.user_id;

-- Sắp xếp danh sách theo username giảm dần và giới hạn kết quả chỉ hiển thị 10 bài đăng đầu tiên.
EXPLAIN ANALYZE
SELECT
    u.user_id,
    u.username,
    p.post_id,
    p.content
FROM users u
JOIN posts p ON u.user_id = p.user_id
ORDER BY u.username
LIMIT 10;