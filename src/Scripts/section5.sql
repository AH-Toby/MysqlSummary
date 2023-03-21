# 分组查询
# 一.简单的分组
# 1.查询每个工种的员工平均工资
SELECT job_id AS "工种",
AVG(salary) AS "每个工种员工的平均工资"
FROM employees
GROUP BY job_id;

# 2.查询每个非空领导的手下人数
SELECT manager_id AS "领导id", COUNT(*) AS "手下人数"
FROM employees
WHERE manager_id IS NOT NULL
GROUP BY manager_id;

# 二.实现分组前的筛选
# 1.查询邮箱中包含a字符的 每个部门的最高工资
SELECT department_id AS "部门id", MAX(salary) AS "最高工资"
FROM employees
WHERE email LIKE "%a%"
GROUP BY department_id;

# 2.查询每个领导手下有奖金的员工的平均工资
SELECT manager_id AS "领导id", AVG(salary) AS "平均工资"
FROM employees
WHERE commission_pct IS NOT NULL
GROUP BY manager_id;

# 三.实现分组后筛选
# 1.查询哪个部门的员工个数>5
# 分析1:查询每个部门的员工数
SELECT department_id AS "部门ID",
	   COUNT(*) AS "员工数"
FROM employees
GROUP BY department_id;

# 在刚才的结果基础上，筛选哪个部门的员工个数>5
SELECT department_id AS "部门ID",
	   COUNT(*) AS "员工数" 
FROM employees
GROUP BY department_id
HAVING 员工数 > 5;

# 2.每个工种有奖金的员工的最高工资>12000的工种编号和最高工资
SELECT job_id AS "工种编号",
	   MAX(salary) AS "最高工资" 
FROM employees
WHERE commission_pct IS NOT NULL 
GROUP BY job_id 
HAVING 最高工资 > 12000;

# 3.领导编号>102的每个领导手下的最低工资大于5000的最低工资
SELECT manager_id AS "领导编号",
       MIN(salary) AS "最低工资"
FROM employees
WHERE manager_id > 102
GROUP BY manager_id
HAVING 最低工资 > 5000;

# 4.实现分组排序
# 查询没有奖金的员工的最高工资>6000的工种编号和最高工资,按最高工资升序
SELECT job_id AS "工种编号",
	   MAX(salary) AS "最高工资" 
FROM employees
WHERE commission_pct IS NULL 
GROUP BY job_id 
HAVING MAX(salary) > 6000
ORDER BY MAX(salary);

# 5.多个字段分组
# 查询每个工种每个部门的最低工资,并按最低工资降序
SELECT job_id AS "工种编号",
	   department_id AS "部门编号",
	   MIN(salary) AS "最低工资"
FROM employees
GROUP BY job_id, department_id
ORDER BY MIN(salary) DESC; 

USE girls;
# 连接查询
# 一.92标准，内链接
# 1.查询女神名和对应的男神名
SELECT name AS "女神名",
	   boyName AS "男神名"
FROM beauty, boys
WHERE beauty.boyfriend_id = boys.id;

USE myemployees;
# 2.查询员工名和对应的部门名
SELECT last_name AS "员工名",
	   department_name AS "部门名"
FROM employees, departments
WHERE employees.department_id = departments.department_id;

# 3.为表起别名
# 好处：
#    ①提高语句的简洁度
#    ②区分多个重名的字段
# 查询员工名、工种号、工种名
SELECT e.last_name AS "员工名",
		e.job_id AS "工种号",
		j.job_title AS "工种名"
FROM employees e, jobs j
WHERE e.job_id = j.job_id;

# 4.两个表的顺序是否可以调换
# 可以调换
# 查询员工名、工种号、工种名
SELECT e.last_name AS "员工名",
		e.job_id AS "工种号",
		j.job_title AS "工种名"
FROM jobs j, employees e
WHERE e.job_id = j.job_id;

# 5.可以添加筛选
# 查询有奖金的员工名、部门名
SELECT e.last_name AS "员工名",
	   d.department_name  AS "部门名"
FROM employees e , departments d 
WHERE e.department_id  = d.department_id 
AND e.commission_pct IS NOT NULL;

# 6.查询城市名中第二个字符为o的部门名和城市名
SELECT d.department_name AS "部门名",
	   l.city AS "城市名"
FROM departments d , locations l
WHERE d.location_id = l.location_id 
AND l.city LIKE "_o%";

# 7.可以加分组
# 查询每个城市的部门个数
SELECT l.city AS "城市",
	   COUNT(*) AS "部门数" 
FROM departments d , locations l
WHERE d.location_id = l.location_id 
GROUP BY l.city;

