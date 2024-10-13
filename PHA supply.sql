-- Supply

-- 每个时间点active（被使用）的PHA list

-- 先获得每个时间点所有的APP list

-- 20190501
DROP TABLE IF EXISTS shenzhen_20190501_activePHA;
CREATE TABLE shenzhen_20190501_activePHA AS
SELECT
    DISTINCT sad.lcode
FROM shenzhen_APP_deduplicate sad
Join PHA_APPlist pa ON pa.PHA_APP = sad.lcode
WHERE sad.date = 20190501

-- 20191101
DROP TABLE IF EXISTS shenzhen_20191101_activePHA;
CREATE TABLE shenzhen_20191101_activePHA AS
SELECT
    DISTINCT sad.lcode
FROM shenzhen_APP_deduplicate sad
Join PHA_APPlist pa ON pa.PHA_APP = sad.lcode
WHERE sad.date = 20191101

-- 20200501
DROP TABLE IF EXISTS shenzhen_20200501_activePHA;
CREATE TABLE shenzhen_20200501_activePHA AS
SELECT
    DISTINCT sad.lcode
FROM shenzhen_APP_deduplicate sad
Join PHA_APPlist pa ON pa.PHA_APP = sad.lcode
WHERE sad.date = 20200501

-- 20201101
DROP TABLE IF EXISTS shenzhen_20201101_activePHA;
CREATE TABLE shenzhen_20201101_activePHA AS
SELECT
    DISTINCT sad.lcode
FROM shenzhen_APP_deduplicate sad
Join PHA_APPlist pa ON pa.PHA_APP = sad.lcode
WHERE sad.date = 20201101

-- 20210501
DROP TABLE IF EXISTS shenzhen_20210501_activePHA;
CREATE TABLE shenzhen_20210501_activePHA AS
SELECT
    DISTINCT sad.lcode
FROM shenzhen_APP_deduplicate sad
Join PHA_APPlist pa ON pa.PHA_APP = sad.lcode
WHERE sad.date = 20210501

-- 20211101
DROP TABLE IF EXISTS shenzhen_20211101_activePHA;
CREATE TABLE shenzhen_20211101_activePHA AS
SELECT
    DISTINCT sad.lcode
FROM shenzhen_APP_deduplicate sad
Join PHA_APPlist pa ON pa.PHA_APP = sad.lcode
WHERE sad.date = 20211101

-- 20220501
DROP TABLE IF EXISTS shenzhen_20220501_activePHA;
CREATE TABLE shenzhen_20220501_activePHA AS
SELECT
    DISTINCT sad.lcode
FROM shenzhen_APP_deduplicate sad
Join PHA_APPlist pa ON pa.PHA_APP = sad.lcode
WHERE sad.date = 20220501

-- 20221101
DROP TABLE IF EXISTS shenzhen_20221101_activePHA;
CREATE TABLE shenzhen_20221101_activePHA AS
SELECT
    DISTINCT sad.lcode
FROM shenzhen_APP_deduplicate sad
Join PHA_APPlist pa ON pa.PHA_APP = sad.lcode
WHERE sad.date = 20221101

-- 20230501
DROP TABLE IF EXISTS shenzhen_20230501_activePHA;
CREATE TABLE shenzhen_20230501_activePHA AS
SELECT
    DISTINCT sad.lcode
FROM shenzhen_APP_deduplicate sad
Join PHA_APPlist pa ON pa.PHA_APP = sad.lcode
WHERE sad.date = 20230501

-- 20231101
DROP TABLE IF EXISTS shenzhen_20231101_activePHA;
CREATE TABLE shenzhen_20231101_activePHA AS
SELECT
    DISTINCT sad.lcode
FROM shenzhen_APP_deduplicate sad
Join PHA_APPlist pa ON pa.PHA_APP = sad.lcode
WHERE sad.date = 20231101


-- 导出active PHA list
SELECT lcode
FROM shenzhen_20190501_activePHA

SELECT lcode
FROM shenzhen_20191101_activePHA

SELECT lcode
FROM shenzhen_20200501_activePHA

SELECT lcode
FROM shenzhen_20201101_activePHA

SELECT lcode
FROM shenzhen_20210501_activePHA

SELECT lcode
FROM shenzhen_20211101_activePHA

SELECT lcode
FROM shenzhen_20220501_activePHA

SELECT lcode
FROM shenzhen_20221101_activePHA

SELECT lcode
FROM shenzhen_20230501_activePHA

SELECT lcode
FROM shenzhen_20231101_activePHA


-- 20190501被使用的PHA定义为初始PHA

-- mechanism1
-- 看original user的traffic变化

-- find original user
DROP TABLE IF EXISTS originalPHA_user;
CREATE TABLE originalPHA_user AS
SELECT DISTINCT sauf.pha_qui
FROM shenzhen_app_use_people_10month saupm
JOIN shenzhen_app_use_filtered sauf ON sauf.PHA_qui = saupm.PHA_qui
JOIN shenzhen_20190501_activePHA sa on sa.lcode = saupm.lcode
WHERE date = 20190501

-- 每个original PHA每个时间点被使用的traffic总量
DROP TABLE IF EXISTS originalPHA_user_PHA_totaltraffic;
CREATE TABLE originalPHA_user_PHA_totaltraffic AS
SELECT date,
       lcode,
       sum(lflux) as sum_PHAtraffic
FROM shenzhen_app_use_people_10month saupm
JOIN originalPHA_user ou ON ou.PHA_qui = saupm.PHA_qui
JOIN shenzhen_20190501_activePHA sa on sa.lcode = saupm.lcode
WHERE saupm.date IN (20190501, 20191101, 20200501, 20201101, 20210501, 20211101, 20220501, 20221101, 20230501, 20231101)
GROUP BY date, sa.lcode

SELECT date, lcode, sum_PHAtraffic
FROM originalPHA_user_PHA_totaltraffic


-- Time
DROP TABLE IF EXISTS originalPHA_user_PHA_totaltime;
CREATE TABLE originalPHA_user_PHA_totaltime AS
SELECT date,
       lcode,
       sum(ltime) as sum_PHAtime
