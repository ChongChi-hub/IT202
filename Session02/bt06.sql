CREATE TABLE class (
    ma_lop VARCHAR(50) PRIMARY KEY,
    ten_lop VARCHAR(100),
    nien_khoa VARCHAR(20)
);

CREATE TABLE teacher (
    ma_gv VARCHAR(50) PRIMARY KEY,
    ho_ten VARCHAR(50) NOT NULL,
    email VARCHAR(100),
    UNIQUE(email)
);

CREATE TABLE subject (
    ma_mon_hoc VARCHAR(50) PRIMARY KEY,
    ten_mon_hoc VARCHAR(50),
    so_tin_chi INT,
    ma_gv_phu_trach VARCHAR(50),
    CHECK (so_tin_chi > 0),
    FOREIGN KEY (ma_gv_phu_trach) REFERENCES teacher(ma_gv)
);

CREATE TABLE student (
    ma_sv VARCHAR(50) PRIMARY KEY,
    ho_ten VARCHAR(50),
    ma_lop VARCHAR(50),
    FOREIGN KEY (ma_lop) REFERENCES class(ma_lop)
);

CREATE TABLE enrollment (
    ma_sv VARCHAR(50),
    ma_mon_hoc VARCHAR(50),
    PRIMARY KEY (ma_sv, ma_mon_hoc),
    FOREIGN KEY (ma_sv) REFERENCES student(ma_sv),
    FOREIGN KEY (ma_mon_hoc) REFERENCES subject(ma_mon_hoc)
);

CREATE TABLE score (
    ma_sv VARCHAR(50),
    ma_mon_hoc VARCHAR(50),
    diem_qua_trinh FLOAT,
    diem_cuoi_ky FLOAT,
    PRIMARY KEY (ma_sv, ma_mon_hoc),
    CHECK (diem_qua_trinh >= 0 AND diem_qua_trinh <= 10),
    CHECK (diem_cuoi_ky >= 0 AND diem_cuoi_ky <= 10),
    FOREIGN KEY (ma_sv) REFERENCES student(ma_sv),
    FOREIGN KEY (ma_mon_hoc) REFERENCES subject(ma_mon_hoc)
);