--QUẢN LÝ BÁN HÀNG
CREATE TABLE KHACHHANG
(
MAKH char(4) primary key NOT NULL,
HOTEN varchar(40),
DCHI varchar(50),
SODT varchar(20),
NGSINH smalldatetime,
NGDK smalldatetime,
DOANHSO money
)
CREATE TABLE NHANVIEN
(
MANV char(4) primary key NOT NULL,
HOTEN varchar(40),
SODT varchar(20),
NGVL smalldatetime
)
CREATE TABLE SANPHAM
(
MASP char(4) primary key NOT NULL,
TENSP varchar(40),
DVT varchar(40),
NUOCSX varchar(40),
GIA money
)
CREATE TABLE HOADON
(
SOHD int primary key NOT NULL,
NGHD smalldatetime,
MAKH char(4),
MANV char(4),
TRIGIA money
)
CREATE TABLE CTHD
(
SOHD int foreign key
		references HOADON(SOHD),
MASP char(4) foreign key
			references SANPHAM(MASP),
SL int,
constraint PK_CTHD primary key (SOHD,MASP)
)
--I
--CÂU 2: Thêm vào thuộc tính GHICHU có kiểu dữ liệu varchar(20) cho quan hệ SANPHAM
ALTER TABLE SANPHAM ADD GHICHU varchar(20)
--CÂU 3: Thêm vào thuộc tính LOAIKH có kiểu dữ liệu là tinyint cho quan hệ KHACHHANG
ALTER TABLE KHACHHANG ADD LOAIKH tinyint
--CÂU 4: Sửa kiểu dữ liệu của thuộc tính GHICHU trong quan hệ SANPHAM thành varchar(100)
ALTER TABLE SANPHAM ALTER COLUMN GHICHU varchar(100)
--CÂU 5: Xóa thuộc tính GHICHU trong quan hệ SANPHAM
ALTER TABLE SANPHAM drop column GHICHU
--CÂU 6: Làm thế nào để thuộc tính LOAIKH trong quan hệ KHACHHANG có thể lưu các giá trị là: “Vang lai”, “Thuong xuyen”, “Vip”, …
ALTER TABLE KHACHHANG ALTER COLUMN LOAIKH varchar(20)
--CÂU 7: Đơn vị tính của sản phẩm chỉ có thể là (“cay”,”hop”,”cai”,”quyen”,”chuc”)
ALTER TABLE SANPHAM ADD CONSTRAINT CK_DVT CHECK (DVT IN ('cay','hop','cai','quyen','chuc'))
--CÂU 8: Giá bán của sản phẩm từ 500 đồng trở lên
ALTER TABLE SANPHAM ADD CONSTRAINT CK_GIA CHECK (GIA >= 500)
--Câu 9: Mỗi lần mua hàng, khách hàng phải mua ít nhất 1 sản phẩm
ALTER TABLE CTHD ADD CONSTRAINT CK_SL CHECK (SL>=1)
--CÂU 10: Ngày khách hàng đăng ký là khách hàng thành viên phải lớn hơn ngày sinh của người đó
ALTER TABLE KHACHHANG ADD CONSTRAINT CK_NGSINH CHECK (NGDK>NGSINH)