FROM shenzhen_app_use_people_10month saupm
JOIN originalPHA_user ou ON ou.PHA_qui = saupm.PHA_qui
JOIN shenzhen_20190501_activePHA sa on sa.lcode = saupm.lcode
WHERE saupm.date IN (20190501, 20191101, 20200501, 20201101, 20210501, 20211101, 20220501, 20221101, 20230501, 20231101)
GROUP BY date, sa.lcode

SELECT date, lcode, sum_PHAtime
FROM originalPHA_user_PHA_totaltime




-- 看初始PHA的later adopter和original user的demographic对比
-- originaluser

DROP TABLE IF EXISTS originalPHA_user_demographics;
create table originalPHA_user_demographics AS
SELECT ou.PHA_qui,
       spf.date,
       spf.age,
       spf.gender,
       spf.brand,
       spf.type
FROM originalPHA_user ou
JOIN shenzhen_people_filtered spf ON spf.PHA_qui = ou.PHA_qui
WHERE date = 20191101


-- 20191101新进入original PHA的user

DROP TABLE IF EXISTS originalPHA_20191101newuser;
CREATE TABLE originalPHA_20191101newuser AS
SELECT t.pha_qui
FROM(
  -- 20191101的全部original PHA user
  SELECT DISTINCT sauf.pha_qui
  FROM shenzhen_app_use_people_10month saupm
  JOIN shenzhen_app_use_filtered sauf ON sauf.PHA_qui = saupm.PHA_qui
  JOIN shenzhen_20190501_activePHA sa on sa.lcode = saupm.lcode -- 仍然是original PHA
  WHERE date = 20191101
) t
LEFT JOIN originalPHA_user ou ON t.PHA_qui = ou.PHA_qui
WHERE ou.PHA_qui is NULL
-- 1055人

DROP TABLE IF EXISTS originalPHA_20191101newuser_demographics;
create table originalPHA_20191101newuser_demographics AS
SELECT ou.PHA_qui,
       spf.date,
       spf.age,
       spf.gender,
       spf.brand,
       spf.type
FROM originalPHA_20191101newuser ou
JOIN shenzhen_people_filtered spf ON spf.PHA_qui = ou.PHA_qui
WHERE date = 20191101


-- 20200501新进入original PHA的user
DROP TABLE IF EXISTS originalPHA_20200501newuser;
CREATE TABLE originalPHA_20200501newuser AS
SELECT t.pha_qui
FROM(
  -- 20200501的全部original PHA user
  SELECT DISTINCT sauf.pha_qui
  FROM shenzhen_app_use_people_10month saupm
  JOIN shenzhen_app_use_filtered sauf ON sauf.PHA_qui = saupm.PHA_qui
  JOIN shenzhen_20190501_activePHA sa on sa.lcode = saupm.lcode -- 仍然是original PHA
  WHERE date = 20200501
) t
LEFT JOIN originalPHA_user ou ON t.PHA_qui = ou.PHA_qui
LEFT JOIN originalPHA_20191101newuser ou2 on t.PHA_qui = ou2.PHA_qui
WHERE ou.PHA_qui is NULL
AND ou2.PHA_qui is NULL
-- 142人

DROP TABLE IF EXISTS originalPHA_20200501newuser_demographics;
create table originalPHA_20200501newuser_demographics AS
SELECT ou.PHA_qui,
       spf.date,
       spf.age,
       spf.gender,
       spf.brand,
       spf.type
FROM originalPHA_20200501newuser ou
JOIN shenzhen_people_filtered spf ON spf.PHA_qui = ou.PHA_qui
WHERE date = 20200501


-- 20201101新进入original PHA的user
DROP TABLE IF EXISTS originalPHA_20201101newuser;
CREATE TABLE originalPHA_20201101newuser AS
SELECT t.pha_qui
FROM(
  -- 20201101的全部original PHA user
  SELECT DISTINCT sauf.pha_qui
  FROM shenzhen_app_use_people_10month saupm
  JOIN shenzhen_app_use_filtered sauf ON sauf.PHA_qui = saupm.PHA_qui
  JOIN shenzhen_20190501_activePHA sa on sa.lcode = saupm.lcode -- 仍然是original PHA
  WHERE date = 20201101
) t
LEFT JOIN originalPHA_user ou ON t.PHA_qui = ou.PHA_qui
LEFT JOIN originalPHA_20191101newuser ou2 on t.PHA_qui = ou2.PHA_qui
LEFT JOIN originalPHA_20200501newuser ou3 on t.PHA_qui = ou3.PHA_qui
WHERE ou.PHA_qui is NULL
AND ou2.PHA_qui is NULL
AND ou3.PHA_qui is NULL
-- 259人

DROP TABLE IF EXISTS originalPHA_20201101newuser_demographics;
create table originalPHA_20201101newuser_demographics AS
SELECT ou.PHA_qui,
       spf.date,
       spf.age,
       spf.gender,
       spf.brand,
       spf.type
FROM originalPHA_20201101newuser ou
JOIN shenzhen_people_filtered spf ON spf.PHA_qui = ou.PHA_qui
WHERE date = 20201101




-- 20210501新进入original PHA的user
DROP TABLE IF EXISTS originalPHA_20210501newuser;
CREATE TABLE originalPHA_20210501newuser AS
SELECT t.pha_qui
FROM(
  -- 20210501的全部original PHA user
  SELECT DISTINCT sauf.pha_qui
  FROM shenzhen_app_use_people_10month saupm
  JOIN shenzhen_app_use_filtered sauf ON sauf.PHA_qui = saupm.PHA_qui
  JOIN shenzhen_20190501_activePHA sa on sa.lcode = saupm.lcode -- 仍然是original PHA
  WHERE date = 20210501
) t
LEFT JOIN originalPHA_user ou ON t.PHA_qui = ou.PHA_qui
LEFT JOIN originalPHA_20191101newuser ou2 on t.PHA_qui = ou2.PHA_qui
LEFT JOIN originalPHA_20200501newuser ou3 on t.PHA_qui = ou3.PHA_qui
LEFT JOIN originalPHA_20201101newuser ou4 on t.PHA_qui = ou4.PHA_qui
WHERE ou.PHA_qui is NULL
AND ou2.PHA_qui is NULL
AND ou3.PHA_qui is NULL
AND ou4.PHA_qui is NULL
-- 36人

