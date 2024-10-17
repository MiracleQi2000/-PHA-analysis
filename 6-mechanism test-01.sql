-- mechanism 1
-- original PHA shenzhen_20190501_activePHA

-- income
-- 每个人的人均手机价格（不是每个人都有记录，只有同类型手机数目大于50的才有价格）
-- 有些型号没有价格，不会被匹配到，不会被计入均值
DROP TABLE IF EXISTS shenzhen_people_phoneprice_10monthavg;
CREATE TABLE shenzhen_people_phoneprice_10monthavg AS
SELECT sauf.PHA_qui,
       AVG(pp.price) AS average_price
FROM shenzhen_people_filtered spf -- 有demographics
JOIN shenzhen_app_use_filtered sauf ON spf.PHA_qui = sauf.PHA_qui --只有qui
JOIN phoneprice pp ON pp.brand = spf.brand
     AND pp.type = spf.type
     AND pp.date = spf.date
WHERE spf.date IN (20190501, 20191101, 20200501, 20201101, 20210501, 20211101, 20220501, 20221101, 20230501, 20231101) -- 得到567101人十个月的phone
GROUP BY sauf.PHA_qui


-- 直接把收入划分10个档

-- 先求phoneprice的分位数
SELECT
  percentile_approx(CAST(average_price AS double), 0.1, 9999) AS 10price,
  percentile_approx(CAST(average_price AS double), 0.2, 9999) AS 20price,
  percentile_approx(CAST(average_price AS double), 0.3, 9999) AS 30price,
  percentile_approx(CAST(average_price AS double), 0.4, 9999) AS 40price,
  percentile_approx(CAST(average_price AS double), 0.5, 9999) AS 50price,
  percentile_approx(CAST(average_price AS double), 0.6, 9999) AS 60price,
  percentile_approx(CAST(average_price AS double), 0.7, 9999) AS 70price,
  percentile_approx(CAST(average_price AS double), 0.8, 9999) AS 80price,
  percentile_approx(CAST(average_price AS double), 0.9, 9999) AS 90price
FROM shenzhen_people_phoneprice_10monthavg

select max(average_price)
FROM shenzhen_people_phoneprice_10monthavg


DROP TABLE IF EXISTS shenzhen_people_phoneprice_10monthavg_level;
CREATE TABLE shenzhen_people_phoneprice_10monthavg_level AS
SELECT PHA_qui,
       average_price,
CASE
      WHEN average_price > 7698.9705 THEN 'level10'
      WHEN average_price > 6398.6065 THEN 'level9'
      WHEN average_price > 5857.7621 THEN 'level8'
      WHEN average_price > 5320.4776 THEN 'level7'
      WHEN average_price > 4466.3163 THEN 'level6'
      WHEN average_price > 3711.9518 THEN 'level5'
      WHEN average_price > 3048.3342 THEN 'level4'
      WHEN average_price > 2497.9166 THEN 'level3'
      WHEN average_price > 1798.6741 THEN 'level2'
      ELSE 'level1'
      END AS phoneprice_level
FROM shenzhen_people_phoneprice_10monthavg

-- max： 17570.428571428572	 	 	 




-- abandoned ×

-- original PHA age
SELECT saup.date,
       sa.lcode,
       age,
       COUNT(*) as originalpha_user_num
FROM shenzhen_app_use_people_10month saup -- APP use
JOIN shenzhen_20190501_activePHA sa ON saup.lcode = sa.lcode -- 筛选original PHA
JOIN originalPHA_user ou ON ou.pha_qui = saup.PHA_qui -- 筛选特定人群fixed-panel
JOIN shenzhen_20190501_users_filtered suf on suf.PHA_qui = saup.PHA_qui -- 20190501 demographics
GROUP bY saup.date, sa.lcode, age

-- original PHA gender
SELECT saup.date,
       sa.lcode,
       gender,
       COUNT(*) as originalpha_user_num
