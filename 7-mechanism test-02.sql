-- find user num & user demographics for each PHA(398 in total) at each timepoint


-- PHA created at 20191101
-- user_num
SELECT pha,
       date,
       COUNT(*) as user_num
FROM shenzhen_app_use_people_10month saupm
JOIN shenzhen_app_use_filtered sauf ON sauf.PHA_qui = saupm.PHA_qui
JOIN newlycreatedPHA ncp ON ncp.pha = saupm.lcode
WHERE createdate = 20191101
AND saupm.date IN (20190501, 20191101, 20200501, 20201101, 20210501, 20211101, 20220501, 20221101, 20230501, 20231101)
GROUP BY pha, saupm.date

-- user_demographics
SELECT pha,
       saupm.date,
       gender,
       COUNT(*) as user_num
FROM shenzhen_app_use_people_10month saupm
JOIN shenzhen_app_use_filtered sauf ON sauf.PHA_qui = saupm.PHA_qui
JOIN newlycreatedPHA ncp ON ncp.pha = saupm.lcode
JOIN shenzhen_people_filtered spf on spf.PHA_qui = saupm.PHA_qui
WHERE createdate = 20191101
AND saupm.date IN (20190501, 20191101, 20200501, 20201101, 20210501, 20211101, 20220501, 20221101, 20230501, 20231101)
GROUP BY pha, saupm.date, gender

SELECT pha,
       saupm.date,
       age,
       COUNT(*) as user_num
FROM shenzhen_app_use_people_10month saupm
JOIN shenzhen_app_use_filtered sauf ON sauf.PHA_qui = saupm.PHA_qui
JOIN newlycreatedPHA ncp ON ncp.pha = saupm.lcode
JOIN shenzhen_people_filtered spf on spf.PHA_qui = saupm.PHA_qui
WHERE createdate = 20191101
AND saupm.date IN (20190501, 20191101, 20200501, 20201101, 20210501, 20211101, 20220501, 20221101, 20230501, 20231101)
GROUP BY pha, saupm.date, age

DROP TABLE IF EXISTS eachPHA_dethemographics_created20191101_cell;
CREATE TABLE eachPHA_demographics_created20191101_cell AS
SELECT pha,
       saupm.date,
       brand,
       type,
       COUNT(*) as user_num
FROM shenzhen_app_use_people_10month saupm
JOIN shenzhen_app_use_filtered sauf ON sauf.PHA_qui = saupm.PHA_qui
JOIN newlycreatedPHA ncp ON ncp.pha = saupm.lcode
JOIN shenzhen_people_filtered spf on spf.PHA_qui = saupm.PHA_qui
WHERE createdate = 20191101
AND saupm.date IN (20190501, 20191101, 20200501, 20201101, 20210501, 20211101, 20220501, 20221101, 20230501, 20231101)
GROUP BY pha, saupm.date, brand, type



SELECT pha,
       date,
       concat_ws(',',
          coalesce(user_num, '?'),
          coalesce(cast(brand as string), '?'),
          coalesce(date, '?'),
          coalesce(cast(type as string), '?'),
          coalesce(date, '?')
          ) as combine,
      user_num
FROM eachPHA_demographics_created20191101_cell




-- 20200501
-- user_num1 拆成两份看num
SELECT pha,
       date,
       COUNT(*) as user_num
FROM shenzhen_app_use_people_10month saupm
JOIN shenzhen_app_use_filtered sauf ON sauf.PHA_qui = saupm.PHA_qui
JOIN newlycreatedPHA ncp ON ncp.pha = saupm.lcode
WHERE createdate = 20200501
AND saupm.date IN (20190501, 20191101, 20200501, 20201101, 20210501)
GROUP BY pha, saupm.date

-- user_num2
SELECT pha,
       date,
       COUNT(*) as user_num
FROM shenzhen_app_use_people_10month saupm
JOIN shenzhen_app_use_filtered sauf ON sauf.PHA_qui = saupm.PHA_qui
JOIN newlycreatedPHA ncp ON ncp.pha = saupm.lcode
WHERE createdate = 20200501
AND saupm.date IN (20211101, 20220501, 20221101, 20230501, 20231101)
GROUP BY pha, saupm.date

-- user_demographics
-- gender拆成3个
SELECT pha,
       saupm.date,
       gender,
       COUNT(*) as user_num
FROM shenzhen_app_use_people_10month saupm
JOIN shenzhen_app_use_filtered sauf ON sauf.PHA_qui = saupm.PHA_qui
JOIN newlycreatedPHA ncp ON ncp.pha = saupm.lcode
JOIN shenzhen_people_filtered spf on spf.PHA_qui = saupm.PHA_qui
WHERE createdate = 20200501
AND saupm.date IN (20190501, 20191101, 20200501, 20201101)
GROUP BY pha, saupm.date, gender

-- gender2
SELECT pha,
       saupm.date,
       gender,
       COUNT(*) as user_num
FROM shenzhen_app_use_people_10month saupm
JOIN shenzhen_app_use_filtered sauf ON sauf.PHA_qui = saupm.PHA_qui
JOIN newlycreatedPHA ncp ON ncp.pha = saupm.lcode
JOIN shenzhen_people_filtered spf on spf.PHA_qui = saupm.PHA_qui
WHERE createdate = 20200501
AND saupm.date IN (20210501, 20211101, 20220501)
GROUP BY pha, saupm.date, gender

-- gender3
SELECT pha,
       saupm.date,
       gender,
       COUNT(*) as user_num
FROM shenzhen_app_use_people_10month saupm
JOIN shenzhen_app_use_filtered sauf ON sauf.PHA_qui = saupm.PHA_qui
JOIN newlycreatedPHA ncp ON ncp.pha = saupm.lcode
JOIN shenzhen_people_filtered spf on spf.PHA_qui = saupm.PHA_qui
WHERE createdate = 20200501
AND saupm.date IN (20221101, 20230501, 20231101)
GROUP BY pha, saupm.date, gender


-- age 拆成10个
SELECT pha,
       saupm.date,
       age,
       COUNT(*) as user_num
FROM shenzhen_app_use_people_10month saupm
JOIN shenzhen_app_use_filtered sauf ON sauf.PHA_qui = saupm.PHA_qui
JOIN newlycreatedPHA ncp ON ncp.pha = saupm.lcode
JOIN shenzhen_people_filtered spf on spf.PHA_qui = saupm.PHA_qui
WHERE createdate = 20200501
AND saupm.date = 20190501
GROUP BY pha, saupm.date, age

-- age2
SELECT pha,
       saupm.date,
       age,
       COUNT(*) as user_num
FROM shenzhen_app_use_people_10month saupm
JOIN shenzhen_app_use_filtered sauf ON sauf.PHA_qui = saupm.PHA_qui
JOIN newlycreatedPHA ncp ON ncp.pha = saupm.lcode
JOIN shenzhen_people_filtered spf on spf.PHA_qui = saupm.PHA_qui
WHERE createdate = 20200501
AND saupm.date = 20191101
GROUP BY pha, saupm.date, age

-- age3
SELECT pha,
       saupm.date,
       age,
       COUNT(*) as user_num
FROM shenzhen_app_use_people_10month saupm
JOIN shenzhen_app_use_filtered sauf ON sauf.PHA_qui = saupm.PHA_qui
JOIN newlycreatedPHA ncp ON ncp.pha = saupm.lcode
JOIN shenzhen_people_filtered spf on spf.PHA_qui = saupm.PHA_qui
WHERE createdate = 20200501
AND saupm.date = 20200501
GROUP BY pha, saupm.date, age

-- age4
SELECT pha,
       saupm.date,
       age,
       COUNT(*) as user_num
FROM shenzhen_app_use_people_10month saupm
JOIN shenzhen_app_use_filtered sauf ON sauf.PHA_qui = saupm.PHA_qui
JOIN newlycreatedPHA ncp ON ncp.pha = saupm.lcode
JOIN shenzhen_people_filtered spf on spf.PHA_qui = saupm.PHA_qui
WHERE createdate = 20200501
AND saupm.date = 20201101
GROUP BY pha, saupm.date, age

-- age5
SELECT pha,
       saupm.date,
       age,
       COUNT(*) as user_num
FROM shenzhen_app_use_people_10month saupm
JOIN shenzhen_app_use_filtered sauf ON sauf.PHA_qui = saupm.PHA_qui
JOIN newlycreatedPHA ncp ON ncp.pha = saupm.lcode
JOIN shenzhen_people_filtered spf on spf.PHA_qui = saupm.PHA_qui
WHERE createdate = 20200501
AND saupm.date = 20210501
GROUP BY pha, saupm.date, age


-- age6
SELECT pha,
       saupm.date,
       age,
       COUNT(*) as user_num
FROM shenzhen_app_use_people_10month saupm
JOIN shenzhen_app_use_filtered sauf ON sauf.PHA_qui = saupm.PHA_qui
JOIN newlycreatedPHA ncp ON ncp.pha = saupm.lcode
JOIN shenzhen_people_filtered spf on spf.PHA_qui = saupm.PHA_qui
WHERE createdate = 20200501
AND saupm.date = 20211101
GROUP BY pha, saupm.date, age

-- age7
SELECT pha,
       saupm.date,
       age,
       COUNT(*) as user_num
FROM shenzhen_app_use_people_10month saupm
JOIN shenzhen_app_use_filtered sauf ON sauf.PHA_qui = saupm.PHA_qui
JOIN newlycreatedPHA ncp ON ncp.pha = saupm.lcode
JOIN shenzhen_people_filtered spf on spf.PHA_qui = saupm.PHA_qui
WHERE createdate = 20200501
AND saupm.date = 20220501
GROUP BY pha, saupm.date, age


