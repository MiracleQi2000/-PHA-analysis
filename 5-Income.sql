-- 需要知道不同手机品牌、型号的人的APP use & PAH APP use


-- 20190501 JOIN demographics
DROP TABLE IF EXISTS shenzhen_20190501_avgphone_APPcount;
CREATE TABLE shenzhen_20190501_avgphone_APPcount AS
SELECT uf.brand,
       uf.type as cell,
       COUNT(*) as num,
       AVG(t.app_eachmonth_count) AS 20190501avg_phone
FROM shenzhen_20190501_users_filtered uf
JOIN shenzhen_app_use_eachmonth_count_filtered t
      ON t.PHA_qui = uf.PHA_qui
      AND t.date = uf.date
GROUP BY uf.brand, uf.type


-- 20191101
DROP TABLE IF EXISTS shenzhen_20191101_avgphone_APPcount;
CREATE TABLE shenzhen_20191101_avgphone_APPcount AS
SELECT uf.brand,
       uf.type as cell,
       COUNT(*) as num,
       AVG(t.app_eachmonth_count) AS 20191101avg_phone
FROM shenzhen_20191101_users_filtered uf
JOIN shenzhen_app_use_eachmonth_count_filtered t
      ON t.PHA_qui = uf.PHA_qui
      AND t.date = uf.date
GROUP BY uf.brand, uf.type



-- 20200501
DROP TABLE IF EXISTS shenzhen_20200501_avgphone_APPcount;
CREATE TABLE shenzhen_20200501_avgphone_APPcount AS
SELECT uf.brand,
       uf.type as cell,
       COUNT(*) as num,
       AVG(t.app_eachmonth_count) AS 20200501avg_phone
FROM shenzhen_20200501_users_filtered uf
JOIN shenzhen_app_use_eachmonth_count_filtered t
      ON t.PHA_qui = uf.PHA_qui
      AND t.date = uf.date
GROUP BY uf.brand, uf.type


-- 20201101
DROP TABLE IF EXISTS shenzhen_20201101_avgphone_APPcount;
CREATE TABLE shenzhen_20201101_avgphone_APPcount AS
SELECT uf.brand,
       uf.type as cell,
       COUNT(*) as num,
       AVG(t.app_eachmonth_count) AS 20201101avg_phone
FROM shenzhen_20201101_users_filtered uf
JOIN shenzhen_app_use_eachmonth_count_filtered t
      ON t.PHA_qui = uf.PHA_qui
      AND t.date = uf.date
GROUP BY uf.brand, uf.type


-- 20210501
DROP TABLE IF EXISTS shenzhen_20210501_avgphone_APPcount;
CREATE TABLE shenzhen_20210501_avgphone_APPcount AS
SELECT uf.brand,
       uf.type as cell,
       COUNT(*) as num,
       AVG(t.app_eachmonth_count) AS 20210501avg_phone
FROM shenzhen_20210501_users_filtered uf
JOIN shenzhen_app_use_eachmonth_count_filtered t
      ON t.PHA_qui = uf.PHA_qui
      AND t.date = uf.date
GROUP BY uf.brand, uf.type


-- 20211101
DROP TABLE IF EXISTS shenzhen_20211101_avgphone_APPcount;
CREATE TABLE shenzhen_20211101_avgphone_APPcount AS
SELECT uf.brand,
       uf.type as cell,
       COUNT(*) as num,
       AVG(t.app_eachmonth_count) AS 20211101avg_phone
FROM shenzhen_20211101_users_filtered uf
JOIN shenzhen_app_use_eachmonth_count_filtered t
      ON t.PHA_qui = uf.PHA_qui
      AND t.date = uf.date
GROUP BY uf.brand, uf.type


-- 20220501
DROP TABLE IF EXISTS shenzhen_20220501_avgphone_APPcount;
CREATE TABLE shenzhen_20220501_avgphone_APPcount AS
SELECT uf.brand,
       uf.type as cell,
       COUNT(*) as num,
       AVG(t.app_eachmonth_count) AS 20220501avg_phone
