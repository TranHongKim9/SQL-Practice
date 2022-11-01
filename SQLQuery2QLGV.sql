--QUẢN LÝ GIÁO VỤ
CREATE TABLE KHOA
(
MAKHOA varchar(4) primary key,
TENKHOA varchar(40),
NGTLAP smalldatetime,
TRGKHOA char(4)
)
ALTER TABLE KHOA ADD CONSTRAINT PK_GV foreign key (TRGKHOA) references GIAOVIEN(MAGV)

CREATE TABLE MONHOC 
(
MAMH varchar(10) primary key,
TENMH varchar(40),
TCLT tinyint,
TCTH tinyint,
MAKHOA varchar(4)
)
CREATE TABLE DIEUKIEN
(
MAMH varchar(10) foreign key 
		references MONHOC(MAMH),
MAMH_TRUOC varchar(10) foreign key
			referenceS MONHOC(MAMH),
constraint PK_MAMHTRUOC primary key  (MAMH, MAMH_TRUOC)
)

CREATE TABLE GIAOVIEN
(
MAGV char(4) primary key ,
HOTEN varchar(40),
HOCVI varchar(10),
HOCHAM varchar(10),
GIOITINH varchar(3),
NGSINH smalldatetime,
NGVL smalldatetime,
HESO numeric(4,2),
MUCLUONG money,
MAKHOA varchar(4)
)
CREATE TABLE LOP
(
MALOP char(3) primary key,
TENLOP varchar(40),
TRGLOP char(5),
SISO tinyint,
MAGVCN char(4)
)
ALTER TABLE LOP ADD CONSTRAINT PK_HV foreign key (TRGLOP) references HOCVIEN(MAHV)
CREATE TABLE HOCVIEN
(
MAHV char(5) primary key,
HO varchar(40),
TEN varchar(10),
NGSINH smalldatetime,
GIOITINH varchar(3),
NOISINH varchar(40),
MALOP char(3)
)
CREATE TABLE GIANGDAY
(
MALOP char(3) foreign key
				references LOP(MALOP),
MAMH varchar(10) foreign key
				references MONHOC(MAMH),
MAGV char(4),
HOCKY tinyint,
NAM smallint,
TUNGAY smalldatetime,
DENNGAY smalldatetime,
constraint PK_GIANGDAY primary key(MALOP, MAMH)
)
CREATE TABLE KETQUATHI
(
MAHV char(5) foreign key 
			references HOCVIEN(MAHV),
MAMH varchar(10) foreign key
			references MONHOC(MAMH),
LANTHI tinyint,
NGTHI smalldatetime,
DIEM numeric(4,2),
KQUA varchar(10)
CONSTRAINT PK_KETQUATHI primary key (MAHV, MAMH, LANTHI)
)