DROP TABLE IF EXISTS originalPHA_20210501newuser_demographics;
create table originalPHA_20210501newuser_demographics AS
SELECT ou.PHA_qui,
       spf.date,
       spf.age,
       spf.gender,
       spf.brand,
       spf.type
FROM originalPHA_20210501newuser ou
JOIN shenzhen_people_filtered spf ON spf.PHA_qui = ou.PHA_qui
WHERE date = 20210501




-- 20211101新进入original PHA的user
DROP TABLE IF EXISTS originalPHA_20211101newuser;
CREATE TABLE originalPHA_20211101newuser AS
SELECT t.pha_qui
FROM(
  -- 20211101的全部original PHA user
  SELECT DISTINCT sauf.pha_qui
  FROM shenzhen_app_use_people_10month saupm
  JOIN shenzhen_app_use_filtered sauf ON sauf.PHA_qui = saupm.PHA_qui
  JOIN shenzhen_20190501_activePHA sa on sa.lcode = saupm.lcode -- 仍然是original PHA
  WHERE date = 20211101
) t
LEFT JOIN originalPHA_user ou ON t.PHA_qui = ou.PHA_qui
LEFT JOIN originalPHA_20191101newuser ou2 on t.PHA_qui = ou2.PHA_qui
LEFT JOIN originalPHA_20200501newuser ou3 on t.PHA_qui = ou3.PHA_qui
LEFT JOIN originalPHA_20201101newuser ou4 on t.PHA_qui = ou4.PHA_qui
LEFT JOIN originalPHA_20210501newuser ou5 on t.PHA_qui = ou5.PHA_qui
WHERE ou.PHA_qui is NULL
AND ou2.PHA_qui is NULL
AND ou3.PHA_qui is NULL
AND ou4.PHA_qui is NULL
AND ou5.PHA_qui is NULL
-- 人

DROP TABLE IF EXISTS originalPHA_20211101newuser_demographics;
create table originalPHA_20211101newuser_demographics AS
SELECT ou.PHA_qui,
       spf.date,
       spf.age,
       spf.gender,
       spf.brand,
       spf.type
FROM originalPHA_20211101newuser ou
JOIN shenzhen_people_filtered spf ON spf.PHA_qui = ou.PHA_qui
WHERE date = 20211101



-- 20220501新进入original PHA的user
DROP TABLE IF EXISTS originalPHA_20220501newuser;
CREATE TABLE originalPHA_20220501newuser AS
SELECT t.pha_qui
FROM(
  -- 20220501的全部original PHA user
  SELECT DISTINCT sauf.pha_qui
  FROM shenzhen_app_use_people_10month saupm
  JOIN shenzhen_app_use_filtered sauf ON sauf.PHA_qui = saupm.PHA_qui
  JOIN shenzhen_20190501_activePHA sa on sa.lcode = saupm.lcode -- 仍然是original PHA
  WHERE date = 20220501
) t
LEFT JOIN originalPHA_user ou ON t.PHA_qui = ou.PHA_qui
LEFT JOIN originalPHA_20191101newuser ou2 on t.PHA_qui = ou2.PHA_qui
LEFT JOIN originalPHA_20200501newuser ou3 on t.PHA_qui = ou3.PHA_qui
LEFT JOIN originalPHA_20201101newuser ou4 on t.PHA_qui = ou4.PHA_qui
LEFT JOIN originalPHA_20210501newuser ou5 on t.PHA_qui = ou5.PHA_qui
LEFT JOIN originalPHA_20211101newuser ou6 on t.PHA_qui = ou6.PHA_qui
WHERE ou.PHA_qui is NULL
AND ou2.PHA_qui is NULL
AND ou3.PHA_qui is NULL
AND ou4.PHA_qui is NULL
AND ou5.PHA_qui is NULL
AND ou6.PHA_qui is NULL
-- 人

DROP TABLE IF EXISTS originalPHA_20220501newuser_demographics;
create table originalPHA_20220501newuser_demographics AS
SELECT ou.PHA_qui,
       spf.date,
       spf.age,
       spf.gender,
       spf.brand,
       spf.type
FROM originalPHA_20220501newuser ou
JOIN shenzhen_people_filtered spf ON spf.PHA_qui = ou.PHA_qui
WHERE date = 20220501


-- 20221101新进入original PHA的user
DROP TABLE IF EXISTS originalPHA_20221101newuser;
CREATE TABLE originalPHA_20221101newuser AS
SELECT t.pha_qui
FROM(
  -- 20221101的全部original PHA user
  SELECT DISTINCT sauf.pha_qui
  FROM shenzhen_app_use_people_10month saupm
  JOIN shenzhen_app_use_filtered sauf ON sauf.PHA_qui = saupm.PHA_qui
  JOIN shenzhen_20190501_activePHA sa on sa.lcode = saupm.lcode -- 仍然是original PHA
  WHERE date = 20221101
) t
LEFT JOIN originalPHA_user ou ON t.PHA_qui = ou.PHA_qui
LEFT JOIN originalPHA_20191101newuser ou2 on t.PHA_qui = ou2.PHA_qui
LEFT JOIN originalPHA_20200501newuser ou3 on t.PHA_qui = ou3.PHA_qui
LEFT JOIN originalPHA_20201101newuser ou4 on t.PHA_qui = ou4.PHA_qui
LEFT JOIN originalPHA_20210501newuser ou5 on t.PHA_qui = ou5.PHA_qui
LEFT JOIN originalPHA_20211101newuser ou6 on t.PHA_qui = ou6.PHA_qui
LEFT JOIN originalPHA_20220501newuser ou7 on t.PHA_qui = ou7.PHA_qui
WHERE ou.PHA_qui is NULL
AND ou2.PHA_qui is NULL
AND ou3.PHA_qui is NULL
AND ou4.PHA_qui is NULL
AND ou5.PHA_qui is NULL
AND ou6.PHA_qui is NULL
AND ou7.PHA_qui is NULL
-- 人

