-- describe each month

DROP TABLE IF EXISTS shenzhen_20190501_app_use;
CREATE TABLE shenzhen_20190501_app_use AS
SELECT app_eachmonth_count,
       COUNT(*) AS people_num
FROM shenzhen_app_use_eachmonth_count_filtered
WHERE date = 20190501
GROUP BY app_eachmonth_count
ORDER BY app_eachmonth_count


DROP TABLE IF EXISTS shenzhen_20191101_app_use;
CREATE TABLE shenzhen_20191101_app_use AS
SELECT app_eachmonth_count,
       COUNT(*) AS people_num
FROM shenzhen_app_use_eachmonth_count_filtered
WHERE date = 20191101
GROUP BY app_eachmonth_count
ORDER BY app_eachmonth_count

DROP TABLE IF EXISTS shenzhen_20200501_app_use;
CREATE TABLE shenzhen_20200501_app_use AS
SELECT app_eachmonth_count,
       COUNT(*) AS people_num
FROM shenzhen_app_use_eachmonth_count_filtered
WHERE date = 20200501
GROUP BY app_eachmonth_count
ORDER BY app_eachmonth_count

DROP TABLE IF EXISTS shenzhen_20201101_app_use;
CREATE TABLE shenzhen_20201101_app_use AS
SELECT app_eachmonth_count,
       COUNT(*) AS people_num
FROM shenzhen_app_use_eachmonth_count_filtered
WHERE date = 20201101
GROUP BY app_eachmonth_count
ORDER BY app_eachmonth_count

DROP TABLE IF EXISTS shenzhen_20210501_app_use;
CREATE TABLE shenzhen_20210501_app_use AS
SELECT app_eachmonth_count,
       COUNT(*) AS people_num
FROM shenzhen_app_use_eachmonth_count_filtered
WHERE date = 20210501
GROUP BY app_eachmonth_count
ORDER BY app_eachmonth_count

DROP TABLE IF EXISTS shenzhen_20211101_app_use;
CREATE TABLE shenzhen_20211101_app_use AS
SELECT app_eachmonth_count,
       COUNT(*) AS people_num
FROM shenzhen_app_use_eachmonth_count_filtered
WHERE date = 20211101
GROUP BY app_eachmonth_count
ORDER BY app_eachmonth_count

DROP TABLE IF EXISTS shenzhen_20220501_app_use;
CREATE TABLE shenzhen_20220501_app_use AS
SELECT app_eachmonth_count,
       COUNT(*) AS people_num
FROM shenzhen_app_use_eachmonth_count_filtered
WHERE date = 20220501
GROUP BY app_eachmonth_count
ORDER BY app_eachmonth_count

DROP TABLE IF EXISTS shenzhen_20221101_app_use;
CREATE TABLE shenzhen_20221101_app_use AS
SELECT app_eachmonth_count,
       COUNT(*) AS people_num
FROM shenzhen_app_use_eachmonth_count_filtered
WHERE date = 20221101
GROUP BY app_eachmonth_count
ORDER BY app_eachmonth_count

DROP TABLE IF EXISTS shenzhen_20230501_app_use;
CREATE TABLE shenzhen_20230501_app_use AS
SELECT app_eachmonth_count,
       COUNT(*) AS people_num
FROM shenzhen_app_use_eachmonth_count_filtered
WHERE date = 20230501
GROUP BY app_eachmonth_count
ORDER BY app_eachmonth_count

DROP TABLE IF EXISTS shenzhen_20231101_app_use;
CREATE TABLE shenzhen_20231101_app_use AS
SELECT app_eachmonth_count,
       COUNT(*) AS people_num
FROM shenzhen_app_use_eachmonth_count_filtered
WHERE date = 20231101
GROUP BY app_eachmonth_count
ORDER BY app_eachmonth_count



SELECT app_eachmonth_count, people_num
FROM shenzhen_20190501_app_use

SELECT app_eachmonth_count, people_num
FROM shenzhen_20191101_app_use

SELECT app_eachmonth_count, people_num
FROM shenzhen_20200501_app_use

SELECT app_eachmonth_count, people_num
FROM shenzhen_20201101_app_use