FROM shenzhen_app_use_people_10month saup -- APP use
JOIN shenzhen_20190501_activePHA sa ON saup.lcode = sa.lcode -- 筛选original PHA
JOIN originalPHA_user ou ON ou.pha_qui = saup.PHA_qui -- 筛选特定人群fixed-panel
JOIN shenzhen_20190501_users_filtered suf on suf.PHA_qui = saup.PHA_qui -- 20190501 demographics
GROUP bY saup.date, sa.lcode, gender

-- original PHA income
SELECT saup.date,
       sa.lcode,
       phoneprice_level,
       COUNT(*) as originalpha_user_num
FROM shenzhen_app_use_people_10month saup -- APP use
JOIN shenzhen_20190501_activePHA sa ON saup.lcode = sa.lcode -- 筛选original PHA
JOIN originalPHA_user ou ON ou.pha_qui = saup.PHA_qui -- 筛选特定人群fixed-panel
JOIN shenzhen_people_phoneprice_10monthavg_level sp on sp.PHA_qui = saup.PHA_qui -- phoneprice demographics
GROUP bY saup.date, sa.lcode, phoneprice_level
HAVING saup.date = 20190501

SELECT saup.date,
       sa.lcode,
       phoneprice_level,
       COUNT(*) as originalpha_user_num
FROM shenzhen_app_use_people_10month saup -- APP use
JOIN shenzhen_20190501_activePHA sa ON saup.lcode = sa.lcode -- 筛选original PHA
JOIN originalPHA_user ou ON ou.pha_qui = saup.PHA_qui -- 筛选特定人群fixed-panel
JOIN shenzhen_people_phoneprice_10monthavg_level sp on sp.PHA_qui = saup.PHA_qui -- phoneprice demographics
GROUP bY saup.date, sa.lcode, phoneprice_level
HAVING saup.date = 20191101

SELECT saup.date,
       sa.lcode,
       phoneprice_level,
       COUNT(*) as originalpha_user_num
FROM shenzhen_app_use_people_10month saup -- APP use
JOIN shenzhen_20190501_activePHA sa ON saup.lcode = sa.lcode -- 筛选original PHA
JOIN originalPHA_user ou ON ou.pha_qui = saup.PHA_qui -- 筛选特定人群fixed-panel
JOIN shenzhen_people_phoneprice_10monthavg_level sp on sp.PHA_qui = saup.PHA_qui -- phoneprice demographics
GROUP bY saup.date, sa.lcode, phoneprice_level
HAVING saup.date = 20200501

SELECT saup.date,
       sa.lcode,
       phoneprice_level,
       COUNT(*) as originalpha_user_num
FROM shenzhen_app_use_people_10month saup -- APP use
JOIN shenzhen_20190501_activePHA sa ON saup.lcode = sa.lcode -- 筛选original PHA
JOIN originalPHA_user ou ON ou.pha_qui = saup.PHA_qui -- 筛选特定人群fixed-panel
JOIN shenzhen_people_phoneprice_10monthavg_level sp on sp.PHA_qui = saup.PHA_qui -- phoneprice demographics
GROUP bY saup.date, sa.lcode, phoneprice_level
HAVING saup.date = 20201101

SELECT saup.date,
       sa.lcode,
       phoneprice_level,
       COUNT(*) as originalpha_user_num
FROM shenzhen_app_use_people_10month saup -- APP use
JOIN shenzhen_20190501_activePHA sa ON saup.lcode = sa.lcode -- 筛选original PHA
JOIN originalPHA_user ou ON ou.pha_qui = saup.PHA_qui -- 筛选特定人群fixed-panel
JOIN shenzhen_people_phoneprice_10monthavg_level sp on sp.PHA_qui = saup.PHA_qui -- phoneprice demographics
GROUP bY saup.date, sa.lcode, phoneprice_level
HAVING saup.date = 20210501

SELECT saup.date,
       sa.lcode,
       phoneprice_level,
       COUNT(*) as originalpha_user_num
