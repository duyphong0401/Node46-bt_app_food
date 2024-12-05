CREATE TABLE users (
	user_id INT PRIMARY KEY AUTO_INCREMENT,
	full_name VARCHAR(255),
	email VARCHAR(255),
	PASSWORD VARCHAR(255)
)
CREATE TABLE restaurant(
	res_id INT PRIMARY KEY AUTO_INCREMENT,
	res_name VARCHAR(255),
	image VARCHAR(255),
	descrip VARCHAR(255)
)

CREATE TABLE rate_res(
	rate_id INT PRIMARY KEY AUTO_INCREMENT,
	user_id INT,
	res_id INT,
	amount INT,
	date_rate DATETIME,
	FOREIGN KEY (user_id) REFERENCES users(user_id),
	FOREIGN KEY (res_id) REFERENCES restaurant(res_id)
)

CREATE TABLE like_res(
	like_id INT PRIMARY KEY AUTO_INCREMENT,
	user_id INT,
	res_id INT,
	date_like DATETIME,
	FOREIGN KEY (user_id) REFERENCES users(user_id),
	FOREIGN KEY (res_id) REFERENCES restaurant(res_id)
)


CREATE TABLE food_type(
	type_id INT PRIMARY KEY AUTO_INCREMENT,
	type_name VARCHAR(255)
)


CREATE TABLE food(
	food_id INT PRIMARY KEY AUTO_INCREMENT,
	food_name VARCHAR(255),
	image VARCHAR(255),
	price FLOAT,
	descrip VARCHAR(255),
	type_id INT,
	FOREIGN KEY (type_id) REFERENCES food_type(type_id)
)
CREATE TABLE orders(
	order_id INT PRIMARY KEY AUTO_INCREMENT,
	user_id INT,
	food_id INT,
	amount INT,
	code VARCHAR(255),
	arr_sub_id VARCHAR(255),
	FOREIGN KEY (user_id) REFERENCES users(user_id),
	FOREIGN KEY (food_id) REFERENCES food(food_id)
)
CREATE TABLE sub_food(
	sub_id INT PRIMARY KEY AUTO_INCREMENT,
	sub_name VARCHAR(255),
	sub_price FLOAT,
	food_id INT,
	FOREIGN KEY (food_id) REFERENCES food(food_id)
)
INSERT INTO like_res(like_id, user_id, res_id, date_like) VALUE
					(1, 1, 1, '2024-12-05 14:30:00'),
					(2, 2, 2, '2024-12-05 15:30:00'),
					(3, 3, 3, '2024-12-05 16:30:00'),
					(4, 4, 4, '2024-12-05 17:30:00')
					
SELECT res_id FROM restaurant

INSERT INTO rate_res(rate_id, user_id, res_id, amount, date_rate) VALUE
					(1, 2, 1, 10, '2024-12-05 6:30:00'),
					(2, 1, 2, 20, '2024-12-05 7:30:00'),
					(3, 3, 4, 7, '2024-12-05 8:30:00'),
					(4, 4, 4, 9, '2024-12-05 9:30:00')
INSERT INTO orders(order_id, user_id, food_id, amount, code, arr_sub_id) VALUE
				  (1, 1, 1, 5, 'co','ec'),
				  (2, 4, 2, 6, 'co','ec'),
				  (3, 3, 4, 7, 'co','ec'),
				  (4, 2, 3, 8, 'co','ec')
				  
-- Tìm 5 người đã like nhiêu nhất
SELECT COUNT(like_res.user_id) AS `Số lượt like`, users.user_id, users.full_name, users.PASSWORD
FROM like_res
INNER JOIN users ON like_res.user_id = users.user_id
GROUP BY users.user_id
ORDER BY `Số lượt like` DESC
LIMIT 5


-- Tìm 2 nhà hàng có lượt like nhiều nhất
SELECT restaurant.res_name, COUNT(like_res.res_id) AS `Số lượt like`
FROM like_res
INNER JOIN restaurant ON like_res.res_id = restaurant.res_id
GROUP BY restaurant.res_id
ORDER BY `Số lượt like` DESC
LIMIT 2;

-- Tìm người đã đặt hàng nhiều nhất.
SELECT users.user_id, users.full_name, COUNT(orders.order_id) AS `Số lượng đặt hàng`
FROM orders
INNER JOIN users ON orders.user_id = users.user_id
GROUP BY users.user_id
ORDER BY `Số lượng đặt hàng` DESC
LIMIT 1;

-- Tìm người dùng không hoạt động trong hệ thống 
SELECT users.user_id, users.full_name AS 'Những người chưa mua hàng'
FROM orders
RIGHT JOIN users ON orders.user_id = users.user_id
WHERE orders.user_id IS NULL

					