--II. Ngôn ngữ thao tác dữ liệu
--Nhân viên
INSERT INTO NHANVIEN VALUES('NV01', 'Nguyen Nhu Nhut', '0927345678', '2006-4-13')
INSERT INTO NHANVIEN VALUES('NV02', 'Le Thi Phi Yen', '0987567390', '2006-4-21')
INSERT INTO NHANVIEN VALUES('NV03', 'Nguyen Van B', '0997047382', '2006-4-27')
INSERT INTO NHANVIEN VALUES('NV04', 'Ngo Thanh Tuan', '0913758498', '2006-6-24')
INSERT INTO NHANVIEN VALUES('NV05', 'Nguyen Thi Truc Thanh', ' 0918590387', '2006-7-20')
select * from NHANVIEN
--Khách hàng
INSERT INTO KHACHHANG VALUES('KH01', 'Nguyen Van A', '731 Tran Hung Dao, Q5, TpHCM', '08823451', '1960-10-22', '2006-07-22', '13,060,000')
INSERT INTO KHACHHANG VALUES('KH02', 'Tran Ngoc Han', '23/5 Nguyen Trai, Q5, TpHCM', '0908256478', '1974-4-3', '2006-07-30', '280,000')
INSERT INTO KHACHHANG VALUES('KH03', 'Tran Ngoc Linh', '45 Nguyen Canh Chan, Q1, TpHCM', '0938776266', '1980-6-12', '2006-08-05', '3,860,000')
INSERT INTO KHACHHANG VALUES('KH04', 'Tran Minh Long', '50/34 Le Dai Hanh, Q10, TpHCM', '09173254761', '1965-3-9', '2006-10-02', '250,000')
INSERT INTO KHACHHANG VALUES('KH05', 'Le Nhat Minh', '34 Truong Dinh, Q3, TpHCM', '08246108', '1950-3-10', '2006-10-28', '21,000')
INSERT INTO KHACHHANG VALUES('KH06', 'Le Hoai Thuong', '227 Nguyen Van Cu, Q5, TpHCM', '0863173', '1981-12-31', '2006-11-24', '915,000')
INSERT INTO KHACHHANG VALUES('KH07', 'Nguyen Van Tam', '32/3 Tran Binh Trong, Q5, TpHCM', '0916783565', '1971-4-6', '2006-12-01', '12,500')
INSERT INTO KHACHHANG VALUES('KH08', 'Phan Thi Thanh', '45/2 An Duong Vuong, Q5, TpHCM', '0938435756', '1971-1-10', '2006-12-13', '365,000')
INSERT INTO KHACHHANG VALUES('KH09', 'Le Ha Vinh', '873 Le Hong Phong, Q5, TpHCM', '08654763', '1979-9-3', '2007-01-14', '70,000')
INSERT INTO KHACHHANG VALUES('KH10', 'Ha Duy Lap', '34/34B Nguyen Trai, Q1, TpHCM', '08768904', '1983-5-2', '2007-01-16', '67,500')
select * from KHACHHANG
--Sản phẩm
INSERT INTO SANPHAM VALUES('BC01','BUT CHI','CAY','SINGAPORE','3000')
INSERT INTO SANPHAM VALUES('BC02','BUT CHI','CAY','SINGAPORE','5000')
INSERT INTO SANPHAM VALUES('BC03','BUT CHI','CAY','VIET NAM','3500')
INSERT INTO SANPHAM VALUES('BC04','BUT CHI','HOP','VIET NAM','30000')
INSERT INTO SANPHAM VALUES('BB01','BUT BI','CAY','VIET NAM','5000')
INSERT INTO SANPHAM VALUES('BB02','BUT BI','CAY','TRUNG QUOC','7000')
INSERT INTO SANPHAM VALUES('BB03','BUT BI','HOP','THAI LAN','100000')
INSERT INTO SANPHAM VALUES('TV01','TAP 100 GIAY MONG','QUYEN','TRUNG QUOC','2500')
INSERT INTO SANPHAM VALUES('TV02','TAP 200 GIAY MONG','QUYEN','TRUNG QUOC','4500')
INSERT INTO SANPHAM VALUES('TV03','TAP 100 GIAY TOT','QUYEN','VIET NAM','3000')
INSERT INTO SANPHAM VALUES('TV04','TAP 200 GIAY TOT','QUYEN','VIET NAM','5500')
INSERT INTO SANPHAM VALUES('TV05','TAP 100 TRANG','CHUC','VIET NAM','23000')
INSERT INTO SANPHAM VALUES('TV06','TAP 200 TRANG','CHUC','VIET NAM','53000')
INSERT INTO SANPHAM VALUES('TV07','TAP 100 TRANG','CHUC','TRUNG QUOC','34000')
INSERT INTO SANPHAM VALUES('ST01','SO TAY 500 TRANG','QUYEN','TRUNG QUOC','40000')
INSERT INTO SANPHAM VALUES('ST02','SO TAY LOAI 1','QUYEN','VIET NAM','55000')
INSERT INTO SANPHAM VALUES('ST03','SO TAY LOAI 2','QUYEN','VIET NAM','51000')
INSERT INTO SANPHAM VALUES('ST04','SO TAY','QUYEN','THAI LAN','55000')
INSERT INTO SANPHAM VALUES('ST05','SO TAY MONG','QUYEN','THAI LAN','20000')
INSERT INTO SANPHAM VALUES('ST06','PHAN VIET BANG','HOP','VIET NAM','5000')
INSERT INTO SANPHAM VALUES('ST07','PHAN KHONG BUI','HOP','VIET NAM','7000')
INSERT INTO SANPHAM VALUES('ST08','BONG BANG','CAI','VIET NAM','1000')
INSERT INTO SANPHAM VALUES('ST09','BUT LONG','CAY','VIET NAM','5000')
INSERT INTO SANPHAM VALUES('ST10','BUT LONG','CAY','TRUNG QUOC','7000')
select * from SANPHAM
--Hóa đơn
INSERT INTO HOADON VALUES('1001', '2006-07-23', 'KH01', 'NV01', '320,000')
INSERT INTO HOADON VALUES('1002', '2006-08-12', 'KH01', 'NV02', '840,000')
INSERT INTO HOADON VALUES('1003', '2006-08-23','KH02', 'NV01', '100,000')
INSERT INTO HOADON VALUES('1004', '2006-09-01', 'KH02', 'NV01', '180,000')
INSERT INTO HOADON VALUES('1005', '2006-10-20', 'KH01', 'NV02', '3,800,000')
INSERT INTO HOADON VALUES('1006', '2006-10-16', 'KH01', 'NV03', '2,430,000')
INSERT INTO HOADON VALUES('1007', '2006-10-28','KH03', 'NV03', '510,000')
INSERT INTO HOADON VALUES('1008', '2006-10-28', 'KH01', 'NV03', '440,000')
INSERT INTO HOADON VALUES('1009', '2006-10-28', 'KH03', 'NV04', '200,000')
INSERT INTO HOADON VALUES('1010', '2006-11-01', 'KH01', 'NV01', '5,200,000')
INSERT INTO HOADON VALUES('1011', '2006-04-11','KH04', 'NV03', '250,000')
INSERT INTO HOADON VALUES('1012', '2006-11-30', 'KH05', 'NV03', '21,000')
INSERT INTO HOADON VALUES('1013', '2006-12-12', 'KH06', 'NV01', '5,000')
INSERT INTO HOADON VALUES('1014', '2006-12-31', 'KH03', 'NV02', '3,150,000')
INSERT INTO HOADON VALUES('1015', '2007-01-01', 'KH06', 'NV01', '910,000')
INSERT INTO HOADON VALUES('1016', '2007-01-01', 'KH07', 'NV02', '12,500')
INSERT INTO HOADON VALUES('1017', '2007-01-02', 'KH08', 'NV03', '35,000')
INSERT INTO HOADON VALUES('1018', '2007-01-13','KH08', 'NV03', '330,000')
INSERT INTO HOADON VALUES('1019', '2007-01-13', 'KH01', 'NV03', '30,000')
INSERT INTO HOADON VALUES('1020', '2007-01-14', 'KH09', 'NV04', '70,000')
INSERT INTO HOADON VALUES('1021', '2007-01-16', 'KH10', 'NV03', '67,500')
INSERT INTO HOADON VALUES('1022', '2007-01-16', 'Null', 'NV03', '7,000')
INSERT INTO HOADON VALUES('1023', '2007-01-17', 'Null', 'NV01', '330,000')
select * from HOADON
--CTHD
INSERT INTO CTHD VALUES(1001,'TV02',10)
INSERT INTO CTHD VALUES(1001,'ST01',5)
INSERT INTO CTHD VALUES(1001,'BC01',5)
INSERT INTO CTHD VALUES(1001,'BC02',10)
INSERT INTO CTHD VALUES(1001,'ST08',10)
INSERT INTO CTHD VALUES(1002,'BC04',20)
INSERT INTO CTHD VALUES(1002,'BB01',20)
INSERT INTO CTHD VALUES(1002,'BB02',20)
INSERT INTO CTHD VALUES(1003,'BB03',10)
INSERT INTO CTHD VALUES(1004,'TV01',20)
INSERT INTO CTHD VALUES(1004,'TV02',10)
INSERT INTO CTHD VALUES(1004,'TV03',10)
INSERT INTO CTHD VALUES(1004,'TV04',10)
INSERT INTO CTHD VALUES(1005,'TV05',50)
INSERT INTO CTHD VALUES(1005,'TV06',50)
INSERT INTO CTHD VALUES(1006,'TV07',20)
INSERT INTO CTHD VALUES(1006,'ST01',30)
INSERT INTO CTHD VALUES(1006,'ST02',10)
INSERT INTO CTHD VALUES(1007,'ST03',10)
INSERT INTO CTHD VALUES(1008,'ST04',8)
INSERT INTO CTHD VALUES(1009,'ST05',10)
INSERT INTO CTHD VALUES(1010,'TV07',50)
INSERT INTO CTHD VALUES(1010,'ST07',50)
INSERT INTO CTHD VALUES(1010,'ST08',100)
INSERT INTO CTHD VALUES(1010,'ST04',50)
INSERT INTO CTHD VALUES(1010,'TV03',100)
INSERT INTO CTHD VALUES(1011,'ST06',50)
INSERT INTO CTHD VALUES(1012,'ST07',3)
INSERT INTO CTHD VALUES(1013,'ST08',5)
INSERT INTO CTHD VALUES(1014,'BC02',80)
INSERT INTO CTHD VALUES(1014,'BB02',100)
INSERT INTO CTHD VALUES(1014,'BC04',60)
INSERT INTO CTHD VALUES(1014,'BB01',50)
INSERT INTO CTHD VALUES(1015,'BB02',30)
INSERT INTO CTHD VALUES(1015,'BB03',7)
INSERT INTO CTHD VALUES(1016,'TV01',5)
INSERT INTO CTHD VALUES(1017,'TV02',1)
INSERT INTO CTHD VALUES(1017,'TV03',1)
INSERT INTO CTHD VALUES(1017,'TV04',5)
INSERT INTO CTHD VALUES(1018,'ST04',6)
INSERT INTO CTHD VALUES(1019,'ST05',1)
INSERT INTO CTHD VALUES(1019,'ST06',2)
INSERT INTO CTHD VALUES(1020,'ST07',10)
INSERT INTO CTHD VALUES(1021,'ST08',5)
INSERT INTO CTHD VALUES(1021,'TV01',7)
INSERT INTO CTHD VALUES(1021,'TV02',10)
INSERT INTO CTHD VALUES(1022,'ST07',1)
INSERT INTO CTHD VALUES(1023,'ST04',6)
select * from CTHD
--Bài 3: II (2-5)
--2.Tạo quan hệ SANPHAM1 chứa toàn bộ dữ liệu của quan hệ SANPHAM. Tạo quan hệ KHACHHANG1 chứa toàn bộ dữ liệu của quan hệ KHACHHANG.
SELECT* FROM SANPHAM, KHACHHANG
--3. Cập nhật giá tăng 5% đối với những sản phẩm do “Thai Lan” sản xuất (cho quan hệ SANPHAM1)
UPDATE SANPHAM 
SET GIA = GIA*1.05
WHERE NUOCSX = 'Thai Lan'
--4. Cập nhật giá giảm 5% đối với những sản phẩm do “Trung Quoc” sản xuất có giá từ 10.000 trở xuống (cho quan hệ SANPHAM1).
UPDATE SANPHAM
SET GIA = GIA*0.95
WHERE NUOCSX='Trung Quoc' AND GIA < = 10.000
--5. Cập nhật giá trị LOAIKH là “Vip” đối với những khách hàng đăng ký thành viên trước ngày 1/1/2007 có doanh số từ 10.000.000 trở lên hoặc khách hàng đăng ký thành viên từ 1/1/2007 trở về sau có doanh số từ 2.000.000 trở lên (cho quan hệ KHACHHANG1).
UPDATE KHACHHANG 
SET LOAIKH = 'Vip'
WHERE (NGDK <'2007-01-01' AND DOANHSO >=10000000 OR (NGDK > '2007-01-01' AND DOANHSO>=2000000))

