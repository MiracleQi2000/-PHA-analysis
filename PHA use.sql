
-- STEP2：和PHA APP list Join
SELECT PHA_APP
FROM PHA_APPlist
limit 10



-- 找到567101个人每个月使用的所有app并去重

DROP TABLE IF EXISTS shenzhen_APP_deduplicate;
CREATE TABLE shenzhen_APP_deduplicate AS
SELECT saup.PHA_qui,
       saup.date, 
       saup.lcode,
       COUNT(*) as date_app_count
FROM shenzhen_app_use_people_10month saup
JOIN shenzhen_app_use_filtered sauf ON sauf.PHA_qui = saup.PHA_qui
GROUP BY saup.PHA_qui, saup.date, saup.lcode


-- PHA list
DROP TABLE IF EXISTS PHA_APPlist_distinct;
CREATE TABLE PHA_APPlist_distinct AS
SELECT DISTINCT PHA_APP
FROM PHA_APPlist


-- 20190501
DROP TABLE IF EXISTS shenzhen_PHAuse_20190501;
CREATE TABLE shenzhen_PHAuse_20190501 AS
SELECT t.PHA_qui,
       COUNT(*) AS PHA_num
FROM (
  SELECT
    sad.PHA_qui,
    sad.lcode
  FROM
    shenzhen_APP_deduplicate sad
  WHERE
    sad.date = 20190501
  AND EXISTS (
    SELECT 1
    FROM PHA_APPlist_distinct pa
    WHERE pa.PHA_APP = sad.lcode
  )
) t
GROUP BY t.PHA_qui

SELECT PHA_num,
       COUNT(*) AS num
FROM shenzhen_PHAuse_20190501
GROUP BY PHA_num

-- 20191101
DROP TABLE IF EXISTS shenzhen_PHAuse_20191101;
CREATE TABLE shenzhen_PHAuse_20191101 AS
SELECT t.PHA_qui,
       COUNT(*) AS PHA_num
FROM (
  SELECT
    sad.PHA_qui,
    sad.lcode
  FROM
    shenzhen_APP_deduplicate sad
  WHERE
    sad.date = 20191101
  AND EXISTS (
    SELECT 1
    FROM PHA_APPlist_distinct pa
    WHERE pa.PHA_APP = sad.lcode
  )
) t
GROUP BY t.PHA_qui

SELECT PHA_num,
       COUNT(*) AS num
FROM shenzhen_PHAuse_20191101
GROUP BY PHA_num


-- 20200501
DROP TABLE IF EXISTS shenzhen_PHAuse_20200501;
CREATE TABLE shenzhen_PHAuse_20200501 AS
SELECT t.PHA_qui,
       COUNT(*) AS PHA_num
FROM (
  SELECT
    sad.PHA_qui,
    sad.lcode
  FROM
    shenzhen_APP_deduplicate sad
  WHERE
    sad.date = 20200501
  AND EXISTS (
    SELECT 1
    FROM PHA_APPlist_distinct pa
    WHERE pa.PHA_APP = sad.lcode
  )
) t
GROUP BY t.PHA_qui

SELECT PHA_num,
       COUNT(*) AS num
FROM shenzhen_PHAuse_20200501
GROUP BY PHA_num

-- 20201101
DROP TABLE IF EXISTS shenzhen_PHAuse_20201101;
CREATE TABLE shenzhen_PHAuse_20201101 AS
SELECT t.PHA_qui,
       COUNT(*) AS PHA_num
FROM (
  SELECT
    sad.PHA_qui,
    sad.lcode
  FROM
    shenzhen_APP_deduplicate sad
  WHERE
    sad.date = 20201101
  AND EXISTS (
    SELECT 1
    FROM PHA_APPlist_distinct pa
    WHERE pa.PHA_APP = sad.lcode
  )
) t
GROUP BY t.PHA_qui

SELECT PHA_num,
       COUNT(*) AS num
FROM shenzhen_PHAuse_20201101
GROUP BY PHA_num

