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