--CÂU 1: Tạo quan hệ và khai báo tất cả các ràng buộc khóa chính, khóa ngoại. Thêm vào 3 thuộc tính, GHICHU, DIEMTB, XEPLOAI cho quan hệ HOCVIEN
ALTER TABLE HOCVIEN ADD GHICHU varchar(20)
ALTER TABLE HOCVIEN ADD DIEMTB float
ALTER TABLE HOCVIEN ADD XEPLOAI varchar(20)
--Câu 2: Mã học viên là một chuỗi 5 ký tự, 3 ký tự đầu là mã lớp, 2 ký tự cuối cùng là số thứ tự học viên trong lớp. VD: “K1101”
ALTER TABLE HOCVIEN ADD CONSTRAINT CK_MAHV CHECK (MAHV LIKE 'K[0-9][0-9][0-9][0-9]')
--CÂU 3: Thuộc tính GIOITINH chỉ có giá trị là “Nam” hoặc “Nu”.
ALTER TABLE HOCVIEN ADD CONSTRAINT CK_GIOITINH CHECK (GIOITINH IN ('Nam','Nu'))
--Câu 4: Điểm số của một lần thi có giá trị từ 0 đến 10 và cần lưu đến 2 số lẽ (VD: 6.22)
ALTER TABLE KETQUATHI ADD CONSTRAINT CK_DIEMTHI CHECK(DIEM>=0 AND DIEM<=10)
--Câu 5: Kết quả thi là “Dat” nếu điểm từ 5 đến 10 và “Khong dat” nếu điểm nhỏ hơn 5
ALTER TABLE KETQUATHI ADD CONSTRAINT CK_KQUA CHECK(KQUA IN ('Dat','Khong dat'))
--Câu 6: Học viên thi một môn tối đa 3 lần
ALTER TABLE KETQUATHI ADD CONSTRAINT CK_SOLANTHI CHECK (LANTHI<=3)
--Câu 7: Học kỳ chỉ có giá trị từ 1 đến 3
ALTER TABLE GIANGDAY ADD CONSTRAINT CK_HOCKY CHECK (HOCKY>=1 AND HOCKY<=3)
--Câu 8: Học vị của giáo viên chỉ có thể là “CN”, “KS”, “Ths”, ”TS”, ”PTS”
ALTER TABLE GIAOVIEN ADD CONSTRAINT CK_HOCVI CHECK (HOCVI IN ('CN','KS','Ths','TS','PTS'))
--Giáo viên
Insert into GIAOVIEN values('GV01', 'Ho Thanh Son', 'PTS', 'GS', 'Nam', '1950-5-2', '2004-1-11', '5.00', '2,250,000', 'KHMT')
Insert into GIAOVIEN values('GV02', 'Tran Tam Thanh', 'TS', 'PGS', 'Nam', '1965-12-17','2004-4-20', '4.50', '2,025,000','HTTT') 
Insert into GIAOVIEN values('GV03', 'Do Nghiem Phung', 'TS', 'GS', 'Nu', '1950-8-1','2004-9-23', '4.00', '1,800,000', 'CNPM')
Insert into GIAOVIEN values('GV04', 'Tran Nam Son', 'TS', 'PGS', 'Nam', '1961-2-22', '2005-1-12', '4.50', '2,025,000', 'KTMT')
Insert into GIAOVIEN values('GV05', 'Mai Thanh Danh', 'ThS', 'GV', 'Nam', '1958-3-12', '2005-1-12', '3.00', '1,350,000', 'HTTT')
Insert into GIAOVIEN values('GV06', 'Tran Doan Hung', 'TS', 'GV', 'Nam', '1953-3-11', '2005-1-12', '4.50', '2,025,000', 'KHMT')
Insert into GIAOVIEN values('GV07', 'Nguyen Minh Tien', 'ThS', 'GV', 'Nam', '1971-11-23','2005-3-1', '4.00', '1,800,000', 'KHMT')
Insert into GIAOVIEN values('GV08', 'Le Thi Tran', 'KS', Null, 'Nu', '1974-3-26', '2005-3-1', '1.69', '760,500', 'KHMT')
Insert into GIAOVIEN values('GV09', 'Nguyen To Lan', 'ThS', 'GV', 'Nu', '1966-12-31', '2005-3-1', '4.00', '1,800,000', 'HTTT')
Insert into GIAOVIEN values('GV10', 'Le Tran Anh Loan', 'KS', Null, 'Nu', '1972-7-17', '2005-3-1', '1.86', '837,000', 'CNPM')
Insert into GIAOVIEN values('GV11', 'Ho Thanh Tung', 'CN', 'GV', 'Nam', '1980-1-12', '2005-5-15', '2.67', '1,201,500', 'MTT')
Insert into GIAOVIEN values('GV12', 'Tran Van Anh', 'CN', Null, 'Nu', '1981-3-29', '2005-5-15', '1.69', '760,500', 'CNPM')
Insert into GIAOVIEN values('GV13', 'Nguyen Linh Dan', 'CN', Null, 'Nu', '1980-5-23','2005-5-15', '1.69', '760,500', 'KTMT')
Insert into GIAOVIEN values('GV14', 'Truong Minh Chau', 'ThS', 'GV', 'Nu', '1976-11-30', '2005-5-15', '3.00', '1,350,000', 'MTT')
Insert into GIAOVIEN values('GV15', 'Le Ha Thanh', 'ThS', 'GV', 'Nam', '1978-5-4', '2005-5-15', '3.00', '1,350,000', 'KHMT')
Select * from GIAOVIEN
--Học viên
ALTER TABLE HOCVIEN DROP COLUMN GHICHU
ALTER TABLE HOCVIEN DROP COLUMN DIEMTB
ALTER TABLE HOCVIEN DROP COLUMN XEPLOAI
INSERT INTO HOCVIEN VALUES ('K1101', 'Nguyen Van','A','1986-01-27','Nam','TpHCM','K11')
INSERT INTO HOCVIEN VALUES ('K1102', 'Tran Ngoc','Han','1986-03-14','Nu','Kien Giang','K11')
INSERT INTO HOCVIEN VALUES ('K1103', 'Ha Duy','Lap','1986-04-18','Nam','Nghe An','K11')
INSERT INTO HOCVIEN VALUES ('K1104', 'Tran Ngoc','Linh','1986-03-30','Nu','Tay Ninh','K11')
INSERT INTO HOCVIEN VALUES ('K1105', 'Tran Minh','Long','1986-02-27','Nam','TpHCM','K11')
INSERT INTO HOCVIEN VALUES ('K1106', 'Le Nhat','Minh','1986-01-24','Nam','TpHCM','K11')
INSERT INTO HOCVIEN VALUES ('K1107', 'Nguyen Nhu','Nhut','1986-01-27','Nam','Ha Noi','K11')
INSERT INTO HOCVIEN VALUES ('K1108', 'Nguyen Manh','Tam','1986-02-27','Nam','Kien Giang','K11')
INSERT INTO HOCVIEN VALUES ('K1109', 'Phan Thi Thanh','Tam','1986-01-27','Nu','Vinh Long','K11')
INSERT INTO HOCVIEN VALUES ('K1110', 'Le Hoai','Thuong','1986-02-05','Nu','Can Tho','K11')
INSERT INTO HOCVIEN VALUES ('K1111', 'Le Ha','Vinh','1986-12-25','Nam','Vĩnh Long','K11')
INSERT INTO HOCVIEN VALUES ('K1201', 'Nguyen Van','B','1986-02-11','Nam','TpHCM','K12')
INSERT INTO HOCVIEN VALUES ('K1202', 'Nguyen Thi Kim','Duyen','1986-01-18','Nu','TpHCM','K12')
INSERT INTO HOCVIEN VALUES ('K1203', 'Tran Thi Kim','Duyen','1986-09-17','Nu','TpHCM','K12')
INSERT INTO HOCVIEN VALUES ('K1204', 'Truong My','Hanh','1986-05-19','Nu','Dong Nai','K12')
INSERT INTO HOCVIEN VALUES ('K1205', 'Nguyen Thanh','Nam','1986-04-17','Nam','TpHCM','K12')
INSERT INTO HOCVIEN VALUES ('K1206', 'Nguyen Thi Truc','Thanh','1986-03-04','Nu','Kien Giang','K12')
INSERT INTO HOCVIEN VALUES ('K1207', 'Tran Thi Bich','Thuy','1986-02-08','Nu','Nghe An','K12')
INSERT INTO HOCVIEN VALUES ('K1208', 'Huynh Thi Kim','Trieu','1986-04-08','Nu','Tay Ninh','K12')
INSERT INTO HOCVIEN VALUES ('K1209', 'Pham Thanh','Trieu','1986-02-23','Nam','TpHCM','K12')
INSERT INTO HOCVIEN VALUES ('K1210', 'Ngo Thanh','Tuan','1986-02-14','Nam','TpHCM','K12')
INSERT INTO HOCVIEN VALUES ('K1211', 'Do Thi','Xuan','1986-03-09','Nu','Ha Noi','K12')
INSERT INTO HOCVIEN VALUES ('K1212', 'Le Thi Phi','Yen','1986-03-12','Nu','Vinh Long','K11')
INSERT INTO HOCVIEN VALUES ('K1301', 'Nguyen Thi Kim','Cuc','1986-06-09','Nu','Kien Giang','K13')
INSERT INTO HOCVIEN VALUES ('K1302', 'Truong Thi My','Hien','1986-03-18','Nu','Nghe An','K13')
INSERT INTO HOCVIEN VALUES ('K1303', 'Le Duc','Hien','1986-03-21','Nam','Tay Ninh','K13')
INSERT INTO HOCVIEN VALUES ('K1304', 'Le Quang','Hien','1986-04-18','Nam','TpHCM','K13')
INSERT INTO HOCVIEN VALUES ('K1305', 'Le Thi ','Huong','1986-03-27','Nu','TpHCM','K13')
INSERT INTO HOCVIEN VALUES ('K1306', 'Nguyen Thai','Huu','1986-03-30','Nam','Ha Noi','K13')
INSERT INTO HOCVIEN VALUES ('K1307', 'Tran Minh','Man','1986-05-28','Nam','TpHCM','K13')
INSERT INTO HOCVIEN VALUES ('K1308', 'Nguyen Hieu','Nghia','1986-04-08','Nam','Kien Giang','K13')
INSERT INTO HOCVIEN VALUES ('K1309', 'Nguyen Trung','Nghia','1986-01-18','Nam','Nghe An','K13')
INSERT INTO HOCVIEN VALUES ('K1310', 'Tran Thi Hong','Tham','1986-04-22','Nu','Tay Ninh','K13')
INSERT INTO HOCVIEN VALUES ('K1311', 'Tran Minh','Thuc','1986-04-04','Nam','TpHCM','K13')
INSERT INTO HOCVIEN VALUES ('K1312', 'Nguyen Thi Kim','Yen','1986-09-07','Nu','TpHCM','K13')
Select * from HOCVIEN
--Khoa
Insert into KHOA values('KHMT','Khoa hoc may tinh','2005-6-7','GV01')
Insert into KHOA values('HTTT','He thong thong tin','2005-6-7','GV02')
Insert into KHOA values('CNPM','Cong nghe phan mem','2005-6-7','GV04')
Insert into KHOA values('MTT','Mang va truyen thong','2005-10-20','GV03')
Insert into KHOA values('KTMT','Ky thuat may tinh','2005-12-20',Null)
--Lop
INSERT INTO LOP VALUES('K11', 'Lop 1 khoa 1', 'K1108', '11', 'GV07')
INSERT INTO LOP VALUES('K12', 'Lop 2 khoa 1', 'K1205', '12', 'GV09')
Insert into LOP values('K13','Lop 3 khoa 1','K1305','13','GV14')
select *from LOP
--Môn học
insert into MONHOC values('THDC','Tin hoc dai cuong','4','1','KHMT')
insert into MONHOC values('CTRR','Cau truc roi rac','5','0','KHMT')
insert into MONHOC values('CSDL','Co so du lieu','3','1','HTTT')
insert into MONHOC values('CTDLGT','Cau truc du lieu va giai thuat','3','1','KHMT')
insert into MONHOC values('PTTKTT','Phan tich thiet ke thuat toan','3','0','KHMT')
insert into MONHOC values('DHMT','Do hoa may tinh','3','1','KHMT') 
insert into MONHOC values('KTMT','Kien truc may tinh','3','0','KTMT')
insert into MONHOC values('TCSDL','Thiet ke co so du lieu','3','1','HTTT')
insert into MONHOC values('PTTKHTTT', 'Phan tich thiet ke he thong thong tin', '4','1','HTTT') 
insert into MONHOC values('HDH', 'He dieu hanh', '4', '0', 'KTMT') 
insert into MONHOC values('NMCNPM', 'Nhap mon cong nghe phan mem','3','0','CNPM') 
insert into MONHOC values('LTCFW','Lap trinh C for win', '3', '1', 'CNPM ')
insert into MONHOC values('LTHDT', 'Lap trinh huong doi tuong', '3', '1', 'CNPM')
select *from MONHOC
--Giảng dạy
INSERT INTO GIANGDAY VALUES ('K11', 'THDC', 'GV07', '1', '2006', '2006-01-02', '2006-05-12') 
insert into GIANGDAY values ('K12', 'THDC', 'GV06', '1', '2006', '2006-01-02', '2006-5-12')
INSERT INTO GIANGDAY VALUES ('K13', 'THDC', 'GV15', '1', '2006','2006-01-02', '2006-05-12') 
INSERT INTO GIANGDAY VALUES ('K11', 'CTRR', 'GV02', '1', '2006', '2006-01-09', '2006-05-17') 
INSERT INTO GIANGDAY VALUES ('K12', 'CTRR', 'GV02', '1', '2006', '2006-01-09', '2006-05-17') 
INSERT INTO GIANGDAY VALUES ('K13', 'CTRR', 'GV08', '1', '2006', '2006-01-09', '2006-05-17') 
INSERT INTO GIANGDAY VALUES ('K11', 'CSDL', 'GV05', '2', '2006', '2006-06-01', '2006-07-15') 
INSERT INTO GIANGDAY VALUES ('K12','CSDL', 'GV09', '2', '2006', '2006-06-01', '2006-07-15')
INSERT INTO GIANGDAY VALUES ('K13', 'CTDLGT', 'GV15', '2', '2006', '2006-06-01', '2006-07-15') 
INSERT INTO GIANGDAY VALUES ('K13', 'CSDL', 'GV05', '3', '2006', '2006-08-01', '2006-12-15') 
INSERT INTO GIANGDAY VALUES ('K13', 'DHMT', 'GV07', '3', '2006', '2006-08-01', '2006-12-15') 
INSERT INTO GIANGDAY VALUES ('K11', 'CTDLGT', 'GV15', '3', '2006', '2006-08-01', '2006-12-15') 
INSERT INTO GIANGDAY VALUES ('K12', 'CTDLGT', 'GV15', '3', '2006', '2006-08-01', '2006-12-15') 
INSERT INTO GIANGDAY VALUES ('K11', 'HDH', 'GV04', '1', '2007', '2007-01-02', '2007-02-18') 
INSERT INTO GIANGDAY VALUES ('K12', 'HDH', 'GV04', '1', '2007', '2007-01-02', '2007-03-20') 
INSERT INTO GIANGDAY VALUES ('K11', 'DHMT', 'GV07', '1', '2007', '2007-02-18', '2007-03-20')
select * from GIANGDAY
--Điều kiện
insert into DIEUKIEN values ('CSDL', 'CTRR')
insert into DIEUKIEN values ('CSDL', 'CTDLGT')
insert into DIEUKIEN values ('CTDLGT', 'THDC')
insert into DIEUKIEN values ('PTTKTT', 'THDC')
insert into DIEUKIEN values ('PTTKTT', 'CTDLGT')
insert into DIEUKIEN values ('DHMT', 'THDC')
insert into DIEUKIEN values ('LTHDT', 'THDC')
insert into DIEUKIEN values ('PTTKHTTT', 'CSDL')
select * from DIEUKIEN
--Kết quả thi
INSERT INTO KETQUATHI VALUES ('K1101', 'CSDL', '1', '2006-7-20', '10.00', 'Dat')
INSERT INTO KETQUATHI VALUES ('K1101','CTDLGT','1','2006-12-28','9.00', 'Dat')
INSERT INTO KETQUATHI VALUES ('K1101','THDC','1','2006-05-25','9.00', 'Dat')
INSERT INTO KETQUATHI VALUES ('K1101','CTRR','1','2008-05-13','9.50', 'Dat')
INSERT INTO KETQUATHI VALUES ('K1102','CSDL','1','2006-07-20','4.00', 'Khong Dat')
INSERT INTO KETQUATHI VALUES ('K1102','CSDL','2','2006-07-27','4.25', 'Khong Dat')
INSERT INTO KETQUATHI VALUES ('K1102','CSDL','3','2006-08-10','4.50', 'Khong Dat')
INSERT INTO KETQUATHI VALUES ('K1102','CTDLGT','1','2006-12-28','4.50', 'Khong Dat')
INSERT INTO KETQUATHI VALUES ('K1102','CTDLGT','2','2007-01-05','4.00', 'Khong Dat')
INSERT INTO KETQUATHI VALUES ('K1102','CTDLGT','3','2007-01-15','6.00', 'Dat')
INSERT INTO KETQUATHI VALUES ('K1102','THDC','2','2006-05-20','5.00', 'Dat')
INSERT INTO KETQUATHI VALUES ('K1102','CTRR','3','2006-05-13','7.00', 'Dat')
INSERT INTO KETQUATHI VALUES ('K1103','CSDL','1','2006-07-20','3.50', 'Khong Dat')
INSERT INTO KETQUATHI VALUES ('K1103','CSDL','2','2006-07-27','8.50', 'Dat')
INSERT INTO KETQUATHI VALUES ('K1103','CTDLGT','1','2006-12-28','7.00', 'Dat')
INSERT INTO KETQUATHI VALUES ('K1103','THDC','1','2006-05-20','8.00', 'Dat')
INSERT INTO KETQUATHI VALUES ('K1103','CTRR','3','2006-05-13','6.50', 'Dat')
INSERT INTO KETQUATHI VALUES ('K1104','CSDL','1','2006-07-20','3.75', 'Khong Dat')
INSERT INTO KETQUATHI VALUES ('K1104','CTDLGT','1','2006-12-28','4.50', 'Khong Dat')
INSERT INTO KETQUATHI VALUES ('K1104','THDC','1','2006-05-20','4.00', 'Khong Dat')
INSERT INTO KETQUATHI VALUES ('K1104','CTRR','1','2006-05-13','4.00', 'Khong Dat')
INSERT INTO KETQUATHI VALUES ('K1104','CTRR','2','2006-05-20','3.50', 'Khong Dat')
INSERT INTO KETQUATHI VALUES ('K1104','CTRR','3','2006-08-30','4.00', 'Khong Dat')
INSERT INTO KETQUATHI VALUES ('K1201', 'CTDLGT', '1', '2006-12-18', '5.00', 'Dat') 
INSERT INTO KETQUATHI VALUES ('K1201', 'THDC', '1', '2006-05-20','8.50','Dat') 
INSERT INTO KETQUATHI VALUES ('K1201', 'CTRR', '1', '2006-05-13','9.00','Dat') 
INSERT INTO KETQUATHI VALUES ('K1202', 'CSDL', '1', '2006-07-20','8.00','Dat') 
INSERT INTO KETQUATHI VALUES ('K1202', 'CTDLGT', '1', '2006-12-28','4.00','Khong Dat') 
INSERT INTO KETQUATHI VALUES ('K1202', 'CTDLGT', '2', '2007-01-05','5.00','Dat') 
INSERT INTO KETQUATHI VALUES ('K1202', 'THDC', '1', '2006-05-20','4.00','Khong Dat')  
INSERT INTO KETQUATHI VALUES ('K1202', 'CTRR', '1', '2006-05-13', '3.00', 'Khong Dat')
INSERT INTO KETQUATHI VALUES ('K1202', 'CTRR', '2', '2006-05-20', '4.00', 'Khong Dat') 
INSERT INTO KETQUATHI VALUES ('K1202', 'CTRR', '3', '2006-06-30','6.24','Dat')
INSERT INTO KETQUATHI VALUES ('K1203', 'CSDL', '1', '2006-07-20', '9.25', 'Dat')
INSERT INTO KETQUATHI VALUES ('K1203', 'CTDLGT', '1', '2006-12-28', '9.50', 'Dat') 
INSERT INTO KETQUATHI VALUES ('K1203', 'THDC', '1', '2006-05-20', '10.00', 'Dat') 
INSERT INTO KETQUATHI VALUES ('K1203', 'CTRR', '1', '2006-05-13', '10.00', 'Dat') 
INSERT INTO KETQUATHI VALUES ('K1204', 'CSDL', '1', '2006-07-20', '8.50', 'Dat') 
INSERT INTO KETQUATHI VALUES ('K1204', 'CTDLGT', '1', '2006-12-28', '6.75', 'Dat') 
INSERT INTO KETQUATHI VALUES ('K1204', 'THDC', '1', '2006-05-20', '4.00', 'Khong Dat') 
INSERT INTO KETQUATHI VALUES ('K1204', 'CTRR', '1', '2006-05-13', '6.00', 'Dat') 
INSERT INTO KETQUATHI VALUES ('K1301', 'CSDL', '1', '2006-12-20', '4.25', 'Khong Dat') 
INSERT INTO KETQUATHI VALUES ('K1301', 'CTDLGT', '1', '2006-07-25', '8.00', 'Dat') 
INSERT INTO KETQUATHI VALUES ('K1301', 'THDC', '1', '2006-05-20', '7.75', 'Dat') 
INSERT INTO KETQUATHI VALUES ('K1301', 'CTRR', '1', '2006-05-13', '8.00', 'Dat') 
INSERT INTO KETQUATHI VALUES ('K1302', 'CSDL', '1', '2006-12-20', '6.75', 'Dat') 
INSERT INTO KETQUATHI VALUES ('K1302', 'CTDLGT', '1', '2006-07-25', '5.00', 'Dat') 
INSERT INTO KETQUATHI VALUES ('K1302', 'THDC', '1', '2006-05-20', '8.00', 'Dat') 
INSERT INTO KETQUATHI VALUES ('K1302', 'CTRR', '1', '2006-05-13', '8.50', 'Dat') 
INSERT INTO KETQUATHI VALUES ('K1303', 'CSDL', '1', '2006-12-20', '4.00', 'Khong Dat') 
INSERT INTO KETQUATHI VALUES ('K1303', 'CTDLGT', '1', '2006-07-25', '4.50', 'Khong Dat') 
INSERT INTO KETQUATHI VALUES ('K1303', 'CTDLGT', '2', '2006-08-07','4.00','Khong Dat') 
INSERT INTO KETQUATHI VALUES ('K1303', 'CTDLGT', '3', '2006-08-15','4.25','Khong Dat') 
INSERT INTO KETQUATHI VALUES ('K1303', 'THDC', '1', '2006-05-20','4.50', 'Khong Dat')
INSERT INTO KETQUATHI VALUES ('K1303', 'CTRR', '1', '2006-05-13', '3.25', 'Khong Dat') 
INSERT INTO KETQUATHI VALUES ('K1303', 'CTRR', '2', '2006-05-20', '5.00', 'Dat') 
INSERT INTO KETQUATHI VALUES ('K1304', 'CSDL', '1', '2006-12-20', '7.75', 'Dat') 
INSERT INTO KETQUATHI VALUES ('K1304', 'CTDLGT', '1', '2006-07-25', '9.75', 'Dat') 
INSERT INTO KETQUATHI VALUES ('K1304', 'THDC', '1', '2006-05-20', '5.50', 'Dat') 
INSERT INTO KETQUATHI VALUES ('K1304', 'CTRR', '1', '2006-05-13', '5.00', 'Dat') 
INSERT INTO KETQUATHI VALUES ('K1305', 'CSDL', '1', '2006-12-20','9.25', 'Dat') 
INSERT INTO KETQUATHI VALUES ('K1305', 'CTDLGT', '1', '2006-07-25','10.00', 'Dat')
INSERT INTO KETQUATHI VALUES ('K1305', 'THDC', '1', '2006-05-20', '8.00', 'Dat') 
INSERT INTO KETQUATHI VALUES ('K1305', 'CTRR', '1', '2006-05-13', '10.00','Dat')
Select * from KETQUATHI

