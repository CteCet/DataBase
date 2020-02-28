
-- “Транзакции, переменные, представления”

-- Создайте представление, 
-- которое выводит название name товарной позиции из таблицы products 
-- и соответствующее название каталога name из таблицы catalogs.


create or replace view names (product_name, catalog_name) as select products.name, catalogs.name from products 
	join catalogs on products.catalog_id = catalogs.id;
select * from names

-- В базе данных shop и sample присутствуют одни и те же таблицы, учебной базы данных. 
-- Переместите запись id = 1 из таблицы shop.users в таблицу sample.users. 
-- Используйте транзакции.

start transaction;

select 
	@name := name, 
	@birthday_at := birthday_at, 
	@created_at := created_at, 
	@updated_at := updated_at 
from shop.users 
where id = 1;

INSERT INTO sample.users VALUES (@name, @birthday_at, @created_at, @updated_at)

commit;
	
--  “Хранимые процедуры и функции, триггеры

-- Создайте хранимую функцию hello(), которая будет возвращать приветствие, в зависимости от текущего времени суток. 
-- С 6:00 до 12:00 функция должна возвращать фразу "Доброе утро", с 12:00 до 18:00 функция должна возвращать фразу "Добрый день", 
-- с 18:00 до 00:00 — "Добрый вечер", с 00:00 до 6:00 — "Доброй ночи".


DELIMITER //

create function hello()
returns varchar(255) deterministic
BEGIN
	DECLARE hours int;

	-- set hours = date_format(now(), '%H') ;
	set hours = hour(now());
	case
	when hours between 6 and 11 then 
		return 'Доброе утро';
 	when hours between 12 and 17 then 
		return 'Добрый день';
 	when hours between 18 and 23 then 
		return 'Добрый вечер';
 	when hours between 0 and 5 then 
		return 'Доброй ночи';
	end case;
end 

select hello() as welcoming

drop function if exists hello;

-- В таблице products есть два текстовых поля: name с названием товара и description с его описанием. 
-- Допустимо присутствие обоих полей или одно из них. Ситуация, когда оба поля принимают неопределенное значение NULL неприемлема. 
-- Используя триггеры, добейтесь того, чтобы одно из этих полей или оба поля были заполнены. 
-- При попытке присвоить полям NULL-значение необходимо отменить операцию.


DELIMITER //

create trigger product_update before update on products
for each row 
begin
	declare product_name text;
	select name into product_name from products where name = 'Intel Core i3-8100';
	set new.name = coalesce (new.name,old.name, product_name);
end 
	

update products set name is Null where id = 6;

drop trigger if exists product_update;


DELIMITER //

create trigger product_check before update on products
for each row 
begin
	declare product_name_check text;
	select name into product_name from products;
	if product_name = null then
		signal sqlstate '45000' set message_text = 'UPDATE canceled';
	end if;
end 

update products set name = Null where id = 6;
INSERT INTO products VALUES ('8',Null )


drop trigger if exists product_check;
