DROP TABLE IF EXISTS originalPHA_20221101newuser_demographics;
create table originalPHA_20221101newuser_demographics AS
SELECT ou.PHA_qui,
       spf.date,
       spf.age,
       spf.gender,
       spf.brand,
       spf.type
FROM originalPHA_20221101newuser ou
JOIN shenzhen_people_filtered spf ON spf.PHA_qui = ou.PHA_qui
WHERE date = 20221101




-- 20230501新进入original PHA的user
DROP TABLE IF EXISTS originalPHA_20230501newuser;
CREATE TABLE originalPHA_20230501newuser AS
SELECT t.pha_qui
FROM(
  -- 20230501的全部original PHA user
  SELECT DISTINCT sauf.pha_qui
  FROM shenzhen_app_use_people_10month saupm
  JOIN shenzhen_app_use_filtered sauf ON sauf.PHA_qui = saupm.PHA_qui
  JOIN shenzhen_20190501_activePHA sa on sa.lcode = saupm.lcode -- 仍然是original PHA
  WHERE date = 20230501
) t
LEFT JOIN originalPHA_user ou ON t.PHA_qui = ou.PHA_qui
LEFT JOIN originalPHA_20191101newuser ou2 on t.PHA_qui = ou2.PHA_qui
LEFT JOIN originalPHA_20200501newuser ou3 on t.PHA_qui = ou3.PHA_qui
LEFT JOIN originalPHA_20201101newuser ou4 on t.PHA_qui = ou4.PHA_qui
LEFT JOIN originalPHA_20210501newuser ou5 on t.PHA_qui = ou5.PHA_qui
LEFT JOIN originalPHA_20211101newuser ou6 on t.PHA_qui = ou6.PHA_qui
LEFT JOIN originalPHA_20220501newuser ou7 on t.PHA_qui = ou7.PHA_qui
LEFT JOIN originalPHA_20221101newuser ou8 on t.PHA_qui = ou8.PHA_qui
WHERE ou.PHA_qui is NULL
AND ou2.PHA_qui is NULL
AND ou3.PHA_qui is NULL
AND ou4.PHA_qui is NULL
AND ou5.PHA_qui is NULL
AND ou6.PHA_qui is NULL
AND ou7.PHA_qui is NULL
AND ou8.PHA_qui is NULL
-- 人

DROP TABLE IF EXISTS originalPHA_20230501newuser_demographics;
create table originalPHA_20230501newuser_demographics AS
SELECT ou.PHA_qui,
       spf.date,
       spf.age,
       spf.gender,
       spf.brand,
       spf.type
FROM originalPHA_20230501newuser ou
JOIN shenzhen_people_filtered spf ON spf.PHA_qui = ou.PHA_qui
WHERE date = 20230501



-- 20231101新进入original PHA的user
DROP TABLE IF EXISTS originalPHA_20231101newuser;
CREATE TABLE originalPHA_20231101newuser AS
SELECT t.pha_qui
FROM(
  -- 20231101的全部original PHA user
  SELECT DISTINCT sauf.pha_qui
  FROM shenzhen_app_use_people_10month saupm
  JOIN shenzhen_app_use_filtered sauf ON sauf.PHA_qui = saupm.PHA_qui
  JOIN shenzhen_20190501_activePHA sa on sa.lcode = saupm.lcode -- 仍然是original PHA
  WHERE date = 20231101
) t
LEFT JOIN originalPHA_user ou ON t.PHA_qui = ou.PHA_qui
LEFT JOIN originalPHA_20191101newuser ou2 on t.PHA_qui = ou2.PHA_qui
LEFT JOIN originalPHA_20200501newuser ou3 on t.PHA_qui = ou3.PHA_qui
LEFT JOIN originalPHA_20201101newuser ou4 on t.PHA_qui = ou4.PHA_qui
LEFT JOIN originalPHA_20210501newuser ou5 on t.PHA_qui = ou5.PHA_qui
LEFT JOIN originalPHA_20211101newuser ou6 on t.PHA_qui = ou6.PHA_qui
LEFT JOIN originalPHA_20220501newuser ou7 on t.PHA_qui = ou7.PHA_qui
LEFT JOIN originalPHA_20221101newuser ou8 on t.PHA_qui = ou8.PHA_qui
LEFT JOIN originalPHA_20230501newuser ou9 on t.PHA_qui = ou9.PHA_qui
WHERE ou.PHA_qui is NULL
AND ou2.PHA_qui is NULL
AND ou3.PHA_qui is NULL
AND ou4.PHA_qui is NULL
AND ou5.PHA_qui is NULL
AND ou6.PHA_qui is NULL
AND ou7.PHA_qui is NULL
AND ou8.PHA_qui is NULL
AND ou9.PHA_qui is NULL
-- 人

DROP TABLE IF EXISTS originalPHA_20231101newuser_demographics;
create table originalPHA_20231101newuser_demographics AS
SELECT ou.PHA_qui,
       spf.date,
       spf.age,
       spf.gender,
       spf.brand,
       spf.type
FROM originalPHA_20231101newuser ou
JOIN shenzhen_people_filtered spf ON spf.PHA_qui = ou.PHA_qui
WHERE date = 20231101


-- 20190501
-- gender
SELECT gender,
       COUNT(*) as num
FROM originalPHA_user_demographics
GROUP BY gender

-- age
SELECT age,
       COUNT(*) as num
FROM originalPHA_user_demographics
GROUP BY age

-- phone
SELECT brand,
       type,
       COUNT(*) as num
FROM originalPHA_user_demographics
GROUP BY brand, type

-- 20191101
-- gender
SELECT gender,
       COUNT(*) as num
FROM originalpha_20191101newuser_demographics
GROUP BY gender

-- age
SELECT age,
       COUNT(*) as num