FROM shenzhen_app_use_people_10month saup -- APP use
JOIN shenzhen_20190501_activePHA sa ON saup.lcode = sa.lcode -- 筛选original PHA
JOIN originalPHA_user ou ON ou.pha_qui = saup.PHA_qui -- 筛选特定人群fixed-panel
JOIN shenzhen_people_phoneprice_10monthavg_level sp on sp.PHA_qui = saup.PHA_qui -- phoneprice demographics
GROUP bY saup.date, sa.lcode, phoneprice_level
HAVING saup.date = 20211101

SELECT saup.date,
       sa.lcode,
       phoneprice_level,
       COUNT(*) as originalpha_user_num
FROM shenzhen_app_use_people_10month saup -- APP use
JOIN shenzhen_20190501_activePHA sa ON saup.lcode = sa.lcode -- 筛选original PHA
JOIN originalPHA_user ou ON ou.pha_qui = saup.PHA_qui -- 筛选特定人群fixed-panel
JOIN shenzhen_people_phoneprice_10monthavg_level sp on sp.PHA_qui = saup.PHA_qui -- phoneprice demographics
GROUP bY saup.date, sa.lcode, phoneprice_level
HAVING saup.date = 20220501

SELECT saup.date,
       sa.lcode,
       phoneprice_level,
       COUNT(*) as originalpha_user_num
FROM shenzhen_app_use_people_10month saup -- APP use
JOIN shenzhen_20190501_activePHA sa ON saup.lcode = sa.lcode -- 筛选original PHA
JOIN originalPHA_user ou ON ou.pha_qui = saup.PHA_qui -- 筛选特定人群fixed-panel
JOIN shenzhen_people_phoneprice_10monthavg_level sp on sp.PHA_qui = saup.PHA_qui -- phoneprice demographics
GROUP bY saup.date, sa.lcode, phoneprice_level
HAVING saup.date = 20221101

SELECT saup.date,
       sa.lcode,
       phoneprice_level,
       COUNT(*) as originalpha_user_num
FROM shenzhen_app_use_people_10month saup -- APP use
JOIN shenzhen_20190501_activePHA sa ON saup.lcode = sa.lcode -- 筛选original PHA
JOIN originalPHA_user ou ON ou.pha_qui = saup.PHA_qui -- 筛选特定人群fixed-panel
JOIN shenzhen_people_phoneprice_10monthavg_level sp on sp.PHA_qui = saup.PHA_qui -- phoneprice demographics
GROUP bY saup.date, sa.lcode, phoneprice_level
HAVING saup.date = 20230501

SELECT saup.date,
       sa.lcode,
       phoneprice_level,
       COUNT(*) as originalpha_user_num
FROM shenzhen_app_use_people_10month saup -- APP use
JOIN shenzhen_20190501_activePHA sa ON saup.lcode = sa.lcode -- 筛选original PHA
JOIN originalPHA_user ou ON ou.pha_qui = saup.PHA_qui -- 筛选特定人群fixed-panel
JOIN shenzhen_people_phoneprice_10monthavg_level sp on sp.PHA_qui = saup.PHA_qui -- phoneprice demographics
GROUP bY saup.date, sa.lcode, phoneprice_level
HAVING saup.date = 20231101




-- newly created PHA income

-- 20191101
SELECT saup.date,
       ncp.pha,
       phoneprice_level,
       COUNT(*) as newpha_user_num
FROM shenzhen_app_use_people_10month saup -- APP use
JOIN newlycreatedPHA ncp ON ncp.pha = saup.lcode
JOIN shenzhen_people_phoneprice_10monthavg_level sp on sp.PHA_qui = saup.PHA_qui -- phoneprice demographics
WHERE saup.date IN (20191101, 20200501, 20201101, 20210501, 20211101, 20220501, 20221101, 20230501, 20231101)
AND createdate = 20191101 -- newly created PHA 20191101
GROUP bY saup.date, ncp.pha, phoneprice_level

