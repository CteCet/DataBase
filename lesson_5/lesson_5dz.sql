use lesson_2;

-- 1 Пусть в таблице users поля created_at и updated_at оказались незаполненными. Заполните их текущими датой и временем.
DROP TABLE IF EXISTS `users`;
CREATE TABLE users (
	id SERIAL PRIMARY KEY,
	name VARCHAR(255),
	created_at DATETIME,
	updated_at DATETIME 
);

insert INTO `users`(name)
VALUES ('Геннадий'),
('Наталья'),
('Александр'),
('Сергей'),
('Иван'),
('Мария');

-- 1 option
alter table users change created_at created_at datetime default now();
alter table users change updated_at updated_at datetime default now();

truncate `users`;
insert INTO `users`(name)
VALUES ('Геннадий'),
('Наталья'),
('Александр'),
('Сергей'),
('Иван'),
('Мария');

-- 2 option
update users set created_at =NOW(), updated_at=NOW();


-- 2 Таблица users была неудачно спроектирована. 
-- Записи created_at и updated_at были заданы типом VARCHAR и в них долгое время помещались значения в формате "20.10.2017 8:10". 
-- Необходимо преобразовать поля к типу DATETIME, сохранив введеные ранее значения.

DROP TABLE IF EXISTS `users_2`;
CREATE TABLE users_2 (
	id SERIAL PRIMARY KEY,
	name VARCHAR(255),
	created_at VARCHAR(255),
	updated_at VARCHAR(255)
);

INSERT INTO `users_2`(name, created_at, updated_at)
VALUES ('Геннадий','20.10.2017 8:10','20.10.2017 8:10'),
('Наталья','25.03.1983 15:40','20.10.2017 8:10'),
('Александр','03.03.2001 19:19','20.10.2017 8:10'),
('Сергей','29.03.1997 19:29','20.10.2017 8:10')
;

select STR_TO_DATE(created_at, '%d.%m.%Y %k:%i') from users_2;
select STR_TO_DATE(updated_at, '%d.%m.%Y %k:%i') from users_2;

ALTER TABLE users CHANGE created_at created_at DATETIME;
ALTER TABLE users CHANGE updated_at updated_at DATETIME;

-- 3 В таблице складских запасов storehouses_products в поле value могут встречаться самые разные цифры: 0, если товар закончился и выше нуля, если на складе имеются запасы. 
-- Необходимо отсортировать записи таким образом, чтобы они выводились в порядке увеличения значения value. 
-- Однако, нулевые запасы должны выводиться в конце, после всех записей.


DROP TABLE IF EXISTS storehouses_products;
CREATE TABLE storehouses_products (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255),
  value INT UNSIGNED
);

insert into storehouses_products (name, value)
VALUES('Процессор для настольных персональных компьютеров, основанных на платформе Intel.', '5'),
('Процессор для настольных персональных компьютеров, основанных на платформе Intel.', '4'),
('Процессор для настольных персональных компьютеров, основанных на платформе AMD.', '6'),
('Процессор для настольных персональных компьютеров, основанных на платформе AMD.', '0'),
('Материнская плата ASUS ROG MAXIMUS X HERO, Z370, Socket 1151-V2, DDR4, ATX','1'),
('Материнская плата Gigabyte H310M S2H, H310, Socket 1151-V2, DDR4, mATX','0'),
('Материнская плата MSI B250M GAMING PRO, B250, Socket 1151, DDR4, mATX','2');

select * from storehouses_products order by value;
select * from storehouses_products order by if ( value = '0', 1, 0 ), value;


-- Агрегация данных
-- 1 Подсчитайте средний возраст пользователей в таблице users

DROP TABLE IF EXISTS `users_3`;
CREATE TABLE `users_3`(
  `user_id` SERIAL PRIMARY KEY,
  `gender` CHAR(1),
  `birthday_at` DATE,
  `photo_id` BIGINT UNSIGNED NULL,
  `hometown` VARCHAR(100),
  `created_at` DATETIME DEFAULT now()
);

INSERT INTO `users_3` 
VALUES ('1','P','2007-07-04','1','Ziemefort','1971-08-30 05:56:37'),
('2','D','1987-05-07','2','Lake Hailieview','1978-01-16 01:21:45'),
('3','M','1998-11-16','3','North Deborah','1982-12-10 23:18:12'),
('4','D','1980-04-02','4','Lake Elian','1978-07-16 21:29:09'),
('5','D','2012-10-06','5','Lake Yasminetown','1998-03-08 23:26:33'),
('6','M','2003-02-05','6','South Estelleview','2017-08-29 15:43:50'),
('7','P','2010-01-30','7','Hannastad','2010-08-11 16:27:14'),
('8','D','2004-05-19','8','Judyhaven','2014-02-04 01:15:59'),
('9','M','1998-06-16','9','Port Kaseyshire','2004-05-20 18:57:43'),
('10','M','1979-04-18','10','Bartonfurt','1983-04-20 06:15:11'); 
;

select AVG(to_days(now()) - to_days(birthday_at))/ 365.25 as age from users_3;

-- 2 Подсчитайте количество дней рождения, которые приходятся на каждый из дней недели. 
-- Следует учесть, что необходимы дни недели текущего года, а не года рождения.

SELECT date_format(date(concat_ws('-', year(now()), month(birthday_at), day(birthday_at))), '%W') as day,
	count(*) as total from users_3 group by day order by total desc;





