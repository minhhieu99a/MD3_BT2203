Create DATABASE booktour;
use booktour;

CREATE TABLE thanhpho
(
    idT   INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    Tname varchar(40)
);

INSERT INTO thanhpho(Tname)
values ('Ninh Bình'),
       ('Huế'),
       ('Nha Trang'),
       ('Phú Quốc'),
       ('Lâm Đồng');

CREATE TABLE diemden
(
    idD    INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    dname  VARCHAR(40),
    dmota  TEXT,
    dprice double,
    idT    INT,
    FOREIGN KEY (idT) REFERENCES thanhpho (idT)
);

INSERT INTO diemden(dname, dmota, dprice, idT)
values ('Tràng An', 'Đi thuyền', 500000, 1),
       ('Cố đô Huế', 'Đi bộ', 1000000, 2),
       ('Hòn Tằm', 'Đi lặn và tắm biển', 15000000, 3),
       ('VinResort', 'Vui chơi ngắm thú ', 15000000, 4),
       ('Đà Lạt Mộng Mơ', 'Xe máy đi muốn nơi', 2000000, 5);

CREATE TABLE KH
(
    idKH      INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    KHname    varchar(30),
    KHcancuoc INT,
    KHnamsinh INT,
    idT       INT,
    FOREIGN KEY (idT) REFERENCES thanhpho (idT)
);

INSERT INTO KH(KHname, KHcancuoc, KHnamsinh, idT)
VALUES ('Nguyễn Văn A 1', 123456780, 1999, 1),
       ('Nguyễn Văn A 2', 123456781, 1998, 1),
       ('Nguyễn Văn A 3', 123456782, 1999, 2),
       ('Nguyễn Văn A 4', 123456783, 1998, 2),
       ('Nguyễn Văn A 5', 123456784, 1999, 3),
       ('Nguyễn Văn A 6', 123456785, 1987, 3),
       ('Nguyễn Văn A 7', 123456786, 1964, 4),
       ('Nguyễn Văn A 8', 123456787, 1997, 4),
       ('Nguyễn Văn A 9', 123456788, 2000, 5),
       ('Nguyễn Văn A 10', 123456789, 2002, 5);

CREATE TABLE Loaitour
(
    idLT        INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    MaLoaiTour  VARCHAR(10),
    TenLoaitour varchar(20)
);

INSERT INTO Loaitour(MaLoaiTour, TenLoaitour)
VALUES ('Bien', 'Xuống biển'),
       ('Nui', 'Lên núi');

CREATE TABLE Tour
(
    idTour      INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    maTour      VARCHAR(15),
    idLT        INT,
    Tprice      DOUBLE,
    ngaybatdau  DATE,
    ngayketthuc DATE,
    FOREIGN KEY (idLT) REFERENCES Loaitour (idLT)
);

INSERT INTO Tour(maTour, idLT, Tprice, ngaybatdau, ngayketthuc)
VALUES ('Bien1', 1, 1000000, '2022-1-25', '2022-1-30'),
       ('Bien2', 1, 10000000, '2022-2-1', '2022-2-4'),
       ('Bien3', 1, 15000000, '2022-1-27', '2022-1-31'),
       ('Bien4', 1, 7000000, '2022-1-15', '2022-1-20'),
       ('Bien5', 1, 8000000, '2022-1-10', '2022-1-13'),
       ('Nui1', 2, 5000000, '2022-1-25', '2022-1-27'),
       ('Nui2', 2, 9000000, '2022-1-22', '2022-1-31'),
       ('Nui3', 2, 10000000, '2022-2-2', '2022-2-6'),
       ('Nui4', 2, 4000000, '2022-2-1', '2022-2-3'),
       ('Nui5', 2, 15000000, '2022-2-5', '2022-2-14'),
        ('Nui6', 2, 1700000, '2022-2-4', '2022-2-9'),
        ('Nui7', 2, 1000000, '2022-1-25', '2022-1-26'),
        ('Nui8', 2, 6000000, '2022-2-5', '2022-2-7'),
        ('Bien6', 1, 10000000, '2022-2-10', '2022-2-20'),
        ('Bien7', 1, 1100000, '2022-2-2', '2022-2-5'),
        ('Bien8', 1, 8000000, '2022-2-10', '2022-2-14');
CREATE TABLE hoadon
(
    idHD   INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
    idTour INT,
    idKH   INT,
    status BOOLEAN,
    FOREIGN KEY (idTour) REFERENCES Tour (idTour),
    FOREIGN KEY (idKH) REFERENCES KH (idKH)
);
INSERT INTO hoadon(idTour, idKH, status)
VALUES (1, 1, true),
       (1, 2, true),
       (1, 3, true),
       (1, 4, true),
       (3, 5, true),
       (3, 6, true),
       (3, 7, true),
       (6, 8, true),
       (6, 8, true),
       (6, 9, true),
       (6, 10, true);

Alter TABLE Tour
ADD idD INT;

ALTER TABLE Tour ADD CONSTRAINT FOREIGN KEY (idD)REFERENCES diemden(idD);


SELECT *FROM thanhpho;
SELECT *FROM diemden;
Select *FROM KH;
SELECT *FROM loaitour;
SELECT *FROM Tour;
SELECT *FROM hoadon;

SELECT t.Tname,count(t2.idTour) FROM thanhpho t join diemden d on t.idT = d.idT join tour t2 on d.idD = t2.idD GROUP BY t.Tname;
SELECT count(idTour) as 'Số tour bắt đầu trong tháng 1' FROM tour WHERE MONTH(ngaybatdau)=1 AND YEAR(ngaybatdau)=2022;
SELECT count(idTour) as 'Số tour kết thúc trong tháng 2' FROM tour WHERE MONTH(ngayketthuc)=2 AND YEAR(ngaybatdau)=2022;
