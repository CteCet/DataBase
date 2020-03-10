
/*Сколько пользоватлей повторно взяли Online-курс*/


CREATE OR REPLACE VIEW v_users
AS SELECT
		count(*) as cnt,
		uedu.user_id,
		u.email
	FROM users_edu uedu
	JOIN users u ON uedu.user_id = u.id 
	GROUP BY user_id
	ORDER BY cnt DESC
	;
	
SELECT count(*) cnt
FROM v_users 
WHERE cnt = 2


-- --------------------
/*Сколько языковых и Online-курсов взял пользователь*/

CREATE OR REPLACE VIEW v_cources
AS SELECT 
	user_id,
	email
FROM users_courses uc
JOIN users u ON Uc.user_id = u.id 

UNION ALL

SELECT 
	uedu.user_id,
	u.email
FROM users_edu uedu
JOIN users u ON uedu.user_id = u.id 
;


SELECT count(*) cnt,
	user_id,
    email 
FROM v_cources
GROUP BY user_id
ORDER BY cnt DESC
;

