FROM originalpha_20191101newuser_demographics
GROUP BY age

-- phone
SELECT brand,
       type,
       COUNT(*) as num
FROM originalpha_20191101newuser_demographics
GROUP BY brand, type


-- 20200501
-- gender
SELECT gender,
       COUNT(*) as num
FROM originalPHA_20200501newuser_demographics
GROUP BY gender

-- age
SELECT age,
       COUNT(*) as num
FROM originalPHA_20200501newuser_demographics
GROUP BY age

-- phone
SELECT brand,
       type,
       COUNT(*) as num
FROM originalPHA_20200501newuser_demographics
GROUP BY brand, type



-- 20201101
-- gender
SELECT gender,
       COUNT(*) as num
FROM originalpha_20201101newuser_demographics
GROUP BY gender

-- age
SELECT age,
       COUNT(*) as num
FROM originalpha_20201101newuser_demographics
GROUP BY age

-- phone
SELECT brand,
       type,
       COUNT(*) as num
FROM originalpha_20201101newuser_demographics
GROUP BY brand, type



-- 20210501
-- gender
SELECT gender,
       COUNT(*) as num
FROM originalPHA_20210501newuser_demographics
GROUP BY gender

-- age
SELECT age,
       COUNT(*) as num
FROM originalPHA_20210501newuser_demographics
GROUP BY age

-- phone
SELECT brand,
       type,
       COUNT(*) as num
FROM originalPHA_20210501newuser_demographics
GROUP BY brand, type



-- 20211101
-- gender
SELECT gender,
       COUNT(*) as num
FROM originalpha_20211101newuser_demographics
GROUP BY gender

-- age
SELECT age,
       COUNT(*) as num
FROM originalpha_20211101newuser_demographics
GROUP BY age

-- phone
SELECT brand,
       type,
       COUNT(*) as num
FROM originalpha_20211101newuser_demographics
GROUP BY brand, type




-- 20220501
-- gender
SELECT gender,
       COUNT(*) as num
FROM originalPHA_20220501newuser_demographics
GROUP BY gender

-- age
SELECT age,
       COUNT(*) as num
FROM originalPHA_20220501newuser_demographics
GROUP BY age

-- phone
SELECT brand,
       type,
       COUNT(*) as num
FROM originalPHA_20220501newuser_demographics
GROUP BY brand, type



-- 20221101
-- gender
SELECT gender,
       COUNT(*) as num
FROM originalpha_20221101newuser_demographics
GROUP BY gender

-- age
SELECT age,
       COUNT(*) as num
FROM originalpha_20221101newuser_demographics
GROUP BY age

-- phone
SELECT brand,
       type,
       COUNT(*) as num
FROM originalpha_20221101newuser_demographics
GROUP BY brand, type


-- 20230501
-- gender
SELECT gender,
       COUNT(*) as num
FROM originalPHA_20230501newuser_demographics
GROUP BY gender

-- age
SELECT age,
       COUNT(*) as num
FROM originalPHA_20230501newuser_demographics
GROUP BY age

-- phone
SELECT brand,
       type,
       COUNT(*) as num
FROM originalPHA_20230501newuser_demographics
GROUP BY brand, type



-- 20231101
-- gender
SELECT gender,
       COUNT(*) as num
FROM originalpha_20231101newuser_demographics
GROUP BY gender

-- age
SELECT age,
       COUNT(*) as num
FROM originalpha_20231101newuser_demographics
GROUP BY age

-- phone
SELECT brand,
       type,
       COUNT(*) as num
FROM originalpha_20231101newuser_demographics
GROUP BY brand, type





-- each PHA's traffic at each timepoint
DROP TABLE IF EXISTS EachPHA_20190501__totaltraffic;
CREATE TABLE EachPHA_20190501__totaltraffic AS
SELECT sa.lcode,
       SUM(lflux) as sum_traffic
FROM shenzhen_app_use_people_10month saupm
JOIN shenzhen_app_use_filtered sauf ON sauf.PHA_qui = saupm.PHA_qui
JOIN shenzhen_20190501_activePHA sa on sa.lcode = saupm.lcode
WHERE date = 20190501
GROUP BY sa.lcode

SELECT lcode, sum_traffic
FROM EachPHA_20190501__totaltraffic

DROP TABLE IF EXISTS EachPHA_20191101__totaltraffic;
CREATE TABLE EachPHA_20191101__totaltraffic AS
SELECT sa.lcode,
       SUM(lflux) as sum_traffic
FROM shenzhen_app_use_people_10month saupm
JOIN shenzhen_app_use_filtered sauf ON sauf.PHA_qui = saupm.PHA_qui
JOIN shenzhen_20191101_activePHA sa on sa.lcode = saupm.lcode
WHERE date = 20191101
GROUP BY sa.lcode

SELECT lcode, sum_traffic
FROM EachPHA_20191101__totaltraffic



DROP TABLE IF EXISTS EachPHA_20200501__totaltraffic;
CREATE TABLE EachPHA_20200501__totaltraffic AS
SELECT sa.lcode,
       SUM(lflux) as sum_traffic
FROM shenzhen_app_use_people_10month saupm
JOIN shenzhen_app_use_filtered sauf ON sauf.PHA_qui = saupm.PHA_qui
JOIN shenzhen_20200501_activePHA sa on sa.lcode = saupm.lcode
WHERE date = 20200501
GROUP BY sa.lcode

SELECT lcode, sum_traffic
FROM EachPHA_20200501__totaltraffic

DROP TABLE IF EXISTS EachPHA_20201101__totaltraffic;
CREATE TABLE EachPHA_20201101__totaltraffic AS
SELECT sa.lcode,
       SUM(lflux) as sum_traffic
FROM shenzhen_app_use_people_10month saupm
JOIN shenzhen_app_use_filtered sauf ON sauf.PHA_qui = saupm.PHA_qui
JOIN shenzhen_20201101_activePHA sa on sa.lcode = saupm.lcode
WHERE date = 20201101
GROUP BY sa.lcode

SELECT lcode, sum_traffic
FROM EachPHA_20201101__totaltraffic