FROM shenzhen_20220501_users_filtered uf
JOIN shenzhen_app_use_eachmonth_count_filtered t
      ON t.PHA_qui = uf.PHA_qui
      AND t.date = uf.date
GROUP BY uf.brand, uf.type


-- 20221101
DROP TABLE IF EXISTS shenzhen_20221101_avgphone_APPcount;
CREATE TABLE shenzhen_20221101_avgphone_APPcount AS
SELECT uf.brand,
       uf.type as cell,
       COUNT(*) as num,
       AVG(t.app_eachmonth_count) AS 20221101avg_phone
FROM shenzhen_20221101_users_filtered uf
JOIN shenzhen_app_use_eachmonth_count_filtered t
      ON t.PHA_qui = uf.PHA_qui
      AND t.date = uf.date
GROUP BY uf.brand, uf.type



-- 20230501
DROP TABLE IF EXISTS shenzhen_20230501_avgphone_APPcount;
CREATE TABLE shenzhen_20230501_avgphone_APPcount AS
SELECT uf.brand,
       uf.type as cell,
       COUNT(*) as num,
       AVG(t.app_eachmonth_count) AS 20230501avg_phone
FROM shenzhen_20230501_users_filtered uf
JOIN shenzhen_app_use_eachmonth_count_filtered t
      ON t.PHA_qui = uf.PHA_qui
      AND t.date = uf.date
GROUP BY uf.brand, uf.type


-- 20231101
DROP TABLE IF EXISTS shenzhen_20231101_avgphone_APPcount;
CREATE TABLE shenzhen_20231101_avgphone_APPcount AS
SELECT uf.brand,
       uf.type as cell,
       COUNT(*) as num,
       AVG(t.app_eachmonth_count) AS 20231101avg_phone
FROM shenzhen_20231101_users_filtered uf
JOIN shenzhen_app_use_eachmonth_count_filtered t
      ON t.PHA_qui = uf.PHA_qui
      AND t.date = uf.date
GROUP BY uf.brand, uf.type



-- 20190501
SELECT 20190501avg_phone, num
FROM shenzhen_20190501_avgphone_APPcount
ORDER BY 20190501avg_phone

-- 20190501
SELECT uf.brand,
       AVG(t.app_eachmonth_count) AS 20190501avg_phone
FROM shenzhen_20190501_users_filtered uf
JOIN shenzhen_app_use_eachmonth_count_filtered t
      ON t.PHA_qui = uf.PHA_qui
      AND t.date = uf.date
GROUP BY uf.brand
ORDER BY 20190501avg_phone


-- 20191101
SELECT 20191101avg_phone, num
FROM shenzhen_20191101_avgphone_APPcount
ORDER BY 20191101avg_phone

-- 20191101
SELECT uf.brand,
       AVG(t.app_eachmonth_count) AS 20191101avg_phone
FROM shenzhen_20191101_users_filtered uf
JOIN shenzhen_app_use_eachmonth_count_filtered t
      ON t.PHA_qui = uf.PHA_qui
      AND t.date = uf.date
GROUP BY uf.brand
ORDER BY 20191101avg_phone


-- 20200501
SELECT 20200501avg_phone, num
FROM shenzhen_20200501_avgphone_APPcount
ORDER BY 20200501avg_phone

-- 20200501
SELECT uf.brand,
       AVG(t.app_eachmonth_count) AS 20200501avg_phone
FROM shenzhen_20200501_users_filtered uf
JOIN shenzhen_app_use_eachmonth_count_filtered t
      ON t.PHA_qui = uf.PHA_qui
      AND t.date = uf.date
GROUP BY uf.brand
ORDER BY 20200501avg_phone


-- 20201101
SELECT 20201101avg_phone, num
FROM shenzhen_20201101_avgphone_APPcount
ORDER BY 20201101avg_phone

-- 20201101
SELECT uf.brand,
       AVG(t.app_eachmonth_count) AS 20201101avg_phone
FROM shenzhen_20201101_users_filtered uf
JOIN shenzhen_app_use_eachmonth_count_filtered t
      ON t.PHA_qui = uf.PHA_qui
      AND t.date = uf.date
GROUP BY uf.brand
ORDER BY 20201101avg_phone


