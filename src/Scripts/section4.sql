# 字符函数
# 1.concat拼接字符串
SELECT CONCAT('hello',first_name,last_name) "备注"
FROM employees;

# 2.length获取字节长度
SELECT LENGTH('hello,word!');
SELECT LENGTH('hello,世界');

# 3.获取字符长度
SELECT CHAR_LENGTH('hello,世界');

# 4.substring截取字符串
/*
注意：起始索引从1开始！！！
substr(str,起始索引，截取的字符长度)
substr(str,起始索引)
sql中起始索引为1
*/
SELECT SUBSTRING("张三丰爱上郭襄", 1, 3);
SELECT SUBSTR("张三丰爱上郭襄", 6); 

# 5.instr获取字符第一次出现的索引
SELECT INSTR("三打白骨精aaa白骨精bbb白骨精","白骨精");

# 6.TRIM去除前后指定的字符，默认是去除空格
# 默认去除左右空格
SELECT TRIM('    虚   竹          ');
# 默认去除左右指定字符
SELECT TRIM('x' FROM 'xxxxxx虚xxx竹xxxxxxxxxxxxxxxxxx');
# 去除左侧指定字符
SELECT TRIM(LEADING  'x' FROM 'xxxxxx虚xxx竹xxxxxxxxxxxxxxxxxx');
# 去除右侧指定字符
SELECT TRIM(TRAILING 'x' FROM 'xxxxxx虚xxx竹xxxxxxxxxxxxxxxxxx');

# 7.LPAD/RPAD  左填充/右填充
SELECT LPAD("木婉清", 10, "a");
SELECT RPAD("木婉清", 10, "a");

# 8.UPPER/LOWER  变大写/变小写
# 查询员工表的姓名，要求格式：姓首字符大写，其他字符小写，名所有字符大写，且姓和名之间用_分割，最后起别名“OUTPUT”
SELECT CONCAT(UPPER(SUBSTR(first_name,1,1)),LOWER(SUBSTR(first_name,2)),"_",LOWER(last_name)) AS "output" 
FROM employees;

# 9.STRCMP 比较两个字符大小
# 比较循序，如果第二个字符串比第一个大，返回查询结果1，如果相同返回0，如果后面字符比前面小返回-1
SELECT STRCMP("aec","abc");
SELECT STRCMP("aec","aec"); 
SELECT STRCMP("abc","aec"); 

# 10.LEFT/RIGHT  截取子串
# 左向右截取
SELECT LEFT("鸠摩智",1);
# 右向左截取
SELECT RIGHT ("鸠摩智",1);


# 数学函数
# 1.ABS绝对值
SELECT ABS(-2.4); 

# 2.CEIL向上取整 返回>=该参数的最小整数
SELECT CEIL(-1.09);
SELECT CEIL(0.09);
SELECT CEIL(1.01);

# 3.FLOOR向下取整 返回<=该参数的最大整数
SELECT FLOOR(-1.09);
SELECT FLOOR(0.09);
SELECT FLOOR(1.01);

# 4.ROUND四舍五入
SELECT ROUND(1.8712345);
SELECT ROUND(1.8712345,2);

# 5.TRUNCATE截断
SELECT TRUNCATE(1.87123456,1);

# 6.MOD取余
SELECT MOD(-10,3);


# 日期函数
# 1.获取当前时间now
SELECT NOW() AS "当前时间"; 

# 2.获取当前时间时间年月日 CURDATE
SELECT CURDATE() AS "当前时间年月日";

# 3.获取当前时间 时分秒 CURTIME
SELECT CURTIME() AS "当前时间时分秒";

# 4.获取两个时间的时间间隔 天数 DATEDIFF
SELECT DATEDIFF("2023-3-15","2023-3-17") AS "时间间隔天数";

# 5.获取两个时间的时间间隔 时分秒 timediff
SELECT TIMEDIFF("14:14:15","12:16:19") AS "时间间隔时分秒"; 

# 6.格式化时间 date_format
SELECT DATE_FORMAT("2023-3-15","%Y年%m月%d天 %H时:%i分钟:%s秒") AS "格式化时间";
# 获取入职时间
SELECT DATE_FORMAT(hiredate,"%Y年%m月%d天 %H时:%i分:%s秒") AS "入职时间"
FROM employees;

# 7.按指定格式解析字符串为日期类型 str_to_date
# 获取1998年3月15日前入职的员工信息
SELECT *
FROM employees
WHERE hiredate < STR_TO_DATE("3/15 1998","%m/%d %Y");


# 流程控制函数
# 1.if条件判断函数
SELECT IF (100>9, "好", "坏") AS "IF条件判断";
SELECT IF (100<9, "好", "坏") AS "IF条件判断";
# 如果有奖金则显示最终奖金数，如果没有则显示0
SELECT commission_pct AS "奖金率",IF (commission_pct IS NULL,0,salary*commission_pct*12) AS "奖金"
FROM employees;

# 2.CASE函数
/*
①情况1 ：类似于switch语句，可以实现等值判断
CASE 表达式
WHEN 值1 THEN 结果1
WHEN 值2 THEN 结果2
...
ELSE 结果n
END
*/

/*
部门编号是30，工资显示为2倍
部门编号是50，工资显示为3倍
部门编号是60，工资显示为4倍
否则不变
显示 部门编号，新工资，旧工资
*/
SELECT department_id AS "部门编号",
CASE department_id 
WHEN 30 THEN salary*2
WHEN 50 THEN salary*3
WHEN 60 THEN salary*4
ELSE salary
END
AS "新工资",
salary "旧工资"
FROM employees;

/*
②情况2：类似于多重IF语句，实现区间判断
CASE 
WHEN 条件1 THEN 结果1
WHEN 条件2 THEN 结果2
...

ELSE 结果n
END
*/

/*
如果工资>20000,显示级别:A
工资>15000,显示级别:B
工资>10000,显示级别:C
否则，显示级别:D
*/
SELECT salary AS "工资",
CASE
WHEN salary > 20000 THEN "A"
WHEN salary > 15000 THEN "B"
WHEN salary > 10000 THEN "C"
ELSE "D"
END
AS "工资级别"
FROM employees;

# 分组聚合函数
# 1.查询员工信息表中，所有员工的工资和、工资平均值、最低工资、最高工资、有工资的个数
SELECT SUM(salary) AS "工资和", AVG(salary) AS "工资平均值", MIN(salary) AS "最低工资", MAX(salary) AS "最高工资", COUNT(salary) AS "有工资的个数"  
FROM employees;

# 2.添加筛选条件
# 查询emp表中的记录数
SELECT COUNT(employee_id)
FROM employees;

# 查询emp表中有佣金的人数
SELECT COUNT(salary)
FROM employees;

# 查询emp表中月薪大于2500的人数
SELECT COUNT(salary)
FROM employees
WHERE salary > 2500;

# 查询有领导的人数
SELECT COUNT(manager_id)
FROM employees;

# COUNT补充介绍
# 1.统计结果集的行数
# 总行数
SELECT COUNT(*) AS "总行数"
FROM employees;

SELECT COUNT(1) AS "总行数"
FROM employees;

# 部门ID是30的数量
SELECT COUNT(*) AS "部门ID是30的数量"
FROM employees
WHERE department_id = 30;

SELECT COUNT(1) AS "部门ID是30的数量"
FROM employees
WHERE department_id = 30;

# 搭配distinic实现去重查询
# 1.查询有员工的部门数
SELECT COUNT(DISTINCT(department_id))
FROM employees;