# 8.查询有奖金的每个部门的部门名和部门的领导编号和该部门的最低工资
SELECT d.department_name AS "部门名",
       d.manager_id AS "领导编号",
       MIN(e.salary) AS "最低工资" 
FROM departments d , employees e
WHERE d.department_id = e.department_id
AND e.commission_pct IS NOT NULL
GROUP BY d.department_name, d.manager_id;

# 9.可以加排序
# 查询每个工种的工种名和员工的个数，并且按员工个数降序
SELECT j.job_title AS "工种名",
	   COUNT(*) AS "员工数" 
FROM jobs j , employees e 
WHERE e.job_id =j.job_id
GROUP BY j.job_title
ORDER BY 员工数 DESC;

# 10.可以实现三表连接？
# 查询员工名、部门名和所在的城市首字母为s开头，并以部门名进行降序
SELECT e.last_name AS "员工名",
       d.department_name AS "部门名",
       l.city AS "所在城市"
FROM employees e , departments d , locations l 
WHERE e.department_id = d.department_id 
AND d.location_id = l.location_id
AND l.city LIKE "s%"
ORDER BY d.department_name DESC;

# 非等值连接
# 新建表
source demo03.sql

# 1.查询员工的工资和工资级别
SELECT last_name AS "员工名",
	   salary AS "工资",
	   grade AS "工资级别"
FROM employees e , sal_grade sg 
WHERE salary BETWEEN sg.min_salary AND sg.max_salary;

# 非等值自连接
# 1.查询员工名和上级的名称
SELECT e.last_name AS "员工名",
	   e2.last_name AS "上级名"
FROM employees e , employees e2 
WHERE e2.employee_id = e.manager_id;


# 二.99标准
# 1.等值连接
# 查询员工名和部门名
SELECT last_name AS "员工名",
       department_name AS "部门名"
FROM employees e 
JOIN departments d
ON d.department_id = e.department_id;

# 2.添加查询条件
# 查询部门编号>100的部门名和所在的城市名
SELECT department_name AS "部门名",
	   city AS "城市名",
	   department_id AS "部门编号"
FROM departments d 
JOIN locations l 
ON d.location_id = l.location_id 
WHERE d.department_id > 100;

# 3.添加分组和筛选
# 查询每个城市的部门个数
SELECT COUNT(*) AS "部门数",
		city AS "城市名"
FROM departments d 
JOIN locations l 
ON d.location_id = l.location_id
GROUP BY l.city;

# 4.添加分组+筛选+排序
# 查询部门中员工个数>10的部门名，并按员工个数降序
SELECT department_name AS "部门名",
	   COUNT(*)  AS "员工个数" 
FROM departments d 
JOIN employees e 
ON e.department_id = d.department_id
GROUP BY d.department_name 
HAVING COUNT(*) >10
ORDER BY COUNT(*) DESC;

# 5.非等值连接
# 查询部门编号在10-90之间的员工的工资级别和人数，并按级别进行分组
SELECT COUNT(*)  AS "人数",
       sg.grade AS "工资级别"
FROM employees e 
JOIN sal_grade sg
ON e.salary BETWEEN sg.min_salary AND sg.max_salary
WHERE e.department_id BETWEEN 10 AND 90
GROUP BY sg.grade;

# 6.非等值自连接
# 查询员工名和对应的领导名
SELECT e.last_name AS "员工名",
	   e2.last_name AS "领导名"
FROM employees e 
JOIN employees e2 
ON e.manager_id = e2.employee_id;


# 7.外连接
# 查询所有女神记录，以及对应的男神名，如果没有对应的男神，则显示为null
use girls;
# 左连接
SELECT girl.*,
	   boy.*
FROM beauty girl
LEFT JOIN boys boy
ON girl.boyfriend_id = boy.id;

# 右连接
SELECT girl.*,
	   boy.*
FROM beauty girl
RIGHT JOIN boys boy
ON girl.boyfriend_id = boy.id;

# 8.查哪个女神没有男朋友
# 左链接
SELECT girl.*,
	   boy.*
FROM beauty girl
LEFT JOIN boys boy
ON girl.boyfriend_id = boy.id
WHERE boy.id IS NULL;

# 右链接,以右表为主表，所以没有数据
SELECT girl.*,
	   boy.*
FROM beauty girl
RIGHT JOIN boys boy
ON girl.boyfriend_id = boy.id
WHERE boy.id IS NULL;

USE myemployees;
# 9.查询哪个部门没有员工，并显示其部门编号和部门名
SELECT e.department_id AS "部门编号",
	   department_name AS "部门名"
FROM employees e
RIGHT JOIN departments d 
ON e.department_id = d.department_id
WHERE e.employee_id IS NULL;







		









