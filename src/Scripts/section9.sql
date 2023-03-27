# 一.事务
# 1.取消事务自动开启
SET autocommit = 0;

# 2.开启事务
START TRANSACTION;

# 3.编写事务的sql语句
#将张三丰的钱-5000
UPDATE stuinfo SET balance=balance-5000 WHERE stuid = 1;
#将灭绝的钱+5000
UPDATE stuinfo SET balance=balance+5000 WHERE stuid = 2;

#4.结束事务
# 提交
# commit;

# 回滚
ROLLBACK;


show databases;