SELECT app_eachmonth_count, people_num
FROM shenzhen_20210501_app_use

SELECT app_eachmonth_count, people_num
FROM shenzhen_20211101_app_use

SELECT app_eachmonth_count, people_num
FROM shenzhen_20220501_app_use

SELECT app_eachmonth_count, people_num
FROM shenzhen_20221101_app_use

SELECT app_eachmonth_count, people_num
FROM shenzhen_20230501_app_use

SELECT app_eachmonth_count, people_num
FROM shenzhen_20231101_app_use





-- 20190501 JOIN demographics
SELECT uf.age,
       AVG(t.app_eachmonth_count) AS avg_age
FROM shenzhen_20190501_users_filtered uf
JOIN (SELECT PHA_qui, app_eachmonth_count
      FROM shenzhen_app_use_eachmonth_count_filtered
      WHERE date = 20190501) t ON t.PHA_qui = uf.PHA_qui
GROUP BY age

SELECT uf.gender,
       AVG(t.app_eachmonth_count) AS avg_gender
FROM shenzhen_20190501_users_filtered uf
JOIN (SELECT PHA_qui, app_eachmonth_count
      FROM shenzhen_app_use_eachmonth_count_filtered
      WHERE date = 20190501) t ON t.PHA_qui = uf.PHA_qui
GROUP BY gender
      

-- 20191101
SELECT uf.age,
       AVG(t.app_eachmonth_count) AS avg_age
FROM shenzhen_20191101_users_filtered uf
JOIN (SELECT PHA_qui, app_eachmonth_count
      FROM shenzhen_app_use_eachmonth_count_filtered
      WHERE date = 20191101) t ON t.PHA_qui = uf.PHA_qui
GROUP BY age

SELECT uf.gender,
       AVG(t.app_eachmonth_count) AS avg_gender
FROM shenzhen_20191101_users_filtered uf
JOIN (SELECT PHA_qui, app_eachmonth_count
      FROM shenzhen_app_use_eachmonth_count_filtered
      WHERE date = 20191101) t ON t.PHA_qui = uf.PHA_qui
GROUP BY gender
      
-- 20200501
SELECT uf.age,
       AVG(t.app_eachmonth_count) AS avg_age
FROM shenzhen_20200501_users_filtered uf
JOIN (SELECT PHA_qui, app_eachmonth_count
      FROM shenzhen_app_use_eachmonth_count_filtered
      WHERE date = 20200501) t ON t.PHA_qui = uf.PHA_qui
GROUP BY age

SELECT uf.gender,
       AVG(t.app_eachmonth_count) AS avg_gender
FROM shenzhen_20200501_users_filtered uf
JOIN (SELECT PHA_qui, app_eachmonth_count
      FROM shenzhen_app_use_eachmonth_count_filtered
      WHERE date = 20200501) t ON t.PHA_qui = uf.PHA_qui
GROUP BY gender
      

-- 20201101
SELECT uf.age,
       AVG(t.app_eachmonth_count) AS avg_age
FROM shenzhen_20201101_users_filtered uf
JOIN (SELECT PHA_qui, app_eachmonth_count
      FROM shenzhen_app_use_eachmonth_count_filtered
      WHERE date = 20201101) t ON t.PHA_qui = uf.PHA_qui
GROUP BY age

SELECT uf.gender,
       AVG(t.app_eachmonth_count) AS avg_gender
FROM shenzhen_20201101_users_filtered uf
JOIN (SELECT PHA_qui, app_eachmonth_count
      FROM shenzhen_app_use_eachmonth_count_filtered
      WHERE date = 20201101) t ON t.PHA_qui = uf.PHA_qui
GROUP BY gender
      


-- 20210501
SELECT uf.age,
       AVG(t.app_eachmonth_count) AS avg_age
FROM shenzhen_20210501_users_filtered uf
JOIN (SELECT PHA_qui, app_eachmonth_count
      FROM shenzhen_app_use_eachmonth_count_filtered
      WHERE date = 20210501) t ON t.PHA_qui = uf.PHA_qui
GROUP BY age

SELECT uf.gender,
       AVG(t.app_eachmonth_count) AS avg_gender
