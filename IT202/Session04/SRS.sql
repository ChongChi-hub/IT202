create database hoc_truc_tuyen;
use hoc_truc_tuyen;

CREATE TABLE Teacher (
    MaGV VARCHAR(10) PRIMARY KEY,
    HoTen VARCHAR(50) NOT NULL,
    Email VARCHAR(50)
);

CREATE TABLE Student (
    MaSV VARCHAR(10) PRIMARY KEY,
    HoTen VARCHAR(50) NOT NULL,
    NgaySinh DATE,
    Email VARCHAR(50) UNIQUE
);

CREATE TABLE Course (
    MaKH VARCHAR(10) PRIMARY KEY,
    TenKH VARCHAR(100) NOT NULL,
    MoTaNgan VARCHAR(255),
    SoBuoiHoc INT,
    MaGV_PhuTrach VARCHAR(10),
    FOREIGN KEY (MaGV_PhuTrach) REFERENCES Teacher(MaGV)
);

CREATE TABLE Enrollment (
    MaSV VARCHAR(10),
    MaKH VARCHAR(10),
    NgayDangKy DATE,
    PRIMARY KEY (MaSV, MaKH),
    FOREIGN KEY (MaSV) REFERENCES Student(MaSV),
    FOREIGN KEY (MaKH) REFERENCES Course(MaKH)
);

CREATE TABLE Score (
    MaSV VARCHAR(10),
    MaKH VARCHAR(10),
    DiemGiuaKy DECIMAL(4, 2),
    DiemCuoiKy DECIMAL(4, 2),
    PRIMARY KEY (MaSV, MaKH),
    CHECK (DiemGiuaKy >= 0 AND DiemGiuaKy <= 10),
    CHECK (DiemCuoiKy >= 0 AND DiemCuoiKy <= 10),
    FOREIGN KEY (MaSV) REFERENCES Student(MaSV),
    FOREIGN KEY (MaKH) REFERENCES Course(MaKH)
);