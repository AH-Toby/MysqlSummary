# 条件查询
# 一.关系运算符
# 1.查询工资>15000的员工信息
SELECT *
FROM employees
WHERE salary > 15000;

# 2.查询工资<15000的员工信息
SELECT *
FROM employees
WHERE salary < 15000;

# 3.查询工资>=15000的员工信息
SELECT *
FROM employees
WHERE salary >= 15000;

# 4.查询工资<=15000的员工信息
SELECT *
FROM employees
WHERE salary <= 15000;

# 5.查询工资=12000的员工信息
SELECT *
FROM employees
WHERE salary = 12000;

# 6.查询部门编号不是100的员工
SELECT * 
FROM employees 
WHERE department_id <> 100;

# 7.查询commission_pct为NULL的员工
# =不能判断NULL值
SELECT *
FROM employees
WHERE commission_pct = NULL;
# <=>安全等于可以判断NULL值
SELECT *
FROM employees
WHERE commission_pct <=> NULL;

# 二.逻辑运算符
#1：查询部门编号不是 50-100之间员工姓名、部门编号、邮箱
# 方式1:
SELECT last_name, department_id, email
FROM employees
WHERE NOT (department_id >= 50 AND department_id <= 100);

# 方式2：
SELECT last_name, department_id, email
FROM employees
WHERE department_id < 50 OR department_id > 100;

# 2.查询奖金率>0.03 或者 员工编号在60-110之间的员工信息
SELECT *
FROM employees
WHERE commission_pct > 0.03 or (department_id >= 60 AND department_id <= 110);

# 三.模糊查询
# like
# 1：查询姓名中包含字符a的员工信息
SELECT *
FROM employees
WHERE last_name LIKE "%a%";

# 2：查询姓名中包含最后一个字符为e的员工信息
SELECT *
FROM employees
WHERE last_name LIKE '%e';

# 3：查询姓名中包含第一个字符为e的员工信息
SELECT *
FROM employees
WHERE last_name LIKE 'e%';

# 4：查询姓名中包含第三个字符为x的员工信息
SELECT *
FROM employees
WHERE last_name LIKE '__x%';

# 5.查询姓名中包含第二个字符为_的员工信息
SELECT *
FROM employees
WHERE last_name LIKE '_\_%';

# ESCAPE语法表示将其后的字符当作转义符,作用相当于\字符
SELECT *
FROM employees
WHERE last_name LIKE '_$_%' ESCAPE '$';

# in
# 1.查询部门编号是30/50/90的员工名、部门编号
# 方式1：
SELECT last_name,department_id
FROM employees
WHERE department_id IN (30, 50, 90);

# 方式2：
SELECT last_name,department_id
FROM employees
WHERE department_id = 30 OR  
department_id = 50 OR 
department_id = 90;

# 2.查询工种编号不是SH_CLERK或IT_PROG的员工信息
# 方式1：
SELECT *
FROM employees
WHERE job_id NOT IN ("SH_CLERK", "IT_PROG");

# 方式2：
SELECT *
FROM employees
WHERE job_id <> 'SH_CLERK' AND 
job_id <> 'IT_PROG';

# between...and
# 1.查询部门编号是30-90的员工名、部门编号
# 方式1：
SELECT last_name, department_id
FROM employees
WHERE department_id BETWEEN 30 AND 90;

# 方式2：
SELECT last_name, department_id
FROM employees
WHERE department_id >= 30 AND 
department_id <= 90; 


# 2：查询年薪不是100000-200000之间的员工姓名、工资、年薪
# 方式1：
SELECT last_name,
       salary,
       salary*12*(1+IFNULL(commission_pct, 0)) AS "年薪"
FROM employees
WHERE salary*12*(1+IFNULL(commission_pct, 0)) NOT BETWEEN 100000 AND 200000;

# 方式2：
SELECT last_name,salary,salary*12*(1+IFNULL(commission_pct, 0)) AS "年薪"
FROM employees
WHERE salary*12*(1+IFNULL(commission_pct, 0)) < 100000 OR 
salary*12*(1+IFNULL(commission_pct, 0)) > 200000

# isnull
# 1：查询没有奖金的员工信息
SELECT *
FROM employees
WHERE commission_pct IS NULL; 

# 2.查询有奖金的员工信息
# 方式1：
SELECT *
FROM employees
WHERE commission_pct IS NOT NULL;

# 方式2：
SELECT *
FROM employees
WHERE NOT commission_pct <=> NULL;

# = is <=> 区别
# 1.=只能判断普通的内容
# 因为=只能判断普通内容，不能判断其他内容
SELECT *
FROM employees
WHERE commission_pct = NULL;
# 其他内容
SELECT *
FROM employees
WHERE commission_pct = 0.4;

# 2.is只能判断NULL,不能判断其他内容
SELECT *
FROM employees
WHERE commission_pct IS NULL;
# 其他内容
# SELECT *
# FROM employees
# WHERE commission_pct IS 0.4;

# 3.<=> 安全等于，既能判断普通内容，又能判断NULL值
SELECT *
FROM employees
WHERE commission_pct <=> NULL;
# 其他内容
SELECT *
FROM employees
WHERE commission_pct <=> 0.4;

