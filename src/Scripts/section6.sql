# 一.子查询
# 1.单行子查询
# 谁的工资比 Abel 高?
SELECT last_name AS "姓名",
		salary AS "工资"
FROM employees e 
WHERE salary > (SELECT salary
FROM employees
WHERE last_name = 'Abel'
);

# 2.返回job_id与141号员工相同，salary比143号员工多的员工姓名，job_id 和工资
SELECT last_name AS "员工姓名",
       job_id,
       salary AS "工资"
FROM employees
WHERE job_id = (
	SELECT job_id
	FROM employees 
	WHERE employee_id  = 141)
AND salary > (
	SELECT salary
	FROM employees
	WHERE employee_id =143
);

# 3.返回公司工资最少的员工的last_name,job_id和salary
SELECT last_name,
	   job_id,
	   salary
FROM employees
WHERE salary  = (
	SELECT MIN(salary)  
	FROM employees
);

# 4.查询最低工资大于50号部门最低工资的部门id和其最低工资
SELECT department_id AS "部门ID",
	   MIN(salary) AS "最低工资"
FROM employees
GROUP BY department_id
HAVING MIN(salary) > (
	SELECT MIN(salary)
	FROM employees
	WHERE department_id = 50
);

# 5.多行查询
# 返回location_id是1400或1700的部门中的所有员工姓名
SELECT last_name AS "员工姓名"
FROM employees
WHERE department_id IN (
	SELECT DISTINCT department_id 
	FROM departments
	WHERE location_id IN (1400, 1700)
);

# 6.返回其它部门中比job_id为‘IT_PROG’部门任一工资低的员工的员工号、姓名、job_id 以及salary
SELECT employee_id AS "员工号",
	   last_name AS "姓名",
	   job_id AS "工作编号",
	   salary AS "薪资"
FROM employees
WHERE salary  < ANY (
	SELECT DISTINCT salary 
	FROM employees 
	WHERE job_id  = "IT_PROG"
);

# 等价于
SELECT employee_id AS "员工号",
	   last_name AS "姓名",
	   job_id AS "工作编号",
	   salary AS "薪资"
FROM employees
WHERE salary < (
	  SELECT MAX(salary)
	  FROM employees
	  WHERE job_id = 'IT_PROG'
);

# 7.返回其它部门中比job_id为‘IT_PROG’部门所有工资都低的员工 的员工号、姓名、job_id 以及salary
SELECT employee_id AS "员工号",
	   last_name AS "姓名",
	   job_id AS "工作编号",
	   salary AS "薪资"
FROM employees
WHERE salary < ALL (
	  SELECT DISTINCT salary 
	  FROM employees
	  WHERE job_id = 'IT_PROG'
);

# 等价于
SELECT employee_id AS "员工号",
	   last_name AS "姓名",
	   job_id AS "工作编号",
	   salary AS "薪资"
FROM employees
WHERE salary < (
	  SELECT MIN(salary)
	  FROM employees
	  WHERE job_id = 'IT_PROG'
);

# 8.子查询在不同的位置
# where后面
# 谁的工资比 Abel 高?
SELECT *
FROM employees
WHERE salary > (
	SELECT salary
	FROM employees
	WHERE last_name = 'Abel'
);

# having后面
# 查询最低工资大于50号部门最低工资 的部门id和其最低工资
SELECT department_id AS "部门id",
		MIN(salary) AS "最低工资"
FROM employees
GROUP BY department_id
HAVING MIN(salary) > (
	SELECT MIN(salary)
	FROM employees
	WHERE department_id = 50
);

# SELECT 之后
# 查询部门编号是50的员工个数
SELECT (
	SELECT COUNT(*) 
	FROM employees
	WHERE department_id = 50
) AS "员工数";

# 等同于
SELECT COUNT(*) 
FROM employees
WHERE department_id = 50;

# FROM之后
# 查询每个部门的平均工资的工资级别

# 解题思路
# 查询每个部门的平均工资
SELECT AVG(salary) AS "平均工资",
	   department_id AS "部门ID"
FROM employees
GROUP BY department_id;

# 查询工资级别合并查询
SELECT sg.grade AS "工资级别",
	   avg_salary.sal AS "平均工资"
FROM sal_grade sg
INNER JOIN (
	 SELECT AVG(salary) AS sal
	 FROM employees
     GROUP BY department_id
) AS avg_salary ON avg_salary.sal BETWEEN min_salary AND max_salary;

# exists之后
# 查询有无名字叫“张三丰”的员工信息
SELECT EXISTS(
	SELECT * 
	FROM employees
	WHERE last_name = "张三丰"
) AS "是否有信息";

# 查询有无名字叫“Abel”的员工信息
SELECT EXISTS(
	SELECT * 
	FROM employees
	WHERE last_name = 'Abel'
) AS "是否有信息";

USE girls;
# 查询没有女朋友的男神信息
SELECT boy.*
FROM boys boy
WHERE boy.id NOT IN (
	SELECT b.boyfriend_id 
	FROM beauty b 
);

SELECT boy.*
FROM boys boy
WHERE NOT EXISTS  (
	SELECT girl.boyfriend_id 
	FROM beauty girl
	WHERE boy.id = girl.boyfriend_id 
);

# 9.综合案例
USE myemployees;
# 查询和 Zlotkey 相同部门的员工姓名和工资
SELECT last_name AS "姓名",
	    salary AS "工资"
FROM employees
WHERE department_id = (
		SELECT department_id 
		FROM employees
		WHERE last_name = "Zlotkey"
);

# 查询工资比公司平均工资高的员工的员工号，姓名和工资。
SELECT employee_id AS "员工号",
		last_name AS "姓名",
		salary AS "工资"
FROM employees
WHERE salary > (
	SELECT AVG(salary)
	FROM employees
);

# 二.分页查询
# 1.查询员工信息表的前5条
SELECT *
FROM employees
LIMIT 5;

# 等价于
SELECT *
FROM employees
LIMIT 0,5;

# 2.查询有奖金的，且工资较高的第11名到第20名
 SELECT *
 FROM employees
 WHERE commission_pct IS NOT NULL
 ORDER BY salary
 LIMIT 10,10;

# 三.联合查询
# 1.查询所有国家的年龄>20岁的用户信息
SELECT * FROM usa WHERE uage >20 UNION
SELECT * FROM chinese WHERE age >20 ;

# 2.查询所有国家的用户姓名和年龄
SELECT uname,uage FROM usa
UNION
SELECT age,name FROM chinese;

# 3.union自动去重/union all 可以支持重复项
SELECT 1,'范冰冰' 
UNION ALL
SELECT 1,'范冰冰' 
UNION  ALL
SELECT 1,'范冰冰' 
UNION  ALL
SELECT 1,'范冰冰' ;