-- 20200501
SELECT saup.date,
       ncp.pha,
       phoneprice_level,
       COUNT(*) as newpha_user_num
FROM shenzhen_app_use_people_10month saup -- APP use
JOIN newlycreatedPHA ncp ON ncp.pha = saup.lcode
JOIN shenzhen_people_phoneprice_10monthavg_level sp on sp.PHA_qui = saup.PHA_qui -- phoneprice demographics
WHERE saup.date IN (20200501, 20201101, 20210501, 20211101, 20220501, 20221101, 20230501, 20231101)
AND createdate = 20200501 -- newly created PHA 20200501
GROUP bY saup.date, ncp.pha, phoneprice_level


-- 20201101
SELECT saup.date,
       ncp.pha,
       phoneprice_level,
       COUNT(*) as newpha_user_num
FROM shenzhen_app_use_people_10month saup -- APP use
JOIN newlycreatedPHA ncp ON ncp.pha = saup.lcode
JOIN shenzhen_people_phoneprice_10monthavg_level sp on sp.PHA_qui = saup.PHA_qui -- phoneprice demographics
WHERE saup.date IN (20201101, 20210501, 20211101, 20220501, 20221101, 20230501, 20231101)
AND createdate = 20201101 -- newly created PHA 20201101
GROUP bY saup.date, ncp.pha, phoneprice_level

-- new补充
-- 20210501
SELECT saup.date,
       ncp.pha,
       phoneprice_level,
       COUNT(*) as newpha_user_num
FROM shenzhen_app_use_people_10month saup -- APP use
JOIN newlycreatedPHA ncp ON ncp.pha = saup.lcode
JOIN shenzhen_people_phoneprice_10monthavg_level sp on sp.PHA_qui = saup.PHA_qui -- phoneprice demographics
WHERE saup.date IN (20210501, 20211101, 20220501, 20221101, 20230501, 20231101)
AND createdate = 20210501 -- newly created PHA 20210501
GROUP bY saup.date, ncp.pha, phoneprice_level


-- 20211101
SELECT saup.date,
       ncp.pha,
       phoneprice_level,
       COUNT(*) as newpha_user_num
FROM shenzhen_app_use_people_10month saup -- APP use
JOIN newlycreatedPHA ncp ON ncp.pha = saup.lcode
JOIN shenzhen_people_phoneprice_10monthavg_level sp on sp.PHA_qui = saup.PHA_qui -- phoneprice demographics
WHERE saup.date IN (20211101, 20220501, 20221101, 20230501, 20231101)
AND createdate = 20211101 -- newly created PHA 20211101
GROUP bY saup.date, ncp.pha, phoneprice_level

-- 20221101
SELECT saup.date,
       phoneprice_level,
       COUNT(*) as newpha_user_num
FROM shenzhen_app_use_people_10month saup -- APP use
JOIN newlycreatedPHA ncp ON ncp.pha = saup.lcode
JOIN shenzhen_people_phoneprice_10monthavg_level sp on sp.PHA_qui = saup.PHA_qui -- phoneprice demographics
WHERE saup.date IN (20221101, 20230501, 20231101)
AND createdate = 20221101 -- newly created PHA 20221101
GROUP bY saup.date, ncp.pha, phoneprice_level


-- 20231101
SELECT saup.date,
       ncp.pha,
       phoneprice_level,
       COUNT(*) as newpha_user_num
FROM shenzhen_app_use_people_10month saup -- APP use
JOIN newlycreatedPHA ncp ON ncp.pha = saup.lcode
JOIN shenzhen_people_phoneprice_10monthavg_level sp on sp.PHA_qui = saup.PHA_qui -- phoneprice demographics
WHERE saup.date = 20231101
AND createdate = 20231101 -- newly created PHA 20231101
GROUP bY saup.date, ncp.pha, phoneprice_level