--Bài 5: III (1-11)
--1. In ra danh sách các sản phẩm (MASP,TENSP) do “Trung Quoc” sản xuất.
SELECT MASP, TENSP
FROM SANPHAM
WHERE NUOCSX='Trung Quoc'
--2. In ra danh sách các sản phẩm (MASP, TENSP) có đơn vị tính là “cay”, ”quyen”.
SELECT MASP, TENSP
FROM SANPHAM
WHERE DVT IN ('cay', 'quyen')
--3. In ra danh sách các sản phẩm (MASP,TENSP) có mã sản phẩm bắt đầu là “B” và kết thúc là “01”.
SELECT MASP, TENSP
FROM SANPHAM
WHERE MASP LIKE 'B%01'
--4. In ra danh sách các sản phẩm (MASP,TENSP) do “Trung Quốc” sản xuất có giá từ 30.000 đến 40.000.
SELECT MASP, TENSP
FROM SANPHAM
WHERE NUOCSX='Trung Quoc' AND GIA BETWEEN 30000 AND 40000
--5. In ra danh sách các sản phẩm (MASP,TENSP) do “Trung Quoc” hoặc “Thai Lan” sản xuất có giá từ 30.000 đến 40.000.
SELECT MASP, TENSP
FROM SANPHAM
WHERE (NUOCSX = 'Trung Quoc' OR NUOCSX ='Thai Lan') AND GIA BETWEEN 30000 AND 40000
--6. In ra các số hóa đơn, trị giá hóa đơn bán ra trong ngày 1/1/2007 và ngày 2/1/2007.
SELECT SOHD, TRIGIA
FROM HOADON
WHERE NGHD = '2007-01-01' OR NGHD = '2007-01-02'
--7. In ra các số hóa đơn, trị giá hóa đơn trong tháng 1/2007, sắp xếp theo ngày (tăng dần) và trị giá của hóa đơn (giảm dần).
SELECT SOHD, TRIGIA
FROM HOADON
WHERE YEAR(NGHD)='2007' AND MONTH(NGHD)='1'
ORDER BY DAY(NGHD) ASC, TRIGIA DESC
--8. In ra danh sách các khách hàng (MAKH, HOTEN) đã mua hàng trong ngày 1/1/2007.
SELECT KH.MAKH, HOTEN
FROM KHACHHANG KH JOIN HOADON HD ON KH.MAKH = HD.MAKH
WHERE NGHD = '2007-01-01'
--9. In ra số hóa đơn, trị giá các hóa đơn do nhân viên có tên “Nguyen Van B” lập trong ngày 28/10/2006.
SELECT SOHD, TRIGIA
FROM HOADON HD JOIN NHANVIEN NV ON HD.MANV = NV.MANV
WHERE NV.HOTEN = 'Nguyen Van B' AND NGHD = '2006-10-28'
--10. In ra danh sách các sản phẩm (MASP,TENSP) được khách hàng có tên “Nguyen Van A” mua trong tháng 10/2006.
SELECT SP.MASP, SP.TENSP
FROM SANPHAM SP, CTHD CT, HOADON HD, KHACHHANG KH 
WHERE SP.MASP = CT.MASP AND CT.SOHD = HD.SOHD AND HD.MAKH = KH.MAKH
AND KH.HOTEN = 'Nguyen Van A' AND YEAR(HD.NGHD)= 2010 AND MONTH(HD.NGHD)=10