--Bài 4: QLGV I (11-14)
--11. Học viên ít nhất là 18 tuổi.
ALTER TABLE HOCVIEN ADD CONSTRAINT CK_TUOI check (year(GETDATE())- year(NGSINH)>=18)

--12. Giảng dạy một môn học ngày bắt đầu (TUNGAY) phải nhỏ hơn ngày kết thúc(DENNGAY).
ALTER TABLE GIANGDAY ADD CONSTRAINT CK_TGDAY CHECK (TUNGAY<DENNGAY)
--13. Giáo viên khi vào làm ít nhất là 22 tuổi.
ALTER TABLE GIAOVIEN ADD CONSTRAINT CK_NGAYVAO CHECK (year(GETDATE())- year(NGVL)>=22)
--14. Tất cả các môn học đều có số tín chỉ lý thuyết và tín chỉ thực hành chênh lệch nhau không quá 3.
ALTER TABLE MONHOC ADD CONSTRAINT CK_TINCHI CHECK (ABS(TCLT-TCTH)<=5)
--Bài 6: III (1-5)
--1. In ra danh sách (mã học viên, họ tên, ngày sinh, mã lớp) lớp trưởng của các lớp.
SELECT HV.MAHV , HV.HO , HV.TEN, HV.NGSINH, HV.MALOP
FROM HOCVIEN HV JOIN LOP ON HV.MALOP = LOP.MALOP
WHERE HV.MAHV = LOP.TRGLOP
--2. In ra bảng điểm khi thi (mã học viên, họ tên , lần thi, điểm số) môn CTRR của lớp “K12”,sắp xếp theo tên, họ học viên.
SELECT hv.MAHV, hv.HO, hv.TEN, kq.LANTHI, kq.DIEM
FROM HOCVIEN hv JOIN KETQUATHI kq ON hv.MAHV = kq.MAHV and hv.MAHV=kq.MAHV
WHERE kq.MAMH='CTRR' and hv.MALOP='k12'
ORDER BY hv.HO, hv.TEN
--3. In ra danh sách những học viên (mã học viên, họ tên) và những môn học mà học viên đó thi lần thứ nhất đã đạt.
SELECT hv.MAHV, hv.HO, hv.TEN, kq.MAMH
FROM HOCVIEN hv JOIN KETQUATHI kq ON hv.MAHV = kq.MAHV 
WHERE kq.LANTHI='1' and kq.KQUA='Dat'
--4. In ra danh sách học viên (mã học viên, họ tên) của lớp “K11” thi môn CTRR không đạt (ởlần thi 1).
SELECT hv.MAHV, hv.HO, hv.TEN,LANTHI,KQUA
FROM HOCVIEN hv JOIN KETQUATHI kq ON hv.MAHV = kq.MAHV
WHERE hv.MALOP='k11' and kq.MAMH='CTRR' and kq.LANTHI ='1' AND kq.KQUA='Khong Dat'
--5. Danh sách học viên (mã học viên, họ tên) của lớp “K” thi môn CTRR không đạt (ở tất cả các lần thi).
SELECT distinct HV.MAHV, HO, TEN
FROM HOCVIEN HV JOIN KETQUATHI KQ ON HV.MAHV = KQ.MAHV
WHERE MALOP LIKE 'K1[1-3]' AND MAMH = 'CTRR' and  KQUA = 'Khong Dat' AND LANTHI= '3'
EXCEPT SELECT distinct HV.MAHV, HO, TEN From HOCVIEN HV JOIN KETQUATHI KQ ON HV.MAHV = KQ.MAHV where KQUA = 'Dat' AND LANTHI between 1 and 3
--Cách 2:
SELECT DISTINCT HV.MAHV, HO, TEN 
FROM HOCVIEN HV 
WHERE NOT EXISTS(SELECT* FROM KETQUATHI KQ WHERE NOT EXISTS(SELECT* FROM (SELECT DISTINCT LANTHI, HV.MAHV FROM KETQUATHI KQ JOIN HOCVIEN HV ON KQ.MAHV = HV.MAHV
WHERE KQUA = 'Khong Dat' AND MAMH = 'CTRR' AND HV.MALOP LIKE 'K%') K
WHERE HV.MAHV = K.MAHV AND K.LANTHI = KQ.LANTHI))
--6.Tìm tên những môn học mà giáo viên có tên “Tran Tam Thanh” dạy trong học kỳ 1 năm 2006
SELECT distinct mh.MAMH, gv.HOTEN,gd.HOCKY,gd.NAM
From (MONHOC mh JOIN GIANGDAY gd on mh.MaMH = gd.MAMH) JOIN GIAOVIEN gv on(gv.MaGV=gv.MaGV)
Where gv.HOTEN='Tran Tam Thanh' and HOCKY='1' and NAM='2006'
--7.Tìm những môn học (mã môn học, tên môn học) mà giáo viên chủ nhiệm lớp “K11” dạy trong học kỳ 1 năm 2006.
SELECT mh.MAMH, mh.TENMH
From (MONHOC mh JOIN GIANGDAY gd on mh.MaMH = gd.MAMH) JOIN LOP on(gd.MAGV=LOP.MAGVCN)
WHERE gd.MALOP='K11' and HOCKY='1' and NAM='2006'
--8*.Tìm họ tên lớp trưởng của các lớp mà giáo viên có tên “Nguyen To Lan” dạy môn “Co So Du Lieu”.
SELECT HV.HO, HV.TEN , GV.HOTEN, MH.TENMH
FROM HOCVIEN HV, LOP, GIAOVIEN GV, MONHOC MH
WHERE HV.MAHV = LOP.TRGLOP AND LOP.MAGVCN = GV.MAGV AND GV.MAKHOA = MH.MAKHOA AND GV.HOTEN = 'Nguyen To Lan' AND TENMH = 'Co So Du Lieu'
--9.In ra danh sách những môn học (mã môn học, tên môn học) phải học liền trước môn “Co So Du Lieu”.
SELECT dk.MAMH_TRUOC,  mhoc.TENMH
From (MONHOC mh JOIN DIEUKIEN dk on mh.MAMH=dk.MAMH) JOIN MONHOC Mhoc on dk.MAMH_TRUOC=Mhoc.MAMH
Where mh.TENMH='Co So Du Lieu'
--10. Môn “Cau Truc Roi Rac” là môn bắt buộc phải học liền trước những môn học (mã môn học, tên môn học) nào
select MONHOC.MAMH, TENMH 
FROM MONHOC JOIN(SELECT DK.MAMH FROM DIEUKIEN DK JOIN MONHOC MH ON DK.MAMH_TRUOC=MH.MAMH WHERE TENMH='Cau Truc Roi Rac') MHTR
ON MONHOC.MAMH=MHTR.MAMH
--11. Tìm họ tên giáo viên dạy môn CTRR cho cả hai lớp “K11” và “K12” trong cùng học kỳ 1 năm 2006.
SELECT distinct gv.HOTEN
FROM GIAOVIEN gv JOIN GIANGDAY gd on gv.MAGV=gd.MAGV
Where gd.MALOP in ('K11','K12') and gd.HOCKY='1' and gd.NAM='2006' and gd.MAMH='CTRR'
--12. Tìm những học viên (mã học viên, họ tên) thi không đạt môn CSDL ở lần thi thứ 1 nhưng chưa thi lại môn này.
SELECT distinct HV.MAHV, HV.HO, HV.TEN
FROM HOCVIEN HV JOIN KETQUATHI KQ ON HV.MAHV = KQ.MAHV
WHERE KQUA = 'Khong Dat' AND LANTHI= '1' and KQ.MAMH='CSDL'
EXCEPT SELECT distinct HV.MAHV, HO, TEN From HOCVIEN HV JOIN KETQUATHI KQ ON HV.MAHV = KQ.MAHV
where KQUA in( 'Dat','Khong Dat') AND LANTHI in ('2','3') AND KQ.MAMH='CSDL'
--13. Tìm giáo viên (mã giáo viên, họ tên) không được phân công giảng dạy bất kỳ môn học nào.
SELECT distinct gv.MAGV, gv.HOTEN
FROM GIAOVIEN gv 
WHERE NOT EXISTS (SELECT distinct gv.MAGV, gv.HOTEN from GIAOVIEN JOIN GIANGDAY gd on gv.MAGV=gd.MAGV)
--14(đã sửa). Tìm giáo viên (mã giáo viên, họ tên) không được phân công giảng dạy bất kỳ môn học nào thuộc khoa giáo viên đó phụ trách
SELECT DISTINCT GV.MAGV
fROM GIAOVIEN GV JOIN GIANGDAY GD ON GV.MAGV=GD.MAGV JOIN MONHOC MH ON GD.MAMH=MH.MAMH
WHERE GV.MAKHOA=MH.MAKHOA
--15.Tìm họ tên các học viên thuộc lớp “K11” thi một môn bất kỳ quá 3 lần vẫn “Khong dat” hoặc thi lần thứ 2 môn CTRR được 5 điểm.
SELECT hv.HO, hv.TEN
FROM HOCVIEN hv JOIN KETQUATHI kq on hv.MAHV=kq.MAHV
WHERE hv.MALOP='K11' and kq.KQUA='Khong Dat' and kq.LANTHI ='3' or (KQ.LANTHI='2' and kq.MAMH='CTRR' and kq.DIEM='5')
--16 (đã sửa). Tìm họ tên giáo viên dạy môn CTRR cho ít nhất hai lớp trong cùng một học kỳ của một năm học.
SELECT MAGV, HOTEN
FROM GIAOVIEN
WHERE MAGV IN (SELECT MAGV FROM GIANGDAY WHERE (MAMH='CTRR') GROUP BY MAGV, HOCKY,NAM
HAVING (COUNT(MAGV)>=2))