-- other APP list
DROP TABLE IF EXISTS shenzhen_otherAPPuse;
create table shenzhen_otherAPPuse AS
SELECT DISTINCT saup.lcode
FROM shenzhen_app_use_people_10month saup
JOIN shenzhen_app_use_filtered sauf ON sauf.PHA_qui = saup.PHA_qui -- 567101 population
LEFT JOIN PHA_APPlist_distinc



-- other APP age
-- 文件太大跑不出来，分组
-- GROUP 1
SELECT saup.date,
       so.lcode, 
       age,
       COUNT(*) as otherapp_user_num
FROM shenzhen_app_use_people_10month saup -- APP use
JOIN shenzhen_otherAPPuse so ON saup.lcode = so.lcode -- other APP
JOIN shenzhen_20190501_users_filtered suf on suf.PHA_qui = saup.PHA_qui -- 20190501 demographics
WHERE saup.date = 20190501
GROUP bY saup.date, so.lcode, age

-- GROUP 2
SELECT saup.date,
       so.lcode, 
       age,
       COUNT(*) as otherapp_user_num
FROM shenzhen_app_use_people_10month saup -- APP use
JOIN shenzhen_otherAPPuse so ON saup.lcode = so.lcode -- other APP
JOIN shenzhen_20190501_users_filtered suf on suf.PHA_qui = saup.PHA_qui -- 20190501 demographics
WHERE saup.date = 20191101
GROUP bY saup.date, so.lcode, age


-- GROUP 3
SELECT saup.date,
       so.lcode,
       age,
       COUNT(*) as otherapp_user_num
FROM shenzhen_app_use_people_10month saup -- APP use
JOIN shenzhen_otherAPPuse so ON saup.lcode = so.lcode -- other APP
JOIN shenzhen_20190501_users_filtered suf on suf.PHA_qui = saup.PHA_qui -- 20190501 demographics
WHERE saup.date = 20200501
GROUP bY saup.date, so.lcode, age


-- GROUP 4
SELECT saup.date,
       so.lcode, 
       age,
       COUNT(*) as otherapp_user_num
FROM shenzhen_app_use_people_10month saup -- APP use
JOIN shenzhen_otherAPPuse so ON saup.lcode = so.lcode -- other APP
JOIN shenzhen_20190501_users_filtered suf on suf.PHA_qui = saup.PHA_qui -- 20190501 demographics
WHERE saup.date = 20201101
GROUP bY saup.date, so.lcode, age


-- GROUP 5
SELECT saup.date,
       so.lcode, 
       age,
       COUNT(*) as otherapp_user_num
FROM shenzhen_app_use_people_10month saup -- APP use
JOIN shenzhen_otherAPPuse so ON saup.lcode = so.lcode -- other APP
JOIN shenzhen_20190501_users_filtered suf on suf.PHA_qui = saup.PHA_qui -- 20190501 demographics
WHERE saup.date = 20210501
GROUP bY saup.date, so.lcode, age


-- GROUP 6
SELECT saup.date,
       so.lcode, 
       age,
       COUNT(*) as otherapp_user_num
FROM shenzhen_app_use_people_10month saup -- APP use
JOIN shenzhen_otherAPPuse so ON saup.lcode = so.lcode -- other APP
JOIN shenzhen_20190501_users_filtered suf on suf.PHA_qui = saup.PHA_qui -- 20190501 demographics
WHERE saup.date = 20211101
GROUP bY saup.date, so.lcode, age


-- GROUP 7
SELECT saup.date,
       so.lcode, 
       age,
       COUNT(*) as otherapp_user_num
FROM shenzhen_app_use_people_10month saup -- APP use
JOIN shenzhen_otherAPPuse so ON saup.lcode = so.lcode -- other APP
JOIN shenzhen_20190501_users_filtered suf on suf.PHA_qui = saup.PHA_qui -- 20190501 demographics
WHERE saup.date = 20220501
GROUP bY saup.date, so.lcode, age


-- GROUP 8
SELECT saup.date,
       so.lcode, 
       age,
       COUNT(*) as otherapp_user_num