-- 20210501
SELECT 20210501avg_phone, num
FROM shenzhen_20210501_avgphone_APPcount
ORDER BY 20210501avg_phone

-- 20210501
SELECT uf.brand,
       AVG(t.app_eachmonth_count) AS 20210501avg_phone
FROM shenzhen_20210501_users_filtered uf
JOIN shenzhen_app_use_eachmonth_count_filtered t
      ON t.PHA_qui = uf.PHA_qui
      AND t.date = uf.date
GROUP BY uf.brand
ORDER BY 20210501avg_phone


-- 20211101
SELECT 20211101avg_phone, num
FROM shenzhen_20211101_avgphone_APPcount
ORDER BY 20211101avg_phone

-- 20211101
SELECT uf.brand,
       AVG(t.app_eachmonth_count) AS 20211101avg_phone
FROM shenzhen_20211101_users_filtered uf
JOIN shenzhen_app_use_eachmonth_count_filtered t
      ON t.PHA_qui = uf.PHA_qui
      AND t.date = uf.date
GROUP BY uf.brand
ORDER BY 20211101avg_phone


-- 20220501
SELECT 20220501avg_phone, num
FROM shenzhen_20220501_avgphone_APPcount
ORDER BY 20220501avg_phone

-- 20220501
SELECT uf.brand,
       AVG(t.app_eachmonth_count) AS 20220501avg_phone
FROM shenzhen_20220501_users_filtered uf
JOIN shenzhen_app_use_eachmonth_count_filtered t
      ON t.PHA_qui = uf.PHA_qui
      AND t.date = uf.date
GROUP BY uf.brand
ORDER BY 20220501avg_phone

-- 20221101
SELECT 20221101avg_phone, num
FROM shenzhen_20221101_avgphone_APPcount
ORDER BY 20221101avg_phone

-- 20221101
SELECT uf.brand,
       AVG(t.app_eachmonth_count) AS 20221101avg_phone
FROM shenzhen_20221101_users_filtered uf
JOIN shenzhen_app_use_eachmonth_count_filtered t
      ON t.PHA_qui = uf.PHA_qui
      AND t.date = uf.date
GROUP BY uf.brand
ORDER BY 20221101avg_phone


-- 20230501
SELECT 20230501avg_phone, num
FROM shenzhen_20230501_avgphone_APPcount
ORDER BY 20230501avg_phone

-- 20230501
SELECT uf.brand,
       AVG(t.app_eachmonth_count) AS 20230501avg_phone
FROM shenzhen_20230501_users_filtered uf
JOIN shenzhen_app_use_eachmonth_count_filtered t
      ON t.PHA_qui = uf.PHA_qui
      AND t.date = uf.date
GROUP BY uf.brand
ORDER BY 20230501avg_phone

-- 20231101
SELECT 20231101avg_phone, num
FROM shenzhen_20231101_avgphone_APPcount
ORDER BY 20231101avg_phone

-- 20231101
SELECT uf.brand,
       AVG(t.app_eachmonth_count) AS 20231101avg_phone
FROM shenzhen_20231101_users_filtered uf
JOIN shenzhen_app_use_eachmonth_count_filtered t
      ON t.PHA_qui = uf.PHA_qui
      AND t.date = uf.date
GROUP BY uf.brand
ORDER BY 20231101avg_phone




-- 2019
DROP TABLE IF EXISTS shenzhen_20190501_avgphone_APPcount_coal;
CREATE TABLE shenzhen_20190501_avgphone_APPcount_coal AS
SELECT concat_ws(',',
       coalesce(num, '?'),
       coalesce(cast(brand as string), '?'),
       coalesce(20190501avg_phone, '?'),
       coalesce(cast(cell as string), '?'),
       coalesce(num, '?')
       ) AS combine
FROM shenzhen_20190501_avgphone_APPcount

SELECT combine
FROM shenzhen_20190501_avgphone_APPcount_coal

DROP TABLE IF EXISTS shenzhen_20191101_avgphone_APPcount_coal;
CREATE TABLE shenzhen_20191101_avgphone_APPcount_coal AS
SELECT concat_ws(',',
       coalesce(num, '?'),
       coalesce(cast(brand as string), '?'),
       coalesce(20191101avg_phone, '?'),
       coalesce(cast(cell as string), '?'),
       coalesce(num, '?')
       ) AS combine
