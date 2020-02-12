DROP DATABASE IF EXISTS vk;
CREATE DATABASE vk;
USE vk;


DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  id SERIAL PRIMARY KEY,
  `firstname` VARCHAR(100), 
  `lastname` VARCHAR(100), 
  `email` VARCHAR(100) UNIQUE,
  `phone` VARCHAR(12),
  
  INDEX users_phone_idx(phone),
  INDEX (firstname, lastname)
);

INSERT INTO `users` VALUES ('1','Ryleigh','Ledner','zcruickshank@example.org','234-519-3924'),
('2','Lura','Rempel','abbie69@example.com','948.806.5646'),
('3','Citlalli','Littel','chaz.marvin@example.org','1-827-271-44'),
('4','Danial','Wuckert','morris.littel@example.com','03429075262'),
('5','Jannie','Monahan','johns.skyla@example.net','220-263-6872'),
('6','Joanie','Padberg','ankunding.peggie@example.com','(356)217-684'),
('7','Sammy','Fahey','theresia59@example.net','1-674-517-38'),
('8','Braulio','Kuphal','gina.mcdermott@example.net','843-603-1017'),
('9','Helmer','Schoen','stephania15@example.com','258-131-4591'),
('10','Leland','Oberbrunner','stanton.jovan@example.net','1-228-667-27'); 


DROP TABLE IF EXISTS `profiles`;
CREATE TABLE `profiles`(
  `user_id` SERIAL PRIMARY KEY,
  `gender` CHAR(1),
  `birthday` DATE,
  `photo_id` BIGINT UNSIGNED NULL,
  `hometown` VARCHAR(100),
  -- is_active BOOLEAN DEFAULT TRUE,
  created_at DATETIME DEFAULT now(),
  
  FOREIGN KEY (user_id) references `users`(id)
  ON UPDATE cascade
  ON DELETE RESTRICT
);

INSERT INTO `profiles` 
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

DROP TABLE IF EXISTS `messages`;
CREATE TABLE `messages` (
  `id` SERIAL PRIMARY KEY,
  `from_user_id` BIGINT UNSIGNED NOT NULL,
  `to_user_id` BIGINT UNSIGNED NOT NULL,
  `body` text,
  `created_at` DATETIME DEFAULT now(),
  
  index (from_user_id),
  index (to_user_id),
  FOREIGN KEY (from_user_id) references `users`(id),
  FOREIGN KEY (to_user_id) references `users`(id)
);

truncate messages;
INSERT INTO `messages` 
VALUES ('1','1','3','Sunt neque id iure sapiente iusto earum pariatur. Officiis beatae illo similique sunt ex autem voluptatem. Sit et et natus inventore dicta consequatur autem.','1977-02-05 09:11:59'),
('2','2','1','Nihil iusto repellendus vero dicta dolorem id non. Ipsam enim esse asperiores beatae minus sunt. Natus impedit nihil aliquid voluptatem.','2002-03-07 02:53:18'),
('3','3','3','Tempora id id voluptatum pariatur cum quas consectetur. Rem quo iusto dolorem quo alias possimus. Eos laboriosam dignissimos quasi eum. Illum et deleniti deleniti aliquam.','1979-01-28 13:40:26'),
('4','4','5','Laudantium vel dolorum incidunt iure repudiandae. Qui explicabo nisi omnis. Deserunt fugiat voluptate enim et reiciendis veniam porro. Facere et et ex eum tenetur.','2014-11-11 23:42:58'),
('5','5','3','Ut ad assumenda eius. Harum est quia omnis. Minima blanditiis dolores expedita quibusdam odio excepturi ea consectetur.','1991-05-18 11:36:28'),
('6','6','7','Eaque iure et omnis possimus ipsam qui qui. Ducimus voluptates est officia facilis quia nostrum. Sit ut quam id ea.','2001-09-26 20:55:13'),
('7','7','6','Laboriosam hic ullam sed sunt quos architecto. Eum labore tempore doloribus et et incidunt aliquid et. Quo eos consequatur tempora tenetur.','2012-03-28 02:18:47'),
('8','8','1','Laudantium enim aut excepturi numquam. Sunt quisquam culpa aut pariatur aperiam animi laboriosam. Magni animi rerum saepe consequatur deserunt. Amet ipsum vel quam quas est.','1975-01-31 14:10:51'),
('9','9','2','Quia voluptate ab et ullam eveniet. Deserunt suscipit eveniet doloribus vel aperiam quos. Dolor est eius nostrum velit.','2016-03-22 01:24:28'),
('10','10','9','Quod ullam fugiat delectus optio dignissimos. Veniam minima maxime enim suscipit et. Reiciendis saepe excepturi corrupti pariatur sint omnis.','2019-05-19 22:51:04'),
('11','1','3','Sunt neque id iure sapiente iusto earum pariatur. Officiis beatae illo similique sunt ex autem voluptatem. Sit et et natus inventore dicta consequatur autem.','2020-03-05 09:11:59'); 