FROM shenzhen_app_use_people_10month saup -- APP use
JOIN shenzhen_otherAPPuse so ON saup.lcode = so.lcode -- other APP
JOIN shenzhen_20190501_users_filtered suf on suf.PHA_qui = saup.PHA_qui -- 20190501 demographics
WHERE saup.date = 20221101
GROUP bY saup.date, so.lcode, age


-- GROUP 9
SELECT saup.date,
       so.lcode, 
       age,
       COUNT(*) as otherapp_user_num
FROM shenzhen_app_use_people_10month saup -- APP use
JOIN shenzhen_otherAPPuse so ON saup.lcode = so.lcode -- other APP
JOIN shenzhen_20190501_users_filtered suf on suf.PHA_qui = saup.PHA_qui -- 20190501 demographics
WHERE saup.date = 20230501
GROUP bY saup.date, so.lcode, age

-- GROUP 10
SELECT saup.date,
       so.lcode, 
       age,
       COUNT(*) as otherapp_user_num
FROM shenzhen_app_use_people_10month saup -- APP use
JOIN shenzhen_otherAPPuse so ON saup.lcode = so.lcode -- other APP
JOIN shenzhen_20190501_users_filtered suf on suf.PHA_qui = saup.PHA_qui -- 20190501 demographics
WHERE saup.date = 20231101
GROUP bY saup.date, so.lcode, age





-- other APP gender
-- 文件太大跑不出来，分组
-- GROUP 1
SELECT saup.date,
       so.lcode, 
       gender,
       COUNT(*) as otherapp_user_num
FROM shenzhen_app_use_people_10month saup -- APP use
JOIN shenzhen_otherAPPuse so ON saup.lcode = so.lcode -- other APP
JOIN shenzhen_20190501_users_filtered suf on suf.PHA_qui = saup.PHA_qui -- 20190501 demographics
WHERE saup.date = 20190501
GROUP bY saup.date, so.lcode, gender

-- GROUP 2
SELECT saup.date,
       so.lcode, 
       gender,
       COUNT(*) as otherapp_user_num
FROM shenzhen_app_use_people_10month saup -- APP use
JOIN shenzhen_otherAPPuse so ON saup.lcode = so.lcode -- other APP
JOIN shenzhen_20190501_users_filtered suf on suf.PHA_qui = saup.PHA_qui -- 20190501 demographics
WHERE saup.date = 20191101
GROUP bY saup.date, so.lcode, gender


-- GROUP 3
SELECT saup.date,
       so.lcode,
       gender,
       COUNT(*) as otherapp_user_num
FROM shenzhen_app_use_people_10month saup -- APP use
JOIN shenzhen_otherAPPuse so ON saup.lcode = so.lcode -- other APP
JOIN shenzhen_20190501_users_filtered suf on suf.PHA_qui = saup.PHA_qui -- 20190501 demographics
WHERE saup.date = 20200501
GROUP bY saup.date, so.lcode, gender


-- GROUP 4
SELECT saup.date,
       so.lcode, 
       gender,
       COUNT(*) as otherapp_user_num
FROM shenzhen_app_use_people_10month saup -- APP use
JOIN shenzhen_otherAPPuse so ON saup.lcode = so.lcode -- other APP
JOIN shenzhen_20190501_users_filtered suf on suf.PHA_qui = saup.PHA_qui -- 20190501 demographics
WHERE saup.date = 20201101
GROUP bY saup.date, so.lcode, gender


-- GROUP 5
SELECT saup.date,
       so.lcode, 
       gender,
       COUNT(*) as otherapp_user_num
FROM shenzhen_app_use_people_10month saup -- APP use
JOIN shenzhen_otherAPPuse so ON saup.lcode = so.lcode -- other APP
JOIN shenzhen_20190501_users_filtered suf on suf.PHA_qui = saup.PHA_qui -- 20190501 demographics
WHERE saup.date = 20210501
GROUP bY saup.date, so.lcode, gender