-- age8
SELECT pha,
       saupm.date,
       age,
       COUNT(*) as user_num
FROM shenzhen_app_use_people_10month saupm
JOIN shenzhen_app_use_filtered sauf ON sauf.PHA_qui = saupm.PHA_qui
JOIN newlycreatedPHA ncp ON ncp.pha = saupm.lcode
JOIN shenzhen_people_filtered spf on spf.PHA_qui = saupm.PHA_qui
WHERE createdate = 20200501
AND saupm.date = 20221101
GROUP BY pha, saupm.date, age

-- age9
SELECT pha,
       saupm.date,
       age,
       COUNT(*) as user_num
FROM shenzhen_app_use_people_10month saupm
JOIN shenzhen_app_use_filtered sauf ON sauf.PHA_qui = saupm.PHA_qui
JOIN newlycreatedPHA ncp ON ncp.pha = saupm.lcode
JOIN shenzhen_people_filtered spf on spf.PHA_qui = saupm.PHA_qui
WHERE createdate = 20200501
AND saupm.date = 20230501
GROUP BY pha, saupm.date, age

-- age10
SELECT pha,
       saupm.date,
       age,
       COUNT(*) as user_num
FROM shenzhen_app_use_people_10month saupm
JOIN shenzhen_app_use_filtered sauf ON sauf.PHA_qui = saupm.PHA_qui
JOIN newlycreatedPHA ncp ON ncp.pha = saupm.lcode
JOIN shenzhen_people_filtered spf on spf.PHA_qui = saupm.PHA_qui
WHERE createdate = 20200501
AND saupm.date = 20231101
GROUP BY pha, saupm.date, age





-- 20201101
-- user_num1 拆成两份看num
SELECT pha,
       date,
       COUNT(*) as user_num
FROM shenzhen_app_use_people_10month saupm
JOIN shenzhen_app_use_filtered sauf ON sauf.PHA_qui = saupm.PHA_qui
JOIN newlycreatedPHA ncp ON ncp.pha = saupm.lcode
WHERE createdate = 20201101
AND saupm.date IN (20190501, 20191101, 20200501, 20201101, 20210501)
GROUP BY pha, saupm.date

-- user_num2
SELECT pha,
       date,
       COUNT(*) as user_num
FROM shenzhen_app_use_people_10month saupm
JOIN shenzhen_app_use_filtered sauf ON sauf.PHA_qui = saupm.PHA_qui
JOIN newlycreatedPHA ncp ON ncp.pha = saupm.lcode
WHERE createdate = 20201101
AND saupm.date IN (20211101, 20220501, 20221101, 20230501, 20231101)
GROUP BY pha, saupm.date

-- user_demographics
-- gender拆成3个
SELECT pha,
       saupm.date,
       gender,
       COUNT(*) as user_num
FROM shenzhen_app_use_people_10month saupm
JOIN shenzhen_app_use_filtered sauf ON sauf.PHA_qui = saupm.PHA_qui
JOIN newlycreatedPHA ncp ON ncp.pha = saupm.lcode
JOIN shenzhen_people_filtered spf on spf.PHA_qui = saupm.PHA_qui
WHERE createdate = 20201101
AND saupm.date IN (20190501, 20191101, 20200501, 20201101)
GROUP BY pha, saupm.date, gender

-- gender2
SELECT pha,
       saupm.date,
       gender,
       COUNT(*) as user_num
FROM shenzhen_app_use_people_10month saupm
JOIN shenzhen_app_use_filtered sauf ON sauf.PHA_qui = saupm.PHA_qui
JOIN newlycreatedPHA ncp ON ncp.pha = saupm.lcode
JOIN shenzhen_people_filtered spf on spf.PHA_qui = saupm.PHA_qui
WHERE createdate = 20201101
AND saupm.date IN (20210501, 20211101, 20220501)
GROUP BY pha, saupm.date, gender

-- gender3
SELECT pha,
       saupm.date,
       gender,
       COUNT(*) as user_num
FROM shenzhen_app_use_people_10month saupm
JOIN shenzhen_app_use_filtered sauf ON sauf.PHA_qui = saupm.PHA_qui
JOIN newlycreatedPHA ncp ON ncp.pha = saupm.lcode
JOIN shenzhen_people_filtered spf on spf.PHA_qui = saupm.PHA_qui
WHERE createdate = 20201101
AND saupm.date IN (20221101, 20230501, 20231101)
GROUP BY pha, saupm.date, gender


-- age 拆成4个
SELECT pha,
       saupm.date,
       age,
       COUNT(*) as user_num
FROM shenzhen_app_use_people_10month saupm
JOIN shenzhen_app_use_filtered sauf ON sauf.PHA_qui = saupm.PHA_qui
JOIN newlycreatedPHA ncp ON ncp.pha = saupm.lcode
JOIN shenzhen_people_filtered spf on spf.PHA_qui = saupm.PHA_qui
WHERE createdate = 20200501
AND saupm.date IN (20190501, 20191101)
GROUP BY pha, saupm.date, age

-- age2
SELECT pha,
       saupm.date,
       age,
       COUNT(*) as user_num
FROM shenzhen_app_use_people_10month saupm
JOIN shenzhen_app_use_filtered sauf ON sauf.PHA_qui = saupm.PHA_qui
JOIN newlycreatedPHA ncp ON ncp.pha = saupm.lcode
JOIN shenzhen_people_filtered spf on spf.PHA_qui = saupm.PHA_qui
WHERE createdate = 20200501
AND saupm.date IN (20200501, 20201101)
GROUP BY pha, saupm.date, age

-- age3
SELECT pha,
       saupm.date,
       age,
       COUNT(*) as user_num
FROM shenzhen_app_use_people_10month saupm
JOIN shenzhen_app_use_filtered sauf ON sauf.PHA_qui = saupm.PHA_qui
JOIN newlycreatedPHA ncp ON ncp.pha = saupm.lcode
JOIN shenzhen_people_filtered spf on spf.PHA_qui = saupm.PHA_qui
WHERE createdate = 20200501
AND saupm.date IN (20210501,20211101, 20220501)
GROUP BY pha, saupm.date, age

-- age4
SELECT pha,
       saupm.date,
       age,
       COUNT(*) as user_num
FROM shenzhen_app_use_people_10month saupm
JOIN shenzhen_app_use_filtered sauf ON sauf.PHA_qui = saupm.PHA_qui
JOIN newlycreatedPHA ncp ON ncp.pha = saupm.lcode
JOIN shenzhen_people_filtered spf on spf.PHA_qui = saupm.PHA_qui
WHERE createdate = 20200501
AND saupm.date IN (20221101, 20230501, 20231101)
GROUP BY pha, saupm.date, age




-- 20210501
-- user_num1 拆成两份看num
SELECT pha,
       date,
       COUNT(*) as user_num
FROM shenzhen_app_use_people_10month saupm
JOIN shenzhen_app_use_filtered sauf ON sauf.PHA_qui = saupm.PHA_qui
JOIN newlycreatedPHA ncp ON ncp.pha = saupm.lcode
WHERE createdate = 20210501
AND saupm.date IN (20190501, 20191101, 20200501, 20201101, 20210501)
GROUP BY pha, saupm.date

-- user_num2
SELECT pha,
       date,
       COUNT(*) as user_num
FROM shenzhen_app_use_people_10month saupm
JOIN shenzhen_app_use_filtered sauf ON sauf.PHA_qui = saupm.PHA_qui
JOIN newlycreatedPHA ncp ON ncp.pha = saupm.lcode
WHERE createdate = 20210501
AND saupm.date IN (20211101, 20220501, 20221101, 20230501, 20231101)
GROUP BY pha, saupm.date

-- user_demographics
-- gender拆成3个
SELECT pha,
       saupm.date,
       gender,
       COUNT(*) as user_num
FROM shenzhen_app_use_people_10month saupm
JOIN shenzhen_app_use_filtered sauf ON sauf.PHA_qui = saupm.PHA_qui
JOIN newlycreatedPHA ncp ON ncp.pha = saupm.lcode
JOIN shenzhen_people_filtered spf on spf.PHA_qui = saupm.PHA_qui
WHERE createdate = 20210501
AND saupm.date IN (20190501, 20191101, 20200501, 20201101)
GROUP BY pha, saupm.date, gender

-- gender2
SELECT pha,
       saupm.date,
       gender,
       COUNT(*) as user_num
FROM shenzhen_app_use_people_10month saupm
JOIN shenzhen_app_use_filtered sauf ON sauf.PHA_qui = saupm.PHA_qui
JOIN newlycreatedPHA ncp ON ncp.pha = saupm.lcode
JOIN shenzhen_people_filtered spf on spf.PHA_qui = saupm.PHA_qui
WHERE createdate = 20210501
AND saupm.date IN (20210501, 20211101, 20220501)
GROUP BY pha, saupm.date, gender

-- gender3
SELECT pha,
       saupm.date,
       gender,
       COUNT(*) as user_num
FROM shenzhen_app_use_people_10month saupm
JOIN shenzhen_app_use_filtered sauf ON sauf.PHA_qui = saupm.PHA_qui
JOIN newlycreatedPHA ncp ON ncp.pha = saupm.lcode
JOIN shenzhen_people_filtered spf on spf.PHA_qui = saupm.PHA_qui
WHERE createdate = 20210501
AND saupm.date IN (20221101, 20230501, 20231101)
GROUP BY pha, saupm.date, gender


-- age 拆成5个
SELECT pha,
       saupm.date,
       age,
       COUNT(*) as user_num