DROP TABLE IF EXISTS EachPHA_20210501__totaltraffic;
CREATE TABLE EachPHA_20210501__totaltraffic AS
SELECT sa.lcode,
       SUM(lflux) as sum_traffic
FROM shenzhen_app_use_people_10month saupm
JOIN shenzhen_app_use_filtered sauf ON sauf.PHA_qui = saupm.PHA_qui
JOIN shenzhen_20210501_activePHA sa on sa.lcode = saupm.lcode
WHERE date = 20210501
GROUP BY sa.lcode

SELECT lcode, sum_traffic
FROM EachPHA_20210501__totaltraffic

DROP TABLE IF EXISTS EachPHA_20211101__totaltraffic;
CREATE TABLE EachPHA_20211101__totaltraffic AS
SELECT sa.lcode,
       SUM(lflux) as sum_traffic
FROM shenzhen_app_use_people_10month saupm
JOIN shenzhen_app_use_filtered sauf ON sauf.PHA_qui = saupm.PHA_qui
JOIN shenzhen_20211101_activePHA sa on sa.lcode = saupm.lcode
WHERE date = 20211101
GROUP BY sa.lcode

SELECT lcode, sum_traffic
FROM EachPHA_20211101__totaltraffic


DROP TABLE IF EXISTS EachPHA_20220501__totaltraffic;
CREATE TABLE EachPHA_20220501__totaltraffic AS
SELECT sa.lcode,
       SUM(lflux) as sum_traffic
FROM shenzhen_app_use_people_10month saupm
JOIN shenzhen_app_use_filtered sauf ON sauf.PHA_qui = saupm.PHA_qui
JOIN shenzhen_20220501_activePHA sa on sa.lcode = saupm.lcode
WHERE date = 20220501
GROUP BY sa.lcode

SELECT lcode, sum_traffic
FROM EachPHA_20220501__totaltraffic

DROP TABLE IF EXISTS EachPHA_20221101__totaltraffic;
CREATE TABLE EachPHA_20221101__totaltraffic AS
SELECT sa.lcode,
       SUM(lflux) as sum_traffic
FROM shenzhen_app_use_people_10month saupm
JOIN shenzhen_app_use_filtered sauf ON sauf.PHA_qui = saupm.PHA_qui
JOIN shenzhen_20221101_activePHA sa on sa.lcode = saupm.lcode
WHERE date = 20221101
GROUP BY sa.lcode

SELECT lcode, sum_traffic
FROM EachPHA_20221101__totaltraffic


DROP TABLE IF EXISTS EachPHA_20230501__totaltraffic;
CREATE TABLE EachPHA_20230501__totaltraffic AS
SELECT sa.lcode,
       SUM(lflux) as sum_traffic
FROM shenzhen_app_use_people_10month saupm
JOIN shenzhen_app_use_filtered sauf ON sauf.PHA_qui = saupm.PHA_qui
JOIN shenzhen_20230501_activePHA sa on sa.lcode = saupm.lcode
WHERE date = 20230501
GROUP BY sa.lcode

SELECT lcode, sum_traffic
FROM EachPHA_20230501__totaltraffic

DROP TABLE IF EXISTS EachPHA_20231101__totaltraffic;
CREATE TABLE EachPHA_20231101__totaltraffic AS
SELECT sa.lcode,
       SUM(lflux) as sum_traffic
FROM shenzhen_app_use_people_10month saupm
JOIN shenzhen_app_use_filtered sauf ON sauf.PHA_qui = saupm.PHA_qui
JOIN shenzhen_20231101_activePHA sa on sa.lcode = saupm.lcode
WHERE date = 20231101
GROUP BY sa.lcode

SELECT lcode, sum_traffic
FROM EachPHA_20231101__totaltraffic




-- 只看original user使用origina pha的traffic


DROP TABLE IF EXISTS originalPHA_orignialuser_20190501__totaltraffic;
CREATE TABLE originalPHA_orignialuser_20190501__totaltraffic AS
SELECT sa.lcode,
       SUM(lflux) as sum_traffic
FROM shenzhen_app_use_people_10month saupm
JOIN originalPHA_user ou ON ou.PHA_qui = saupm.PHA_qui
JOIN shenzhen_20190501_activePHA sa on sa.lcode = saupm.lcode
WHERE date = 20190501
GROUP BY sa.lcode

SELECT lcode,sum_traffic
FROM originalPHA_orignialuser_20190501__totaltraffic

DROP TABLE IF EXISTS originalPHA_orignialuser_20191101__totaltraffic;
CREATE TABLE originalPHA_orignialuser_20191101__totaltraffic AS
SELECT sa.lcode,
       SUM(lflux) as sum_traffic
FROM shenzhen_app_use_people_10month saupm
JOIN originalPHA_user ou ON ou.PHA_qui = saupm.PHA_qui
JOIN shenzhen_20190501_activePHA sa on sa.lcode = saupm.lcode
WHERE date = 20191101
GROUP BY sa.lcode

SELECT lcode,sum_traffic
FROM originalPHA_orignialuser_20191101__totaltraffic

DROP TABLE IF EXISTS originalPHA_orignialuser_20200501__totaltraffic;
CREATE TABLE originalPHA_orignialuser_20200501__totaltraffic AS
SELECT sa.lcode,
       SUM(lflux) as sum_traffic
FROM shenzhen_app_use_people_10month saupm
JOIN originalPHA_user ou ON ou.PHA_qui = saupm.PHA_qui
JOIN shenzhen_20190501_activePHA sa on sa.lcode = saupm.lcode
WHERE date = 20200501
GROUP BY sa.lcode

SELECT lcode,sum_traffic
FROM originalPHA_orignialuser_20200501__totaltraffic

DROP TABLE IF EXISTS originalPHA_orignialuser_20201101__totaltraffic;
CREATE TABLE originalPHA_orignialuser_20201101__totaltraffic AS
SELECT sa.lcode,
       SUM(lflux) as sum_traffic