SELECT DISTINCT GIAOVIEN.MAGV, HOTEN 
FROM GIAOVIEN JOIN GIANGDAY ON GIAOVIEN.MAGV=GIANGDAY.MAGV 
WHERE MAMH='CTRR' 
GROUP BY GIAOVIEN.MAGV, HOTEN, NAM, HOCKY 
HAVING COUNT(*)>=2


--17. Danh sách học viên và điểm thi môn CSDL (chỉ lấy điểm của lần thi sau cùng).
SELECT K1.MAHV, K1.DIEM, LANTHI 
FROM KETQUATHI K1 JOIN (
SELECT MAHV, MAX(LANTHI) LANTHISC 
FROM KETQUATHI WHERE MAMH='CSDL' GROUP BY MAHV) LT 
ON K1.MAHV=LT.MAHV AND K1.LANTHI=LT.LANTHISC 
WHERE MAMH='CSDL'

SELECT K1.MAHV, K1.DIEM, LANTHI 
FROM KETQUATHI K1 JOIN 
(SELECT MAHV, MAX(LANTHI) LANTHISC 
FROM KETQUATHI WHERE MAMH='CSDL' GROUP BY MAHV) LT 
ON K1.MAHV=LT.MAHV AND K1.LANTHI=LT.LANTHISC 
WHERE MAMH='CSDL'
ORDER BY K1.MAHV ASC