FROM shenzhen_app_use_people_10month saupm
JOIN shenzhen_app_use_filtered sauf ON sauf.PHA_qui = saupm.PHA_qui
JOIN newlycreatedPHA ncp ON ncp.pha = saupm.lcode
JOIN shenzhen_people_filtered spf on spf.PHA_qui = saupm.PHA_qui
WHERE createdate = 20210501
AND saupm.date IN (20190501, 20191101)
GROUP BY pha, saupm.date, age

-- age2
SELECT pha,
       saupm.date,
       age,
       COUNT(*) as user_num
FROM shenzhen_app_use_people_10month saupm
JOIN shenzhen_app_use_filtered sauf ON sauf.PHA_qui = saupm.PHA_qui
JOIN newlycreatedPHA ncp ON ncp.pha = saupm.lcode
JOIN shenzhen_people_filtered spf on spf.PHA_qui = saupm.PHA_qui
WHERE createdate = 20210501
AND saupm.date IN (20200501, 20201101)
GROUP BY pha, saupm.date, age

-- age3
SELECT pha,
       saupm.date,
       age,
       COUNT(*) as user_num
FROM shenzhen_app_use_people_10month saupm
JOIN shenzhen_app_use_filtered sauf ON sauf.PHA_qui = saupm.PHA_qui
JOIN newlycreatedPHA ncp ON ncp.pha = saupm.lcode
JOIN shenzhen_people_filtered spf on spf.PHA_qui = saupm.PHA_qui
WHERE createdate = 20210501
AND saupm.date IN (20210501,20211101)
GROUP BY pha, saupm.date, age

-- age4
SELECT pha,
       saupm.date,
       age,
       COUNT(*) as user_num
FROM shenzhen_app_use_people_10month saupm
JOIN shenzhen_app_use_filtered sauf ON sauf.PHA_qui = saupm.PHA_qui
JOIN newlycreatedPHA ncp ON ncp.pha = saupm.lcode
JOIN shenzhen_people_filtered spf on spf.PHA_qui = saupm.PHA_qui
WHERE createdate = 20210501
AND saupm.date IN (20220501, 20221101)
GROUP BY pha, saupm.date, age

-- age5
SELECT pha,
       saupm.date,
       age,
       COUNT(*) as user_num
FROM shenzhen_app_use_people_10month saupm
JOIN shenzhen_app_use_filtered sauf ON sauf.PHA_qui = saupm.PHA_qui
JOIN newlycreatedPHA ncp ON ncp.pha = saupm.lcode
JOIN shenzhen_people_filtered spf on spf.PHA_qui = saupm.PHA_qui
WHERE createdate = 20210501
AND saupm.date IN (20230501, 20231101)
GROUP BY pha, saupm.date, age



-- 20211101
-- user_num
SELECT pha,
       date,
       COUNT(*) as user_num
FROM shenzhen_app_use_people_10month saupm
JOIN shenzhen_app_use_filtered sauf ON sauf.PHA_qui = saupm.PHA_qui
JOIN newlycreatedPHA ncp ON ncp.pha = saupm.lcode
WHERE createdate = 20211101
AND saupm.date IN (20190501, 20191101, 20200501, 20201101, 20210501, 20211101, 20220501, 20221101, 20230501, 20231101)
GROUP BY pha, saupm.date

-- user_demographics
SELECT pha,
       saupm.date,
       gender,
       COUNT(*) as user_num
FROM shenzhen_app_use_people_10month saupm
JOIN shenzhen_app_use_filtered sauf ON sauf.PHA_qui = saupm.PHA_qui
JOIN newlycreatedPHA ncp ON ncp.pha = saupm.lcode
JOIN shenzhen_people_filtered spf on spf.PHA_qui = saupm.PHA_qui
WHERE createdate = 20211101
AND saupm.date IN (20190501, 20191101, 20200501, 20201101, 20210501, 20211101, 20220501, 20221101, 20230501, 20231101)
GROUP BY pha, saupm.date, gender

SELECT pha,
       saupm.date,
       age,
       COUNT(*) as user_num
FROM shenzhen_app_use_people_10month saupm
JOIN shenzhen_app_use_filtered sauf ON sauf.PHA_qui = saupm.PHA_qui
JOIN newlycreatedPHA ncp ON ncp.pha = saupm.lcode
JOIN shenzhen_people_filtered spf on spf.PHA_qui = saupm.PHA_qui
WHERE createdate = 20211101
AND saupm.date IN (20190501, 20191101, 20200501, 20201101, 20210501, 20211101, 20220501, 20221101, 20230501, 20231101)
GROUP BY pha, saupm.date, age

DROP TABLE IF EXISTS eachPHA_demographics_created20211101_cell;
CREATE TABLE eachPHA_demographics_created20211101_cell AS
SELECT pha,
       saupm.date,
       brand,
       type,
       COUNT(*) as user_num
FROM shenzhen_app_use_people_10month saupm
JOIN shenzhen_app_use_filtered sauf ON sauf.PHA_qui = saupm.PHA_qui
JOIN newlycreatedPHA ncp ON ncp.pha = saupm.lcode
JOIN shenzhen_people_filtered spf on spf.PHA_qui = saupm.PHA_qui
WHERE createdate = 20211101
AND saupm.date IN (20190501, 20191101, 20200501, 20201101, 20210501, 20211101, 20220501, 20221101, 20230501, 20231101)
GROUP BY pha, saupm.date, brand, type



SELECT pha,
       date,
       concat_ws(',',
          coalesce(user_num, '?'),
          coalesce(cast(brand as string), '?'),
          coalesce(date, '?'),
          coalesce(cast(type as string), '?'),
          coalesce(date, '?')
          ) as combine,
      user_num
FROM eachPHA_demographics_created20211101_cell



-- 20221101
-- user_num
SELECT pha,
       date,
       COUNT(*) as user_num
FROM shenzhen_app_use_people_10month saupm
JOIN shenzhen_app_use_filtered sauf ON sauf.PHA_qui = saupm.PHA_qui
JOIN newlycreatedPHA ncp ON ncp.pha = saupm.lcode
WHERE createdate = 20221101
AND saupm.date IN (20190501, 20191101, 20200501, 20201101, 20210501, 20211101, 20220501, 20221101, 20230501, 20231101)
GROUP BY pha, saupm.date

-- user_demographics
SELECT pha,
       saupm.date,
       gender,
       COUNT(*) as user_num
FROM shenzhen_app_use_people_10month saupm
JOIN shenzhen_app_use_filtered sauf ON sauf.PHA_qui = saupm.PHA_qui
JOIN newlycreatedPHA ncp ON ncp.pha = saupm.lcode
JOIN shenzhen_people_filtered spf on spf.PHA_qui = saupm.PHA_qui
WHERE createdate = 20221101
AND saupm.date IN (20190501, 20191101, 20200501, 20201101, 20210501, 20211101, 20220501, 20221101, 20230501, 20231101)
GROUP BY pha, saupm.date, gender

SELECT pha,
       saupm.date,
       age,
       COUNT(*) as user_num
FROM shenzhen_app_use_people_10month saupm
JOIN shenzhen_app_use_filtered sauf ON sauf.PHA_qui = saupm.PHA_qui
JOIN newlycreatedPHA ncp ON ncp.pha = saupm.lcode
JOIN shenzhen_people_filtered spf on spf.PHA_qui = saupm.PHA_qui
WHERE createdate = 20221101
AND saupm.date IN (20190501, 20191101, 20200501, 20201101, 20210501, 20211101, 20220501, 20221101, 20230501, 20231101)
GROUP BY pha, saupm.date, age

DROP TABLE IF EXISTS eachPHA_demographics_created20221101_cell;
CREATE TABLE eachPHA_demographics_created20221101_cell AS
SELECT pha,
       saupm.date,
       brand,
       type,
       COUNT(*) as user_num
FROM shenzhen_app_use_people_10month saupm
JOIN shenzhen_app_use_filtered sauf ON sauf.PHA_qui = saupm.PHA_qui
JOIN newlycreatedPHA ncp ON ncp.pha = saupm.lcode
JOIN shenzhen_people_filtered spf on spf.PHA_qui = saupm.PHA_qui
WHERE createdate = 20221101
AND saupm.date IN (20190501, 20191101, 20200501, 20201101, 20210501, 20211101, 20220501, 20221101, 20230501, 20231101)
GROUP BY pha, saupm.date, brand, type



SELECT pha,
       date,
       concat_ws(',',
          coalesce(user_num, '?'),
          coalesce(cast(brand as string), '?'),
          coalesce(date, '?'),
          coalesce(cast(type as string), '?'),
          coalesce(date, '?')
          ) as combine,
      user_num
FROM eachPHA_demographics_created20221101_cell


-- 20231101

-- user_num
SELECT pha,
       date,
       COUNT(*) as user_num
FROM shenzhen_app_use_people_10month saupm
JOIN shenzhen_app_use_filtered sauf ON sauf.PHA_qui = saupm.PHA_qui
JOIN newlycreatedPHA ncp ON ncp.pha = saupm.lcode
WHERE createdate = 20231101
AND saupm.date IN (20190501, 20191101, 20200501, 20201101, 20210501, 20211101, 20220501, 20221101, 20230501, 20231101)
GROUP BY pha, saupm.date

-- user_demographics
SELECT pha,
       saupm.date,
       gender,
       COUNT(*) as user_num
FROM shenzhen_app_use_people_10month saupm
JOIN shenzhen_app_use_filtered sauf ON sauf.PHA_qui = saupm.PHA_qui
JOIN newlycreatedPHA ncp ON ncp.pha = saupm.lcode
JOIN shenzhen_people_filtered spf on spf.PHA_qui = saupm.PHA_qui
WHERE createdate = 20231101
AND saupm.date IN (20190501, 20191101, 20200501, 20201101, 20210501, 20211101, 20220501, 20221101, 20230501, 20231101)
GROUP BY pha, saupm.date, gender