FROM shenzhen_20191101_avgphone_APPcount

SELECT combine
FROM shenzhen_20191101_avgphone_APPcount_coal

-- 2020
DROP TABLE IF EXISTS shenzhen_20200501_avgphone_APPcount_coal;
CREATE TABLE shenzhen_20200501_avgphone_APPcount_coal AS
SELECT concat_ws(',',
       coalesce(num, '?'),
       coalesce(cast(brand as string), '?'),
       coalesce(20200501avg_phone, '?'),
       coalesce(cast(cell as string), '?'),
       coalesce(num, '?')
       ) AS combine
FROM shenzhen_20200501_avgphone_APPcount

SELECT combine
FROM shenzhen_20200501_avgphone_APPcount_coal


DROP TABLE IF EXISTS shenzhen_20201101_avgphone_APPcount_coal;
CREATE TABLE shenzhen_20201101_avgphone_APPcount_coal AS
SELECT concat_ws(',',
       coalesce(num, '?'),
       coalesce(cast(brand as string), '?'),
       coalesce(20201101avg_phone, '?'),
       coalesce(cast(cell as string), '?'),
       coalesce(num, '?')
       ) AS combine
FROM shenzhen_20201101_avgphone_APPcount

SELECT combine
FROM shenzhen_20201101_avgphone_APPcount_coal


-- 2021
DROP TABLE IF EXISTS shenzhen_20210501_avgphone_APPcount_coal;
CREATE TABLE shenzhen_20210501_avgphone_APPcount_coal AS
SELECT concat_ws(',',
       coalesce(num, '?'),
       coalesce(cast(brand as string), '?'),
       coalesce(20210501avg_phone, '?'),
       coalesce(cast(cell as string), '?'),
       coalesce(num, '?')
       ) AS combine
FROM shenzhen_20210501_avgphone_APPcount

SELECT combine
FROM shenzhen_20210501_avgphone_APPcount_coal

DROP TABLE IF EXISTS shenzhen_20211101_avgphone_APPcount_coal;
CREATE TABLE shenzhen_20211101_avgphone_APPcount_coal AS
SELECT concat_ws(',',
       coalesce(num, '?'),
       coalesce(cast(brand as string), '?'),
       coalesce(20211101avg_phone, '?'),
       coalesce(cast(cell as string), '?'),
       coalesce(num, '?')
       ) AS combine
FROM shenzhen_20211101_avgphone_APPcount

SELECT combine
FROM shenzhen_20211101_avgphone_APPcount_coal


-- 2022
DROP TABLE IF EXISTS shenzhen_20220501_avgphone_APPcount_coal;
CREATE TABLE shenzhen_20220501_avgphone_APPcount_coal AS
SELECT concat_ws(',',
       coalesce(num, '?'),
       coalesce(cast(brand as string), '?'),
       coalesce(20220501avg_phone, '?'),
       coalesce(cast(cell as string), '?'),
       coalesce(num, '?')
       ) AS combine
FROM shenzhen_20220501_avgphone_APPcount

SELECT combine
FROM shenzhen_20220501_avgphone_APPcount_coal

DROP TABLE IF EXISTS shenzhen_20221101_avgphone_APPcount_coal;
CREATE TABLE shenzhen_20221101_avgphone_APPcount_coal AS
SELECT concat_ws(',',
       coalesce(num, '?'),
       coalesce(cast(brand as string), '?'),
       coalesce(20221101avg_phone, '?'),
       coalesce(cast(cell as string), '?'),
       coalesce(num, '?')
       ) AS combine
FROM shenzhen_20221101_avgphone_APPcount

SELECT combine
FROM shenzhen_20221101_avgphone_APPcount_coal


-- 2023
DROP TABLE IF EXISTS shenzhen_20230501_avgphone_APPcount_coal;
CREATE TABLE shenzhen_20230501_avgphone_APPcount_coal AS
SELECT concat_ws(',',
       coalesce(num, '?'),
       coalesce(cast(brand as string), '?'),
       coalesce(20230501avg_phone, '?'),
       coalesce(cast(cell as string), '?'),
       coalesce(num, '?')
       ) AS combine