DROP TABLE IF EXISTS `friend_requests`;
CREATE TABLE `friend_requests` (
  `initiator_user_id` BIGINT UNSIGNED NOT NULL,
  `target_user_id` BIGINT UNSIGNED NOT NULL,
  `status` ENUM('requested','approved','unfriended','declined'),
  `requested_at` datetime DEFAULT now(),
  `update_at` datetime on update CURRENT_TIMESTAMP,
  
  PRIMARY KEY (`initiator_user_id`,`target_user_id`),
  index (`initiator_user_id`),
  index (`target_user_id`),
  FOREIGN KEY (`initiator_user_id`) references `users`(id),
  FOREIGN KEY (target_user_id) references `users`(id)
);

INSERT INTO `friend_requests` (initiator_user_id, target_user_id, status)
VALUES ('1','2','requested'),
('2','3','requested'),
('3','5','requested'),
('4','3','requested'),
('5','6','requested'),
('6','3','requested'),
('7','8','requested'),
('8','9','requested'),
('9','7','requested'),
('10','1','requested'); 


DROP TABLE IF EXISTS `communities`;
CREATE TABLE `communities`(
  `id`SERIAL primary KEY,
  `name` varchar(200),
  `admin_user_id` BIGINT unsigned not null,
  
  index (`admin_user_id`),
  FOREIGN KEY (`admin_user_id`) references `users`(id)
);

INSERT INTO `communities` 
VALUES ('1','et','1'),
('2','tempore','2'),
('3','ratione','3'),
('4','sit','4'),
('5','ad','5'),
('6','molestias','6'),
('7','quod','7'),
('8','ut','8'),
('9','suscipit','9'),
('10','in','10'); 


DROP TABLE IF EXISTS `users_communities`;
CREATE TABLE `users_communities` (
  `user_id` BIGINT UNSIGNED NOT NULL,
  `community_id` BIGINT UNSIGNED NOT NULL,
  
  PRIMARY KEY (`user_id`,`community_id`),
  FOREIGN KEY (`user_id`) references `users`(id),
  FOREIGN KEY (`community_id`) references `communities`(id)
);  

INSERT INTO `users_communities` 
VALUES ('1','10'),
('2','2'),
('3','2'),
('4','7'),
('5','1'),
('6','4'),
('7','3'),
('8','2'),
('9','2'),
('10','1'); 


DROP TABLE IF EXISTS `media_types`;
CREATE TABLE `media_types` (
  `id` SERIAL primary KEY,
  `name` varchar(200)
);

INSERT INTO `media_types` 
VALUES ('1','sapiente'),
('2','nostrum'),
('3','alias'),
('4','dolore'),
('5','omnis'),
('6','magni'),
('7','et'),
('8','asperiores'),
('9','atque'),
('10','odio'),
('11','itaque'),
('12','delectus'),
('13','quia'),
('14','fugit'); 
  
DROP TABLE IF EXISTS `media`;
CREATE TABLE `media`(
  `id` SERIAL primary KEY,
  `media_type_id` BIGINT UNSIGNED NOT NULL,
  `user_id` BIGINT UNSIGNED NOT NULL,
  `body` text,
  `filename` varchar(255),
  `size` int,
  `metadata` JSON,
  `created_at` datetime DEFAULT now(),
  
  index (user_id),
  FOREIGN KEY (`user_id`) references `users`(id),
  FOREIGN KEY (`media_type_id` ) references `media_types`(id)
);  

