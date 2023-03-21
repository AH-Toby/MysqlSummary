# 排序查询
# 一.按单个字段排序
# 1.将员工编号>120的员工信息进行工资的升序
SELECT * 
FROM employees
WHERE employee_id  > 120
ORDER BY salary;

# 2.将员工编号>120的员工信息进行工资的降序
SELECT *
FROM employees
WHERE employee_id > 120
ORDER BY salary DESC;

# 二.按表达式排序
# 1.对有奖金的员工，按年薪降序 
SELECT *,
	   salary*12*(1+IFNULL(commission_pct,0)) AS "年薪"
FROM employees
WHERE commission_pct IS NOT NULL 
ORDER BY salary*12*(1+IFNULL(commission_pct,0)) DESC;

# 三.按别名排序
# 1.对有奖金的员工，按年薪降序 
SELECT *,
	   salary*12*(1+IFNULL(commission_pct,0)) AS "年薪"
FROM employees
WHERE commission_pct IS NOT NULL 
ORDER BY 年薪 DESC;

# 四.按函数的结果排序
# 1.按姓名的字数长度进行升序
SELECT last_name
FROM employees
ORDER BY LENGTH(last_name);

# 五.按多个字段排序
# 1.查询员工的姓名、工资、部门编号，先按工资升序，再按部门编号降序
SELECT last_name,salary,department_id
FROM employees
ORDER BY salary ASC, department_id DESC;


# 六.补充选学：按列数排序
SELECT * FROM employees 
ORDER BY 2 DESC;

SELECT * FROM employees 
ORDER BY first_name DESC;