FROM shenzhen_20230501_avgphone_APPcount

SELECT combine
FROM shenzhen_20230501_avgphone_APPcount_coal

DROP TABLE IF EXISTS shenzhen_20231101_avgphone_APPcount_coal;
CREATE TABLE shenzhen_20231101_avgphone_APPcount_coal AS
SELECT concat_ws(',',
       coalesce(num, '?'),
       coalesce(cast(brand as string), '?'),
       coalesce(20231101avg_phone, '?'),
       coalesce(cast(cell as string), '?'),
       coalesce(num, '?')
       ) AS combine
FROM shenzhen_20231101_avgphone_APPcount

SELECT combine
FROM shenzhen_20231101_avgphone_APPcount_coal


-- PHA use      

-- 20190501

DROP TABLE IF EXISTS shenzhen_20190501_avgphone_PHAcount;
CREATE TABLE shenzhen_20190501_avgphone_PHAcount AS
SELECT uf.brand,
       uf.type,
       AVG(t.PHA_num) AS avg_cell,
       COUNT(*) AS num
FROM shenzhen_20190501_users_filtered uf
JOIN (SELECT PHA_qui, PHA_num
      FROM shenzhen_PHAuse_20190501_all) t on t.PHA_qui = uf.PHA_qui
GROUP BY brand, type


DROP TABLE IF EXISTS shenzhen_20190501_avgphone_PHAcount_coal;
CREATE TABLE shenzhen_20190501_avgphone_PHAcount_coal AS
SELECT concat_ws(',',
       coalesce(num, '?'),
       coalesce(cast(brand as string), '?'),
       coalesce(avg_cell, '?'),
       coalesce(cast(type as string), '?'),
       coalesce(num, '?')
       ) AS combine
FROM shenzhen_20190501_avgphone_PHAcount

SELECT combine
FROM shenzhen_20190501_avgphone_PHAcount_coal



-- 20191101

DROP TABLE IF EXISTS shenzhen_20191101_avgphone_PHAcount;
CREATE TABLE shenzhen_20191101_avgphone_PHAcount AS
SELECT uf.brand,
       uf.type,
       AVG(t.PHA_num) AS avg_cell,
       COUNT(*) AS num
FROM shenzhen_20191101_users_filtered uf
JOIN (SELECT PHA_qui, PHA_num
      FROM shenzhen_PHAuse_20191101_all) t on t.PHA_qui = uf.PHA_qui
GROUP BY brand, type


DROP TABLE IF EXISTS shenzhen_20191101_avgphone_PHAcount_coal;
CREATE TABLE shenzhen_20191101_avgphone_PHAcount_coal AS
SELECT concat_ws(',',
       coalesce(num, '?'),
       coalesce(cast(brand as string), '?'),
       coalesce(avg_cell, '?'),
       coalesce(cast(type as string), '?'),
       coalesce(num, '?')
       ) AS combine
FROM shenzhen_20191101_avgphone_PHAcount

SELECT combine
FROM shenzhen_20191101_avgphone_PHAcount_coal



-- 20200501

DROP TABLE IF EXISTS shenzhen_20200501_avgphone_PHAcount;
CREATE TABLE shenzhen_20200501_avgphone_PHAcount AS
SELECT uf.brand,
       uf.type,
       AVG(t.PHA_num) AS avg_cell,
       COUNT(*) AS num
FROM shenzhen_20200501_users_filtered uf
JOIN (SELECT PHA_qui, PHA_num
      FROM shenzhen_PHAuse_20200501_all) t on t.PHA_qui = uf.PHA_qui
GROUP BY brand, type


DROP TABLE IF EXISTS shenzhen_20200501_avgphone_PHAcount_coal;
CREATE TABLE shenzhen_20200501_avgphone_PHAcount_coal AS
SELECT concat_ws(',',
       coalesce(num, '?'),
       coalesce(cast(brand as string), '?'),
       coalesce(avg_cell, '?'),
       coalesce(cast(type as string), '?'),
       coalesce(num, '?')
       ) AS combine
