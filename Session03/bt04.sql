-- SINH VIEN --
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


-- MÔN HỌC --
create table subjects (
	subject_id int primary key,
    subject_name varchar(255),
    credit int,
    check(credit > 0)
);

insert into subjects(subject_id, subject_name, credit)
values 
	(1, 'Toán cao cấp', 3),
	(2, 'Toán rời rạc', 4),
    (3, 'Toán siêu cấp', 5),
    (4, 'Toán đẳng cấp', 6),
    (5, 'Toán tối thượng', 7);
		
select * from subjects;

update subjects set credit = 10 where subject_id = '1';

update subjects set subject_name = 'Toán vip pro' where subject_id = '1';



-- ĐƠN ĐĂNG KÝ --
create table enrollments (
	student_id int,
    subject_id int,
    enroll_date date,
    primary key(student_id, subject_id),
    foreign key (student_id) references students(student_id),
    foreign key (subject_id) references subjects(subject_id)
);

insert into enrollments(student_id, subject_id, enroll_date) 
values 
	(1, 5, '2026-02-13'),
    (2, 4, '2026-02-12'),
    (3, 3, '2026-02-11'),
    (4, 2, '2026-02-10'),
    (5, 1, '2026-02-09');

select * from enrollments;

select * from enrollments 
where student_id = 1; 