-- GROUP 6
SELECT saup.date,
       so.lcode, 
       gender,
       COUNT(*) as otherapp_user_num
FROM shenzhen_app_use_people_10month saup -- APP use
JOIN shenzhen_otherAPPuse so ON saup.lcode = so.lcode -- other APP
JOIN shenzhen_20190501_users_filtered suf on suf.PHA_qui = saup.PHA_qui -- 20190501 demographics
WHERE saup.date = 20211101
GROUP bY saup.date, so.lcode, gender


-- GROUP 7
SELECT saup.date,
       so.lcode, 
       gender,
       COUNT(*) as otherapp_user_num
FROM shenzhen_app_use_people_10month saup -- APP use
JOIN shenzhen_otherAPPuse so ON saup.lcode = so.lcode -- other APP
JOIN shenzhen_20190501_users_filtered suf on suf.PHA_qui = saup.PHA_qui -- 20190501 demographics
WHERE saup.date = 20220501
GROUP bY saup.date, so.lcode, gender


-- GROUP 8
SELECT saup.date,
       so.lcode, 
       gender,
       COUNT(*) as otherapp_user_num
FROM shenzhen_app_use_people_10month saup -- APP use
JOIN shenzhen_otherAPPuse so ON saup.lcode = so.lcode -- other APP
JOIN shenzhen_20190501_users_filtered suf on suf.PHA_qui = saup.PHA_qui -- 20190501 demographics
WHERE saup.date = 20221101
GROUP bY saup.date, so.lcode, gender


-- GROUP 9
SELECT saup.date,
       so.lcode, 
       gender,
       COUNT(*) as otherapp_user_num
FROM shenzhen_app_use_people_10month saup -- APP use
JOIN shenzhen_otherAPPuse so ON saup.lcode = so.lcode -- other APP
JOIN shenzhen_20190501_users_filtered suf on suf.PHA_qui = saup.PHA_qui -- 20190501 demographics
WHERE saup.date = 20230501
GROUP bY saup.date, so.lcode, gender

-- GROUP 10
SELECT saup.date,
       so.lcode, 
       gender,
       COUNT(*) as otherapp_user_num
FROM shenzhen_app_use_people_10month saup -- APP use
JOIN shenzhen_otherAPPuse so ON saup.lcode = so.lcode -- other APP
JOIN shenzhen_20190501_users_filtered suf on suf.PHA_qui = saup.PHA_qui -- 20190501 demographics
WHERE saup.date = 20231101
GROUP bY saup.date, so.lcode, gender






-- other APP income
SELECT saup.date,
       so.lcode,
       phoneprice_level,
       COUNT(*) as otherapp_user_num
FROM shenzhen_app_use_people_10month saup -- APP use
JOIN shenzhen_otherAPPuse so ON saup.lcode = so.lcode -- other APP
JOIN shenzhen_people_phoneprice_10monthavg_level sp on sp.PHA_qui = saup.PHA_qui -- phoneprice demographics
GROUP bY saup.date, so.lcode, phoneprice_level
HAVING saup.date = 20190501

-- 20191101
SELECT saup.date,
       so.lcode,
       phoneprice_level,
       COUNT(*) as otherapp_user_num
FROM shenzhen_app_use_people_10month saup -- APP use
JOIN shenzhen_otherAPPuse so ON saup.lcode = so.lcode -- other APP
JOIN shenzhen_people_phoneprice_10monthavg_level sp on sp.PHA_qui = saup.PHA_qui -- phoneprice demographics
GROUP bY saup.date, so.lcode, phoneprice_level
HAVING saup.date = 20191101


-- 20200501
SELECT saup.date,
       so.lcode,
       phoneprice_level,
       COUNT(*) as otherapp_user_num
FROM shenzhen_app_use_people_10month saup -- APP use
JOIN shenzhen_otherAPPuse so ON saup.lcode = so.lcode -- other APP
JOIN shenzhen_people_phoneprice_10monthavg_level sp on sp.PHA_qui = saup.PHA_qui -- phoneprice demographics
GROUP bY saup.date, so.lcode, phoneprice_level
HAVING saup.date = 20200501

