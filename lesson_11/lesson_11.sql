/*Создайте таблицу logs типа Archive. 
Пусть при каждом создании записи в таблицах users, catalogs и products в таблицу logs помещается 
время и дата создания записи, название таблицы, идентификатор первичного ключа и содержимое поля name.*/

DROP TABLE IF EXISTS logs;
CREATE TABLE logs(
	tablename VARCHAR(200),
	created DATE,
	pr_id BIGINT,
	name VARCHAR (200)
		
)ENGINE=Archive;


insert into logs 
	select 'users' as tablename, created_at, id, name
	from users
	where created_at > now()
		union 
	select 'products' as tablename, created_at, id, name
	from products
	where created_at > now()
		union
	select 'catalogs' as tablename, created_at, id, name
	from catalogs 
	where created_at > now();

-- Практическое задание по теме “NoSQL”

-- Организуйте хранение категорий и товарных позиций учебной базы данных shop в СУБД MongoDB.

use shop
dp.shop.insert({category: 'Процессоры', 
{$set: {product: 
{name: 'Intel Core i3-8100', 'Intel Core i5-7400', 'AMD FX-8320E', 'AMD FX-8320', 
description: 'Процессор для настольных персональных компьютеров, основанных на платформе Intel',
'Процессор для настольных персональных компьютеров, основанных на платформе Intel',
'Процессор для настольных персональных компьютеров, основанных на платформе AMD',
'Процессор для настольных персональных компьютеров, основанных на платформе AMD'
}}})
dp.shop.insert({category: 'Материнские платы', 
{$set: {product: 
{name: 'ASUS ROG MAXIMUS X HERO', 'Gigabyte H310M S2H', 'MSI B250M GAMING PRO', 
description: 'Материнская плата ASUS ROG MAXIMUS X HERO, Z370, Socket 1151-V2, DDR4, ATX',
'Материнская плата Gigabyte H310M S2H, H310, Socket 1151-V2, DDR4, mATX',
'Материнская плата MSI B250M GAMING PRO, B250, Socket 1151, DDR4, mATX',
}}})