FROM shenzhen_app_use_people_10month saupm
JOIN originalPHA_user ou ON ou.PHA_qui = saupm.PHA_qui
JOIN shenzhen_20190501_activePHA sa on sa.lcode = saupm.lcode
WHERE date = 20201101
GROUP BY sa.lcode

SELECT lcode,sum_traffic
FROM originalPHA_orignialuser_20201101__totaltraffic

DROP TABLE IF EXISTS originalPHA_orignialuser_20210501__totaltraffic;
CREATE TABLE originalPHA_orignialuser_20210501__totaltraffic AS
SELECT sa.lcode,
       SUM(lflux) as sum_traffic
FROM shenzhen_app_use_people_10month saupm
JOIN originalPHA_user ou ON ou.PHA_qui = saupm.PHA_qui
JOIN shenzhen_20190501_activePHA sa on sa.lcode = saupm.lcode
WHERE date = 20210501
GROUP BY sa.lcode

SELECT lcode,sum_traffic
FROM originalPHA_orignialuser_20210501__totaltraffic

DROP TABLE IF EXISTS originalPHA_orignialuser_20211101__totaltraffic;
CREATE TABLE originalPHA_orignialuser_20211101__totaltraffic AS
SELECT sa.lcode,
       SUM(lflux) as sum_traffic
FROM shenzhen_app_use_people_10month saupm
JOIN originalPHA_user ou ON ou.PHA_qui = saupm.PHA_qui
JOIN shenzhen_20190501_activePHA sa on sa.lcode = saupm.lcode
WHERE date = 20211101
GROUP BY sa.lcode

SELECT lcode,sum_traffic
FROM originalPHA_orignialuser_20211101__totaltraffic


DROP TABLE IF EXISTS originalPHA_orignialuser_20220501__totaltraffic;
CREATE TABLE originalPHA_orignialuser_20220501__totaltraffic AS
SELECT sa.lcode,
       SUM(lflux) as sum_traffic
FROM shenzhen_app_use_people_10month saupm
JOIN originalPHA_user ou ON ou.PHA_qui = saupm.PHA_qui
JOIN shenzhen_20190501_activePHA sa on sa.lcode = saupm.lcode
WHERE date = 20220501
GROUP BY sa.lcode

SELECT lcode,sum_traffic
FROM originalPHA_orignialuser_20220501__totaltraffic

DROP TABLE IF EXISTS originalPHA_orignialuser_20221101__totaltraffic;
CREATE TABLE originalPHA_orignialuser_20221101__totaltraffic AS
SELECT sa.lcode,
       SUM(lflux) as sum_traffic
FROM shenzhen_app_use_people_10month saupm
JOIN originalPHA_user ou ON ou.PHA_qui = saupm.PHA_qui
JOIN shenzhen_20190501_activePHA sa on sa.lcode = saupm.lcode
WHERE date = 20221101
GROUP BY sa.lcode

SELECT lcode,sum_traffic
FROM originalPHA_orignialuser_20221101__totaltraffic

DROP TABLE IF EXISTS originalPHA_orignialuser_20230501__totaltraffic;
CREATE TABLE originalPHA_orignialuser_20230501__totaltraffic AS
SELECT sa.lcode,
       SUM(lflux) as sum_traffic
FROM shenzhen_app_use_people_10month saupm
JOIN originalPHA_user ou ON ou.PHA_qui = saupm.PHA_qui
JOIN shenzhen_20190501_activePHA sa on sa.lcode = saupm.lcode
WHERE date = 20230501
GROUP BY sa.lcode

SELECT lcode,sum_traffic
FROM originalPHA_orignialuser_20230501__totaltraffic

DROP TABLE IF EXISTS originalPHA_orignialuser_20231101__totaltraffic;
CREATE TABLE originalPHA_orignialuser_20231101__totaltraffic AS
SELECT sa.lcode,
       SUM(lflux) as sum_traffic
FROM shenzhen_app_use_people_10month saupm
JOIN originalPHA_user ou ON ou.PHA_qui = saupm.PHA_qui
JOIN shenzhen_20190501_activePHA sa on sa.lcode = saupm.lcode
WHERE date = 20231101
GROUP BY sa.lcode

SELECT lcode,sum_traffic
FROM originalPHA_orignialuser_20231101__totaltraffic



-- shenzhen_app_use_filtered 567101人 是满足所有筛选条件的
-- shenzhen_app_use_people_10month 每个人每个时间点用的app traffic&time
-- shenzhen_people_filtered join demographic用



-- Traffic
-- 算每个人每个时间点的总数/均值 分别都算一下

-- 每个人每个时间点使用的traffic总量
DROP TABLE IF EXISTS shenzhen_totaltraffic_use_10month;
CREATE TABLE shenzhen_totaltraffic_use_10month AS
SELECT saupm.pha_qui,
       date,
       sum(lflux) as sum_traffic
FROM shenzhen_app_use_people_10month saupm
JOIN shenzhen_app_use_filtered sauf ON sauf.PHA_qui = saupm.PHA_qui
WHERE saupm.date IN (20190501, 20191101, 20200501, 20201101, 20210501, 20211101, 20220501, 20221101, 20230501, 20231101)
GROUP BY saupm.pha_qui, date

-- describe each month
DROP TABLE IF EXISTS    ;
CREATE TABLE shenzhen_totaltraffic_use_eachmonth AS
SELECT date,
       sum(sum_traffic) as traffic_eachmonth
FROM shenzhen_totaltraffic_use_10month
GROUP BY date

SELECT date, traffic_eachmonth
FROM shenzhen_totaltraffic_use_eachmonth

-- 每个时间点的traffic均值
-- describe each month
DROP TABLE IF EXISTS shenzhen_avgtraffic_use_eachmonth;
CREATE TABLE shenzhen_avgtraffic_use_eachmonth AS
SELECT date,
       AVG(sum_traffic) as avgtraffic_eachmonth
FROM shenzhen_totaltraffic_use_10month
GROUP BY date

SELECT date, avgtraffic_eachmonth
FROM shenzhen_avgtraffic_use_eachmonth

--  Q：为什么20210501traffic使用量巨大