-- 20201101
SELECT saup.date,
       so.lcode,
       phoneprice_level,
       COUNT(*) as otherapp_user_num
FROM shenzhen_app_use_people_10month saup -- APP use
JOIN shenzhen_otherAPPuse so ON saup.lcode = so.lcode -- other APP
JOIN shenzhen_people_phoneprice_10monthavg_level sp on sp.PHA_qui = saup.PHA_qui -- phoneprice demographics
GROUP bY saup.date, so.lcode, phoneprice_level
HAVING saup.date = 20201101


-- 20210501
SELECT saup.date,
       so.lcode,
       phoneprice_level,
       COUNT(*) as otherapp_user_num
FROM shenzhen_app_use_people_10month saup -- APP use
JOIN shenzhen_otherAPPuse so ON saup.lcode = so.lcode -- other APP
JOIN shenzhen_people_phoneprice_10monthavg_level sp on sp.PHA_qui = saup.PHA_qui -- phoneprice demographics
GROUP bY saup.date, so.lcode, phoneprice_level
HAVING saup.date = 20210501

-- 20211101
SELECT saup.date,
       so.lcode,
       phoneprice_level,
       COUNT(*) as otherapp_user_num
FROM shenzhen_app_use_people_10month saup -- APP use
JOIN shenzhen_otherAPPuse so ON saup.lcode = so.lcode -- other APP
JOIN shenzhen_people_phoneprice_10monthavg_level sp on sp.PHA_qui = saup.PHA_qui -- phoneprice demographics
GROUP bY saup.date, so.lcode, phoneprice_level
HAVING saup.date = 20211101

-- 20220501
SELECT saup.date,
       so.lcode,
       phoneprice_level,
       COUNT(*) as otherapp_user_num
FROM shenzhen_app_use_people_10month saup -- APP use
JOIN shenzhen_otherAPPuse so ON saup.lcode = so.lcode -- other APP
JOIN shenzhen_people_phoneprice_10monthavg_level sp on sp.PHA_qui = saup.PHA_qui -- phoneprice demographics
GROUP bY saup.date, so.lcode, phoneprice_level
HAVING saup.date = 20220501

-- 20221101
SELECT saup.date,
       so.lcode,
       phoneprice_level,
       COUNT(*) as otherapp_user_num
FROM shenzhen_app_use_people_10month saup -- APP use
JOIN shenzhen_otherAPPuse so ON saup.lcode = so.lcode -- other APP
JOIN shenzhen_people_phoneprice_10monthavg_level sp on sp.PHA_qui = saup.PHA_qui -- phoneprice demographics
GROUP bY saup.date, so.lcode, phoneprice_level
HAVING saup.date = 20221101

-- 20230501
SELECT saup.date,
       so.lcode,
       phoneprice_level,
       COUNT(*) as otherapp_user_num
FROM shenzhen_app_use_people_10month saup -- APP use
JOIN shenzhen_otherAPPuse so ON saup.lcode = so.lcode -- other APP
JOIN shenzhen_people_phoneprice_10monthavg_level sp on sp.PHA_qui = saup.PHA_qui -- phoneprice demographics
GROUP bY saup.date, so.lcode, phoneprice_level
HAVING saup.date = 20230501

-- 20231101
SELECT saup.date,
       so.lcode,
       phoneprice_level,
       COUNT(*) as otherapp_user_num
FROM shenzhen_app_use_people_10month saup -- APP use
JOIN shenzhen_otherAPPuse so ON saup.lcode = so.lcode -- other APP
JOIN shenzhen_people_phoneprice_10monthavg_level sp on sp.PHA_qui = saup.PHA_qui -- phoneprice demographics
GROUP bY saup.date, so.lcode, phoneprice_level
HAVING saup.date = 20231101