--11. Tìm các số hóa đơn đã mua sản phẩm có mã số “BB01” hoặc “BB02”.
SELECT SOHD
FROM CTHD
WHERE MASP IN ('BB01', 'BB02')
--12. Tìm các số hóa đơn đã mua sản phẩm có mã số “BB01” hoặc “BB02”, mỗi sản phẩm mua với số lượng từ 10 đến 20
SELECT DISTINCT SOHD
FROM CTHD
WHERE MASP IN ('BB01', 'BB02') AND SL BETWEEN 10 AND 20
--13. Tìm các số hóa đơn mua cùng lúc 2 sản phẩm có mã số “BB01” và “BB02”, mỗi sản phẩm mua với số lượng từ 10 đến 20.
SELECT DISTINCT SOHD , MASP, SL
FROM CTHD WHERE MASP='BB01' AND SOHD IN (SELECT SOHD FROM CTHD WHERE MASP='BB02') AND CTHD.SL BETWEEN 10 AND 20
--14. In ra danh sách các sản phẩm (MASP,TENSP) do “Trung Quoc” sản xuất hoặc các sản phẩm được bán ra trong ngày 1/1/2007.
SELECT sp.MASP, sp.TENSP, hd.NGHD, sp.NUOCSX
FROM SANPHAM sp, HOADON hd, CTHD ct
WHERE hd.SOHD = ct.SOHD and sp.MASP=ct.MASP and sp.NUOCSX='Trung Quoc' and hd.NGHD='2007-01-01' 
--15.In ra danh sách các sản phẩm (MASP,TENSP) không bán được
SELECT sp.MASP,sp.TENSP
FROM SANPHAM sp
WHERE sp.MASP NOT IN ( SELECT ct.MASP FROM CTHD ct )
--16. In ra danh sách các sản phẩm (MASP,TENSP) không bán được trong năm 2006
SELECT sp.MASP,sp.TENSP
FROM SANPHAM sp
WHERE not exists ( SELECT ct.MASP FROM CTHD ct, HOADON hd WHERE HD.SOHD=CT.SOHD AND sp.MASP=ct.MASP AND  YEAR(hd.NGHD)=2006)
--17. In ra danh sách các sản phẩm (MASP,TENSP) do “Trung Quoc” sản xuất không bán được trong năm 2006.
SELECT MASP, TENSP
FROM SANPHAM
WHERE NUOCSX='Trung Quoc' 
EXCEPT
SELECT distinct sp.MASP, sp.TENSP
FROM HOADON hd, CTHD ct, SANPHAM sp
WHERE year(hd.NGHD)=2006 and hd.SOHD=ct.SOHD and sp.MASP = ct.MASP
--18.Tìm số hóa đơn đã mua tất cả các sản phẩm do Singapore sản xuất.
SELECT SOHD
FROM HOADON
WHERE
NOT EXISTS
(
    SELECT *
    FROM SANPHAM
    WHERE NUOCSX= 'Singapore' AND MASP NOT IN
    (
        SELECT masp
        FROM CTHD
        WHERE SOHD = HOADON.SOHD and CTHD.MASP = SANPHAM.MASP
    )
)
--19. Tìm số hóa đơn trong năm 2006 đã mua ít nhất tất cả các sản phẩm do Singapore sản xuất.
SELECT SOHD
FROM HOADON
WHERE year(NGHD)=2006
and NOT EXISTS
(
    SELECT *
    FROM SANPHAM
    WHERE NUOCSX = 'Singapore' and MASP NOT IN
    (
        SELECT masp
        FROM CTHD
        WHERE SOHD = HOADON.SOHD
    )
)
--20. Có bao nhiêu hóa đơn không phải của khách hàng đăng ký thành viên mua?
SELECT COUNT(SOHD)SL from HOADON hd
WHERE not exists (select MAKH from KHACHHANG kh where kh.MAKH=hd.MAKH)
--21. Có bao nhiêu sản phẩm khác nhau được bán ra trong năm 2006.
SELECT COUNT( DISTINCT MASP) 
from CTHD JOIN HOADON hd on CTHD.SOHD=hd.SOHD
WHERE YEAR(hd.NGHD)='2006'
--22. Cho biết trị giá hóa đơn cao nhất, thấp nhất là bao nhiêu ?
SELECT MAX(TRIGIA) MAX_GIA, MIN(TRIGIA) MIN_GIA from HOADON
--23.Trị giá trung bình của tất cả các hóa đơn được bán ra trong năm 2006 là bao nhiêu?
SELECT AVG(TRIGIA) AVG_GIA
FROM HOADON hd 
WHERE YEAR(HD.NGHD)= '2006'
--24.Tính doanh thu bán hàng trong năm 2006
SELECT SUM(TRIGIA) DOANHTHU FROM HOADON
WHERE YEAR(NGHD)= '2006'
--25.Tìm số hóa đơn có trị giá cao nhất trong năm 2006.
SELECT SOHD
FROM HOADON hd
WHERE TRIGIA = (SELECT MAX(TRIGIA)
FROM HOADON) AND YEAR(hd.NGHD)='2006'
--26. Tìm họ tên khách hàng đã mua hóa đơn có trị giá cao nhất trong năm 2006
SELECT kh.HOTEN
From KHACHHANG kh JOIN HOADON hd on kh.MAKH=hd.MAKH
WHERE hd.TRIGIA = (select MAX(TRIGIA) FROM HOADON) and YEAR(hd.NGHD)='2006'
--27. In ra danh sách 3 khách hàng (MAKH, HOTEN) có doanh số cao nhất
SELECT TOP 3 MAKH, HOTEN, DOANHSO
FROM KHACHHANG
ORDER BY DOANHSO DESC
--28. In ra danh sách các sản phẩm (MASP, TENSP) có giá bán bằng 1 trong 3 mức giá cao nhất.
SELECT sp.MASP, sp.TENSP
FROM SANPHAM SP 
WHERE GIA IN (SELECT TOP 3 GIA FROM SANPHAM ORDER BY GIA DESC)
--29.In ra danh sách các sản phẩm (MASP, TENSP) do “Thai Lan” sản xuất có giá bằng 1 trong 3 mức giá cao nhất (của tất cả các sản phẩm)
SELECT sp.MASP, sp.TENSP 
FROM SANPHAM sp 
WHERE GIA IN (SELECT TOP 3 GIA FROM SANPHAM  Order by GIA DESC) and NUOCSX='Thai Lan'
--30. In ra danh sách các sản phẩm (MASP, TENSP) do “Trung Quoc” sản xuất có giá bằng 1 trong 3 mức giá cao nhất (của sản phẩm do “Trung Quoc” sản xuất).
SELECT sp.MASP, sp.TENSP
FROM SANPHAM sp
WHERE GIA IN (SELECT TOP 3 GIA FROM SANPHAM where NUOCSX='Trung Quoc') and NUOCSX='Trung Quoc'
--31.* In ra danh sách 3 khách hàng có doanh số cao nhất (sắp xếp theo kiểu xếp hạng).
SELECT TOP 3 MAKH, HOTEN
FROM KHACHHANG kh
ORDER BY DOANHSO DESC
--32. Tính tổng số sản phẩm do “Trung Quoc” sản xuất.
SELECT COUNT(DISTINCT MASP) TONG_SP
FROM SANPHAM
WHERE NUOCSX = 'Trung Quoc'
--33.Tính tổng số sản phẩm của từng nước sản xuất.
SELECT NUOCSX, COUNT(DISTINCT MASP) TONG_SP
FROM SANPHAM
GROUP BY NUOCSX
--34. Với từng nước sản xuất, tìm giá bán cao nhất, thấp nhất, trung bình của các sản phẩm
SELECT NUOCSX, AVG(GIA) GIA_TB, MAX(GIA) MAX_GIA, MIN(GIA) MIN_GIAN
FROM SANPHAM
GROUP BY NUOCSX
--35. Tính doanh thu bán hàng mỗi ngày.
SELECT DISTINCT NGHD, SUM(TRIGIA) DOANHTHU
FROM  HOADON
GROUP BY NGHD
--36. Tính tổng số lượng của từng sản phẩm bán ra trong tháng 10/2006.
SELECT sp.TENSP, SUM(SL) TONG_SL, sp.MASP
FROM (HOADON hd JOIN CTHD on hd.SOHD=CTHD.SOHD) JOIN SANPHAM sp on sp.MASP=CTHD.MASP
WHERE month(hd.NGHD)='10' and YEAR(hd.NGHD)='2006'
group by sp.TENSP, sp.MASP
--37. Tính doanh thu bán hàng của từng tháng trong năm 2006.
SELECT MONTH(NGHD) THANG, SUM(TRIGIA) DOANHTHU
FROM HOADON where YEAR(NGHD)='2006'
GROUP BY MONTH(NGHD)
--38. Tìm hóa đơn có mua ít nhất 4 sản phẩm khác nhau
SELECT HOADON.SOHD
FROM HOADON JOIN CTHD ON HOADON.SOHD=CTHD.SOHD
GROUP BY HOADON.SOHD
HAVING COUNT(DISTINCT MASP) >= 4
--39.Tìm hóa đơn có mua 3 sản phẩm do “Viet Nam” sản xuất (3 sản phẩm khác nhau).
SELECT distinct CTHD.SOHD, COUNT(CTHD.MASP)SO_SP
FROM CTHD JOIN SANPHAM sp ON sp.MASP=CTHD.MASP 
WHERE sp.NUOCSX='Viet Nam'
group by CTHD.SOHD
HAVING COUNT(CTHD.MASP)>=3
--40. Tìm khách hàng (MAKH, HOTEN) có số lần mua hàng nhiều nhất.
SELECT kh.MAKH, kh.HOTEN
FROM KHACHHANG kh JOIN HOADON hd on kh.MAKH=hd.MAKH
WHERE kh.MAKH=(SELECT TOP 1 MAKH FROM HOADON)
GROUP BY kh.MAKH, kh.HOTEN
--41. Tháng mấy trong năm 2006, doanh số bán hàng cao nhất ?
SELECT TOP 1 MONTH(NGHD) THANG
from HOADON
WHERE YEAR(NGHD)='2006'
GROUP BY MONTH(NGHD)
ORDER BY SUM(TRIGIA) DESC
--42. Tìm sản phẩm (MASP, TENSP) có tổng số lượng bán ra thấp nhất trong năm 2006.
SELECT MASP, TENSP
FROM SANPHAM
WHERE MASP = (SELECT TOP 1 MASP
FROM CTHD
GROUP BY MASP
ORDER BY SUM(SL) DESC)
--43. *Mỗi nước sản xuất, tìm sản phẩm (MASP,TENSP) có giá bán cao nhất.