--C2
SELECT K1.MAHV, HV.HO, HV.TEN, K1.LANTHI,K1.DIEM
FROM KETQUATHI K1 JOIN HOCVIEN HV ON K1.MAHV = HV.MAHV
WHERE EXISTS (SELECT MAHV, MAMH, MAX(LANTHI)
FROM KETQUATHI K2
WHERE (K2.MAMH = 'CSDL') AND (K1.MAHV = K2.MAHV) AND (K1.MAMH = K2.MAMH)
GROUP BY MAHV, MAMH
HAVING (K1.LANTHI = MAX(LANTHI)))
ORDER BY K1.MAHV ASC
--18. Danh sách học viên và điểm thi môn “Co So Du Lieu” (chỉ lấy điểm cao nhất của các lần thi).
SELECT MAHV, Max(DIEM) 
FROM KETQUATHI KQ JOIN MONHOC MH ON KQ.MAMH=MH.MAMH 
WHERE TENMH='Co So Du Lieu' 
GROUP BY MAHV

SELECT K1.MAHV, HV.HO, HV.TEN, K1.DIEM
FROM KETQUATHI K1 JOIN HOCVIEN HV ON K1.MAHV = HV.MAHV
WHERE EXISTS (SELECT K2.MAHV, K2.MAMH, MAX(DIEM)
FROM KETQUATHI K2 JOIN MONHOC MH ON K2.MAMH = MH.MAMH
WHERE (MH.TENMH = 'Co So Du Lieu') AND (K1.MAHV = K2.MAHV) AND (K1.MAMH = K2.MAMH)
GROUP BY K2.MAHV, K2.MAMH
HAVING (K1.DIEM = MAX(DIEM)))