-- 20210501
DROP TABLE IF EXISTS shenzhen_PHAuse_20210501;
CREATE TABLE shenzhen_PHAuse_20210501 AS
SELECT t.PHA_qui,
       COUNT(*) AS PHA_num
FROM (
  SELECT
    sad.PHA_qui,
    sad.lcode
  FROM
    shenzhen_APP_deduplicate sad
  WHERE
    sad.date = 20210501
  AND EXISTS (
    SELECT 1
    FROM PHA_APPlist_distinct pa
    WHERE pa.PHA_APP = sad.lcode
  )
) t
GROUP BY t.PHA_qui

SELECT PHA_num,
       COUNT(*) AS num
FROM shenzhen_PHAuse_20210501
GROUP BY PHA_num

-- 20211101
DROP TABLE IF EXISTS shenzhen_PHAuse_20211101;
CREATE TABLE shenzhen_PHAuse_20211101 AS
SELECT t.PHA_qui,
       COUNT(*) AS PHA_num
FROM (
  SELECT
    sad.PHA_qui,
    sad.lcode
  FROM
    shenzhen_APP_deduplicate sad
  WHERE
    sad.date = 20211101
  AND EXISTS (
    SELECT 1
    FROM PHA_APPlist_distinct pa
    WHERE pa.PHA_APP = sad.lcode
  )
) t
GROUP BY t.PHA_qui

SELECT PHA_num,
       COUNT(*) AS num
FROM shenzhen_PHAuse_20211101
GROUP BY PHA_num


-- 20220501
DROP TABLE IF EXISTS shenzhen_PHAuse_20220501;
CREATE TABLE shenzhen_PHAuse_20220501 AS
SELECT t.PHA_qui,
       COUNT(*) AS PHA_num
FROM (
  SELECT
    sad.PHA_qui,
    sad.lcode
  FROM
    shenzhen_APP_deduplicate sad
  WHERE
    sad.date = 20220501
  AND EXISTS (
    SELECT 1
    FROM PHA_APPlist_distinct pa
    WHERE pa.PHA_APP = sad.lcode
  )
) t
GROUP BY t.PHA_qui

SELECT PHA_num,
       COUNT(*) AS num
FROM shenzhen_PHAuse_20220501
GROUP BY PHA_num


-- 20221101
DROP TABLE IF EXISTS shenzhen_PHAuse_20221101;
CREATE TABLE shenzhen_PHAuse_20221101 AS
SELECT t.PHA_qui,
       COUNT(*) AS PHA_num
FROM (
  SELECT
    sad.PHA_qui,
    sad.lcode
  FROM
    shenzhen_APP_deduplicate sad
  WHERE
    sad.date = 20221101
  AND EXISTS (
    SELECT 1
    FROM PHA_APPlist_distinct pa
    WHERE pa.PHA_APP = sad.lcode
  )
) t
GROUP BY t.PHA_qui

SELECT PHA_num,
       COUNT(*) AS num
FROM shenzhen_PHAuse_20221101
GROUP BY PHA_num


-- 20230501
DROP TABLE IF EXISTS shenzhen_PHAuse_20230501;
CREATE TABLE shenzhen_PHAuse_20230501 AS
SELECT t.PHA_qui,
       COUNT(*) AS PHA_num
FROM (
  SELECT
    sad.PHA_qui,
    sad.lcode
  FROM
    shenzhen_APP_deduplicate sad
  WHERE
    sad.date = 20230501
  AND EXISTS (
    SELECT 1
    FROM PHA_APPlist_distinct pa
    WHERE pa.PHA_APP = sad.lcode
  )
) t
GROUP BY t.PHA_qui

SELECT PHA_num,
       COUNT(*) AS num
FROM shenzhen_PHAuse_20230501
GROUP BY PHA_num

-- 20231101
DROP TABLE IF EXISTS shenzhen_PHAuse_20231101;
CREATE TABLE shenzhen_PHAuse_20231101 AS
SELECT t.PHA_qui,
       COUNT(*) AS PHA_num
FROM (
  SELECT
    sad.PHA_qui,
    sad.lcode
  FROM
    shenzhen_APP_deduplicate sad
  WHERE
    sad.date = 20231101
  AND EXISTS (
    SELECT 1
    FROM PHA_APPlist_distinct pa
    WHERE pa.PHA_APP = sad.lcode
  )
) t
GROUP BY t.PHA_qui

