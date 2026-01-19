create table lh (
	ma_lop varchar(50) primary key,
    ten_lop varchar(50),
    nam_hoc int 
);

create table sv (
	ma_sv varchar(50) primary key,
    ho_ten varchar (50),
    ngay_sinh datetime,
    ma_lop_hoc_thuoc_ve varchar(50),
    foreign key (ma_lop_hoc_thuoc_ve) references lh(ma_lop)
);