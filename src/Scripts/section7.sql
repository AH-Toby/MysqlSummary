# 一.库管理
# 1.创建数据库
CREATE DATABASE stuDB CHARSET="UTF8";

# 2.创建数据库，存在则不创建
CREATE DATABASE IF NOT EXISTS stuDB CHARSET="UTF8";

# 3.删除数据库
DROP DATABASE stuDB;

# 4.删除数据库，存在则删除
DROP DATABASE IF EXISTS stuDB;

# 5.查看所有数据库
SHOW DATABASES;

# 6.使用数据库
USE stuDB;

# 7.查看现在使用的数据库
SELECT DATABASE();

# 创建表
# 数据类型
# 1.创建表
CREATE TABLE IF NOT EXISTS myTab(
 c1 TINYINT,
 c2 SMALLINT,
 c3 MEDIUMINT,
 c4 INT,
 c5 BIGINT,
 c6 TINYINT UNSIGNED,
 c7 SMALLINT UNSIGNED,
 c8 MEDIUMINT UNSIGNED,
 c9 INT UNSIGNED,
 c10 BIGINT UNSIGNED
);

# 2.查看表结构
DESC myTab;

# 3.插入数据
INSERT INTO myTab VALUES(200, 200, 200, 200, 200, 200, 200, 200, 200, 200);
# Out of range value for column 'c1' at row 1

# 4.搭配zerofill，重新创建表
DROP TABLE IF EXISTS myTab;

CREATE TABLE IF NOT EXISTS myTab(
 c1 TINYINT ZEROFILL,
 c2 SMALLINT ZEROFILL,
 c3 MEDIUMINT ZEROFILL,
 c4 INT ZEROFILL,
 c5 BIGINT ZEROFILL,
 c6 TINYINT UNSIGNED ZEROFILL,
 c7 SMALLINT UNSIGNED ZEROFILL,
 c8 MEDIUMINT UNSIGNED ZEROFILL,
 c9 INT UNSIGNED ZEROFILL,
 c10 BIGINT UNSIGNED ZEROFILL
);
DESC myTab;

# 5.插入数据
INSERT INTO myTab VALUES(200, 200, 200, 200, 200, 200, 200, 200, 200, 200);
SELECT * 
FROM myTab;

# 字符类型
CREATE TABLE T2 (
	id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
	b1 BINARY(1),
	b2 BINARY(3)
);

# 插入数值
INSERT INTO T2(b1,b2) VALUES("中","中");



# 枚举类型
CREATE TABLE IF NOT EXISTS t3(
gender ENUM("M","F")
);

DESC t3;

# 插入数据
INSERT INTO t3(gender) VALUES("M");
INSERT INTO t3(gender) VALUES("F");
INSERT INTO t3(gender) VALUES("m");
INSERT INTO t3(gender) VALUES("f");
INSERT INTO t3(gender) VALUES("1");
INSERT INTO t3(gender) VALUES("0");
INSERT INTO t3(gender) VALUES("2");
INSERT INTO t3(gender) VALUES("M");
INSERT INTO t3(gender) VALUES("a");
INSERT INTO t3(gender) VALUES(NULL);

SELECT * 
FROM t3; 

# SET类型
CREATE TABLE IF NOT EXISTS T4(
	col SET("r","g","b") NOT NULL
);
DESC T4;

# 插入数据
INSERT INTO T4(col) VALUES("r");
INSERT INTO T4(col) VALUES("r,g");
INSERT INTO T4(col) VALUES("r");
INSERT INTO T4(col) VALUES("R");
INSERT INTO T4(col) VALUES("r,g,b");
INSERT INTO T4(col) VALUES("1");
SELECT *
FROM T4;


# 没有添加约束
CREATE TABLE IF NOT EXISTS stuinfo(
	stuid INT,
	stuname VARCHAR(20),
	stugender CHAR(1),
	email VARCHAR(30),
	borndate DATETIME
);

CREATE TABLE IF NOT EXISTS major(
	id INT PRIMARY KEY AUTO_INCREMENT NOT NULL
);

# 添加约束
CREATE TABLE IF NOT EXISTS stuinfo(
	stuid INT PRIMARY KEY,  # 添加主键约束
	stuname VARCHAR(20) UNIQUE NOT NULL, # 添加唯一约束和非空,
	stugender CHAR(1) DEFAULT "男",  # 添加默认值
	email VARCHAR(30) NOT NULL,  # 添加非空约束 
	age INT CHECK(age BETWEEN 0 AND 100), # 添加了检查约束，mysql不支持
	majorid INT,
	CONSTRAINT fk_stuinfo_major FOREIGN KEY (majorid) REFERENCES major(id)  #添加了外键约束
);
DESC stuinfo;

show tables;
# 修改表名
ALTER TABLE stuinfo RENAME TO students;

# 添加字段
ALTER TABLE students ADD COLUMN borndate TIMESTAMP NOT NULL;

# 修改字段
ALTER TABLE students CHANGE COLUMN borndate birthday DATETIME NULL;

# 修改字段类型
ALTER TABLE students MODIFY COLUMN birthday TIMESTAMP;

# 删除字段
ALTER TABLE students DROP COLUMN birthday;

# 删除表
DROP TABLE IF EXISTS students;

# 复制表，仅仅复制表的结构
CREATE TABLE newTable2 Like major;
desc newTable2;

# 复制表的结构和数据
CREATE TABLE newTable3 SELECT * FROM girls.beauty;
SELECT * FROM newTable3;

# 复制employees表中的last_name,department_id,salary字段到新表 emp表，但不复制数据

CREATE TABLE emp SELECT last_name, department_id, salary FROM myemployees.employees WHERE 1=2;
CREATE TABLE emp1 SELECT last_name, department_id, salary FROM myemployees.employees WHERE FALSE;
