SELECT pha,
       saupm.date,
       age,
       COUNT(*) as user_num
FROM shenzhen_app_use_people_10month saupm
JOIN shenzhen_app_use_filtered sauf ON sauf.PHA_qui = saupm.PHA_qui
JOIN newlycreatedPHA ncp ON ncp.pha = saupm.lcode
JOIN shenzhen_people_filtered spf on spf.PHA_qui = saupm.PHA_qui
WHERE createdate = 20231101
AND saupm.date IN (20190501, 20191101, 20200501, 20201101, 20210501, 20211101, 20220501, 20221101, 20230501, 20231101)
GROUP BY pha, saupm.date, age

DROP TABLE IF EXISTS eachPHA_demographics_created20231101_cell;
CREATE TABLE eachPHA_demographics_created20231101_cell AS
SELECT pha,
       saupm.date,
       brand,
       type,
       COUNT(*) as user_num
FROM shenzhen_app_use_people_10month saupm
JOIN shenzhen_app_use_filtered sauf ON sauf.PHA_qui = saupm.PHA_qui
JOIN newlycreatedPHA ncp ON ncp.pha = saupm.lcode
JOIN shenzhen_people_filtered spf on spf.PHA_qui = saupm.PHA_qui
WHERE createdate = 20231101
AND saupm.date IN (20190501, 20191101, 20200501, 20201101, 20210501, 20211101, 20220501, 20221101, 20230501, 20231101)
GROUP BY pha, saupm.date, brand, type



SELECT pha,
       date,
       concat_ws(',',
          coalesce(user_num, '?'),
          coalesce(cast(brand as string), '?'),
          coalesce(date, '?'),
          coalesce(cast(type as string), '?'),
          coalesce(date, '?')
          ) as combine,
      user_num
FROM eachPHA_demographics_created20231101_cell




-- 20190501 PHA 较多 将10个timepoint拆开跑，防止数据过大无法导出
-- user_num1 拆成两份看num
SELECT pha,
       date,
       COUNT(*) as user_num
FROM shenzhen_app_use_people_10month saupm
JOIN shenzhen_app_use_filtered sauf ON sauf.PHA_qui = saupm.PHA_qui
JOIN newlycreatedPHA ncp ON ncp.pha = saupm.lcode
WHERE createdate = 20190501
AND saupm.date = 20190501
GROUP BY pha, saupm.date

-- user_num2
SELECT pha,
       date,
       COUNT(*) as user_num
FROM shenzhen_app_use_people_10month saupm
JOIN shenzhen_app_use_filtered sauf ON sauf.PHA_qui = saupm.PHA_qui
JOIN newlycreatedPHA ncp ON ncp.pha = saupm.lcode
WHERE createdate = 20190501
AND saupm.date IN (20211101, 20220501, 20221101, 20230501, 20231101)
GROUP BY pha, saupm.date

-- user_demographics
-- gender拆成10个
SELECT pha,
       saupm.date,
       gender,
       COUNT(*) as user_num
FROM shenzhen_app_use_people_10month saupm
JOIN shenzhen_app_use_filtered sauf ON sauf.PHA_qui = saupm.PHA_qui
JOIN newlycreatedPHA ncp ON ncp.pha = saupm.lcode
JOIN shenzhen_people_filtered spf on spf.PHA_qui = saupm.PHA_qui
WHERE createdate = 20190501
AND saupm.date IN (20190501, 20191101, 20200501, 20201101)
GROUP BY pha, saupm.date, gender

-- gender2
SELECT pha,
       saupm.date,
       gender,
       COUNT(*) as user_num
FROM shenzhen_app_use_people_10month saupm
JOIN shenzhen_app_use_filtered sauf ON sauf.PHA_qui = saupm.PHA_qui
JOIN newlycreatedPHA ncp ON ncp.pha = saupm.lcode
JOIN shenzhen_people_filtered spf on spf.PHA_qui = saupm.PHA_qui
WHERE createdate = 20190501
AND saupm.date = 20191101
GROUP BY pha, saupm.date, gender

-- gender3
SELECT pha,
       saupm.date,
       gender,
       COUNT(*) as user_num
FROM shenzhen_app_use_people_10month saupm
JOIN shenzhen_app_use_filtered sauf ON sauf.PHA_qui = saupm.PHA_qui
JOIN newlycreatedPHA ncp ON ncp.pha = saupm.lcode
JOIN shenzhen_people_filtered spf on spf.PHA_qui = saupm.PHA_qui
WHERE createdate = 20190501
AND saupm.date = 20200501
GROUP BY pha, saupm.date, gender

-- gender4
SELECT pha,
       saupm.date,
       gender,
       COUNT(*) as user_num
FROM shenzhen_app_use_people_10month saupm
JOIN shenzhen_app_use_filtered sauf ON sauf.PHA_qui = saupm.PHA_qui
JOIN newlycreatedPHA ncp ON ncp.pha = saupm.lcode
JOIN shenzhen_people_filtered spf on spf.PHA_qui = saupm.PHA_qui
WHERE createdate = 20190501
AND saupm.date = 20201101
GROUP BY pha, saupm.date, gender

-- gender5
SELECT pha,
       saupm.date,
       gender,
       COUNT(*) as user_num
FROM shenzhen_app_use_people_10month saupm
JOIN shenzhen_app_use_filtered sauf ON sauf.PHA_qui = saupm.PHA_qui
JOIN newlycreatedPHA ncp ON ncp.pha = saupm.lcode
JOIN shenzhen_people_filtered spf on spf.PHA_qui = saupm.PHA_qui
WHERE createdate = 20190501
AND saupm.date = 20210501
GROUP BY pha, saupm.date, gender

-- gender6
SELECT pha,
       saupm.date,
       gender,
       COUNT(*) as user_num
FROM shenzhen_app_use_people_10month saupm
JOIN shenzhen_app_use_filtered sauf ON sauf.PHA_qui = saupm.PHA_qui
JOIN newlycreatedPHA ncp ON ncp.pha = saupm.lcode
JOIN shenzhen_people_filtered spf on spf.PHA_qui = saupm.PHA_qui
WHERE createdate = 20190501
AND saupm.date = 20211101
GROUP BY pha, saupm.date, gender

-- gender7
SELECT pha,
       saupm.date,
       gender,
       COUNT(*) as user_num
FROM shenzhen_app_use_people_10month saupm
JOIN shenzhen_app_use_filtered sauf ON sauf.PHA_qui = saupm.PHA_qui
JOIN newlycreatedPHA ncp ON ncp.pha = saupm.lcode
JOIN shenzhen_people_filtered spf on spf.PHA_qui = saupm.PHA_qui
WHERE createdate = 20190501
AND saupm.date = 20220501
GROUP BY pha, saupm.date, gender

-- gender8
SELECT pha,
       saupm.date,
       gender,
       COUNT(*) as user_num
FROM shenzhen_app_use_people_10month saupm
JOIN shenzhen_app_use_filtered sauf ON sauf.PHA_qui = saupm.PHA_qui
JOIN newlycreatedPHA ncp ON ncp.pha = saupm.lcode
JOIN shenzhen_people_filtered spf on spf.PHA_qui = saupm.PHA_qui
WHERE createdate = 20190501
AND saupm.date = 20221101
GROUP BY pha, saupm.date, gender

-- gender9
SELECT pha,
       saupm.date,
       gender,
       COUNT(*) as user_num
FROM shenzhen_app_use_people_10month saupm
JOIN shenzhen_app_use_filtered sauf ON sauf.PHA_qui = saupm.PHA_qui
JOIN newlycreatedPHA ncp ON ncp.pha = saupm.lcode
JOIN shenzhen_people_filtered spf on spf.PHA_qui = saupm.PHA_qui
WHERE createdate = 20190501
AND saupm.date = 20230501
GROUP BY pha, saupm.date, gender

-- gender10
SELECT pha,
       saupm.date,
       gender,
       COUNT(*) as user_num
FROM shenzhen_app_use_people_10month saupm
JOIN shenzhen_app_use_filtered sauf ON sauf.PHA_qui = saupm.PHA_qui
JOIN newlycreatedPHA ncp ON ncp.pha = saupm.lcode
JOIN shenzhen_people_filtered spf on spf.PHA_qui = saupm.PHA_qui
WHERE createdate = 20190501
AND saupm.date = 20231101
GROUP BY pha, saupm.date, gender


-- age 拆成10个
SELECT pha,
       saupm.date,
       age,
       COUNT(*) as user_num
FROM shenzhen_app_use_people_10month saupm
JOIN shenzhen_app_use_filtered sauf ON sauf.PHA_qui = saupm.PHA_qui
JOIN newlycreatedPHA ncp ON ncp.pha = saupm.lcode
JOIN shenzhen_people_filtered spf on spf.PHA_qui = saupm.PHA_qui
WHERE createdate = 20190501
AND saupm.date = 20190501
GROUP BY pha, saupm.date, age

-- age2
SELECT pha,
       saupm.date,
       age,
       COUNT(*) as user_num
FROM shenzhen_app_use_people_10month saupm
JOIN shenzhen_app_use_filtered sauf ON sauf.PHA_qui = saupm.PHA_qui
JOIN newlycreatedPHA ncp ON ncp.pha = saupm.lcode
JOIN shenzhen_people_filtered spf on spf.PHA_qui = saupm.PHA_qui
WHERE createdate = 20190501
AND saupm.date = 20191101
GROUP BY pha, saupm.date, age

-- age3
SELECT pha,
       saupm.date,
       age,
       COUNT(*) as user_num