INSERT INTO `media` 
VALUES ('1','1','1','Molestias quas a at et voluptatum ullam. Et velit explicabo perferendis eos nesciunt dicta nihil molestias. Voluptatem at sint praesentium et consectetur deleniti vitae totam. Et omnis expedita ducimus vel.','nisi','3506',NULL,'1978-11-08 15:24:47'),
('2','2','2','Repudiandae alias eos aperiam sequi beatae dolor. Pariatur fugiat facere harum illum. A blanditiis veritatis molestiae voluptas qui ex.','repudiandae','6994494',NULL,'2009-02-06 17:00:21'),
('3','3','3','Nostrum voluptatem molestiae sint aut voluptatum sed sunt. Aut similique illo aperiam consectetur. Alias et dignissimos ut sed qui nihil. Rerum expedita officia nihil sequi eos consequatur maiores architecto.','et','27033',NULL,'1985-07-25 17:50:13'),
('4','4','4','Debitis commodi veniam dignissimos sunt at sed veritatis. Rerum delectus fugit ut corporis distinctio.','ut','48669017',NULL,'2006-09-06 08:28:51'),
('5','5','5','Vero veritatis consequatur magnam praesentium autem. Qui incidunt aut eaque. Ipsa perferendis mollitia expedita illo ipsam.','porro','36',NULL,'2019-07-25 07:29:20'),
('6','6','6','Nobis ab id et minima nostrum ipsa maxime. Ratione similique quia debitis magnam. Temporibus veniam perspiciatis consequuntur ut sapiente voluptatibus. Unde et nam corporis voluptas culpa quibusdam. Itaque eos commodi sed et nihil quis.','repudiandae','946806666',NULL,'2014-01-17 22:28:13'),
('7','7','7','Delectus repudiandae alias repellendus reprehenderit minima autem. Voluptatem quae nobis consequatur et. Nisi vel nihil et. Repellendus beatae id doloremque vel enim.','ab','2885316',NULL,'2018-05-09 09:09:43'),
('8','8','8','Architecto sint aut ut quisquam. Ipsam occaecati libero omnis. Sapiente omnis quos sed natus quia.','animi','916495',NULL,'1979-07-22 02:32:43'),
('9','9','9','Dolor ullam ipsum labore porro tempora harum. Vitae quis qui et natus quaerat est illum. Unde aliquam aut aperiam voluptas atque enim inventore. Sunt et molestiae rerum iure maxime minus a.','quia','46783',NULL,'2014-03-14 14:00:47'),
('10','10','10','Dolor nobis dolorem eaque nam veritatis. Quo et ut ipsam voluptates voluptatibus. Sed impedit alias et ad porro.','atque','71346',NULL,'1988-05-03 10:29:30');


DROP TABLE IF EXISTS `likes`;
CREATE TABLE `likes`(
  `id` SERIAL primary KEY,
  `user_id` BIGINT UNSIGNED NOT NULL,
  `media_id` BIGINT UNSIGNED NOT NULL,
  `created_at` datetime default now(),
  FOREIGN KEY (`user_id`) references `users`(id),
  FOREIGN KEY (`media_id` ) references `media`(id)
); 

INSERT INTO `likes` 
VALUES ('1','2','4','2019-06-02 03:53:27'),
('2','3','4','1973-03-28 04:48:43'),
('3','1','3','1997-02-22 20:04:11'),
('4','2','9','1992-05-03 04:37:16'),
('5','1','4','2013-10-07 04:50:20'),
('6','5','4','1988-10-27 08:24:58'),
('7','9','1','1979-08-29 10:52:49'),
('8','5','1','2004-04-16 09:26:44'),
('9','2','7','1998-06-29 20:34:42'),
('10','2','1','2012-08-08 14:59:11'); 


DROP TABLE IF EXISTS `photo_albums`;
CREATE TABLE `photo_albums` (
  `id` SERIAL primary KEY,
  `name` VARCHAR(200),
  `user_id` BIGINT UNSIGNED DEFAULT NULL,
   FOREIGN KEY (`user_id` ) references `users`(id)
); 


INSERT INTO `photo_albums` 
VALUES ('1','maiores','2'),
('2','et','4'),
('3','et','3'),
('4','eum','7'),
('5','expedita','6'),
('6','vitae','5'),
('7','sunt','8'),
('8','doloribus','10'),
('9','et','7'),
('10','cupiditate','9');

DROP TABLE IF EXISTS `photos`;
CREATE TABLE `photos`(
  `id` SERIAL primary KEY,
  `album_id` BIGINT UNSIGNED NULL,
  `media_id` BIGINT UNSIGNED NOT NULL,
  
  FOREIGN KEY (`album_id`) references `photo_albums`(id),
  FOREIGN KEY (`media_id` ) references `media`(id)
); 