--44. Tìm nước sản xuất sản xuất ít nhất 3 sản phẩm có giá bán khác nhau.
--45. *Trong 10 khách hàng có doanh số cao nhất, tìm khách hàng có số lần mua hàng nhiều nhất.
SELECT *
FROM KHACHHANG
WHERE MAKH = (SELECT TOP 1 A.MAKH
FROM (SELECT TOP 10 MAKH
FROM KHACHHANG
ORDER BY DOANHSO DESC) AS A
LEFT JOIN 
(SELECT MAKH, COUNT(SOHD) AS SL
FROM HOADON
GROUP BY MAKH) AS B
ON A.MAKH = B.MAKH
ORDER BY SL DESC)
--LAB 8
--Câu 11 Ngày mua hàng (NGHD) của một khách hàng thành viên sẽ lớn hơn hoặc bằng ngày khách hàng đ đăng ký thành viên (NGDK).
CREATE TRIGGER HD_C11
ON HOADON
FOR INSERT,UPDATE
AS
DECLARE @NGDK SMALLDATETIME, 
@NGHD SMALLDATETIME
SELECT @NGDK=NGDK,@NGHD=NGHD
FROM  INSERTED I, KHACHHANG A
WHERE I.MAKH=A.MAKH
IF @NGHD<@NGDK
BEGIN
ROLLBACK TRAN
PRINT 'ERROR!NGHD PHAI LON HON NGDK'
END
ELSE
PRINT' SUCCESSFUL'
 --Câu 12 Ngày bán hàng (NGHD) của một nhân viên phải lớn hơn hoặc bằng ngày nhân viên đó vào làm