FROM shenzhen_app_use_people_10month saupm
JOIN shenzhen_app_use_filtered sauf ON sauf.PHA_qui = saupm.PHA_qui
JOIN newlycreatedPHA ncp ON ncp.pha = saupm.lcode
JOIN shenzhen_people_filtered spf on spf.PHA_qui = saupm.PHA_qui
WHERE createdate = 20190501
AND saupm.date = 20200501
GROUP BY pha, saupm.date, age

-- age4
SELECT pha,
       saupm.date,
       age,
       COUNT(*) as user_num
FROM shenzhen_app_use_people_10month saupm
JOIN shenzhen_app_use_filtered sauf ON sauf.PHA_qui = saupm.PHA_qui
JOIN newlycreatedPHA ncp ON ncp.pha = saupm.lcode
JOIN shenzhen_people_filtered spf on spf.PHA_qui = saupm.PHA_qui
WHERE createdate = 20190501
AND saupm.date = 20201101
GROUP BY pha, saupm.date, age

-- age5
SELECT pha,
       saupm.date,
       age,
       COUNT(*) as user_num
FROM shenzhen_app_use_people_10month saupm
JOIN shenzhen_app_use_filtered sauf ON sauf.PHA_qui = saupm.PHA_qui
JOIN newlycreatedPHA ncp ON ncp.pha = saupm.lcode
JOIN shenzhen_people_filtered spf on spf.PHA_qui = saupm.PHA_qui
WHERE createdate = 20190501
AND saupm.date = 20210501
GROUP BY pha, saupm.date, age


-- age6
SELECT pha,
       saupm.date,
       age,
       COUNT(*) as user_num
FROM shenzhen_app_use_people_10month saupm
JOIN shenzhen_app_use_filtered sauf ON sauf.PHA_qui = saupm.PHA_qui
JOIN newlycreatedPHA ncp ON ncp.pha = saupm.lcode
JOIN shenzhen_people_filtered spf on spf.PHA_qui = saupm.PHA_qui
WHERE createdate = 20190501
AND saupm.date = 20211101
GROUP BY pha, saupm.date, age

-- age7
SELECT pha,
       saupm.date,
       age,
       COUNT(*) as user_num
FROM shenzhen_app_use_people_10month saupm
JOIN shenzhen_app_use_filtered sauf ON sauf.PHA_qui = saupm.PHA_qui
JOIN newlycreatedPHA ncp ON ncp.pha = saupm.lcode
JOIN shenzhen_people_filtered spf on spf.PHA_qui = saupm.PHA_qui
WHERE createdate = 20190501
AND saupm.date = 20220501
GROUP BY pha, saupm.date, age


-- age8
SELECT pha,
       saupm.date,
       age,
       COUNT(*) as user_num
FROM shenzhen_app_use_people_10month saupm
JOIN shenzhen_app_use_filtered sauf ON sauf.PHA_qui = saupm.PHA_qui
JOIN newlycreatedPHA ncp ON ncp.pha = saupm.lcode
JOIN shenzhen_people_filtered spf on spf.PHA_qui = saupm.PHA_qui
WHERE createdate = 20190501
AND saupm.date = 20221101
GROUP BY pha, saupm.date, age

-- age9
SELECT pha,
       saupm.date,
       age,
       COUNT(*) as user_num
FROM shenzhen_app_use_people_10month saupm
JOIN shenzhen_app_use_filtered sauf ON sauf.PHA_qui = saupm.PHA_qui
JOIN newlycreatedPHA ncp ON ncp.pha = saupm.lcode
JOIN shenzhen_people_filtered spf on spf.PHA_qui = saupm.PHA_qui
WHERE createdate = 20190501
AND saupm.date = 20230501
GROUP BY pha, saupm.date, age

-- age10
SELECT pha,
       saupm.date,
       age,
       COUNT(*) as user_num
FROM shenzhen_app_use_people_10month saupm
JOIN shenzhen_app_use_filtered sauf ON sauf.PHA_qui = saupm.PHA_qui
JOIN newlycreatedPHA ncp ON ncp.pha = saupm.lcode
JOIN shenzhen_people_filtered spf on spf.PHA_qui = saupm.PHA_qui
WHERE createdate = 20190501
AND saupm.date = 20231101
GROUP BY pha, saupm.date, age



-- phone 行数较多 需单独处理

DROP TABLE IF EXISTS eachPHA_demographics_created20190501_cell;
CREATE TABLE eachPHA_demographics_created20190501_cell AS
SELECT pha,
       saupm.date,
       brand,
       type,
       COUNT(*) as user_num
FROM shenzhen_app_use_people_10month saupm
JOIN shenzhen_app_use_filtered sauf ON sauf.PHA_qui = saupm.PHA_qui
JOIN newlycreatedPHA ncp ON ncp.pha = saupm.lcode
JOIN shenzhen_people_filtered spf on spf.PHA_qui = saupm.PHA_qui
WHERE createdate = 20190501
AND saupm.date IN (20190501, 20191101, 20200501, 20201101, 20210501, 20211101, 20220501, 20221101, 20230501, 20231101)
GROUP BY pha, saupm.date, brand, type


DROP TABLE IF EXISTS eachPHA_demographics_created20200501_cell;
CREATE TABLE eachPHA_demographics_created20200501_cell AS
SELECT pha,
       saupm.date,
       brand,
       type,
       COUNT(*) as user_num
FROM shenzhen_app_use_people_10month saupm
JOIN shenzhen_app_use_filtered sauf ON sauf.PHA_qui = saupm.PHA_qui
JOIN newlycreatedPHA ncp ON ncp.pha = saupm.lcode
JOIN shenzhen_people_filtered spf on spf.PHA_qui = saupm.PHA_qui
WHERE createdate = 20200501
AND saupm.date IN (20190501, 20191101, 20200501, 20201101, 20210501, 20211101, 20220501, 20221101, 20230501, 20231101)
GROUP BY pha, saupm.date, brand, type

DROP TABLE IF EXISTS eachPHA_demographics_created20201101_cell;
CREATE TABLE eachPHA_demographics_created20201101_cell AS
SELECT pha,
       saupm.date,
       brand,
       type,
       COUNT(*) as user_num
FROM shenzhen_app_use_people_10month saupm
JOIN shenzhen_app_use_filtered sauf ON sauf.PHA_qui = saupm.PHA_qui
JOIN newlycreatedPHA ncp ON ncp.pha = saupm.lcode
JOIN shenzhen_people_filtered spf on spf.PHA_qui = saupm.PHA_qui
WHERE createdate = 20201101
AND saupm.date IN (20190501, 20191101, 20200501, 20201101, 20210501, 20211101, 20220501, 20221101, 20230501, 20231101)
GROUP BY pha, saupm.date, brand, type


DROP TABLE IF EXISTS eachPHA_demographics_created20210501_cell;
CREATE TABLE eachPHA_demographics_created20210501_cell AS
SELECT pha,
       saupm.date,
       brand,
       type,
       COUNT(*) as user_num
FROM shenzhen_app_use_people_10month saupm
JOIN shenzhen_app_use_filtered sauf ON sauf.PHA_qui = saupm.PHA_qui
JOIN newlycreatedPHA ncp ON ncp.pha = saupm.lcode
JOIN shenzhen_people_filtered spf on spf.PHA_qui = saupm.PHA_qui
WHERE createdate = 20210501
AND saupm.date IN (20190501, 20191101, 20200501, 20201101, 20210501, 20211101, 20220501, 20221101, 20230501, 20231101)
GROUP BY pha, saupm.date, brand, type



-- 20200501

SELECT pha,
       date,
       concat_ws(',',
          coalesce(user_num, '?'),
          coalesce(cast(brand as string), '?'),
          coalesce(date, '?'),
          coalesce(cast(type as string), '?'),
          coalesce(date, '?')
          ) as combine,
      user_num
FROM eachpha_demographics_created20200501_cell
WHERE date = 20200501

SELECT pha,
       date,
       concat_ws(',',
          coalesce(user_num, '?'),
          coalesce(cast(brand as string), '?'),
          coalesce(date, '?'),
          coalesce(cast(type as string), '?'),
          coalesce(date, '?')
          ) as combine,
      user_num
FROM eachpha_demographics_created20200501_cell
WHERE date = 20201101

SELECT pha,
       date,
       concat_ws(',',
          coalesce(user_num, '?'),
          coalesce(cast(brand as string), '?'),
          coalesce(date, '?'),
          coalesce(cast(type as string), '?'),
          coalesce(date, '?')
          ) as combine,
      user_num
FROM eachpha_demographics_created20200501_cell
WHERE date = 20210501

SELECT pha,
       date,
       concat_ws(',',
          coalesce(user_num, '?'),
          coalesce(cast(brand as string), '?'),
          coalesce(date, '?'),
          coalesce(cast(type as string), '?'),
          coalesce(date, '?')
          ) as combine,
      user_num
FROM eachpha_demographics_created20200501_cell
WHERE date = 20211101

SELECT pha,
       date,
       concat_ws(',',
          coalesce(user_num, '?'),
          coalesce(cast(brand as string), '?'),
          coalesce(date, '?'),
          coalesce(cast(type as string), '?'),
          coalesce(date, '?')
          ) as combine,
      user_num
FROM eachpha_demographics_created20200501_cell
WHERE date = 20220501

SELECT pha,
       date,
       concat_ws(',',
          coalesce(user_num, '?'),
          coalesce(cast(brand as string), '?'),
          coalesce(date, '?'),
          coalesce(cast(type as string), '?'),
          coalesce(date, '?')
          ) as combine,
      user_num
FROM eachpha_demographics_created20200501_cell
WHERE date = 20221101