FROM shenzhen_20200501_avgphone_PHAcount

SELECT combine
FROM shenzhen_20200501_avgphone_PHAcount_coal


-- 20201101

DROP TABLE IF EXISTS shenzhen_20201101_avgphone_PHAcount;
CREATE TABLE shenzhen_20201101_avgphone_PHAcount AS
SELECT uf.brand,
       uf.type,
       AVG(t.PHA_num) AS avg_cell,
       COUNT(*) AS num
FROM shenzhen_20201101_users_filtered uf
JOIN (SELECT PHA_qui, PHA_num
      FROM shenzhen_PHAuse_20201101_all) t on t.PHA_qui = uf.PHA_qui
GROUP BY brand, type


DROP TABLE IF EXISTS shenzhen_20201101_avgphone_PHAcount_coal;
CREATE TABLE shenzhen_20201101_avgphone_PHAcount_coal AS
SELECT concat_ws(',',
       coalesce(num, '?'),
       coalesce(cast(brand as string), '?'),
       coalesce(avg_cell, '?'),
       coalesce(cast(type as string), '?'),
       coalesce(num, '?')
       ) AS combine
FROM shenzhen_20201101_avgphone_PHAcount

SELECT combine
FROM shenzhen_20201101_avgphone_PHAcount_coal



-- 20210501

DROP TABLE IF EXISTS shenzhen_20210501_avgphone_PHAcount;
CREATE TABLE shenzhen_20210501_avgphone_PHAcount AS
SELECT uf.brand,
       uf.type,
       AVG(t.PHA_num) AS avg_cell,
       COUNT(*) AS num
FROM shenzhen_20210501_users_filtered uf
JOIN (SELECT PHA_qui, PHA_num
      FROM shenzhen_PHAuse_20210501_all) t on t.PHA_qui = uf.PHA_qui
GROUP BY brand, type


DROP TABLE IF EXISTS shenzhen_20210501_avgphone_PHAcount_coal;
CREATE TABLE shenzhen_20210501_avgphone_PHAcount_coal AS
SELECT concat_ws(',',
       coalesce(num, '?'),
       coalesce(cast(brand as string), '?'),
       coalesce(avg_cell, '?'),
       coalesce(cast(type as string), '?'),
       coalesce(num, '?')
       ) AS combine
FROM shenzhen_20210501_avgphone_PHAcount

SELECT combine
FROM shenzhen_20210501_avgphone_PHAcount_coal


-- 20211101

DROP TABLE IF EXISTS shenzhen_20211101_avgphone_PHAcount;
CREATE TABLE shenzhen_20211101_avgphone_PHAcount AS
SELECT uf.brand,
       uf.type,
       AVG(t.PHA_num) AS avg_cell,
       COUNT(*) AS num
FROM shenzhen_20211101_users_filtered uf
JOIN (SELECT PHA_qui, PHA_num
      FROM shenzhen_PHAuse_20211101_all) t on t.PHA_qui = uf.PHA_qui
GROUP BY brand, type


DROP TABLE IF EXISTS shenzhen_20211101_avgphone_PHAcount_coal;
CREATE TABLE shenzhen_20211101_avgphone_PHAcount_coal AS
SELECT concat_ws(',',
       coalesce(num, '?'),
       coalesce(cast(brand as string), '?'),
       coalesce(avg_cell, '?'),
       coalesce(cast(type as string), '?'),
       coalesce(num, '?')
       ) AS combine
FROM shenzhen_20211101_avgphone_PHAcount

SELECT combine
FROM shenzhen_20211101_avgphone_PHAcount_coal


-- 20220501

DROP TABLE IF EXISTS shenzhen_20220501_avgphone_PHAcount;
CREATE TABLE shenzhen_20220501_avgphone_PHAcount AS
SELECT uf.brand,
       uf.type,
       AVG(t.PHA_num) AS avg_cell,
       COUNT(*) AS num
FROM shenzhen_20220501_users_filtered uf
JOIN (SELECT PHA_qui, PHA_num
      FROM shenzhen_PHAuse_20220501_all) t on t.PHA_qui = uf.PHA_qui
