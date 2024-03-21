-- Lấy danh sách người dùng theo thứ tự tên (A-Z)
SELECT * 
FROM `users` 
WHERE `users`.`user_name` >= 'a' AND `users`.`user_name` <= 'z'
ORDER BY `users`.`user_name` ASC
--Lấy ra 07 người dùng theo thứ tự tên theo Alphabet (A->Z)
SELECT * 
FROM `users` 
WHERE `users`.`user_name` >= 'a' AND `users`.`user_name` <= 'z'
ORDER BY `users`.`user_name` ASC
LIMIT 7
--Lấy ra danh sách người dùng theo thứ tự tên theo Alphabet (A->Z), 
--trong đó tên người dùng có chữ a
SELECT * 
FROM `users` 
WHERE `users`.`user_name` LIKE '%a%'
ORDER BY `users`.`user_name` ASC
--Lấy ra danh sách người dùng trong đó tên người dùng bắt đầu bằng chữ m
SELECT * 
FROM`users` 
WHERE `users`.`user_name` LIKE 'm%'
--Lấy ra danh sách người dùng trong đó tên người dùng bắt đầu bằng chữ i
SELECT * 
FROM`users` 
WHERE `users`.`user_name` LIKE '%i'
--Lấy ra danh sách người dùng trong đó email người dùng là Gmail
SELECT * 
FROM`users` 
WHERE `users`.`user_email` LIKE '%gmail%'
--Lấy ra danh sách người dùng trong đó email người dùng là Gmail, 
--tên người dùng bắt đầu bằng chữ m
SELECT * 
FROM`users` 
WHERE `users`.`user_email` LIKE '%gmail%' AND `users`.`user_name` LIKE 'm%'
--Lấy ra danh sách người dùng trong đó email người dùng là Gmail , 
--tên người dùng có chữ i và tên người dùng có chiều dài lớn hơn 5
SELECT * 
FROM `users` 
WHERE `users`.`user_email` LIKE '%gmail%' AND `users`.`user_name` LIKE '%i%' AND LENGTH(`users`.`user_name`) >5
--Lấy ra danh sách người dùng trong đó tên người dùng có chữ a,
-- chiều dài từ 5 đến 9, email dùng dịch vụ Gmail, trong tên email có chữ I
SELECT * FROM `users` 
WHERE `users`.`user_name` LIKE '%a%' AND `users`.`user_email` LIKE '%i%@gmail.com' AND LENGTH(`users`.`user_name`) BETWEEN 5 AND 9 
--Lấy ra danh sách người dùng trong đó tên người dùng có chữ a, chiều dài từ 5
--đến 9 hoặc tên người dùng có chữ i, chiều dài nhỏ hơn 9 hoặc email dùng dịch vụ
--Gmail, trong tên email có chữ i
SELECT * FROM `users` 
WHERE `users`.`user_name` LIKE '%a%' AND LENGTH(`users`.`user_name`) BETWEEN 5 AND 9 
OR 
`users`.`user_name` LIKE '%i%' AND LENGTH(`users`.`user_name`) <9 
OR 
`users`.`user_email` LIKE '%i%@gmail.com'
