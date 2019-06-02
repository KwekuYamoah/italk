DROP DATABASE IF EXISTS italk;
CREATE DATABASE italk;
USE italk;
CREATE TABLE IF NOT EXISTS user(
	username VARCHAR(50) NOT NULL,
	fname VARCHAR(20) NOT NULL,
	lname VARCHAR(20) NOT NULL,
	mname VARCHAR(20) NULL,
	email VARCHAR(70) NOT NULL,
	password VARCHAR(160) NOT NULL,
	role ENUM("ADMIN","VISITOR","SUPPORT") NOT NULL,
	PRIMARY KEY (username),
	UNIQUE(email),
	INDEX(email),
	INDEX(role),
	INDEX(fname),
	INDEX(lname)
)ENGINE=InnoDB;
CREATE TABLE IF NOT EXISTS post(
	id INT NOT NULL AUTO_INCREMENT,
	sender VARCHAR(50) NOT NULL,
	post TEXT NOT NULL,
	dateAdded TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY(id),
	CONSTRAINT FOREIGN KEY(sender) REFERENCES user(username) ON DELETE CASCADE ON UPDATE CASCADE,
	FULLTEXT(post)
)Engine=InnoDB;
CREATE TABLE IF NOT EXISTS postReply(
	postID INT NOT NULL,
	user VARCHAR(50) NOT NULL,
	reply TEXT NOT NULL,
	dateAdded TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	CONSTRAINT FOREIGN KEY(postID) REFERENCES post(id) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT FOREIGN KEY(user) REFERENCES user(username) ON DELETE CASCADE ON UPDATE CASCADE,
	INDEX(postID),
	INDEX(user),
	FULLTEXT(reply)
)Engine=InnoDB;
CREATE TABLE IF NOT EXISTS chat(
	id INT NOT NULL AUTO_INCREMENT,
	sender VARCHAR(50) NOT NULL,
	receiver VARCHAR(50) NOT NULL,
	message TEXT NOT NULL,
	dateAdded TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY(id) ON DELETE CASCADE ON UPDATE CASCADE,
	INDEX(sender),
	INDEX(receiver),
	FULLTEXT(message)
)Engine=InnoDB;
CREATE TABLE IF NOT EXISTS resource(
	id INT NOT NULL AUTO_INCREMENT,
	name VARCHAR(200) NOT NULL,
	user VARCHAR(50) NOT NULL,
	url VARCHAR(200) NOT NULL,
	PRIMARY KEY (id),
	CONSTRAINT FOREIGN KEY(user) REFERENCES user(username),
	INDEX(url)
)Engine=InnoDB;