FROM shenzhen_20210501_users_filtered uf
JOIN (SELECT PHA_qui, app_eachmonth_count
      FROM shenzhen_app_use_eachmonth_count_filtered
      WHERE date = 20210501) t ON t.PHA_qui = uf.PHA_qui
GROUP BY gender
      

-- 20211101
SELECT uf.age,
       AVG(t.app_eachmonth_count) AS avg_age
FROM shenzhen_20211101_users_filtered uf
JOIN (SELECT PHA_qui, app_eachmonth_count
      FROM shenzhen_app_use_eachmonth_count_filtered
      WHERE date = 20211101) t ON t.PHA_qui = uf.PHA_qui
GROUP BY age

SELECT uf.gender,
       AVG(t.app_eachmonth_count) AS avg_gender
FROM shenzhen_20211101_users_filtered uf
JOIN (SELECT PHA_qui, app_eachmonth_count
      FROM shenzhen_app_use_eachmonth_count_filtered
      WHERE date = 20211101) t ON t.PHA_qui = uf.PHA_qui
GROUP BY gender
      
      

-- 20220501
SELECT uf.age,
       AVG(t.app_eachmonth_count) AS avg_age
FROM shenzhen_20220501_users_filtered uf
JOIN (SELECT PHA_qui, app_eachmonth_count
      FROM shenzhen_app_use_eachmonth_count_filtered
      WHERE date = 20220501) t ON t.PHA_qui = uf.PHA_qui
GROUP BY age

SELECT uf.gender,
       AVG(t.app_eachmonth_count) AS avg_gender
FROM shenzhen_20220501_users_filtered uf
JOIN (SELECT PHA_qui, app_eachmonth_count
      FROM shenzhen_app_use_eachmonth_count_filtered
      WHERE date = 20220501) t ON t.PHA_qui = uf.PHA_qui
GROUP BY gender
      

-- 20221101
SELECT uf.age,
       AVG(t.app_eachmonth_count) AS avg_age
FROM shenzhen_20221101_users_filtered uf
JOIN (SELECT PHA_qui, app_eachmonth_count
      FROM shenzhen_app_use_eachmonth_count_filtered
      WHERE date = 20221101) t ON t.PHA_qui = uf.PHA_qui
GROUP BY age

SELECT uf.gender,
       AVG(t.app_eachmonth_count) AS avg_gender
FROM shenzhen_20221101_users_filtered uf
JOIN (SELECT PHA_qui, app_eachmonth_count
      FROM shenzhen_app_use_eachmonth_count_filtered
      WHERE date = 20221101) t ON t.PHA_qui = uf.PHA_qui
GROUP BY gender
      
      

-- 20230501
SELECT uf.age,
       AVG(t.app_eachmonth_count) AS avg_age
FROM shenzhen_20230501_users_filtered uf
JOIN (SELECT PHA_qui, app_eachmonth_count
      FROM shenzhen_app_use_eachmonth_count_filtered
      WHERE date = 20230501) t ON t.PHA_qui = uf.PHA_qui
GROUP BY age

SELECT uf.gender,
       AVG(t.app_eachmonth_count) AS avg_gender
FROM shenzhen_20230501_users_filtered uf
JOIN (SELECT PHA_qui, app_eachmonth_count
      FROM shenzhen_app_use_eachmonth_count_filtered
      WHERE date = 20230501) t ON t.PHA_qui = uf.PHA_qui
GROUP BY gender
      

-- 20231101
SELECT uf.age,
       AVG(t.app_eachmonth_count) AS avg_age
FROM shenzhen_20231101_users_filtered uf
JOIN (SELECT PHA_qui, app_eachmonth_count
      FROM shenzhen_app_use_eachmonth_count_filtered
      WHERE date = 20231101) t ON t.PHA_qui = uf.PHA_qui
GROUP BY age

SELECT uf.gender,
       AVG(t.app_eachmonth_count) AS avg_gender
FROM shenzhen_20231101_users_filtered uf
JOIN (SELECT PHA_qui, app_eachmonth_count
      FROM shenzhen_app_use_eachmonth_count_filtered
      WHERE date = 20231101) t ON t.PHA_qui = uf.PHA_qui
GROUP BY gender
      