INSERT INTO `photos` 
VALUES ('1','1','1'),
('2','2','2'),
('3','3','3'),
('4','4','4'),
('5','5','5'),
('6','6','6'),
('7','7','7'),
('8','8','8'),
('9','9','9'),
('10','10','10'); 


DROP TABLE IF EXISTS status;
CREATE TABLE status(
	id SERIAL PRIMARY KEY,
	user_id BIGINT UNSIGNED NOT NULL,
	body TEXT,
	created_at DATETIME DEFAULT NOW(),
	
	FOREIGN KEY (user_id) REFERENCES users(id)
);

INSERT INTO `status` 
VALUES ('1','1','Ullam pariatur similique cupiditate cumque. Atque ipsum est cum qui. Et et sed sed eius quis alias. Eligendi earum explicabo sit ullam rerum voluptates.','1978-05-28 08:45:41'),
('2','2','Ea voluptatum dolore magni est sunt rem sit ipsa. Impedit velit placeat neque cupiditate repellendus quam est.','2016-12-16 00:22:21'),
('3','3','Culpa dolor odio facilis quod consequuntur quia eius. Quae consequatur repellendus nobis vel dicta voluptatem. Est et minima pariatur. Iusto repellat harum adipisci.','2015-10-15 05:16:05'),
('4','4','Error provident enim tempora libero sed dicta ut. Earum atque itaque quae occaecati neque omnis.','1989-10-01 04:32:00'),
('5','5','Cum possimus natus aut sed. Accusamus in doloremque quas dolorem velit rem. Vitae quia velit vel reprehenderit sed quia. Fugit voluptatibus sit cum possimus nihil.','1984-09-03 16:12:23'),
('6','6','Et doloremque omnis commodi quod doloremque. Accusantium sed repellat cupiditate non totam commodi eum. Quos provident ipsa quod quia dolorem dolor a. Modi in aliquid non incidunt molestias earum dolores.','2000-12-29 09:50:58'),
('7','7','Maxime accusamus eligendi autem dolorum debitis. Et laudantium facere cumque iusto possimus. Praesentium quia voluptas ab saepe. Vel odit natus nisi quo.','2012-12-19 07:40:53'),
('8','8','Earum incidunt voluptatem voluptatem nihil commodi rerum est. Voluptas numquam dolores doloremque et velit et. Molestiae ut eveniet omnis in minus eum voluptatem. Iusto architecto aut provident facilis eos enim doloribus.','1979-09-30 14:40:23'),
('9','9','Nihil quisquam dolorem et id. Eveniet architecto et et. Natus asperiores ut vero voluptatibus error. Assumenda quae natus inventore ut ad odio et natus.','2002-03-14 19:40:47'),
('10','10','Reprehenderit occaecati quis cupiditate quisquam ipsum libero cupiditate quam. Ut pariatur et eaque dolores autem voluptas. Unde minima dolorem doloribus ut omnis laborum et.','1988-01-09 23:46:23'); 


DROP TABLE IF EXISTS comments;
CREATE TABLE comments(
	id SERIAL PRIMARY KEY,
	user_id BIGINT UNSIGNED NOT NULL,
	media_id BIGINT UNSIGNED NOT NULL,
	body TEXT,
	created_at DATETIME DEFAULT NOW(),
	
	FOREIGN KEY (user_id) REFERENCES users(id),
	FOREIGN KEY (media_id) REFERENCES media(id)
);

