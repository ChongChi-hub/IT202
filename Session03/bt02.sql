create table students (
	student_id int primary key,
    full_name varchar(100) not null,
    dob date not null,
    email varchar(100) unique
);

insert into students (student_id, full_name, dob, email)
values 
	(1, 'Nguyễn Văn An', '2004-05-15', 'an.nguyen@email.com'),
    (2, 'Trần Thị Bích', '2004-08-20', 'bich.tran@email.com'),
    (3, 'Lê Hoàng Cường', '2003-12-10', 'cuong.le@email.com'),
    (4, 'Đinh Văn Tý', '2002-12-12', 'ty.dinh@gmail.com'),
    (5, 'Trương Văn Thành', '1999-03-09', 'thanh.truong@gmail.com');
    
-- lấy ra tất cả thông tin sinh viên    
select * from students;
-- lấy ra thông tin cụ thể
select student_id, full_name from students;

-- chọn bảng cần sửa
update students set email = 'cuong.le.new@gmail.com' where student_id = 3;

update students set dob = '2006-09-21' where student_id = 2;

delete from students where student_id = 5;