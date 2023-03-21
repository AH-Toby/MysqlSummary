# 一.数据插入
USE stuDB;
# 1.多条数据插入
INSERT INTO major(id)
VALUES(1);
INSERT INTO major(id)
VALUES(2);

INSERT INTO major(id)
VALUES(3);

# 2.要求字段和值列表一一对应，且遵循类型和约束的限制
INSERT INTO stuinfo(stuid, stuname, stugender, email, age, majorid)
VALUES(1, "吴倩", "男", "wuqian@qq.com", 12, 1);

INSERT INTO stuinfo(stuid, stuname, stugender, email, age, majorid)
VALUES(6, "王祖贤", "女", "wangzuxian@qq.com", 32, 2);

# 3.可以为空字段如何插入
# 方案1：字段名和值都不写
INSERT INTO stuinfo(stuid, stuname, email, majorid)
VALUES(5, "齐豫", "qiyu@qq.com", 2);

# 方案2：字段名写上，值使用null
INSERT INTO stuinfo(stuid, stuname, email, age, majorid)
VALUES(4, "齐豫1", "qiyu@qq.com", NULL, 2);

# 4.默认字段如何插入
# 方案1：字段名写上，值使用default
INSERT INTO stuinfo(stuid, stuname, email, stugender, majorid)
VALUES(3, "齐豫2", "qiyu@qq.com", DEFAULT, 2);

# 方案2：字段名和值都不写
INSERT INTO stuinfo(stuid, stuname, email, majorid)
VALUES(2, "齐豫3", "qiyu@qq.com", 2);

# 方案3：可以省略字段列表，默认所有字段
INSERT INTO stuinfo VALUES(7,'林忆莲','女','lin@126.com',12,2);
INSERT INTO stuinfo VALUES(8,'小黄','男','dd@12.com',12,2);

SELECT * 
FROM stuinfo;

# 5.数据修改
# 修改年龄<20的专业编号为3号，且邮箱更改为 xx@qq.com
UPDATE stuinfo SET majorid = 3, email = "xx@qq.com"
WHERE age < 20;

# 二.数据删除
# 1.删除姓齐的所有信息
DELETE FROM stuinfo WHERE stuname LIKE "齐%";
# 2.删除表中所有数据
TRUNCATE TABLE stuinfo;