DROP TABLE IF EXISTS a20201101;
CREATE TABLE a20201101 AS
SELECT saupm.pha_qui,
       date,
       sum(lflux) as sumtraffic
FROM shenzhen_app_use_people_10month saupm
JOIN shenzhen_app_use_filtered sauf ON sauf.PHA_qui = saupm.PHA_qui
WHERE saupm.date = 20201101
Group by saupm.pha_qui, date
ORDER BY sumtraffic DESC

SELECT pha_qui, date, sumtraffic
from a20201101
LIMIT 100

DROP TABLE IF EXISTS a20210501;
CREATE TABLE a20210501 AS
SELECT saupm.pha_qui,
       date,
       sum(lflux) as sumtraffic
FROM shenzhen_app_use_people_10month saupm
JOIN shenzhen_app_use_filtered sauf ON sauf.PHA_qui = saupm.PHA_qui
WHERE saupm.date = 20210501
Group by saupm.pha_qui, date
ORDER BY sumtraffic DESC

SELECT pha_qui, date, sumtraffic
from a20210501
LIMIT 100


-- Time 思路同上
-- 每个人每个时间点使用的time总量
DROP TABLE IF EXISTS shenzhen_totaltime_use_10month;
CREATE TABLE shenzhen_totaltime_use_10month AS
SELECT saupm.pha_qui,
       date,
       sum(ltime) as sum_time
FROM shenzhen_app_use_people_10month saupm
JOIN shenzhen_app_use_filtered sauf ON sauf.PHA_qui = saupm.PHA_qui
WHERE saupm.date IN (20190501, 20191101, 20200501, 20201101, 20210501, 20211101, 20220501, 20221101, 20230501, 20231101)
GROUP BY saupm.pha_qui, date

-- describe each month
DROP TABLE IF EXISTS shenzhen_totaltime_use_eachmonth;
CREATE TABLE shenzhen_totaltime_use_eachmonth AS
SELECT date,
       sum(sum_time) as time_eachmonth
FROM shenzhen_totaltime_use_10month
GROUP BY date

SELECT date, time_eachmonth
FROM shenzhen_totaltime_use_eachmonth

-- 每个人每个时间点的time均值
-- describe each month
DROP TABLE IF EXISTS shenzhen_avgtime_use_eachmonth;
CREATE TABLE shenzhen_avgtime_use_eachmonth AS
SELECT date,
       AVG(sum_time) as avgtime_eachmonth
FROM shenzhen_totaltime_use_10month
GROUP BY date

SELECT date, avgtime_eachmonth
FROM shenzhen_avgtime_use_eachmonth




-- 所有APP 每个时间点的traffic总量
DROP TABLE IF EXISTS shenzhen_totaltraffic_use_10month_allAPP;
CREATE TABLE shenzhen_totaltraffic_use_10month_allAPP AS
SELECT saupm.pha_qui,
       lcode,
       date,
       sum(lflux) as sum_traffic
FROM shenzhen_app_use_people_10month saupm
JOIN shenzhen_app_use_filtered sauf ON sauf.PHA_qui = saupm.PHA_qui
WHERE saupm.date IN (20190501, 20191101, 20200501, 20201101, 20210501, 20211101, 20220501, 20221101, 20230501, 20231101)
GROUP BY saupm.pha_qui, date, lcode


-- describe each month
DROP TABLE IF EXISTS shenzhen_totaltraffic_use_eachmonth_allAPP;
CREATE TABLE shenzhen_totaltraffic_use_eachmonth_allAPP AS
SELECT lcode,
       date,
       sum(sum_traffic) as traffic_eachmonth
FROM shenzhen_totaltraffic_use_10month_allAPP
GROUP BY lcode, date

SELECT lcode, date, traffic_eachmonth
FROM shenzhen_totaltraffic_use_eachmonth_allAPP


-- 每个时间点的traffic均值
-- describe each month
DROP TABLE IF EXISTS shenzhen_avgtraffic_use_eachmonth_allAPP;
CREATE TABLE shenzhen_avgtraffic_use_eachmonth_allAPP AS
SELECT date,
       lcode,
       AVG(sum_traffic) as avgtraffic_eachmonth
FROM shenzhen_totaltraffic_use_10month_allAPP
GROUP BY lcode, date

SELECT lcode, date, avgtraffic_eachmonth
FROM shenzhen_avgtraffic_use_eachmonth_allAPP


-- Time
DROP TABLE IF EXISTS shenzhen_totaltime_use_10month_allAPP;
CREATE TABLE shenzhen_totaltime_use_10month_allAPP AS
SELECT saupm.pha_qui,
       date,
       lcode,
       sum(ltime) as sum_time
FROM shenzhen_app_use_people_10month saupm
JOIN shenzhen_app_use_filtered sauf ON sauf.PHA_qui = saupm.PHA_qui
WHERE saupm.date IN (20190501, 20191101, 20200501, 20201101, 20210501, 20211101, 20220501, 20221101, 20230501, 20231101)
GROUP BY saupm.pha_qui, date, lcode

-- describe each month
DROP TABLE IF EXISTS shenzhen_totaltime_use_eachmonth_allAPP;
CREATE TABLE shenzhen_totaltime_use_eachmonth_allAPP AS
SELECT lcode,
       date,
       sum(sum_time) as time_eachmonth
FROM shenzhen_totaltime_use_10month_allAPP
GROUP BY lcode, date

SELECT lcode, date, time_eachmonth
FROM shenzhen_totaltime_use_eachmonth_allAPP

-- 每个人每个时间点的time均值
-- describe each month
DROP TABLE IF EXISTS shenzhen_avgtime_use_eachmonth_allAPP;
CREATE TABLE shenzhen_avgtime_use_eachmonth_allAPP AS
SELECT lcode, 
       date,
       AVG(sum_time) as avgtime_eachmonth
FROM shenzhen_totaltime_use_10month_allAPP
GROUP BY lcode, date

SELECT lcode, date, avgtime_eachmonth
FROM shenzhen_avgtime_use_eachmonth_allAPP