INSERT INTO `comments` 
VALUES ('1','1','1','Et dicta dignissimos ut facere. Voluptas aut unde omnis voluptatem. Consectetur atque culpa asperiores consectetur. Et alias alias iste qui velit ad dolorum.','1990-10-24 01:18:19'),
('2','2','2','Adipisci itaque beatae blanditiis veritatis fuga tempore asperiores. Voluptatem ut quisquam et fugit perspiciatis suscipit nisi totam. Minima at velit quia aut totam.','1985-10-18 07:29:51'),
('3','3','3','Veritatis sit sint temporibus soluta harum. Omnis enim dolores consequuntur debitis maiores. Hic enim ea qui. Aut molestiae ut non magnam. Iste aliquid placeat doloremque exercitationem atque.','1978-06-07 22:16:51'),
('4','4','4','Veniam qui ullam quod rerum earum atque corporis vel. Quia quibusdam distinctio distinctio voluptas saepe. Quas qui magni inventore delectus sint laudantium.','1988-09-18 04:46:09'),
('5','5','5','Esse quae doloribus ut necessitatibus exercitationem nemo et. Et rerum molestias inventore dolorum ipsam delectus fuga placeat. Perspiciatis qui recusandae voluptatem dolores. Magnam quo aspernatur adipisci ex expedita amet velit.','2002-07-27 19:10:16'),
('6','6','6','Iure tempora accusantium ab iusto. Eos recusandae praesentium deleniti voluptas est et. Quibusdam et dolorem illo reprehenderit inventore quos saepe. Laboriosam nulla perspiciatis quam laborum omnis omnis sint.','1982-11-24 13:12:35'),
('7','7','7','Molestias itaque aut quia repellat consectetur. Sunt dolores ad aut eaque ipsum. Tempore recusandae totam non qui rerum.','1979-06-07 18:35:08'),
('8','8','8','Est sit dolorum accusamus aut et temporibus unde. Aperiam dicta velit occaecati quam cumque. Repellat autem quidem et ullam.','2011-04-14 10:12:55'),
('9','9','9','Vero sunt sit excepturi. Qui nemo unde error placeat.','1996-11-13 19:27:58'),
('10','10','10','Ullam aliquid id quos occaecati dolorum. Doloribus voluptatibus asperiores dignissimos repellendus reiciendis assumenda ut. Praesentium ipsum vitae maxime nesciunt enim et non.','1982-11-08 02:16:36'); 



DROP TABLE IF EXISTS bookmarks;
CREATE TABLE bookmarks(
	user_id BIGINT UNSIGNED NOT NULL,
	community_id BIGINT UNSIGNED NOT NULL,
	media_id BIGINT UNSIGNED NOT NULL,
	
	PRIMARY KEY (user_id, community_id),
	
	INDEX community_news(user_id, community_id),
	FOREIGN KEY (user_id) REFERENCES users(id),
	FOREIGN KEY (community_id) REFERENCES communities(id),
	FOREIGN KEY (media_id) REFERENCES media(id),
	
	created_at DATETIME DEFAULT NOW(),
	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

INSERT INTO `bookmarks` 
VALUES ('1','1','1','2016-11-05 18:13:25','1983-03-25 15:40:13'),
('2','2','2','1988-08-22 04:23:32','2001-02-03 19:19:51'),
('3','3','3','2006-03-16 18:54:57','1997-03-29 19:29:04'),
('4','4','4','2005-05-05 10:07:04','1978-03-13 19:22:07'),
('5','5','5','2000-12-07 01:58:17','1983-06-12 05:18:18'),
('6','6','6','1973-03-14 23:11:40','2012-05-10 16:31:38'),
('7','7','7','1983-11-21 11:10:26','1983-10-22 15:06:04'),
('8','8','8','1974-04-13 17:12:12','2013-03-11 15:09:29'),
('9','9','9','2010-01-06 07:42:45','1992-10-04 00:48:06'),
('10','10','10','2005-11-16 18:03:03','2012-10-06 00:21:55'); 


-- 2
SELECT distinct firstname
FROM users;

-- 3
alter table profiles add column is_active BOOLEAN DEFAULT true after birthday;

truncate profiles;
INSERT INTO `profiles`
VALUES ('1','P','2007-07-04','1','1','Ziemefort','1971-08-30 05:56:37'),
('2','D','1987-05-07','1','2','Lake Hailieview','1978-01-16 01:21:45'),
('3','M','1998-11-16','1','3','North Deborah','1982-12-10 23:18:12'),
('4','D','1980-04-02','1','4','Lake Elian','1978-07-16 21:29:09'),
('5','D','2012-10-06','1','5','Lake Yasminetown','1998-03-08 23:26:33'),
('6','M','2003-02-05','1','6','South Estelleview','2017-08-29 15:43:50'),
('7','P','2010-01-30','1','7','Hannastad','2010-08-11 16:27:14'),
('8','D','2004-05-19','1','8','Judyhaven','2014-02-04 01:15:59'),
('9','M','1998-06-16','1','9','Port Kaseyshire','2004-05-20 18:57:43'),
('10','M','1979-04-18','1','10','Bartonfurt','1983-04-20 06:15:11'); 

select distinct user_id, birthday
from profiles 
where birthday>'2002-10-06';

update profiles 
set
	is_active ='2'
where 
	birthday>'2002-10-06'
	and is_active = 1;

-- 4
delete from messages
where `created_at` > '2019-02-19 00:00:00'