SELECT PHA_num,
       COUNT(*) AS num
FROM shenzhen_PHAuse_20231101
GROUP BY PHA_num



-- PHA list 应该包含全部567101人，没有匹配到的记为0


DROP TABLE IF EXISTS shenzhen_PHAuse_20190501_all;
CREATE TABLE shenzhen_PHAuse_20190501_all AS
SELECT sauf.PHA_qui,
       IF(sp.PHA_num is null, 0, sp.PHA_num) AS PHA_num
FROM shenzhen_app_use_filtered sauf
LEFT JOIN shenzhen_PHAuse_20190501 sp on sauf.PHA_qui = sp.PHA_qui

SELECT PHA_num, count(*) as num
from shenzhen_PHAuse_20190501_all
group by PHA_num

DROP TABLE IF EXISTS shenzhen_PHAuse_20191101_all;
CREATE TABLE shenzhen_PHAuse_20191101_all AS
SELECT sauf.PHA_qui,
       IF(sp.PHA_num is null, 0, sp.PHA_num) AS PHA_num
FROM shenzhen_app_use_filtered sauf
LEFT JOIN shenzhen_PHAuse_20191101 sp on sauf.PHA_qui = sp.PHA_qui


DROP TABLE IF EXISTS shenzhen_PHAuse_20200501_all;
CREATE TABLE shenzhen_PHAuse_20200501_all AS
SELECT sauf.PHA_qui,
       IF(sp.PHA_num is null, 0, sp.PHA_num) AS PHA_num
FROM shenzhen_app_use_filtered sauf
LEFT JOIN shenzhen_PHAuse_20200501 sp on sauf.PHA_qui = sp.PHA_qui

DROP TABLE IF EXISTS shenzhen_PHAuse_20201101_all;
CREATE TABLE shenzhen_PHAuse_20201101_all AS
SELECT sauf.PHA_qui,
       IF(sp.PHA_num is null, 0, sp.PHA_num) AS PHA_num
FROM shenzhen_app_use_filtered sauf
LEFT JOIN shenzhen_PHAuse_20201101 sp on sauf.PHA_qui = sp.PHA_qui


DROP TABLE IF EXISTS shenzhen_PHAuse_20210501_all;
CREATE TABLE shenzhen_PHAuse_20210501_all AS
SELECT sauf.PHA_qui,
       IF(sp.PHA_num is null, 0, sp.PHA_num) AS PHA_num
FROM shenzhen_app_use_filtered sauf
LEFT JOIN shenzhen_PHAuse_20210501 sp on sauf.PHA_qui = sp.PHA_qui

DROP TABLE IF EXISTS shenzhen_PHAuse_20211101_all;
CREATE TABLE shenzhen_PHAuse_20211101_all AS
SELECT sauf.PHA_qui,
       IF(sp.PHA_num is null, 0, sp.PHA_num) AS PHA_num
FROM shenzhen_app_use_filtered sauf
LEFT JOIN shenzhen_PHAuse_20211101 sp on sauf.PHA_qui = sp.PHA_qui


DROP TABLE IF EXISTS shenzhen_PHAuse_20220501_all;
CREATE TABLE shenzhen_PHAuse_20220501_all AS
SELECT sauf.PHA_qui,
       IF(sp.PHA_num is null, 0, sp.PHA_num) AS PHA_num
FROM shenzhen_app_use_filtered sauf
LEFT JOIN shenzhen_PHAuse_20220501 sp on sauf.PHA_qui = sp.PHA_qui

DROP TABLE IF EXISTS shenzhen_PHAuse_20221101_all;
CREATE TABLE shenzhen_PHAuse_20221101_all AS
SELECT sauf.PHA_qui,
       IF(sp.PHA_num is null, 0, sp.PHA_num) AS PHA_num
FROM shenzhen_app_use_filtered sauf
LEFT JOIN shenzhen_PHAuse_20221101 sp on sauf.PHA_qui = sp.PHA_qui


