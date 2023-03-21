# 数据库展示
show databases;

# 选择myemployees数据库
use myemployees;
show tables;

# 一.查询常量
SELECT 100;

# 二.查询表达式
SELECT 100*30;

# 三.查询单个字段
SELECT last_name FROM employees;

# 四.查询多个字段
SELECT last_name,email,employee_id FROM employees;
# 对齐格式
SELECT 
	last_name,
	first_name,
	email,
	commission_pct,
	hiredate,
	salary
FROM
	employees;

# 五.查询所有字段
SELECT * FROM employees;

# 六.查询函数(调用函数，获取返回值)
SELECT DATABASE();
SELECT VERSION();
SELECT USER();

# 七.起别名
# 1.使用AS关键词
SELECT USER() AS 用户名;
SELECT USER() AS "用户名";
SELECT USER() AS '用户名';
SELECT last_name AS "姓名" FROM employees;

# 2.使用空格
SELECT USER() 用户名;
SELECT USER() "用户名";
SELECT USER() '用户名';
SELECT last_name "姓名" FROM employees;

# 八.+的作用
# 案例：查询first_name和last_name拼接成全名，最终起别名为：姓名
# 1.使用+
SELECT first_name+last_name AS "姓名" FROM employees;

# 2.使用concat
SELECT CONCAT(first_name,last_name) AS "姓名" FROM employees;

# mysql中+的作用：
# 1.加法运算
# 当两个操作数都是数值型
SELECT 1+10 AS "1+10的值";
# 当其中一个为字符型，字符型数据强制转换成数值型,如果无法转换，则直接当做0处理
SELECT 10+"我" AS "1+我的值";
# 当其中一个操作数为null
SELECT 1+NULL AS "1+NULL的值";

# 九.distinct的使用，去重复
SELECT DISTINCT department_id FROM employees;

# 十.查看表结构
DESC employees;
# 显示列信息
show COLUMNS FROM employees;





