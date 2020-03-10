DROP DATABASE IF EXISTS project;
CREATE DATABASE project;
USE project;

DROP TABLE IF EXISTS users;
CREATE TABLE users(
	id SERIAL PRIMARY KEY,
	firstname VARCHAR(100),
	lastname VARCHAR(100),
	email VARCHAR(100) UNIQUE,
	password_hash VARCHAR(100),
	phone VARCHAR(12),
	
	INDEX (firstname,lastname),
	INDEX (phone)
);


DROP TABLE IF EXISTS profiles;
CREATE TABLE profiles(
	user_id SERIAL PRIMARY KEY,
	gender CHAR(1),
	nationality VARCHAR(100),
	passport VARCHAR(20),
	created_at DATETIME DEFAULT now(),
	
	FOREIGN KEY (user_id) REFERENCES users(id)
	ON UPDATE cascade
	ON DELETE RESTRICT 
);


DROP TABLE IF EXISTS schools;
CREATE TABLE schools(
	id seriAL PRIMARY KEY,
	name VARCHAR(200),
	photo_id BIGINT UNIQUE, 
	country VARCHAR(200),
	city VARCHAR(200),
	`language` VARCHAR(200),
	
	INDEX (`language`),
	INDEX (country)
);


DROP TABLE IF EXISTS school_courses;
CREATE TABLE school_courses(
	id SERIAL PRIMARY KEY,
	school_id BIGINT unsigned not null,
	name VARCHAR(200),
	price DECIMAL (11,2),
	
	FOREIGN KEY (school_id) REFERENCES schools(id)
);


DROP TABLE IF EXISTS accomodation;
CREATE TABLE accomodation(
	id serial PRIMARY KEY,
	school_id BIGINT UNSIGNED NOT NULL,
	ac_type VARCHAR(200),
	ac_name VARCHAR(200),
	food VARCHAR(200),
	ac_price DECIMAL (11,2),
	
	INDEX (school_id, ac_type),
	FOREIGN KEY (school_id) REFERENCES schools(id)
);

DROP TABLE IF EXISTS users_courses; 
CREATE TABLE users_courses(
	id serial PRIMARY KEY,
	user_id BIGINT UNSIGNED NOT NULL,
	course_start VARCHAR(200),
	course_end VARCHAR(200),
	course_id BIGINT UNSIGNED NOT NULL,
	accomodation_id BIGINT UNSIGNED NOT NULL,
	
	FOREIGN KEY (user_id) REFERENCES users(id),
	FOREIGN KEY (course_id) REFERENCES school_courses(id),
	FOREIGN KEY (accomodation_id) REFERENCES accomodation(id)

);

DROP TABLE IF EXISTS course_requests; 
CREATE TABLE course_requests(
	user_course_id BIGINT UNSIGNED NOT NULL,
	user_id BIGINT UNSIGNED NOT NULL,
	`status` enum ('booked','canceled','paid'),
	
	FOREIGN KEY (user_id) REFERENCES users(id),
	FOREIGN KEY (user_course_id) REFERENCES users_courses(id)
);

DROP TABLE IF EXISTS teachers; 
CREATE TABLE teachers(
	id serial PRIMARY KEY,
	firstname VARCHAR (200),
	lastname VARCHAR (200),
	email VARCHAR(100) UNIQUE,
	photo_id BIGINT UNSIGNED NOT NULL,
	description TEXT,
	
	INDEX (firstname, lastname)
);


DROP TABLE IF EXISTS online_edu_types;
CREATE TABLE online_edu_types(
	id serial PRIMARY KEY,
	name VARCHAR(200)
);

DROP TABLE IF EXISTS online_edu;
CREATE TABLE online_edu(
	id serial PRIMARY KEY,
	name VARCHAR(200),
	teacher_id BIGINT UNSIGNED NOT NULL,
	online_edu_type_id BIGINT UNSIGNED NOT NULL,
	start_date DATE,
	price DECIMAL (11,2),
	is_active BOOL DEFAULT TRUE,
	
	INDEX (name),
	FOREIGN KEY (teacher_id) REFERENCES teachers(id),
	FOREIGN KEY (online_edu_type_id) REFERENCES online_edu_types(id)
);

DROP TABLE IF EXISTS users_edu;
CREATE TABLE users_edu(
	user_id BIGINT UNSIGNED NOT NULL,
	online_edu_id bigint UNSIGNED NOT NULL,
	
	FOREIGN KEY (user_id) REFERENCES users(id),
	FOREIGN KEY (online_edu_id) REFERENCES online_edu(id)
);




































