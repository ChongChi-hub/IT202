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