GROUP BY brand, type


DROP TABLE IF EXISTS shenzhen_20220501_avgphone_PHAcount_coal;
CREATE TABLE shenzhen_20220501_avgphone_PHAcount_coal AS
SELECT concat_ws(',',
       coalesce(num, '?'),
       coalesce(cast(brand as string), '?'),
       coalesce(avg_cell, '?'),
       coalesce(cast(type as string), '?'),
       coalesce(num, '?')
       ) AS combine
FROM shenzhen_20220501_avgphone_PHAcount

SELECT combine
FROM shenzhen_20220501_avgphone_PHAcount_coal


-- 20221101

DROP TABLE IF EXISTS shenzhen_20221101_avgphone_PHAcount;
CREATE TABLE shenzhen_20221101_avgphone_PHAcount AS
SELECT uf.brand,
       uf.type,
       AVG(t.PHA_num) AS avg_cell,
       COUNT(*) AS num
FROM shenzhen_20221101_users_filtered uf
JOIN (SELECT PHA_qui, PHA_num
      FROM shenzhen_PHAuse_20221101_all) t on t.PHA_qui = uf.PHA_qui
GROUP BY brand, type


DROP TABLE IF EXISTS shenzhen_20221101_avgphone_PHAcount_coal;
CREATE TABLE shenzhen_20221101_avgphone_PHAcount_coal AS
SELECT concat_ws(',',
       coalesce(num, '?'),
       coalesce(cast(brand as string), '?'),
       coalesce(avg_cell, '?'),
       coalesce(cast(type as string), '?'),
       coalesce(num, '?')
       ) AS combine
FROM shenzhen_20221101_avgphone_PHAcount

SELECT combine
FROM shenzhen_20221101_avgphone_PHAcount_coal


-- 20230501

DROP TABLE IF EXISTS shenzhen_20230501_avgphone_PHAcount;
CREATE TABLE shenzhen_20230501_avgphone_PHAcount AS
SELECT uf.brand,
       uf.type,
       AVG(t.PHA_num) AS avg_cell,
       COUNT(*) AS num
FROM shenzhen_20230501_users_filtered uf
JOIN (SELECT PHA_qui, PHA_num
      FROM shenzhen_PHAuse_20230501_all) t on t.PHA_qui = uf.PHA_qui
GROUP BY brand, type


DROP TABLE IF EXISTS shenzhen_20230501_avgphone_PHAcount_coal;
CREATE TABLE shenzhen_20230501_avgphone_PHAcount_coal AS
SELECT concat_ws(',',
       coalesce(num, '?'),
       coalesce(cast(brand as string), '?'),
       coalesce(avg_cell, '?'),
       coalesce(cast(type as string), '?'),
       coalesce(num, '?')
       ) AS combine
FROM shenzhen_20230501_avgphone_PHAcount

SELECT combine
FROM shenzhen_20230501_avgphone_PHAcount_coal


-- 20231101

DROP TABLE IF EXISTS shenzhen_20231101_avgphone_PHAcount;
CREATE TABLE shenzhen_20231101_avgphone_PHAcount AS
SELECT uf.brand,
       uf.type,
       AVG(t.PHA_num) AS avg_cell,
       COUNT(*) AS num
FROM shenzhen_20231101_users_filtered uf
JOIN (SELECT PHA_qui, PHA_num
      FROM shenzhen_PHAuse_20231101_all) t on t.PHA_qui = uf.PHA_qui
GROUP BY brand, type


DROP TABLE IF EXISTS shenzhen_20231101_avgphone_PHAcount_coal;
CREATE TABLE shenzhen_20231101_avgphone_PHAcount_coal AS
SELECT concat_ws(',',
       coalesce(num, '?'),
       coalesce(cast(brand as string), '?'),
       coalesce(avg_cell, '?'),
       coalesce(cast(type as string), '?'),
       coalesce(num, '?')
       ) AS combine
FROM shenzhen_20231101_avgphone_PHAcount

SELECT combine
FROM shenzhen_20231101_avgphone_PHAcount_coal