SELECT pha,
       date,
       concat_ws(',',
          coalesce(user_num, '?'),
          coalesce(cast(brand as string), '?'),
          coalesce(date, '?'),
          coalesce(cast(type as string), '?'),
          coalesce(date, '?')
          ) as combine,
      user_num
FROM eachpha_demographics_created20200501_cell
WHERE date = 20230501

SELECT pha,
       date,
       concat_ws(',',
          coalesce(user_num, '?'),
          coalesce(cast(brand as string), '?'),
          coalesce(date, '?'),
          coalesce(cast(type as string), '?'),
          coalesce(date, '?')
          ) as combine,
      user_num
FROM eachpha_demographics_created20200501_cell
WHERE date = 20231101




-- 20201101

SELECT pha,
       date,
       concat_ws(',',
          coalesce(user_num, '?'),
          coalesce(cast(brand as string), '?'),
          coalesce(date, '?'),
          coalesce(cast(type as string), '?'),
          coalesce(date, '?')
          ) as combine,
      user_num
FROM eachpha_demographics_created20201101_cell
WHERE date = 20201101


SELECT pha,
       date,
       concat_ws(',',
          coalesce(user_num, '?'),
          coalesce(cast(brand as string), '?'),
          coalesce(date, '?'),
          coalesce(cast(type as string), '?'),
          coalesce(date, '?')
          ) as combine,
      user_num
FROM eachpha_demographics_created20201101_cell
WHERE date = 20210501

SELECT pha,
       date,
       concat_ws(',',
          coalesce(user_num, '?'),
          coalesce(cast(brand as string), '?'),
          coalesce(date, '?'),
          coalesce(cast(type as string), '?'),
          coalesce(date, '?')
          ) as combine,
      user_num
FROM eachpha_demographics_created20201101_cell
WHERE date = 20211101

SELECT pha,
       date,
       concat_ws(',',
          coalesce(user_num, '?'),
          coalesce(cast(brand as string), '?'),
          coalesce(date, '?'),
          coalesce(cast(type as string), '?'),
          coalesce(date, '?')
          ) as combine,
      user_num
FROM eachpha_demographics_created20201101_cell
WHERE date = 20220501

SELECT pha,
       date,
       concat_ws(',',
          coalesce(user_num, '?'),
          coalesce(cast(brand as string), '?'),
          coalesce(date, '?'),
          coalesce(cast(type as string), '?'),
          coalesce(date, '?')
          ) as combine,
      user_num
FROM eachpha_demographics_created20201101_cell
WHERE date = 20221101


SELECT pha,
       date,
       concat_ws(',',
          coalesce(user_num, '?'),
          coalesce(cast(brand as string), '?'),
          coalesce(date, '?'),
          coalesce(cast(type as string), '?'),
          coalesce(date, '?')
          ) as combine,
      user_num
FROM eachpha_demographics_created20201101_cell
WHERE date = 20230501

SELECT pha,
       date,
       concat_ws(',',
          coalesce(user_num, '?'),
          coalesce(cast(brand as string), '?'),
          coalesce(date, '?'),
          coalesce(cast(type as string), '?'),
          coalesce(date, '?')
          ) as combine,
      user_num
FROM eachpha_demographics_created20201101_cell
WHERE date = 20231101



-- 20210501

SELECT pha,
       date,
       concat_ws(',',
          coalesce(user_num, '?'),
          coalesce(cast(brand as string), '?'),
          coalesce(date, '?'),
          coalesce(cast(type as string), '?'),
          coalesce(date, '?')
          ) as combine,
      user_num
FROM eachpha_demographics_created20210501_cell
WHERE date = 20210501

SELECT pha,
       date,
       concat_ws(',',
          coalesce(user_num, '?'),
          coalesce(cast(brand as string), '?'),
          coalesce(date, '?'),
          coalesce(cast(type as string), '?'),
          coalesce(date, '?')
          ) as combine,
      user_num
FROM eachpha_demographics_created20210501_cell
WHERE date = 20211101

SELECT pha,
       date,
       concat_ws(',',
          coalesce(user_num, '?'),
          coalesce(cast(brand as string), '?'),
          coalesce(date, '?'),
          coalesce(cast(type as string), '?'),
          coalesce(date, '?')
          ) as combine,
      user_num
FROM eachpha_demographics_created20210501_cell
WHERE date = 20220501

SELECT pha,
       date,
       concat_ws(',',
          coalesce(user_num, '?'),
          coalesce(cast(brand as string), '?'),
          coalesce(date, '?'),
          coalesce(cast(type as string), '?'),
          coalesce(date, '?')
          ) as combine,
      user_num
FROM eachpha_demographics_created20210501_cell
WHERE date = 20221101


SELECT pha,
       date,
       concat_ws(',',
          coalesce(user_num, '?'),
          coalesce(cast(brand as string), '?'),
          coalesce(date, '?'),
          coalesce(cast(type as string), '?'),
          coalesce(date, '?')
          ) as combine,
      user_num
FROM eachpha_demographics_created20210501_cell
WHERE date = 20230501

SELECT pha,
       date,
       concat_ws(',',
          coalesce(user_num, '?'),
          coalesce(cast(brand as string), '?'),
          coalesce(date, '?'),
          coalesce(cast(type as string), '?'),
          coalesce(date, '?')
          ) as combine,
      user_num
FROM eachpha_demographics_created20210501_cell
WHERE date = 20231101




-- 20211101
SELECT pha,
       date,
       concat_ws(',',
          coalesce(user_num, '?'),
          coalesce(cast(brand as string), '?'),
          coalesce(date, '?'),
          coalesce(cast(type as string), '?'),
          coalesce(date, '?')
          ) as combine,
      user_num
FROM eachpha_demographics_created20211101_cell
WHERE date = 20211101

SELECT pha,
       date,
       concat_ws(',',
          coalesce(user_num, '?'),
          coalesce(cast(brand as string), '?'),
          coalesce(date, '?'),
          coalesce(cast(type as string), '?'),
          coalesce(date, '?')
          ) as combine,
      user_num
FROM eachpha_demographics_created20211101_cell
WHERE date = 20220501

SELECT pha,
       date,
       concat_ws(',',
          coalesce(user_num, '?'),
          coalesce(cast(brand as string), '?'),
          coalesce(date, '?'),
          coalesce(cast(type as string), '?'),
          coalesce(date, '?')
          ) as combine,
      user_num
FROM eachpha_demographics_created20211101_cell
WHERE date = 20221101


SELECT pha,
       date,
       concat_ws(',',
          coalesce(user_num, '?'),
          coalesce(cast(brand as string), '?'),
          coalesce(date, '?'),
          coalesce(cast(type as string), '?'),
          coalesce(date, '?')
          ) as combine,
      user_num
FROM eachpha_demographics_created20211101_cell
WHERE date = 20230501

SELECT pha,
       date,
       concat_ws(',',
          coalesce(user_num, '?'),
          coalesce(cast(brand as string), '?'),
          coalesce(date, '?'),
          coalesce(cast(type as string), '?'),
          coalesce(date, '?')
          ) as combine,
      user_num
FROM eachpha_demographics_created20211101_cell
WHERE date = 20231101






DROP TABLE IF EXISTS pha20190501_1;
CREATE TABLE pha20190501_1 AS
SELECT pha
FROM PHA20190501
WHERE ranknum <= 35

DROP TABLE IF EXISTS pha20190501_11;
CREATE TABLE pha20190501_11 AS
SELECT pha
FROM PHA20190501
WHERE ranknum BETWEEN 36 AND 70

DROP TABLE IF EXISTS pha20190501_2;
CREATE TABLE pha20190501_2 AS
SELECT pha
FROM PHA20190501
WHERE ranknum BETWEEN 71 AND 115

DROP TABLE IF EXISTS pha20190501_3;
CREATE TABLE pha20190501_3 AS
SELECT pha
FROM PHA20190501
WHERE ranknum BETWEEN 116 AND 160

DROP TABLE IF EXISTS pha20190501_4;
CREATE TABLE pha20190501_4 AS
SELECT pha
FROM PHA20190501
WHERE ranknum > 160


SELECT b.pha,
       date,
       concat_ws(',',
          coalesce(user_num, '?'),
          coalesce(cast(brand as string), '?'),
          coalesce(date, '?'),
          coalesce(cast(type as string), '?'),
          coalesce(date, '?')
          ) as combine,
      user_num
FROM eachpha_demographics_created20190501_cell a
JOIN pha20190501_1 b on a.pha = b.pha
WHERE date = 20190501

SELECT b.pha,
       date,
       concat_ws(',',
          coalesce(user_num, '?'),
          coalesce(cast(brand as string), '?'),
          coalesce(date, '?'),
          coalesce(cast(type as string), '?'),
          coalesce(date, '?')
          ) as combine,
      user_num
FROM eachpha_demographics_created20190501_cell a
JOIN pha20190501_11 b on a.pha = b.pha
WHERE date = 20190501

SELECT b.pha,
       date,
       concat_ws(',',
          coalesce(user_num, '?'),
          coalesce(cast(brand as string), '?'),
          coalesce(date, '?'),
          coalesce(cast(type as string), '?'),
          coalesce(date, '?')
          ) as combine,
      user_num
FROM eachpha_demographics_created20190501_cell a
JOIN pha20190501_1 b on a.pha = b.pha
WHERE date = 20191101

SELECT b.pha,
       date,
       concat_ws(',',
          coalesce(user_num, '?'),
          coalesce(cast(brand as string), '?'),
          coalesce(date, '?'),
          coalesce(cast(type as string), '?'),
          coalesce(date, '?')
          ) as combine,
      user_num
FROM eachpha_demographics_created20190501_cell a
JOIN pha20190501_11 b on a.pha = b.pha
WHERE date = 20191101