DROP TABLE IF EXISTS shenzhen_PHAuse_20230501_all;
CREATE TABLE shenzhen_PHAuse_20230501_all AS
SELECT sauf.PHA_qui,
       IF(sp.PHA_num is null, 0, sp.PHA_num) AS PHA_num
FROM shenzhen_app_use_filtered sauf
LEFT JOIN shenzhen_PHAuse_20230501 sp on sauf.PHA_qui = sp.PHA_qui

DROP TABLE IF EXISTS shenzhen_PHAuse_20231101_all;
CREATE TABLE shenzhen_PHAuse_20231101_all AS
SELECT sauf.PHA_qui,
       IF(sp.PHA_num is null, 0, sp.PHA_num) AS PHA_num
FROM shenzhen_app_use_filtered sauf
LEFT JOIN shenzhen_PHAuse_20231101 sp on sauf.PHA_qui = sp.PHA_qui




      
-- PHA use      
      
-- 20190501
SELECT uf.age,
       AVG(t.PHA_num) AS avg_age
FROM shenzhen_20190501_users_filtered uf
JOIN (SELECT PHA_qui, PHA_num
      FROM shenzhen_PHAuse_20190501_all) t on t.PHA_qui = uf.PHA_qui
GROUP BY age

SELECT uf.gender,
       AVG(t.PHA_num) AS avg_gender
FROM shenzhen_20190501_users_filtered uf
JOIN (SELECT PHA_qui, PHA_num
      FROM shenzhen_PHAuse_20190501_all) t on t.PHA_qui = uf.PHA_qui
GROUP BY gender

-- 20191101
SELECT uf.age,
       AVG(t.PHA_num) AS avg_age
FROM shenzhen_20191101_users_filtered uf
JOIN (SELECT PHA_qui, PHA_num
      FROM shenzhen_PHAuse_20191101_all) t on t.PHA_qui = uf.PHA_qui
GROUP BY age

SELECT uf.gender,
       AVG(t.PHA_num) AS avg_gender
FROM shenzhen_20191101_users_filtered uf
JOIN (SELECT PHA_qui, PHA_num
      FROM shenzhen_PHAuse_20191101_all) t on t.PHA_qui = uf.PHA_qui
GROUP BY gender


-- 20200501
SELECT uf.age,
       AVG(t.PHA_num) AS avg_age
FROM shenzhen_20200501_users_filtered uf
JOIN (SELECT PHA_qui, PHA_num
      FROM shenzhen_PHAuse_20200501_all) t on t.PHA_qui = uf.PHA_qui
GROUP BY age

SELECT uf.gender,
       AVG(t.PHA_num) AS avg_gender
FROM shenzhen_20200501_users_filtered uf
JOIN (SELECT PHA_qui, PHA_num
      FROM shenzhen_PHAuse_20200501_all) t on t.PHA_qui = uf.PHA_qui
GROUP BY gender

-- 20201101
SELECT uf.age,
       AVG(t.PHA_num) AS avg_age
FROM shenzhen_20201101_users_filtered uf
JOIN (SELECT PHA_qui, PHA_num
      FROM shenzhen_PHAuse_20201101_all) t on t.PHA_qui = uf.PHA_qui
GROUP BY age

SELECT uf.gender,
       AVG(t.PHA_num) AS avg_gender
FROM shenzhen_20201101_users_filtered uf
JOIN (SELECT PHA_qui, PHA_num
      FROM shenzhen_PHAuse_20201101_all) t on t.PHA_qui = uf.PHA_qui
GROUP BY gender



-- 20210501
SELECT uf.age,
       AVG(t.PHA_num) AS avg_age
FROM shenzhen_20210501_users_filtered uf
JOIN (SELECT PHA_qui, PHA_num
      FROM shenzhen_PHAuse_20210501_all) t on t.PHA_qui = uf.PHA_qui
GROUP BY age

SELECT uf.gender,
       AVG(t.PHA_num) AS avg_gender
