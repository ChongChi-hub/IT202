create table student (
	ma_sv varchar(50) primary key,
    ho_ten varchar(50)
);

create table subject (
	ma_mon_hoc varchar(50) primary key,
    ten_mon_hoc varchar (50),
    so_tin_chi int,
    check (so_tin_chi > 0)
);

create table enrollment (
	ma_sv varchar(50) primary key,
    ma_mon_hoc varchar(50) primary key,
    foreign key (ma_sv) references student(ma_sv),
    foreign key (ma_mon_hoc) references subject(ma_mon_hoc)
);