SELECT b.pha,
       date,
       concat_ws(',',
          coalesce(user_num, '?'),
          coalesce(cast(brand as string), '?'),
          coalesce(date, '?'),
          coalesce(cast(type as string), '?'),
          coalesce(date, '?')
          ) as combine,
      user_num
FROM eachpha_demographics_created20190501_cell a
JOIN pha20190501_1 b on a.pha = b.pha
WHERE date = 20200501

SELECT b.pha,
       date,
       concat_ws(',',
          coalesce(user_num, '?'),
          coalesce(cast(brand as string), '?'),
          coalesce(date, '?'),
          coalesce(cast(type as string), '?'),
          coalesce(date, '?')
          ) as combine,
      user_num
FROM eachpha_demographics_created20190501_cell a
JOIN pha20190501_11 b on a.pha = b.pha
WHERE date = 20200501

SELECT b.pha,
       date,
       concat_ws(',',
          coalesce(user_num, '?'),
          coalesce(cast(brand as string), '?'),
          coalesce(date, '?'),
          coalesce(cast(type as string), '?'),
          coalesce(date, '?')
          ) as combine,
      user_num
FROM eachpha_demographics_created20190501_cell a
JOIN pha20190501_11 b on a.pha = b.pha
WHERE date = 20201101

SELECT b.pha,
       date,
       concat_ws(',',
          coalesce(user_num, '?'),
          coalesce(cast(brand as string), '?'),
          coalesce(date, '?'),
          coalesce(cast(type as string), '?'),
          coalesce(date, '?')
          ) as combine,
      user_num
FROM eachpha_demographics_created20190501_cell a
JOIN pha20190501_1 b on a.pha = b.pha
WHERE date = 20201101



SELECT b.pha,
       date,
       concat_ws(',',
          coalesce(user_num, '?'),
          coalesce(cast(brand as string), '?'),
          coalesce(date, '?'),
          coalesce(cast(type as string), '?'),
          coalesce(date, '?')
          ) as combine,
      user_num
FROM eachpha_demographics_created20190501_cell a
JOIN pha20190501_1 b on a.pha = b.pha
WHERE date = 20210501

SELECT b.pha,
       date,
       concat_ws(',',
          coalesce(user_num, '?'),
          coalesce(cast(brand as string), '?'),
          coalesce(date, '?'),
          coalesce(cast(type as string), '?'),
          coalesce(date, '?')
          ) as combine,
      user_num
FROM eachpha_demographics_created20190501_cell a
JOIN pha20190501_11 b on a.pha = b.pha
WHERE date = 20210501


SELECT b.pha,
       date,
       concat_ws(',',
          coalesce(user_num, '?'),
          coalesce(cast(brand as string), '?'),
          coalesce(date, '?'),
          coalesce(cast(type as string), '?'),
          coalesce(date, '?')
          ) as combine,
      user_num
FROM eachpha_demographics_created20190501_cell a
JOIN pha20190501_1 b on a.pha = b.pha
WHERE date = 20211101

SELECT b.pha,
       date,
       concat_ws(',',
          coalesce(user_num, '?'),
          coalesce(cast(brand as string), '?'),
          coalesce(date, '?'),
          coalesce(cast(type as string), '?'),
          coalesce(date, '?')
          ) as combine,
      user_num
FROM eachpha_demographics_created20190501_cell a
JOIN pha20190501_11 b on a.pha = b.pha
WHERE date = 20211101


SELECT b.pha,
       date,
       concat_ws(',',
          coalesce(user_num, '?'),
          coalesce(cast(brand as string), '?'),
          coalesce(date, '?'),
          coalesce(cast(type as string), '?'),
          coalesce(date, '?')
          ) as combine,
      user_num
FROM eachpha_demographics_created20190501_cell a
JOIN pha20190501_1 b on a.pha = b.pha
WHERE date = 20220501


SELECT b.pha,
       date,
       concat_ws(',',
          coalesce(user_num, '?'),
          coalesce(cast(brand as string), '?'),
          coalesce(date, '?'),
          coalesce(cast(type as string), '?'),
          coalesce(date, '?')
          ) as combine,
      user_num
FROM eachpha_demographics_created20190501_cell a
JOIN pha20190501_11 b on a.pha = b.pha
WHERE date = 20220501


SELECT b.pha,
       date,
       concat_ws(',',
          coalesce(user_num, '?'),
          coalesce(cast(brand as string), '?'),
          coalesce(date, '?'),
          coalesce(cast(type as string), '?'),
          coalesce(date, '?')
          ) as combine,
      user_num
FROM eachpha_demographics_created20190501_cell a
JOIN pha20190501_1 b on a.pha = b.pha
WHERE date = 20221101

SELECT b.pha,
       date,
       concat_ws(',',
          coalesce(user_num, '?'),
          coalesce(cast(brand as string), '?'),
          coalesce(date, '?'),
          coalesce(cast(type as string), '?'),
          coalesce(date, '?')
          ) as combine,
      user_num
FROM eachpha_demographics_created20190501_cell a
JOIN pha20190501_11 b on a.pha = b.pha
WHERE date = 20221101

SELECT b.pha,
       date,
       concat_ws(',',
          coalesce(user_num, '?'),
          coalesce(cast(brand as string), '?'),
          coalesce(date, '?'),
          coalesce(cast(type as string), '?'),
          coalesce(date, '?')
          ) as combine,
      user_num
FROM eachpha_demographics_created20190501_cell a
JOIN pha20190501_1 b on a.pha = b.pha
WHERE date = 20230501

SELECT b.pha,
       date,
       concat_ws(',',
          coalesce(user_num, '?'),
          coalesce(cast(brand as string), '?'),
          coalesce(date, '?'),
          coalesce(cast(type as string), '?'),
          coalesce(date, '?')
          ) as combine,
      user_num
FROM eachpha_demographics_created20190501_cell a
JOIN pha20190501_11 b on a.pha = b.pha
WHERE date = 20230501

SELECT b.pha,
       date,
       concat_ws(',',
          coalesce(user_num, '?'),
          coalesce(cast(brand as string), '?'),
          coalesce(date, '?'),
          coalesce(cast(type as string), '?'),
          coalesce(date, '?')
          ) as combine,
      user_num
FROM eachpha_demographics_created20190501_cell a
JOIN pha20190501_1 b on a.pha = b.pha
WHERE date = 20231101

SELECT b.pha,
       date,
       concat_ws(',',
          coalesce(user_num, '?'),
          coalesce(cast(brand as string), '?'),
          coalesce(date, '?'),
          coalesce(cast(type as string), '?'),
          coalesce(date, '?')
          ) as combine,
      user_num
FROM eachpha_demographics_created20190501_cell a
JOIN pha20190501_11 b on a.pha = b.pha
WHERE date = 20231101




-- 第2组
SELECT b.pha,
       date,
       concat_ws(',',
          coalesce(user_num, '?'),
          coalesce(cast(brand as string), '?'),
          coalesce(date, '?'),
          coalesce(cast(type as string), '?'),
          coalesce(date, '?')
          ) as combine,
      user_num
FROM eachpha_demographics_created20190501_cell a
JOIN pha20190501_2 b on a.pha = b.pha
WHERE date = 20190501

SELECT b.pha,
       date,
       concat_ws(',',
          coalesce(user_num, '?'),
          coalesce(cast(brand as string), '?'),
          coalesce(date, '?'),
          coalesce(cast(type as string), '?'),
          coalesce(date, '?')
          ) as combine,
      user_num
FROM eachpha_demographics_created20190501_cell a
JOIN pha20190501_2 b on a.pha = b.pha
WHERE date = 20191101



SELECT b.pha,
       date,
       concat_ws(',',
          coalesce(user_num, '?'),
          coalesce(cast(brand as string), '?'),
          coalesce(date, '?'),
          coalesce(cast(type as string), '?'),
          coalesce(date, '?')
          ) as combine,
      user_num
FROM eachpha_demographics_created20190501_cell a
JOIN pha20190501_2 b on a.pha = b.pha
WHERE date = 20200501

SELECT b.pha,
       date,
       concat_ws(',',
          coalesce(user_num, '?'),
          coalesce(cast(brand as string), '?'),
          coalesce(date, '?'),
          coalesce(cast(type as string), '?'),
          coalesce(date, '?')
          ) as combine,
      user_num
FROM eachpha_demographics_created20190501_cell a
JOIN pha20190501_2 b on a.pha = b.pha
WHERE date = 20201101


SELECT b.pha,
       date,
       concat_ws(',',
          coalesce(user_num, '?'),
          coalesce(cast(brand as string), '?'),
          coalesce(date, '?'),
          coalesce(cast(type as string), '?'),
          coalesce(date, '?')
          ) as combine,
      user_num
FROM eachpha_demographics_created20190501_cell a
JOIN pha20190501_2 b on a.pha = b.pha
WHERE date = 20210501

SELECT b.pha,
       date,
       concat_ws(',',
          coalesce(user_num, '?'),
          coalesce(cast(brand as string), '?'),
          coalesce(date, '?'),
          coalesce(cast(type as string), '?'),
          coalesce(date, '?')
          ) as combine,
      user_num
FROM eachpha_demographics_created20190501_cell a
JOIN pha20190501_2 b on a.pha = b.pha
WHERE date = 20211101

SELECT b.pha,
       date,
       concat_ws(',',
          coalesce(user_num, '?'),
          coalesce(cast(brand as string), '?'),
          coalesce(date, '?'),
          coalesce(cast(type as string), '?'),
          coalesce(date, '?')
          ) as combine,
      user_num
FROM eachpha_demographics_created20190501_cell a
JOIN pha20190501_2 b on a.pha = b.pha
WHERE date = 20220501

