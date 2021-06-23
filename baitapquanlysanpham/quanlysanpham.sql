use demo2006;
# BÀI TẬP ÔN TẬP SQL
# Bài quản lý sản phẩm
# 6. In ra các số hóa đơn, trị giá hóa đơn bán ra trong ngày 19/6/2006 và ngày 20/6/2006.
select * from demo2006.order
where time between '19/6/2006' and '20/6/2006' ;

# 7. In ra các số hóa đơn, trị giá hóa đơn trong tháng 6/2007, sắp xếp theo ngày (tăng dần) và trị giá của hóa đơn (giảm dần).
select o.id, sum(p.price*od.quantity) as total
from product p, demo2006.order o, orderdetail od
where p.id=od.productid and o.id=od.orderId and month(o.time)=6 and year(o.time)=2006
group by o.id
order by o.time, total desc;

# 8. In ra danh sách các khách hàng (MAKH, HOTEN) đã mua hàng trong ngày 19/06/2007.
select c.id, c.name from customer c 
join demo2006.order o on c.id=o.customerId 
where time = '2006-06-20';

# 10. In ra danh sách các sản phẩm (MASP,TENSP) được khách hàng có tên “Nguyen Van A” mua trong tháng 10/2006.
select p.id, p.name, o.time
from product p, demo2006.order o, orderdetail od, customer c
where p.id=od.productId and o.customerId=c.id and od.orderId=o.id
and c.name = 'Nguyen Van A' and month(o.time)=10 and year(o.time)=2006;

# 11. Tìm các số hóa đơn đã mua sản phẩm “Máy giặt” hoặc “Tủ lạnh”.
select o.id, o.time
from demo2006.order o, product p, orderdetail od
where p.id=od.productId and o.id=od.orderId
and p.name in ('Máy giặt','Tủ lạnh');
# 12. Tìm các số hóa đơn đã mua sản phẩm “Máy giặt” hoặc “Tủ lạnh”, mỗi sản phẩm mua với số lượng từ 10 đến 20.
select o.id, o.time
from demo2006.order o, product p, orderdetail od
where p.id=od.productId and o.id=od.orderId
and p.name in ('Máy giặt', 'Tủ lạnh') and od.quantity between 10 and 20;

# 13. Tìm các số hóa đơn mua cùng lúc 2 sản phẩm “Máy giặt” và “Tủ lạnh”, mỗi sản phẩm mua với số lượng từ 10 đến 20.
create view maygiat as
select o.id, o.time from demo2006.order o join orderdetail od on o.id=od.orderId
join product p on p.id=od.productId
where p.name like 'Máy giặt' and od.quantity between 10 and 20;

# 15. In ra danh sách các sản phẩm (MASP,TENSP) không bán được.
select product.id, product.name 
from product
where id not in (select productID from orderdetail);

# 16. In ra danh sách các sản phẩm (MASP,TENSP) không bán được trong năm 2006.
select product.id, product.name
from product
where id not in (select od.productID
from orderdetail od, demo2006.order o where o.id=od.orderId and year(o.time)=2006);

# 17. In ra danh sách các sản phẩm (MASP,TENSP) có giá >300 sản xuất bán được trong năm 2006.
select id, name
from product
where price > 300 and id in (select od.productId
from orderdetail od, demo2006.order o
where o.id=od.orderId
and year(o.time)=2006); 

# 18. Tìm số hóa đơn đã mua tất cả các sản phẩm có giá >200.
select id, time 
from demo2006.order
where id in (select o.id
from demo2006.order o, orderdetail od, product p
where o.id=od.orderId and p.id=od.productId and p.price>200);


# 19. Tìm số hóa đơn trong năm 2006 đã mua tất cả các sản phẩm có giá <300.
select id, time from demo2006.order
where id in(select o.id
from demo2006.order o, orderdetail od, product p
where o.id=od.orderId and p.id=od.productId and p.price<300 and year(o.time)=2006) ;

# 21. Có bao nhiêu sản phẩm khác nhau được bán ra trong năm 2006.
select count(id) as spkhacnhau
from product
where id in (select od.productId
from orderdetail od, demo2006.order o
where o.id=od.orderId and year(o.time)=2006);

