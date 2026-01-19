create table student (
	ma_sv varchar(50) primary key,
    ho_ten varchar(50)
);

create table subject (
	ma_mon_hoc varchar(50) primary key,
    ten_mon_hoc varchar (50),
    ma_gv_phu_trach varchar(50),
    so_tin_chi int,
    check (so_tin_chi > 0),
    foreign key (ma_gv_phu_trach) references teacher(ma_gv)
);

create table enrollment (
	ma_sv varchar(50),
    ma_mon_hoc varchar(50),
    foreign key (ma_sv) references student(ma_sv),
    foreign key (ma_mon_hoc) references subject(ma_mon_hoc)
);

create table teacher (
	ma_gv varchar(50) primary key,
    ho_ten varchar(50) not null,
    email varchar(20), 
    unique(email)
);

CREATE TABLE score (
    ma_sv VARCHAR(50),
    ma_mon_hoc VARCHAR(50),
    
    diem_qua_trinh FLOAT,
    diem_cuoi_ky FLOAT,

    PRIMARY KEY (ma_sv, ma_mon_hoc),
    
    FOREIGN KEY (ma_sv) REFERENCES student(ma_sv),
    FOREIGN KEY (ma_mon_hoc) REFERENCES subject(ma_mon_hoc),
    
    CHECK (diem_qua_trinh >= 0 AND diem_qua_trinh <= 10),
    CHECK (diem_cuoi_ky >= 0 AND diem_cuoi_ky <= 10)
);