create table student (
	ma_sv varchar(50) primary key,
    ho_ten varchar(50)
);

create table object (
	ma_mon_hoc varchar(50) primary key,
    ten_mon_hoc varchar (50),
    so_tin_chi int,
    check (so_tin_chi > 0)
);