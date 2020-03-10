/*Вывести пользователей, которые уже съездили в языковой курс,
 вывести предложение для дальнейших поездок, основанное на стране и языке первой поздки*/

SELECT 
	u.id,
	u.firstname,
	email,
	s.id as 'Школа',
	course_id,
	`language`,
	s.country
FROM users u
JOIN users_courses uc ON u.id = uc.user_id 
JOIN school_courses sc ON sc.id = uc.course_id 
JOIN schools s ON s.id = sc.school_id 
WHERE course_end < now();



DROP PROCEDURE IF EXISTS lang_course_offers;

DELIMITER //
CREATE PROCEDURE Lang_course_offers(IN for_scool_id BIGINT)
BEGIN
	-- предложения из той же страны
	SELECT s2.name
	FROM schools s1
	JOIN schools s2 on s2.country = s1.country
	WHERE s1.id = for_scool_id
		AND s2.id <> for_scool_id
UNION
	 -- предложения по языку
	SELECT s2.name
	FROM schools s1
	JOIN schools s2 ON s2.`language` = s1.`language` 
	WHERE s1.id = for_scool_id
		AND s2.id <> for_scool_id
	ORDER BY rand()
	-- limit 5
	;
END//
DELIMITER ;

CALL lang_course_offers(30)


-- ------------------------------------------

/*Предложение добавить в "друзья" пользователей с одного Online-курса */

DROP PROCEDURE IF EXISTS users_edu;

DELIMITER //
CREATE PROCEDURE users_edu(IN for_user_id BIGINT)
BEGIN
	SELECT ue2.user_id 
	FROM users_edu ue1 
	JOIN users_edu ue2 ON ue2.online_edu_id = ue1.online_edu_id 
	WHERE ue1.user_id = for_user_id  
		AND ue2.user_id <> for_user_id;

END//
DELIMITER ;

CALL users_edu(47);

-- --------------------------------------------------------- 
/*Добавление нового полльзователя */

DROP PROCEDURE IF EXISTS sp_add_user();

CREATE DEFINER=`root`@`localhost` PROCEDURE `project`.`sp_add_user`(
	firstname varchar(100), lastname varchar(100), email varchar(100), password_hash varchar(100), phone varchar(12),
	gender CHAR(1), nationality varchar(100), passport VARCHAR(20),
	OUT tran_result varchar(200))
BEGIN
	DECLARE `_rollback` BOOL DEFAULT 0;
	DECLARE code varchar(100);
	DECLARE error_string varchar(100);


	DECLARE CONTINUE handler FOR SQLEXCEPTION
	BEGIN
		SET `_rollback` = 1;
	
		GET stacked DIAGNOSTICS CONDITION 1
			code = RETURNED_SQLSTATE, error_string = MESSAGE_TEXT; 
		SET tran_result := CONCAT('Error occured. Code: ', code, '. Text: ', error_string);
	END;
	
	START TRANSACTION;
		INSERT INTO users(firstname, lastname, email, password_hash, phone)
		VALUES (firstname, lastname, email, password_hash, phone);
		
		SELECT @last_user_id := last_insert_id(); 
	
		INSERT INTO profiles (user_id, gender, nationality, passport, created_at)
		VALUES (last_insert_id(), gender, nationality, passport, created_at);
	
	IF `_rollback` THEN
		ROLLBACK;
	ELSE
		SET tran_result = 'ok';
		COMMIT;
	END IF;


CALL project.sp_add_user('New', 'User', 'newUser@example.com', 'c26e4153c35c87e5e7ae57938637f74561858536', '+7983466883',
	 'M','','', @tran_result);

SELECT @tran_result;

-- ---------------------------- 

/*Добавление поездки с неправльной датой*/

DELIMITER //

CREATE TRIGGER check_date_before_update
BEFORE UPDATE 
ON users_courses FOR EACH ROW
BEGIN
	IF NEW.course_start < current_date() THEN 
		SIGNAL SQLSTATE '45000' set MESSAGE_TEXT = 'Update Canceled. Start date cannot be in the past';
	END IF;
END

DELIMITER ;

UPDATE users_courses 
SET course_start = '2020-03-05'
WHERE user_id = 1;


-- -------------------
/*Добавление Online-курса с неправильной датой*/
DELIMITER //

CREATE TRIGGER check_date_before_insert
BEFORE INSERT 
ON online_edu FOR EACH ROW
BEGIN
	IF NEW.start_date < CURRENT_DATE() THEN 
		SET NEW.start_date = NULL;
	END IF;
END

DELIMITER ;


INSERT INTO online_edu
(id, name, teacher_id, online_edu_type_id, start_date, price, is_active)
VALUES(40,'ВУЗы США','6','2','2020-03-05', 99.00, 1);