CREATE TRIGGER UPDATE_NV
ON NHANVIEN
FOR UPDATE
AS
DECLARE @NGVL SMALLDATETIME, 
@NGHD SMALLDATETIME
SELECT @NGVL=NGVL
FROM  INSERTED
IF(@NGVL>ANY(SELECT NGHD
FROM  HOADON A, INSERTED I
WHERE A.MANV=I.MANV))
BEGIN
ROLLBACK TRAN
PRINT 'ERROR!NGVL PHAI NHO HON NGHD'
END
ELSE
PRINT' SUCCESSFUL'
--Câu 13 Mỗi một hóa đơn phải có ít nhất một chi tiết hóa đơn.
CREATE TRIGGER HOADON_1
ON HOADON
FOR INSERT
AS
DECLARE @SOHD INT
SELECT @SOHD=SOHD
FROM  INSERTED
UPDATE CTHD
SET  MASP='NONE',SL=0
WHERE SOHD=@SOHD
PRINT 'SUCCESSFUL! DE NGHI UPDATE LAI CTHD(MAC DINH:MASP="NONE", SL=0)'
--Câu 14 Trị giá của một hóa đơn là tổng thành tiền (số lượng*đơn giá) của các chi tiết thuộc hóa đơn đó.
CREATE TRIGGER INSERT_HOADON
ON HOADON
FOR INSERT
AS
UPDATE HOADON
SET  TRIGIA=0
WHERE SOHD=(SELECT  SOHD
FROM  INSERTED)
PRINT'DA INSERT 1 HOADON VOI TRIGIA BAN DAU LA 0 VND' 