FROM shenzhen_20210501_users_filtered uf
JOIN (SELECT PHA_qui, PHA_num
      FROM shenzhen_PHAuse_20210501_all) t on t.PHA_qui = uf.PHA_qui
GROUP BY gender

-- 20211101
SELECT uf.age,
       AVG(t.PHA_num) AS avg_age
FROM shenzhen_20211101_users_filtered uf
JOIN (SELECT PHA_qui, PHA_num
      FROM shenzhen_PHAuse_20211101_all) t on t.PHA_qui = uf.PHA_qui
GROUP BY age

SELECT uf.gender,
       AVG(t.PHA_num) AS avg_gender
FROM shenzhen_20211101_users_filtered uf
JOIN (SELECT PHA_qui, PHA_num
      FROM shenzhen_PHAuse_20211101_all) t on t.PHA_qui = uf.PHA_qui
GROUP BY gender


-- 20220501
SELECT uf.age,
       AVG(t.PHA_num) AS avg_age
FROM shenzhen_20220501_users_filtered uf
JOIN (SELECT PHA_qui, PHA_num
      FROM shenzhen_PHAuse_20220501_all) t on t.PHA_qui = uf.PHA_qui
GROUP BY age

SELECT uf.gender,
       AVG(t.PHA_num) AS avg_gender
FROM shenzhen_20220501_users_filtered uf
JOIN (SELECT PHA_qui, PHA_num
      FROM shenzhen_PHAuse_20220501_all) t on t.PHA_qui = uf.PHA_qui
GROUP BY gender

-- 20221101
SELECT uf.age,
       AVG(t.PHA_num) AS avg_age
FROM shenzhen_20221101_users_filtered uf
JOIN (SELECT PHA_qui, PHA_num
      FROM shenzhen_PHAuse_20221101_all) t on t.PHA_qui = uf.PHA_qui
GROUP BY age

SELECT uf.gender,
       AVG(t.PHA_num) AS avg_gender
FROM shenzhen_20221101_users_filtered uf
JOIN (SELECT PHA_qui, PHA_num
      FROM shenzhen_PHAuse_20221101_all) t on t.PHA_qui = uf.PHA_qui
GROUP BY gender


-- 20230501
SELECT uf.age,
       AVG(t.PHA_num) AS avg_age
FROM shenzhen_20230501_users_filtered uf
JOIN (SELECT PHA_qui, PHA_num
      FROM shenzhen_PHAuse_20230501_all) t on t.PHA_qui = uf.PHA_qui
GROUP BY age

SELECT uf.gender,
       AVG(t.PHA_num) AS avg_gender
FROM shenzhen_20230501_users_filtered uf
JOIN (SELECT PHA_qui, PHA_num
      FROM shenzhen_PHAuse_20230501_all) t on t.PHA_qui = uf.PHA_qui
GROUP BY gender

-- 20231101
SELECT uf.age,
       AVG(t.PHA_num) AS avg_age
FROM shenzhen_20231101_users_filtered uf
JOIN (SELECT PHA_qui, PHA_num
      FROM shenzhen_PHAuse_20231101_all) t on t.PHA_qui = uf.PHA_qui
GROUP BY age

SELECT uf.gender,
       AVG(t.PHA_num) AS avg_gender
FROM shenzhen_20231101_users_filtered uf
JOIN (SELECT PHA_qui, PHA_num
      FROM shenzhen_PHAuse_20231101_all) t on t.PHA_qui = uf.PHA_qui
GROUP BY gender



-- 查询哪个年龄有PHA为0
SELECT AGE, count(*) as num
FROM shenzhen_20190501_users_filtered uf
JOIN (SELECT PHA_qui, PHA_num
      FROM shenzhen_PHAuse_20190501_all) t on t.PHA_qui = uf.PHA_qui
WHERE PHA_num = 0
GROUP BY age

      
-- 查询哪个性别有PHA为0
SELECT Gender, count(*) as num
FROM shenzhen_20210501_users_filtered uf
JOIN (SELECT PHA_qui, PHA_num
      FROM shenzhen_PHAuse_20210501_all) t on t.PHA_qui = uf.PHA_qui
WHERE PHA_num = 0
GROUP BY Gender