--19. Khoa nào (mã khoa, tên khoa) được thành lập sớm nhất.
SELECT MAKHOA, TENKHOA
FROM KHOA
WHERE NGTLAP = (SELECT MIN(NGTLAP) FROM KHOA)
--20. Có bao nhiêu giáo viên có học hàm là “GS” hoặc “PGS”.
SELECT COUNT(MAGV) SLGV
FROM GIAOVIEN 
WHERE HOCHAM IN ('GS', 'PGS')
--21. Thống kê có bao nhiêu giáo viên có học vị là “CN”, “KS”, “Ths”, “TS”, “PTS” trong mỗi khoa.
SELECT GIAOVIEN.MAKHOA, COUNT(*) SLGV
FROM GIAOVIEN JOIN KHOA ON GIAOVIEN.MAKHOA = KHOA.MAKHOA
WHERE HOCVI IN ('CN', 'KS', 'Ths', 'TS', 'PTS')
GROUP BY GIAOVIEN.MAKHOA
--22. Mỗi môn học thống kê số lượng học viên theo kết quả (đạt và không đạt).
SELECT KQ.MAMH, KQUA, COUNT(*) SLHV
FROM HOCVIEN HV JOIN KETQUATHI KQ ON HV.MAHV = KQ.MAHV
WHERE KQUA IN ('Dat', 'Khong Dat')
GROUP BY KQUA, KQ.MAMH
--23. Tìm giáo viên (mã giáo viên, họ tên) là giáo viên chủ nhiệm của một lớp, đồng thời dạy cho lớp đó ít nhất một môn học.
SELECT DISTINCT GV.MAGV, HOTEN
FROM GIAOVIEN GV, LOP, GIANGDAY GD
WHERE GV.MAGV = LOP.MAGVCN AND GV.MAGV = GD.MAGV
GROUP BY GV.MAGV, HOTEN, MAMH
HAVING COUNT(*) >=1
--24. Tìm họ tên lớp trưởng của lớp có sỉ số cao nhất.
SELECT HV.HO, HV.TEN
FROM HOCVIEN HV, LOP
WHERE HV.MAHV = LOP.TRGLOP AND SISO = (SELECT MAX(SISO) FROM LOP)
--25. * Tìm họ tên những LOPTRG thi không đạt quá 3 môn (mỗi môn đều thi không đạt ở tất cả các lần thi).
SELECT MAHV, HO, TEN 
FROM HOCVIEN 
WHERE MAHV IN (SELECT TRGLOP FROM LOP )  
AND MAHV IN (SELECT MAHV 
FROM (SELECT MAHV, MAMH FROM KETQUATHI 
EXCEPT  
SELECT MAHV, MAMH 
FROM KETQUATHI 
WHERE KQUA NOT IN ('Khong Dat') 
GROUP BY MAHV, MAMH) AS A 
GROUP BY MAHV 
HAVING COUNT(*)>3)
--Bài tập 4: Sinh viên hoàn thành Phần III bài tập QuanLyGiaoVu từ câu 26 đến câu 35.
--26. Tìm học viên (mã học viên, họ tên) có số môn đạt điểm 9,10 nhiều nhất.
SELECT HV.MAHV,HV.HO, HV.TEN
FROM HOCVIEN HV JOIN KETQUATHI KQ ON HV.MAHV = KQ.MAHV
WHERE DIEM BETWEEN 9 AND 10
GROUP BY HV.MAHV, HV.HO, HV.TEN
HAVING  COUNT(*) > = ALL
(SELECT COUNT(*) FROM HOCVIEN HV1 JOIN KETQUATHI KQ1 ON HV1.MAHV = KQ1.MAHV
WHERE DIEM BETWEEN 9 AND 10
GROUP BY HV1.MAHV, HV1.HO, HV1.TEN)
--27. Trong từng lớp, tìm học viên (mã học viên, họ tên) có số môn đạt điểm 9,10 nhiều nhất.
SELECT MALOP,A.MAHV, HO, TEN 
FROM (SELECT MALOP, K.MAHV,HO, TEN, COUNT (DIEM) SL 
FROM HOCVIEN HV JOIN KETQUATHI K ON HV.MAHV=K.MAHV 
WHERE DIEM BETWEEN 9 AND 10 
GROUP BY MALOP, K.MAHV, HO, TEN) A 
WHERE SL IN (SELECT MAX(SL) 
FROM (SELECT MALOP, COUNT (DIEM) SL 
FROM HOCVIEN HV JOIN KETQUATHI K ON HV.MAHV=K.MAHV 
WHERE DIEM BETWEEN 9 AND 10 
GROUP BY MALOP, K.MAHV, HO, TEN)A GROUP BY MALOP )
--28. Trong từng học kỳ của từng năm, mỗi giáo viên phân công dạy bao nhiêu môn học, bao nhiêu lớp.
SELECT DISTINCT HOCKY, NAM, GD.MAGV, GV.HOTEN, COUNT(MALOP) SLLOP, COUNT(MAMH) SLMONHOC
FROM GIANGDAY GD, GIAOVIEN GV
WHERE GD.MAGV = GV.MAGV
GROUP BY HOCKY,NAM, GD.MAGV, GV.HOTEN
ORDER BY HOCKY, NAM ASC
--29. Trong từng học kỳ của từng năm, tìm giáo viên (mã giáo viên, họ tên) giảng dạy nhiều nhất.
SELECT A.NAM, A.HOCKY,MAGV, SLD FROM (SELECT NAM, HOCKY, MAGV,COUNT(*) SLD
FROM GIANGDAY
GROUP BY NAM, HOCKY, MAGV)A JOIN (SELECT NAM, HOCKY, MAX(SLD) MAXSLD FROM ( SELECT NAM, HOCKY, MAGV,COUNT(*) SLD
FROM GIANGDAY
GROUP BY NAM, HOCKY, MAGV) B   GROUP BY NAM, HOCKY  )  C ON A.NAM=C.NAM AND A.HOCKY=C.HOCKY AND A.SLD=C.MAXSLD
--30. Tìm môn học (mã môn học, tên môn học) có nhiều học viên thi không đạt (ở lần thi thứ 1) nhất.
SELECT TOP 1 MH.MAMH, TENMH, COUNT(*) SLKDAT
FROM MONHOC MH, KETQUATHI KQT
WHERE MH.MAMH = KQT.MAMH AND LANTHI = 1 AND KQUA = 'Khong Dat'
GROUP BY MH.MAMH, TENMH
ORDER BY SLKDAT DESC

