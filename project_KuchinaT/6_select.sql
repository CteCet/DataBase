/* Вывести прошедшие online-курсы, отправить участникам рассылку на email с предложением оставить отзыв о курсе */

update online_edu 
set
	is_active = 2 
where 
	start_date < now() 
	and id is not null;
	
select 
	name,
	id 
from online_edu 
where is_active = 2;


select 
	edu.name,
	concat (t.firstname, ' ', t.lastname),
	edt.name,
	edu.id
from online_edu edu
join teachers t on edu.teacher_id = t.id
join online_edu_types edt on edu.online_edu_type_id = edt.id
where is_active = 2;


select 
	email,
	edu.name 
from users u
join users_edu uedu on uedu.user_id = u.id
join online_edu edu on edu.id = uedu.online_edu_id 
where is_active = 2;


-- -----------------------------------
/* Пользователь хочет поехать на курс IELTS, 
 * сделать выборку из всех стран куда он мог бы поехать,
 * исключить из выборки США и курсы стоимостью выше 500€  */
select 
	count(*),
	country
from school_courses sc
join schools s on sc.school_id = s.id 
where sc.name like '%IELTS%' 
group by country


select 
	sc.id, 
	sc.name,
	s.name as 'name of school',
	price,
	country as 'country'
from school_courses sc
join schools s on sc.school_id = s.id 
where sc.name like '%IELTS%' 
	and country <> 'USA' 
	and price < 500
order by price;

-- -----------

/*Отправить пользователям напоминание о предстоящей поездке */

select 
	uc.id,
	concat (u.firstname, ' ', u.lastname), 
	u.email, 
	u.phone,
	uc.course_start,
	uc.course_end,
	(select name from school_courses where course_id = school_courses.id) as 'Курс',
	(select ac_type from accomodation where accomodation_id = accomodation.id) as 'Жильё'
from users as u 
inner join users_courses as uc ON u.id = uc.user_id
where course_start > now() 
order by course_start;

-- ---------------------------

/* купили повторно */

select
	count(*) as cnt,
	uedu.user_id,
	u.email
from users_edu uedu
join users u on uedu.user_id = u.id 
group by user_id
order by cnt desc
;
















