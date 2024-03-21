--1. Liệt kê các hóa đơn của khách hàng, thông tin hiển thị gồm: mã user, tên user, mã hóa đơn
SELECT `users`.`user_id`, `users`.`user_name` , `orders`.`order_id`
FROM `users` 
INNER JOIN `orders`
ON `users`.`user_id` = `orders`.`user_id`
--2. Liệt kê số lượng các hóa đơn của khách hàng: mã user, tên user, số đơn hàng
SELECT `users`.`user_id`, `users`.`user_name` , COUNT(`orders`.`order_id`) as 'sl_don'
FROM `users` 
INNER JOIN `orders`
ON `users`.`user_id` = `orders`.`user_id`
GROUP BY `users`.`user_name`
--3.Liệt kê thông tin hóa đơn: mã đơn hàng, số sản phẩm
SELECT `order_details`.`order_id` , GROUP_CONCAT(`order_details`.`product_id`) as 'product_id_list'
From `order_details`
GROUP BY `order_details`.`order_id`
--4.Liệt kê thông tin mua hàng của người dùng: mã user, tên user, mã đơn hàng, tên sản
--phẩm. Lưu ý: gôm nhóm theo đơn hàng, tránh hiển thị xen kẻ các đơn hàng với nhau
SELECT `users`.`user_id` , `users`.`user_name` , `orders`.`order_id` , GROUP_CONCAT(`products`.`product_name`) 
FROM `users` 
INNER JOIN `orders` ON `users`.`user_id` = `orders`.`user_id` 
INNER JOIN `order_details` ON `orders`.`order_id` = `order_details`.`order_id` 
INNER JOIN `products` ON `order_details`.`product_id` = `products`.`product_id`
GROUP BY `orders`.`order_id`
--5.Liệt kê 7 người dùng có số lượng đơn hàng nhiều nhất, thông tin hiển thị gồm: mã
--user, tên user, số lượng đơn hàng
SELECT `users`.`user_id` , `users`.`user_name` , COUNT(`orders`.`order_id`) as 'sl_don'
FROM `users` 
INNER JOIN `orders` ON `users`.`user_id` = `orders`.`user_id`  
GROUP BY `users`.`user_name`
ORDER BY COUNT(`orders`.`order_id`) DESC
LIMIT 7
--6. Liệt kê 7 người dùng mua sản phẩm có tên: Samsung hoặc Apple trong tên sản
--phẩm, thông tin hiển thị gồm: mã user, tên user, mã đơn hàng, tên sản phẩm
SELECT `users`.`user_id` , `users`.`user_name` , `orders`.`order_id` ,`products`.`product_name`
FROM `users` 
INNER JOIN `orders` ON `users`.`user_id` = `orders`.`user_id` 
INNER JOIN `order_details` ON `orders`.`order_id` = `order_details`.`order_id` 
INNER JOIN `products` ON `order_details`.`product_id` = `products`.`product_id`
WHERE `products`.`product_name` LIKE '%samsung%' OR `products`.`product_name` LIKE '%apple%'
LIMIT 7
--7.Liệt kê danh sách mua hàng của user bao gồm giá tiền của mỗi đơn hàng, thông tin
--hiển thị gồm: mã user, tên user, mã đơn hàng, tổng tiền
SELECT `users`.`user_id` , `users`.`user_name` , `orders`.`order_id` , SUM(`products`.`product_price`) as 'Tong_tien'
FROM `users` 
INNER JOIN `orders` ON `users`.`user_id` = `orders`.`user_id` 
INNER JOIN `order_details` ON `orders`.`order_id` = `order_details`.`order_id` 
INNER JOIN `products` ON `order_details`.`product_id` = `products`.`product_id`
GROUP BY `orders`.`order_id`
--8.Liệt kê danh sách mua hàng của user bao gồm giá tiền của mỗi đơn hàng, thông tin
--hiển thị gồm: mã user, tên user, mã đơn hàng, tổng tiền. Mỗi user chỉ chọn ra 1 đơn
--hàng có giá tiền lớn nhất. 

SELECT ranked.user_id , ranked.user_name , ranked.order_id , ranked.total
FROM (
    SELECT u.user_id , 
    	   u.user_name , 
           o.order_id , 
           SUM(p.product_price) as total, 
           ROW_NUMBER() OVER(PARTITION BY u.user_id ORDER BY SUM(p.product_price) DESC ) as rank_price_person
    FROM users u
    INNER JOIN orders o ON u.user_id = o.user_id
    INNER JOIN order_details od ON od.order_id = o.order_id
    INNER JOIN products p ON p.product_id = od.product_id
    GROUP BY u.user_id , o.order_id
) as ranked
WHERE rank_price_person = 1
    
-- 9. Liệt kê danh sách mua hàng của user bao gồm giá tiền của mỗi đơn hàng, thông tin
--hiển thị gồm: mã user, tên user, mã đơn hàng, tổng tiền, số sản phẩm. Mỗi user chỉ
--chọn ra 1 đơn hàng có giá tiền nhỏ nhất.
SELECT ranked.user_id , ranked.user_name , ranked.order_id , ranked.total, ranked.sl_donhang 
FROM (
    SELECT u.user_id , 
    	   u.user_name , 
           o.order_id , 
           SUM(p.product_price) as total, 
    	   COUNT(od.order_id) as sl_donhang,
           ROW_NUMBER() OVER(PARTITION BY u.user_id ORDER BY SUM(p.product_price) ASC ) as rank_price_person
    FROM users u
    INNER JOIN orders o ON u.user_id = o.user_id
    INNER JOIN order_details od ON od.order_id = o.order_id
    INNER JOIN products p ON p.product_id = od.product_id
    GROUP BY u.user_id , o.order_id
) as ranked
WHERE rank_price_person = 1
--10. Liệt kê danh sách mua hàng của user bao gồm giá tiền của mỗi đơn hàng, thông tin
--hiển thị gồm: mã user, tên user, mã đơn hàng, tổng tiền, số sản phẩm. Mỗi user chỉ
--chọn ra 1 đơn hàng có số sản phẩm là nhiều nhất.
SELECT ranked.user_id , ranked.user_name , ranked.order_id , ranked.total, ranked.sl_donhang 
FROM (
    SELECT u.user_id , 
    	   u.user_name , 
           o.order_id , 
           SUM(p.product_price) as total, 
    	   COUNT(od.order_id) as sl_donhang,
           ROW_NUMBER() OVER(PARTITION BY u.user_id ORDER BY COUNT(od.order_id) DESC ) as rank_price_person
    FROM users u
    INNER JOIN orders o ON u.user_id = o.user_id
    INNER JOIN order_details od ON od.order_id = o.order_id
    INNER JOIN products p ON p.product_id = od.product_id
    GROUP BY u.user_id , o.order_id
) as ranked
WHERE rank_price_person = 1