--C2
SELECT MONHOC.MAMH, TENMH 
FROM KETQUATHI JOIN MONHOC ON KETQUATHI.MAMH=MONHOC.MAMH 
WHERE KQUA='Khong Dat' and LANTHI=1 
GROUP BY MONHOC.MAMH, TENMH 
HAVING COUNT(*) >= ALL 
(SELECT COUNT(*) FROM KETQUATHI 
WHERE KQUA='Khong Dat' and LANTHI=1 
group by MAMH)
--31. Tìm học viên (mã học viên, họ tên) thi môn nào cũng đạt (chỉ xét lần thi thứ 1).
SELECT DISTINCT HV.MAHV, HO, TEN FROM HOCVIEN HV WHERE NOT EXISTS
(SELECT* FROM KETQUATHI KQ WHERE NOT EXISTS
(SELECT*FROM
(SELECT DISTINCT KQUA, LANTHI, MAHV, KQ.MAMH
FROM KETQUATHI KQ, MONHOC MH WHERE KQUA = 'Dat' AND LANTHI = '1')K
WHERE HV.MAHV = K.MAHV AND K.MAMH = KQ.MAMH))
--32. * Tìm học viên (mã học viên, họ tên) thi môn nào cũng đạt (chỉ xét lần thi sau cùng).
SELECT DISTINCT HV.MAHV, HO, TEN FROM HOCVIEN HV WHERE NOT EXISTS
(SELECT* FROM KETQUATHI KQ WHERE NOT EXISTS
(SELECT*FROM
(SELECT DISTINCT KQUA, LANTHI, MAHV, KQ.MAMH
FROM KETQUATHI KQ, MONHOC MH WHERE KQUA = 'Dat' 
GROUP BY LANTHI, KQUA, MAHV, KQ.MAMH
HAVING KQ.LANTHI = MAX(LANTHI))K
WHERE HV.MAHV = K.MAHV AND K.MAMH = KQ.MAMH))
-- Lab 6 II (1-4)
--1. Tăng hệ số lương thêm 0.2 cho những giáo viên là trưởng khoa.
UPDATE GIAOVIEN
SET HESO = HESO*1.2
FROM GIAOVIEN GV JOIN KHOA ON GV.MAGV = TRGKHOA
WHERE GV.MAGV = TRGKHOA
--2. Cập nhật giá trị điểm trung bình tất cả các môn học (DIEMTB) của mỗi học viên (tất cả các môn học đều có hệ số 1 và nếu học viên thi một môn nhiều lần, chỉ lấy điểm của lần thi sau cùng).
ALTER TABLE HOCVIEN ADD DIEMTB float
UPDATE HOCVIEN
SET DIEMTB = (SELECT AVG(DIEM)
FROM KETQUATHI K1
WHERE LANTHI = (SELECT MAX(LANTHI)
FROM KETQUATHI K2
WHERE (K1.MAHV = K2.MAHV AND K1.MAMH = K2.MAMH)
GROUP BY MAHV,MAMH)
GROUP BY MAHV
HAVING MAHV= HOCVIEN .MAHV)
UPDATE HOCVIEN
SET DIEMTB = (
SELECT MAHV, AVG(DIEM) DIEMTB
FROM KETQUATHI K1
WHERE EXISTS (SELECT MAHV, MAMH, MAX(LANTHI) FROM KETQUATHI K2
WHERE (K1.MAHV = K2.MAHV) AND (K1.MAMH=K2.MAMH)
GROUP BY MAHV, MAMH
HAVING (K1.LANTHI = MAX(LANTHI)))
GROUP BY MAHV)
--3. Cập nhật giá trị cho cột GHICHU là “Cam thi” đối với trường hợp: học viên có một môn bất kỳ thi lần thứ 3 dưới 5 điểm.
ALTER TABLE HOCVIEN ADD GHICHU varchar(20)
UPDATE HOCVIEN
SET GHICHU = 'Cam thi'
FROM HOCVIEN HV JOIN KETQUATHI KQ ON HV.MAHV = KQ.MAHV
WHERE LANTHI = '3' AND DIEM < 5
--4. Cập nhật giá trị cho cột XEPLOAI trong quan hệ HOCVIEN như sau:
--Nếu DIEMTB >=9 thì XEPLOAI =”XS”
ALTER TABLE HOCVIEN ADD XEPLOAI varchar(20)
UPDATE HOCVIEN
SET XEPLOAI = 'XS'
WHERE DIEMTB >= 9
--Nếu 8 <= DIEMTB < 9 thì XEPLOAI = “G”
UPDATE HOCVIEN
SET XEPLOAI = 'G'
WHERE 8 <= DIEMTB AND DIEMTB < 9 
--Nếu 6.5 <= DIEMTB < 8 thì XEPLOAI = “K”
UPDATE HOCVIEN
SET XEPLOAI = 'K'
WHERE 6.5 <= DIEMTB AND DIEMTB < 8
--Nếu 5 <= DIEMTB < 6.5 thì XEPLOAI = “TB”
UPDATE HOCVIEN
SET XEPLOAI = 'TB'
WHERE 5 <= DIEMTB AND DIEMTB < 6.5
--Nếu DIEMTB < 5 thì XEPLOAI = ”Y”
UPDATE HOCVIEN
SET XEPLOAI = 'Y'
WHERE DIEMTB < 5