# 22. Cho biết trị giá hóa đơn cao nhất, thấp nhất là bao nhiêu?
create view total as
select o.id, sum(p.price*od.quantity) as total, o.time
from product p, demo2006.order o, orderdetail od
where p.id=od.productId and o.id=od.orderId
group by o.id;

# 23. Trị giá trung bình của tất cả các hóa đơn được bán ra trong năm 2006 là bao nhiêu?
select AVG(total) as DoanhThuTrungBinh2006 from total where year(time)=2006;

# 24. Tính doanh thu bán hàng trong năm 2006.
select sum(total) as DoanhThu2006 from total where year(time)=2006;

# 25. Tìm số hóa đơn có trị giá cao nhất trong năm 2006.
select id, time 
from total 
where total >= all(select total from total);

# 26. Tìm họ tên khách hàng đã mua hóa đơn có trị giá cao nhất trong năm 2006.
select c.id, c.name
from customer c, demo2006.order o 
where o.customerId=c.id
and o.id =(
select id from total where total >= all(select total from total where year(time)=2006));

# 27. In ra danh sách 3 khách hàng (MAKH, HOTEN) mua nhiều hàng nhất (tính theo số lượng).
select c.id, c.name, sum(quantity) as soluonghang 
from customer c join demo2006.order o on c.id=o.customerId
join orderdetail od on od.orderId=o.id
group by c.id
order by soluonghang desc
limit 3; 

# 28. In ra danh sách các sản phẩm (MASP, TENSP) có giá bán bằng 1 trong 3 mức giá cao nhất.
select id, name
from product 
where price in(select price from top3p);

# 29. In ra danh sách các sản phẩm (MASP, TENSP) có tên bắt đầu bằng chữ M, có giá bằng 1 trong 3 mức giá cao nhất (của tất cả các sản phẩm).
select id, name
from product
where price in (select price from top3p) and name like 'M%';

# 32. Tính tổng số sản phẩm giá <300.
select sum(quantity) 
from product 
where price < 300;

# 33. Tính tổng số sản phẩm theo từng giá.
select price, sum(quantity) 
from product
group by price;

# 34. Tìm giá bán cao nhất, thấp nhất, trung bình của các sản phẩm bắt đầu bằng chữ M.
create view productM as
select id, name, price
from product
where name like 'M%';
select max(price), min(price), max(price) from productM;

# 35. Tính doanh thu bán hàng mỗi ngày.
select day(time) as ngày, month(time) as tháng, sum(total) as ThuNhap from total
group by day(time);

# 36. Tính tổng số lượng của từng sản phẩm bán ra trong tháng 10/2006.
select od.productId, sum(od.quantity) as soluongsanphamban
from orderdetail od join demo2006.order o on o.id=od.orderId
where month(o.time)=10 and year(o.time)=2006
group by od.productId;

# 37. Tính doanh thu bán hàng của từng tháng trong năm 2006.
create view totalbymonth2016 as
select month(o.time), sum(p.price*od.quantity) as total, o.time
from product p, demo2006.order o, orderdetail od
where p.id=od.productId and o.id=od.orderId
group by month(o.time);
select month(time) as tháng, sum(total) as ThuNhap from total
where year(time)=2006
group by month(time);

# 38. Tìm hóa đơn có mua ít nhất 4 sản phẩm khác nhau.
select o.id, o.time from demo2006.order o join orderdetail od on od.orderId=o.id
group by od.orderId;

# 39. Tìm hóa đơn có mua 3 sản phẩm có giá <300 (3 sản phẩm khác nhau).
# 40. Tìm khách hàng (MAKH, HOTEN) có số lần mua hàng nhiều nhất.
# 41. Tháng mấy trong năm 2006, doanh số bán hàng cao nhất?

create view doanhsothang_2006 as
select od.orderId, o.time, sum(od.quantity*p.price) as tongdoanhso from product p
join orderdetail od on p.id = od.productId
join demo2006.order o on o.id = od.orderid
where year(o.time) = 2006
group by month(o.time);

select orderID, month(time), tongdoanhso
from doanhsothang_2006
where tongdoanhso = (select max(tongdoanhso) from doanhsothang_2006);

# 42. Tìm sản phẩm (MASP, TENSP) có tổng số lượng bán ra thấp nhất trong năm 2006.
# 45. Trong 10 khách hàng có doanh số cao nhất, tìm khách hàng có số lần mua hàng nhiều nhất.