SELECT b.pha,
       date,
       concat_ws(',',
          coalesce(user_num, '?'),
          coalesce(cast(brand as string), '?'),
          coalesce(date, '?'),
          coalesce(cast(type as string), '?'),
          coalesce(date, '?')
          ) as combine,
      user_num
FROM eachpha_demographics_created20190501_cell a
JOIN pha20190501_2 b on a.pha = b.pha
WHERE date = 20221101


SELECT b.pha,
       date,
       concat_ws(',',
          coalesce(user_num, '?'),
          coalesce(cast(brand as string), '?'),
          coalesce(date, '?'),
          coalesce(cast(type as string), '?'),
          coalesce(date, '?')
          ) as combine,
      user_num
FROM eachpha_demographics_created20190501_cell a
JOIN pha20190501_2 b on a.pha = b.pha
WHERE date = 20230501

SELECT b.pha,
       date,
       concat_ws(',',
          coalesce(user_num, '?'),
          coalesce(cast(brand as string), '?'),
          coalesce(date, '?'),
          coalesce(cast(type as string), '?'),
          coalesce(date, '?')
          ) as combine,
      user_num
FROM eachpha_demographics_created20190501_cell a
JOIN pha20190501_2 b on a.pha = b.pha
WHERE date = 20231101



-- 第3组
SELECT b.pha,
       date,
       concat_ws(',',
          coalesce(user_num, '?'),
          coalesce(cast(brand as string), '?'),
          coalesce(date, '?'),
          coalesce(cast(type as string), '?'),
          coalesce(date, '?')
          ) as combine,
      user_num
FROM eachpha_demographics_created20190501_cell a
JOIN pha20190501_3 b on a.pha = b.pha
WHERE date = 20190501

SELECT b.pha,
       date,
       concat_ws(',',
          coalesce(user_num, '?'),
          coalesce(cast(brand as string), '?'),
          coalesce(date, '?'),
          coalesce(cast(type as string), '?'),
          coalesce(date, '?')
          ) as combine,
      user_num
FROM eachpha_demographics_created20190501_cell a
JOIN pha20190501_3 b on a.pha = b.pha
WHERE date = 20191101



SELECT b.pha,
       date,
       concat_ws(',',
          coalesce(user_num, '?'),
          coalesce(cast(brand as string), '?'),
          coalesce(date, '?'),
          coalesce(cast(type as string), '?'),
          coalesce(date, '?')
          ) as combine,
      user_num
FROM eachpha_demographics_created20190501_cell a
JOIN pha20190501_3 b on a.pha = b.pha
WHERE date = 20200501

SELECT b.pha,
       date,
       concat_ws(',',
          coalesce(user_num, '?'),
          coalesce(cast(brand as string), '?'),
          coalesce(date, '?'),
          coalesce(cast(type as string), '?'),
          coalesce(date, '?')
          ) as combine,
      user_num
FROM eachpha_demographics_created20190501_cell a
JOIN pha20190501_3 b on a.pha = b.pha
WHERE date = 20201101


SELECT b.pha,
       date,
       concat_ws(',',
          coalesce(user_num, '?'),
          coalesce(cast(brand as string), '?'),
          coalesce(date, '?'),
          coalesce(cast(type as string), '?'),
          coalesce(date, '?')
          ) as combine,
      user_num
FROM eachpha_demographics_created20190501_cell a
JOIN pha20190501_3 b on a.pha = b.pha
WHERE date = 20210501

SELECT b.pha,
       date,
       concat_ws(',',
          coalesce(user_num, '?'),
          coalesce(cast(brand as string), '?'),
          coalesce(date, '?'),
          coalesce(cast(type as string), '?'),
          coalesce(date, '?')
          ) as combine,
      user_num
FROM eachpha_demographics_created20190501_cell a
JOIN pha20190501_3 b on a.pha = b.pha
WHERE date = 20211101

SELECT b.pha,
       date,
       concat_ws(',',
          coalesce(user_num, '?'),
          coalesce(cast(brand as string), '?'),
          coalesce(date, '?'),
          coalesce(cast(type as string), '?'),
          coalesce(date, '?')
          ) as combine,
      user_num
FROM eachpha_demographics_created20190501_cell a
JOIN pha20190501_3 b on a.pha = b.pha
WHERE date = 20220501

SELECT b.pha,
       date,
       concat_ws(',',
          coalesce(user_num, '?'),
          coalesce(cast(brand as string), '?'),
          coalesce(date, '?'),
          coalesce(cast(type as string), '?'),
          coalesce(date, '?')
          ) as combine,
      user_num
FROM eachpha_demographics_created20190501_cell a
JOIN pha20190501_3 b on a.pha = b.pha
WHERE date = 20221101


SELECT b.pha,
       date,
       concat_ws(',',
          coalesce(user_num, '?'),
          coalesce(cast(brand as string), '?'),
          coalesce(date, '?'),
          coalesce(cast(type as string), '?'),
          coalesce(date, '?')
          ) as combine,
      user_num
FROM eachpha_demographics_created20190501_cell a
JOIN pha20190501_3 b on a.pha = b.pha
WHERE date = 20230501

SELECT b.pha,
       date,
       concat_ws(',',
          coalesce(user_num, '?'),
          coalesce(cast(brand as string), '?'),
          coalesce(date, '?'),
          coalesce(cast(type as string), '?'),
          coalesce(date, '?')
          ) as combine,
      user_num
FROM eachpha_demographics_created20190501_cell a
JOIN pha20190501_3 b on a.pha = b.pha
WHERE date = 20231101




-- 第4组
SELECT b.pha,
       date,
       concat_ws(',',
          coalesce(user_num, '?'),
          coalesce(cast(brand as string), '?'),
          coalesce(date, '?'),
          coalesce(cast(type as string), '?'),
          coalesce(date, '?')
          ) as combine,
      user_num
FROM eachpha_demographics_created20190501_cell a
JOIN pha20190501_4 b on a.pha = b.pha
WHERE date = 20190501

SELECT b.pha,
       date,
       concat_ws(',',
          coalesce(user_num, '?'),
          coalesce(cast(brand as string), '?'),
          coalesce(date, '?'),
          coalesce(cast(type as string), '?'),
          coalesce(date, '?')
          ) as combine,
      user_num
FROM eachpha_demographics_created20190501_cell a
JOIN pha20190501_4 b on a.pha = b.pha
WHERE date = 20191101


SELECT b.pha,
       date,
       concat_ws(',',
          coalesce(user_num, '?'),
          coalesce(cast(brand as string), '?'),
          coalesce(date, '?'),
          coalesce(cast(type as string), '?'),
          coalesce(date, '?')
          ) as combine,
      user_num
FROM eachpha_demographics_created20190501_cell a
JOIN pha20190501_4 b on a.pha = b.pha
WHERE date = 20200501

SELECT b.pha,
       date,
       concat_ws(',',
          coalesce(user_num, '?'),
          coalesce(cast(brand as string), '?'),
          coalesce(date, '?'),
          coalesce(cast(type as string), '?'),
          coalesce(date, '?')
          ) as combine,
      user_num
FROM eachpha_demographics_created20190501_cell a
JOIN pha20190501_4 b on a.pha = b.pha
WHERE date = 20201101


SELECT b.pha,
       date,
       concat_ws(',',
          coalesce(user_num, '?'),
          coalesce(cast(brand as string), '?'),
          coalesce(date, '?'),
          coalesce(cast(type as string), '?'),
          coalesce(date, '?')
          ) as combine,
      user_num
FROM eachpha_demographics_created20190501_cell a
JOIN pha20190501_4 b on a.pha = b.pha
WHERE date = 20210501

SELECT b.pha,
       date,
       concat_ws(',',
          coalesce(user_num, '?'),
          coalesce(cast(brand as string), '?'),
          coalesce(date, '?'),
          coalesce(cast(type as string), '?'),
          coalesce(date, '?')
          ) as combine,
      user_num
FROM eachpha_demographics_created20190501_cell a
JOIN pha20190501_4 b on a.pha = b.pha
WHERE date = 20211101

SELECT b.pha,
       date,
       concat_ws(',',
          coalesce(user_num, '?'),
          coalesce(cast(brand as string), '?'),
          coalesce(date, '?'),
          coalesce(cast(type as string), '?'),
          coalesce(date, '?')
          ) as combine,
      user_num
FROM eachpha_demographics_created20190501_cell a
JOIN pha20190501_4 b on a.pha = b.pha
WHERE date = 20220501

SELECT b.pha,
       date,
       concat_ws(',',
          coalesce(user_num, '?'),
          coalesce(cast(brand as string), '?'),
          coalesce(date, '?'),
          coalesce(cast(type as string), '?'),
          coalesce(date, '?')
          ) as combine,
      user_num
FROM eachpha_demographics_created20190501_cell a
JOIN pha20190501_4 b on a.pha = b.pha
WHERE date = 20221101


SELECT b.pha,
       date,
       concat_ws(',',
          coalesce(user_num, '?'),
          coalesce(cast(brand as string), '?'),
          coalesce(date, '?'),
          coalesce(cast(type as string), '?'),
          coalesce(date, '?')
          ) as combine,
      user_num
FROM eachpha_demographics_created20190501_cell a
JOIN pha20190501_4 b on a.pha = b.pha
WHERE date = 20230501

SELECT b.pha,
       date,
       concat_ws(',',
          coalesce(user_num, '?'),
          coalesce(cast(brand as string), '?'),
          coalesce(date, '?'),
          coalesce(cast(type as string), '?'),
          coalesce(date, '?')
          ) as combine,
      user_num
FROM eachpha_demographics_created20190501_cell a
JOIN pha20190501_4 b on a.pha = b.pha
WHERE date = 20231101



