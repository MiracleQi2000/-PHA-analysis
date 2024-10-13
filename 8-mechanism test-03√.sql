
-- 0925 mechanism test

-- mechanism 1
-- 需要fixed-panel
-- 使用初始age group

-- 仅保留10个月都有app使用记录的人的qui（和demographics匹配用） -- previous code as a hint
DROP TABLE IF EXISTS shenzhen_app_use_filtered;
CREATE TABLE shenzhen_app_use_filtered AS
SELECT PHA_qui
FROM shenzhen_app_use_eachmonth_count_filter0
GROUP BY PHA_qui
HAVING COUNT (*) = 10

-- 不要original user
-- original PHA

-- original PHA age
SELECT saup.date,
       sa.lcode,
       suf.age,
       COUNT(*) as originalpha_user_num
FROM shenzhen_app_use_people_10month saup -- APP use
JOIN shenzhen_20190501_activePHA sa ON saup.lcode = sa.lcode -- 筛选original PHA
JOIN shenzhen_20190501_users_filtered suf ON suf.PHA_qui = saup.PHA_qui -- 使用20190501的demographics，同时筛选出567101人
GROUP bY saup.date, sa.lcode, suf.age
-- 个人信息 年龄以第一年为准 205*11*10

-- original PHA gender
SELECT saup.date,
       sa.lcode,
       suf.gender,
       COUNT(*) as originalpha_user_num
FROM shenzhen_app_use_people_10month saup -- APP use
JOIN shenzhen_20190501_activePHA sa ON saup.lcode = sa.lcode -- 筛选original PHA
JOIN shenzhen_20190501_users_filtered suf on suf.PHA_qui = saup.PHA_qui -- 使用20190501的demographics
GROUP bY saup.date, sa.lcode, suf.gender
-- 205*2*10

-- original PHA income
SELECT saup.date,
       sa.lcode,
       sp.phoneprice_level,
       COUNT(*) as originalpha_user_num
FROM shenzhen_app_use_people_10month saup -- APP use
JOIN shenzhen_20190501_activePHA sa ON saup.lcode = sa.lcode -- original PHA
JOIN shenzhen_people_phoneprice_10monthavg_level sp on sp.PHA_qui = saup.PHA_qui -- phoneprice demographics
GROUP bY saup.date, sa.lcode, sp.phoneprice_level


-- 把user总数少于50的去掉
DROP TABLE IF EXISTS shenzhen_APP_deduplicate_userlargerthan50;
CREATE TABLE shenzhen_APP_deduplicate_userlargerthan50 AS
SELECT 
    lcode,
    COUNT(DISTINCT pha_qui) AS lcode_usernum
FROM shenzhen_APP_deduplicate
GROUP BY lcode
HAVING COUNT(DISTINCT pha_qui) > 50


-- newly created Other APP
DROP TABLE IF EXISTS shenzhen_otherAPP_createdtime;
CREATE TABLE shenzhen_otherAPP_createdtime AS
SELECT
    sadu.lcode,
    date,
    ROW_NUMBER() OVER (PARTITION BY sadu.lcode ORDER BY date) AS appearorder
FROM shenzhen_APP_deduplicate sad
JOIN shenzhen_APP_deduplicate_userlargerthan50 sadu ON sadu.lcode = sad.lcode
WHERE date IN (20190501, 20191101, 20200501, 20201101, 20210501, 20211101, 20220501, 20221101, 20230501, 20231101)


DROP TABLE IF EXISTS shenzhen_otherapp_createtime_largerthan50;
CREATE TABLE shenzhen_otherapp_createtime_largerthan50 AS
SELECT
    lcode,
    date AS createdtime
FROM shenzhen_otherAPP_createdtime
WHERE appearorder = 1  -- 只选择每个 lcode 的首次出现
ORDER BY createdtime;  -- 按日期排序

SELECT createdtime,
       COUNT(*) as otherAPP_num
FROM shenzhen_otherapp_createtime_largerthan50
GROUP BY createdtime


-- 看一下user number小于等于50的Other APP数量
DROP TABLE IF EXISTS shenzhen_APP_deduplicate_userlessthan50;
CREATE TABLE shenzhen_APP_deduplicate_userlessthan50 AS
SELECT 
    lcode,
    COUNT(DISTINCT pha_qui) AS lcode_usernum
FROM shenzhen_APP_deduplicate
GROUP BY lcode
HAVING COUNT(DISTINCT pha_qui) <= 50


-- newly created Other APP
DROP TABLE IF EXISTS shenzhen_otherAPP_createdtime_userlessthan50;
CREATE TABLE shenzhen_otherAPP_createdtime_userlessthan50 AS
SELECT
    sadu.lcode,
    date,
    ROW_NUMBER() OVER (PARTITION BY sadu.lcode ORDER BY date) AS appearorder
FROM shenzhen_APP_deduplicate sad
JOIN shenzhen_APP_deduplicate_userlessthan50 sadu ON sadu.lcode = sad.lcode
WHERE date IN (20190501, 20191101, 20200501, 20201101, 20210501, 20211101, 20220501, 20221101, 20230501, 20231101)


DROP TABLE IF EXISTS shenzhen_otherapp_createtime_lessthan50;
CREATE TABLE shenzhen_otherapp_createtime_lessthan50 AS
SELECT
    lcode,
    date AS createdtime
FROM shenzhen_otherAPP_createdtime_userlessthan50
WHERE appearorder = 1  -- 只选择每个 lcode 的首次出现
ORDER BY createdtime;  -- 按日期排序

SELECT createdtime,
       COUNT(*) as otherAPP_num
FROM shenzhen_otherapp_createtime_lessthan50
GROUP BY createdtime

SELECT date, count(DISTINCT lcode) as appnum
FROM shenzhen_APP_deduplicate
WHERE date IN (20190501, 20191101, 20200501, 20201101, 20210501, 20211101, 20220501, 20221101, 20230501, 20231101)
GROUP BY date



-- 直接把age和income level都换成可计算的值，计算均值后再导出
DROP TABLE IF EXISTS shenzhen_20190501_users_filtered_avgagenum;
CREATE TABLE shenzhen_20190501_users_filtered_avgagenum AS
SELECT
  pha_qui,
  date,
  age,
  gender,
  brand,
  type,
  CASE 
        WHEN age = '05' THEN 21.5
        WHEN age = '06' THEN 27
        WHEN age = '07' THEN 32
        WHEN age = '08' THEN 37
        WHEN age = '09' THEN 42
        WHEN age = '10' THEN 47
        WHEN age = '11' THEN 52
        WHEN age = '12' THEN 57
        WHEN age = '13' THEN 62
        WHEN age = '14' THEN 67
        WHEN age = '15' THEN 72
        ELSE NULL
    END AS age_avgnum_eachgroup
FROM shenzhen_20190501_users_filtered
WHERE age IN ('05', '06', '07', '08', '09', '10', '11', '12', '13', '14', '15')  -- 仅保留特定年龄组

DROP TABLE IF EXISTS shenzhen_20190501_users_filtered_gendernum;
CREATE TABLE shenzhen_20190501_users_filtered_gendernum AS
SELECT
  pha_qui,
  date,
  age,
  gender,
  brand,
  type,
CASE
      WHEN gender = '01' THEN 0 -- male
      WHEN gender = '02' THEN 1 -- female
      ELSE NULL
    END AS gender_num
FROM shenzhen_20190501_users_filtered
WHERE gender IN ('01','02') -- 将1-男性记为0, 2-女性记为1，均值即为女性比例

DROP TABLE IF EXISTS shenzhen_people_phoneprice_10monthavg_level_num;
CREATE TABLE shenzhen_people_phoneprice_10monthavg_level_num AS
SELECT PHA_qui,
         CASE 
        WHEN phoneprice_level = 'level1' THEN 1
        WHEN phoneprice_level = 'level2' THEN 2
        WHEN phoneprice_level = 'level3' THEN 3
        WHEN phoneprice_level = 'level4' THEN 4
        WHEN phoneprice_level = 'level5' THEN 5
        WHEN phoneprice_level = 'level6' THEN 6
        WHEN phoneprice_level = 'level7' THEN 7
        WHEN phoneprice_level = 'level8' THEN 8
        WHEN phoneprice_level = 'level9' THEN 9
        WHEN phoneprice_level = 'level10' THEN 10
        ELSE NULL
    END AS phoneprice_level_num
FROM shenzhen_people_phoneprice_10monthavg_level

select age, count(*)
from shenzhen_20190501_users_filtered
group by age

select gender, count(*)
from shenzhen_20190501_users_filtered
group by gender

select phoneprice_level, count(*)
from shenzhen_people_phoneprice_10monthavg_level
group by phoneprice_level


SELECT age_avgnum_eachgroup, count(*)
from shenzhen_20190501_users_filtered_avgagenum
group by age_avgnum_eachgroup

SELECT gender_num, count(*)
from shenzhen_20190501_users_filtered_gendernum
group by gender_num

SELECT phoneprice_level_num, count(*)
from shenzhen_people_phoneprice_10monthavg_level_num
group by phoneprice_level_num

-- original PHA

-- original PHA age
SELECT saup.date,
       sa.lcode,
       AVG(suf.age_avgnum_eachgroup) AS avg_age
FROM shenzhen_app_use_people_10month saup -- APP use
JOIN shenzhen_20190501_activePHA sa ON saup.lcode = sa.lcode -- 筛选original PHA
JOIN shenzhen_20190501_users_filtered_avgagenum suf ON suf.PHA_qui = saup.PHA_qui  -- 20190501 demographics age已处理
GROUP bY saup.date, sa.lcode

-- original PHA gender
SELECT saup.date,
       sa.lcode,
       AVG(gender_num) AS female_pro
FROM shenzhen_app_use_people_10month saup -- APP use
JOIN shenzhen_20190501_activePHA sa ON saup.lcode = sa.lcode -- 筛选original PHA
JOIN shenzhen_20190501_users_filtered_avgage_gender suf ON suf.PHA_qui = saup.PHA_qui  -- 20190501 demographics age已处理
GROUP bY saup.date, sa.lcode

-- original PHA income
SELECT saup.date,
       sa.lcode,
       AVG(phoneprice_level_num) AS avg_income
FROM shenzhen_app_use_people_10month saup -- APP use
JOIN shenzhen_20190501_activePHA sa ON saup.lcode = sa.lcode -- original PHA
JOIN shenzhen_people_phoneprice_10monthavg_level_num sp on sp.PHA_qui = saup.PHA_qui -- phoneprice demographics income已处理
GROUP bY saup.date, sa.lcode





-- original other APP age
SELECT
    saup.date,
    so.lcode,
    AVG(age_avgnum_eachgroup) AS avg_age
FROM shenzhen_app_use_people_10month saup  -- APP use
JOIN shenzhen_otherapp_createtime_largerthan50 so ON saup.lcode = so.lcode  -- original other APP 
JOIN shenzhen_20190501_users_filtered_age_avgnum suf ON suf.PHA_qui = saup.PHA_qui  -- 20190501 demographics age已处理
WHERE so.createdtime = 20190501 -- original other APP
GROUP BY saup.date, so.lcode  -- 按日期和 lcode 分组
-- 违规跑不出来

-- original other APP age
-- originalpha_user_num变量名没有修改，后面都用了这个
SELECT
    saup.date,
    so.lcode,
    suf.age,
    COUNT(*) as originalpha_user_num
FROM shenzhen_app_use_people_10month saup  -- APP use
JOIN shenzhen_otherapp_createtime_largerthan50 so ON saup.lcode = so.lcode  -- original other APP 
JOIN shenzhen_20190501_users_filtered suf ON suf.PHA_qui = saup.PHA_qui -- 使用20190501的demographics，同时筛选出567101人
WHERE so.createdtime = 20190501 -- original other APP
AND saup.date IN (20190501, 20191101, 20200501, 20201101, 20210501, 20211101, 20220501, 20221101, 20230501, 20231101)
AND age IN ('05', '06', '07', '08', '09', '10', '11', '12', '13', '14', '15')
GROUP BY saup.date, so.lcode, suf.age

-- original other APP gender

SELECT saup.date,
       so.lcode,
       AVG(gender_num) AS female_pro
FROM shenzhen_app_use_people_10month saup -- APP use
JOIN shenzhen_otherapp_createtime_largerthan50 so ON saup.lcode = so.lcode -- original other APP 
JOIN shenzhen_20190501_users_filtered_gendernum suf ON suf.PHA_qui = saup.PHA_qui  -- 20190501 demographics age已处理
WHERE so.createdtime = 20190501 -- original other APP
GROUP bY saup.date, so.lcode



-- original other APP income
SELECT saup.date,
       so.lcode,
       AVG(phoneprice_level_num) AS avg_income
FROM shenzhen_app_use_people_10month saup -- APP use
JOIN shenzhen_otherapp_createtime_largerthan50 so ON saup.lcode = so.lcode -- original other APP 
JOIN shenzhen_people_phoneprice_10monthavg_level_num sp on sp.PHA_qui = saup.PHA_qui -- phoneprice demographics income已处理
WHERE so.createdtime = 20190501 -- original other APP
GROUP bY saup.date, so.lcode


-- other APP age
-- 20191101
SELECT
    saup.date,
    so.lcode,
    suf.age,
    COUNT(*) as originalpha_user_num
FROM shenzhen_app_use_people_10month saup  -- APP use
JOIN shenzhen_otherapp_createtime_largerthan50 so ON saup.lcode = so.lcode  -- original other APP 
JOIN shenzhen_20190501_users_filtered suf ON suf.PHA_qui = saup.PHA_qui -- 使用20190501的demographics，同时筛选出567101人
WHERE so.createdtime = 20191101
AND saup.date IN (20191101, 20200501, 20201101, 20210501, 20211101, 20220501, 20221101, 20230501, 20231101)
AND age IN ('05', '06', '07', '08', '09', '10', '11', '12', '13', '14', '15')
GROUP BY saup.date, so.lcode, suf.age

-- 20200501
SELECT
    saup.date,
    so.lcode,
    suf.age,
    COUNT(*) as originalpha_user_num
FROM shenzhen_app_use_people_10month saup  -- APP use
JOIN shenzhen_otherapp_createtime_largerthan50 so ON saup.lcode = so.lcode  -- original other APP 
JOIN shenzhen_20190501_users_filtered suf ON suf.PHA_qui = saup.PHA_qui -- 使用20190501的demographics，同时筛选出567101人
WHERE so.createdtime = 20200501
AND saup.date IN (20200501, 20201101, 20210501, 20211101, 20220501, 20221101, 20230501, 20231101)
AND age IN ('05', '06', '07', '08', '09', '10', '11', '12', '13', '14', '15')
GROUP BY saup.date, so.lcode, suf.age

-- 20201101
SELECT
    saup.date,
    so.lcode,
    suf.age,
    COUNT(*) as originalpha_user_num
FROM shenzhen_app_use_people_10month saup  -- APP use
JOIN shenzhen_otherapp_createtime_largerthan50 so ON saup.lcode = so.lcode  -- original other APP 
JOIN shenzhen_20190501_users_filtered suf ON suf.PHA_qui = saup.PHA_qui -- 使用20190501的demographics，同时筛选出567101人
WHERE so.createdtime = 20201101
AND saup.date IN (20201101, 20210501, 20211101, 20220501, 20221101, 20230501, 20231101)
AND age IN ('05', '06', '07', '08', '09', '10', '11', '12', '13', '14', '15')
GROUP BY saup.date, so.lcode, suf.age

-- 20210501
SELECT
    saup.date,
    so.lcode,
    suf.age,
    COUNT(*) as originalpha_user_num
FROM shenzhen_app_use_people_10month saup  -- APP use
JOIN shenzhen_otherapp_createtime_largerthan50 so ON saup.lcode = so.lcode  -- original other APP 
JOIN shenzhen_20190501_users_filtered suf ON suf.PHA_qui = saup.PHA_qui -- 使用20190501的demographics，同时筛选出567101人
WHERE so.createdtime = 20210501
AND saup.date IN (20210501, 20211101, 20220501, 20221101, 20230501, 20231101)
AND age IN ('05', '06', '07', '08', '09', '10', '11', '12', '13', '14', '15')
GROUP BY saup.date, so.lcode, suf.age

-- 20211101
SELECT
    saup.date,
    so.lcode,
    suf.age,
    COUNT(*) as originalpha_user_num
FROM shenzhen_app_use_people_10month saup  -- APP use
JOIN shenzhen_otherapp_createtime_largerthan50 so ON saup.lcode = so.lcode  -- original other APP 
JOIN shenzhen_20190501_users_filtered suf ON suf.PHA_qui = saup.PHA_qui -- 使用20190501的demographics，同时筛选出567101人
WHERE so.createdtime = 20211101
AND saup.date IN (20211101, 20220501, 20221101, 20230501, 20231101)
AND age IN ('05', '06', '07', '08', '09', '10', '11', '12', '13', '14', '15')
GROUP BY saup.date, so.lcode, suf.age

-- 20220501
SELECT
    saup.date,
    so.lcode,
    suf.age,
    COUNT(*) as originalpha_user_num
FROM shenzhen_app_use_people_10month saup  -- APP use
JOIN shenzhen_otherapp_createtime_largerthan50 so ON saup.lcode = so.lcode  -- original other APP 
JOIN shenzhen_20190501_users_filtered suf ON suf.PHA_qui = saup.PHA_qui -- 使用20190501的demographics，同时筛选出567101人
WHERE so.createdtime = 20220501
AND saup.date IN (20220501, 20221101, 20230501, 20231101)
AND age IN ('05', '06', '07', '08', '09', '10', '11', '12', '13', '14', '15')
GROUP BY saup.date, so.lcode, suf.age

-- 20221101
SELECT
    saup.date,
    so.lcode,
    suf.age,
    COUNT(*) as originalpha_user_num
FROM shenzhen_app_use_people_10month saup  -- APP use
JOIN shenzhen_otherapp_createtime_largerthan50 so ON saup.lcode = so.lcode  -- original other APP 
JOIN shenzhen_20190501_users_filtered suf ON suf.PHA_qui = saup.PHA_qui -- 使用20190501的demographics，同时筛选出567101人
WHERE so.createdtime = 20221101
AND saup.date IN (20221101, 20230501, 20231101)
AND age IN ('05', '06', '07', '08', '09', '10', '11', '12', '13', '14', '15')
GROUP BY saup.date, so.lcode, suf.age

-- 20230501
SELECT
    saup.date,
    so.lcode,
    suf.age,
    COUNT(*) as originalpha_user_num
FROM shenzhen_app_use_people_10month saup  -- APP use
JOIN shenzhen_otherapp_createtime_largerthan50 so ON saup.lcode = so.lcode  -- original other APP 
JOIN shenzhen_20190501_users_filtered suf ON suf.PHA_qui = saup.PHA_qui -- 使用20190501的demographics，同时筛选出567101人
WHERE so.createdtime = 20230501
AND saup.date IN (20230501, 20231101)
AND age IN ('05', '06', '07', '08', '09', '10', '11', '12', '13', '14', '15')
GROUP BY saup.date, so.lcode, suf.age

-- 20231101
SELECT
    saup.date,
    so.lcode,
    suf.age,
    COUNT(*) as originalpha_user_num
FROM shenzhen_app_use_people_10month saup  -- APP use
JOIN shenzhen_otherapp_createtime_largerthan50 so ON saup.lcode = so.lcode  -- original other APP 
JOIN shenzhen_20190501_users_filtered suf ON suf.PHA_qui = saup.PHA_qui -- 使用20190501的demographics，同时筛选出567101人
WHERE so.createdtime = 20231101
AND saup.date = 20231101
AND age IN ('05', '06', '07', '08', '09', '10', '11', '12', '13', '14', '15')
GROUP BY saup.date, so.lcode, suf.age





-- other APP gender
-- 20191101
SELECT saup.date,
       so.lcode,
       AVG(gender_num) AS female_pro
FROM shenzhen_app_use_people_10month saup -- APP use
JOIN shenzhen_otherapp_createtime_largerthan50 so ON saup.lcode = so.lcode -- original other APP 
JOIN shenzhen_20190501_users_filtered_gendernum suf ON suf.PHA_qui = saup.PHA_qui  -- 20190501 demographics gender已处理
WHERE so.createdtime = 20191101
AND saup.date IN (20191101, 20200501, 20201101, 20210501, 20211101, 20220501, 20221101, 20230501, 20231101)
GROUP bY saup.date, so.lcode


-- 20200501
SELECT
    saup.date,
    so.lcode,
    AVG(gender_num) AS female_pro
FROM shenzhen_app_use_people_10month saup  -- APP use
JOIN shenzhen_otherapp_createtime_largerthan50 so ON saup.lcode = so.lcode  -- original other APP 
JOIN shenzhen_20190501_users_filtered_gendernum suf ON suf.PHA_qui = saup.PHA_qui  -- 20190501 demographics gender已处理
WHERE so.createdtime = 20200501
AND saup.date IN (20200501, 20201101, 20210501, 20211101, 20220501, 20221101, 20230501, 20231101)
GROUP BY saup.date, so.lcode


-- 20201101
SELECT
    saup.date,
    so.lcode,
    AVG(gender_num) AS female_pro
FROM shenzhen_app_use_people_10month saup  -- APP use
JOIN shenzhen_otherapp_createtime_largerthan50 so ON saup.lcode = so.lcode  -- original other APP 
JOIN shenzhen_20190501_users_filtered_gendernum suf ON suf.PHA_qui = saup.PHA_qui  -- 20190501 demographics gender已处理
WHERE so.createdtime = 20201101
AND saup.date IN (20201101, 20210501, 20211101, 20220501, 20221101, 20230501, 20231101)
GROUP BY saup.date, so.lcode


-- 20210501
SELECT
    saup.date,
    so.lcode,
    AVG(gender_num) AS female_pro
FROM shenzhen_app_use_people_10month saup  -- APP use
JOIN shenzhen_otherapp_createtime_largerthan50 so ON saup.lcode = so.lcode  -- original other APP 
JOIN shenzhen_20190501_users_filtered_gendernum suf ON suf.PHA_qui = saup.PHA_qui  -- 20190501 demographics gender已处理
WHERE so.createdtime = 20210501
AND saup.date IN (20210501, 20211101, 20220501, 20221101, 20230501, 20231101)
GROUP BY saup.date, so.lcode


-- 20211101
SELECT
    saup.date,
    so.lcode,
    AVG(gender_num) AS female_pro
FROM shenzhen_app_use_people_10month saup  -- APP use
JOIN shenzhen_otherapp_createtime_largerthan50 so ON saup.lcode = so.lcode  -- original other APP 
JOIN shenzhen_20190501_users_filtered_gendernum suf ON suf.PHA_qui = saup.PHA_qui  -- 20190501 demographics gender已处理
WHERE so.createdtime = 20211101
AND saup.date IN (20211101, 20220501, 20221101, 20230501, 20231101)
GROUP BY saup.date, so.lcode


-- 20220501
SELECT
    saup.date,
    so.lcode,
    AVG(gender_num) AS female_pro
FROM shenzhen_app_use_people_10month saup  -- APP use
JOIN shenzhen_otherapp_createtime_largerthan50 so ON saup.lcode = so.lcode  -- original other APP 
JOIN shenzhen_20190501_users_filtered_gendernum suf ON suf.PHA_qui = saup.PHA_qui  -- 20190501 demographics gender已处理
WHERE so.createdtime = 20220501
AND saup.date IN (20220501, 20221101, 20230501, 20231101)
GROUP BY saup.date, so.lcode



-- 20221101
SELECT
    saup.date,
    so.lcode,
    AVG(gender_num) AS female_pro
FROM shenzhen_app_use_people_10month saup  -- APP use
JOIN shenzhen_otherapp_createtime_largerthan50 so ON saup.lcode = so.lcode  -- original other APP 
JOIN shenzhen_20190501_users_filtered_gendernum suf ON suf.PHA_qui = saup.PHA_qui  -- 20190501 demographics gender已处理
WHERE so.createdtime = 20221101
AND saup.date IN (20221101, 20230501, 20231101)
GROUP BY saup.date, so.lcode

-- 20230501
SELECT
    saup.date,
    so.lcode,
    AVG(gender_num) AS female_pro
FROM shenzhen_app_use_people_10month saup  -- APP use
JOIN shenzhen_otherapp_createtime_largerthan50 so ON saup.lcode = so.lcode  -- original other APP 
JOIN shenzhen_20190501_users_filtered_gendernum suf ON suf.PHA_qui = saup.PHA_qui  -- 20190501 demographics gender已处理
WHERE so.createdtime = 20230501
AND saup.date IN (20230501, 20231101)
GROUP BY saup.date, so.lcode

-- 20231101
SELECT
    saup.date,
    so.lcode,
    AVG(gender_num) AS female_pro
FROM shenzhen_app_use_people_10month saup  -- APP use
JOIN shenzhen_otherapp_createtime_largerthan50 so ON saup.lcode = so.lcode  -- original other APP 
JOIN shenzhen_20190501_users_filtered_gendernum suf ON suf.PHA_qui = saup.PHA_qui  -- 20190501 demographics gender已处理
WHERE so.createdtime = 20231101
AND saup.date = 20231101
GROUP BY saup.date, so.lcode



-- other APP income
-- 20191101
SELECT saup.date,
       so.lcode,
       AVG(phoneprice_level_num) AS avg_income
FROM shenzhen_app_use_people_10month saup -- APP use
JOIN shenzhen_otherapp_createtime_largerthan50 so ON saup.lcode = so.lcode -- original other APP 
JOIN shenzhen_people_phoneprice_10monthavg_level_num sp on sp.PHA_qui = saup.PHA_qui -- phoneprice demographics income已处理
WHERE so.createdtime = 20191101
AND saup.date IN (20191101, 20200501, 20201101, 20210501, 20211101, 20220501, 20221101, 20230501, 20231101)
GROUP bY saup.date, so.lcode


-- 20200501
SELECT saup.date,
       so.lcode,
       AVG(phoneprice_level_num) AS avg_income
FROM shenzhen_app_use_people_10month saup -- APP use
JOIN shenzhen_otherapp_createtime_largerthan50 so ON saup.lcode = so.lcode -- original other APP 
JOIN shenzhen_people_phoneprice_10monthavg_level_num sp on sp.PHA_qui = saup.PHA_qui -- phoneprice demographics income已处理
WHERE so.createdtime = 20200501
AND saup.date IN (20200501, 20201101, 20210501, 20211101, 20220501, 20221101, 20230501, 20231101)
GROUP bY saup.date, so.lcode


-- 20201101
SELECT saup.date,
       so.lcode,
       AVG(phoneprice_level_num) AS avg_income
FROM shenzhen_app_use_people_10month saup -- APP use
JOIN shenzhen_otherapp_createtime_largerthan50 so ON saup.lcode = so.lcode -- original other APP 
JOIN shenzhen_people_phoneprice_10monthavg_level_num sp on sp.PHA_qui = saup.PHA_qui -- phoneprice demographics income已处理
WHERE so.createdtime = 20201101
AND saup.date IN (20201101, 20210501, 20211101, 20220501, 20221101, 20230501, 20231101)
GROUP bY saup.date, so.lcode


-- 20210501
SELECT saup.date,
       so.lcode,
       AVG(phoneprice_level_num) AS avg_income
FROM shenzhen_app_use_people_10month saup -- APP use
JOIN shenzhen_otherapp_createtime_largerthan50 so ON saup.lcode = so.lcode -- original other APP 
JOIN shenzhen_people_phoneprice_10monthavg_level_num sp on sp.PHA_qui = saup.PHA_qui -- phoneprice demographics income已处理
WHERE so.createdtime = 20210501
AND saup.date IN (20210501, 20211101, 20220501, 20221101, 20230501, 20231101)
GROUP bY saup.date, so.lcode


-- 20211101
SELECT saup.date,
       so.lcode,
       AVG(phoneprice_level_num) AS avg_income
FROM shenzhen_app_use_people_10month saup -- APP use
JOIN shenzhen_otherapp_createtime_largerthan50 so ON saup.lcode = so.lcode -- original other APP 
JOIN shenzhen_people_phoneprice_10monthavg_level_num sp on sp.PHA_qui = saup.PHA_qui -- phoneprice demographics income已处理
WHERE so.createdtime = 20211101
AND saup.date IN (20211101, 20220501, 20221101, 20230501, 20231101)
GROUP bY saup.date, so.lcode


-- 20220501
SELECT saup.date,
       so.lcode,
       AVG(phoneprice_level_num) AS avg_income
FROM shenzhen_app_use_people_10month saup -- APP use
JOIN shenzhen_otherapp_createtime_largerthan50 so ON saup.lcode = so.lcode -- original other APP 
JOIN shenzhen_people_phoneprice_10monthavg_level_num sp on sp.PHA_qui = saup.PHA_qui -- phoneprice demographics income已处理
WHERE so.createdtime = 20220501
AND saup.date IN (20220501, 20221101, 20230501, 20231101)
GROUP bY saup.date, so.lcode


-- 20221101
SELECT saup.date,
       so.lcode,
       AVG(phoneprice_level_num) AS avg_income
FROM shenzhen_app_use_people_10month saup -- APP use
JOIN shenzhen_otherapp_createtime_largerthan50 so ON saup.lcode = so.lcode -- original other APP 
JOIN shenzhen_people_phoneprice_10monthavg_level_num sp on sp.PHA_qui = saup.PHA_qui -- phoneprice demographics income已处理
WHERE so.createdtime = 20221101
AND saup.date IN (20221101, 20230501, 20231101)
GROUP bY saup.date, so.lcode


-- 20230501
SELECT saup.date,
       so.lcode,
       AVG(phoneprice_level_num) AS avg_income
FROM shenzhen_app_use_people_10month saup -- APP use
JOIN shenzhen_otherapp_createtime_largerthan50 so ON saup.lcode = so.lcode -- original other APP 
JOIN shenzhen_people_phoneprice_10monthavg_level_num sp on sp.PHA_qui = saup.PHA_qui -- phoneprice demographics income已处理
WHERE so.createdtime = 20230501
AND saup.date IN (20230501, 20231101)
GROUP bY saup.date, so.lcode


-- 20231101
SELECT saup.date,
       so.lcode,
       AVG(phoneprice_level_num) AS avg_income
FROM shenzhen_app_use_people_10month saup -- APP use
JOIN shenzhen_otherapp_createtime_largerthan50 so ON saup.lcode = so.lcode -- original other APP 
JOIN shenzhen_people_phoneprice_10monthavg_level_num sp on sp.PHA_qui = saup.PHA_qui -- phoneprice demographics income已处理
WHERE so.createdtime = 20231101
AND saup.date = 20231101
GROUP bY saup.date, so.lcode




-- newly created PHA
-- newly created PHA gender
-- 20191101
SELECT saup.date,
       ncp.pha,
       AVG(gender_num) AS female_pro
FROM shenzhen_app_use_people_10month saup -- APP use
JOIN newlycreatedPHA ncp ON ncp.pha = saup.lcode -- newly created PHA
JOIN shenzhen_20190501_users_filtered_gendernum suf ON suf.PHA_qui = saup.PHA_qui  -- demographics gender已处理
WHERE ncp.createdate = 20191101 -- newly created PHA 20191101
AND saup.date IN (20191101, 20200501, 20201101, 20210501, 20211101, 20220501, 20221101, 20230501, 20231101)
GROUP bY saup.date, ncp.pha

-- 20200501
SELECT saup.date,
       ncp.pha,
       AVG(gender_num) AS female_pro
FROM shenzhen_app_use_people_10month saup -- APP use
JOIN newlycreatedPHA ncp ON ncp.pha = saup.lcode -- newly created PHA
JOIN shenzhen_20190501_users_filtered_gendernum suf ON suf.PHA_qui = saup.PHA_qui  -- demographics gender已处理
WHERE ncp.createdate = 20200501 -- newly created PHA 20200501
AND saup.date IN (20200501, 20201101, 20210501, 20211101, 20220501, 20221101, 20230501, 20231101)
GROUP bY saup.date, ncp.pha

-- 20201101
SELECT saup.date,
       ncp.pha,
       AVG(gender_num) AS female_pro
FROM shenzhen_app_use_people_10month saup -- APP use
JOIN newlycreatedPHA ncp ON ncp.pha = saup.lcode -- newly created PHA
JOIN shenzhen_20190501_users_filtered_gendernum suf ON suf.PHA_qui = saup.PHA_qui  -- demographics gender已处理
WHERE ncp.createdate = 20201101 -- newly created PHA 20201101
AND saup.date IN (20201101, 20210501, 20211101, 20220501, 20221101, 20230501, 20231101)
GROUP bY saup.date, ncp.pha

-- 20210501
SELECT saup.date,
       ncp.pha,
       AVG(gender_num) AS female_pro
FROM shenzhen_app_use_people_10month saup -- APP use
JOIN newlycreatedPHA ncp ON ncp.pha = saup.lcode -- newly created PHA
JOIN shenzhen_20190501_users_filtered_gendernum suf ON suf.PHA_qui = saup.PHA_qui  -- demographics gender已处理
WHERE ncp.createdate = 20210501 -- newly created PHA 20210501
AND saup.date IN (20210501, 20211101, 20220501, 20221101, 20230501, 20231101)
GROUP bY saup.date, ncp.pha

-- 20211101
SELECT saup.date,
       ncp.pha,
       AVG(gender_num) AS female_pro
FROM shenzhen_app_use_people_10month saup -- APP use
JOIN newlycreatedPHA ncp ON ncp.pha = saup.lcode -- newly created PHA
JOIN shenzhen_20190501_users_filtered_gendernum suf ON suf.PHA_qui = saup.PHA_qui  -- demographics gender已处理
WHERE ncp.createdate = 20211101 -- newly created PHA 20211101
AND saup.date IN (20211101, 20220501, 20221101, 20230501, 20231101)
GROUP bY saup.date, ncp.pha

-- 20220501
SELECT saup.date,
       ncp.pha,
       AVG(gender_num) AS female_pro
FROM shenzhen_app_use_people_10month saup -- APP use
JOIN newlycreatedPHA ncp ON ncp.pha = saup.lcode -- newly created PHA
JOIN shenzhen_20190501_users_filtered_gendernum suf ON suf.PHA_qui = saup.PHA_qui  -- demographics gender已处理
WHERE ncp.createdate = 20220501 -- newly created PHA 20220501
AND saup.date IN (20220501, 20221101, 20230501, 20231101)
GROUP bY saup.date, ncp.pha

-- 20221101
SELECT saup.date,
       ncp.pha,
       AVG(gender_num) AS female_pro
FROM shenzhen_app_use_people_10month saup -- APP use
JOIN newlycreatedPHA ncp ON ncp.pha = saup.lcode -- newly created PHA
JOIN shenzhen_20190501_users_filtered_gendernum suf ON suf.PHA_qui = saup.PHA_qui  -- demographics gender已处理
WHERE ncp.createdate = 20221101 -- newly created PHA 20221101
AND saup.date IN (20221101, 20230501, 20231101)
GROUP bY saup.date, ncp.pha

-- 20230501
SELECT saup.date,
       ncp.pha,
       AVG(gender_num) AS female_pro
FROM shenzhen_app_use_people_10month saup -- APP use
JOIN newlycreatedPHA ncp ON ncp.pha = saup.lcode -- newly created PHA
JOIN shenzhen_20190501_users_filtered_gendernum suf ON suf.PHA_qui = saup.PHA_qui  -- demographics gender已处理
WHERE ncp.createdate = 20230501 -- newly created PHA 20230501
AND saup.date IN (20230501, 20231101)
GROUP bY saup.date, ncp.pha

-- 20231101
SELECT saup.date,
       ncp.pha,
       AVG(gender_num) AS female_pro
FROM shenzhen_app_use_people_10month saup -- APP use
JOIN newlycreatedPHA ncp ON ncp.pha = saup.lcode -- newly created PHA
JOIN shenzhen_20190501_users_filtered_gendernum suf ON suf.PHA_qui = saup.PHA_qui  -- demographics gender已处理
WHERE ncp.createdate = 20231101 -- newly created PHA 20230501
AND saup.date = 20231101
GROUP bY saup.date, ncp.pha


-- newly created PHA income
-- 20191101
SELECT saup.date,
       ncp.pha,
       AVG(phoneprice_level_num) AS avg_income
FROM shenzhen_app_use_people_10month saup -- APP use
JOIN newlycreatedPHA ncp ON ncp.pha = saup.lcode -- newly created PHA
JOIN shenzhen_people_phoneprice_10monthavg_level_num sp on sp.PHA_qui = saup.PHA_qui -- phoneprice demographics income已处理
WHERE ncp.createdate = 20191101 -- newly created PHA 20191101
AND saup.date IN (20191101, 20200501, 20201101, 20210501, 20211101, 20220501, 20221101, 20230501, 20231101)
GROUP bY saup.date, ncp.pha

-- 20200501
SELECT saup.date,
       ncp.pha,
       AVG(phoneprice_level_num) AS avg_income
FROM shenzhen_app_use_people_10month saup -- APP use
JOIN newlycreatedPHA ncp ON ncp.pha = saup.lcode -- newly created PHA
JOIN shenzhen_people_phoneprice_10monthavg_level_num sp on sp.PHA_qui = saup.PHA_qui -- phoneprice demographics income已处理
WHERE ncp.createdate = 20200501 -- newly created PHA 20200501
AND saup.date IN (20200501, 20201101, 20210501, 20211101, 20220501, 20221101, 20230501, 20231101)
GROUP bY saup.date, ncp.pha

-- 20201101
SELECT saup.date,
       ncp.pha,
       AVG(phoneprice_level_num) AS avg_income
FROM shenzhen_app_use_people_10month saup -- APP use
JOIN newlycreatedPHA ncp ON ncp.pha = saup.lcode -- newly created PHA
JOIN shenzhen_people_phoneprice_10monthavg_level_num sp on sp.PHA_qui = saup.PHA_qui -- phoneprice demographics income已处理
WHERE ncp.createdate = 20201101 -- newly created PHA 20201101
AND saup.date IN (20201101, 20210501, 20211101, 20220501, 20221101, 20230501, 20231101)
GROUP bY saup.date, ncp.pha

-- 20210501
SELECT saup.date,
       ncp.pha,
       AVG(phoneprice_level_num) AS avg_income
FROM shenzhen_app_use_people_10month saup -- APP use
JOIN newlycreatedPHA ncp ON ncp.pha = saup.lcode -- newly created PHA
JOIN shenzhen_people_phoneprice_10monthavg_level_num sp on sp.PHA_qui = saup.PHA_qui -- phoneprice demographics income已处理
WHERE ncp.createdate = 20210501 -- newly created PHA 20210501
AND saup.date IN (20210501, 20211101, 20220501, 20221101, 20230501, 20231101)
GROUP bY saup.date, ncp.pha

-- 20211101
SELECT saup.date,
       ncp.pha,
       AVG(phoneprice_level_num) AS avg_income
FROM shenzhen_app_use_people_10month saup -- APP use
JOIN newlycreatedPHA ncp ON ncp.pha = saup.lcode -- newly created PHA
JOIN shenzhen_people_phoneprice_10monthavg_level_num sp on sp.PHA_qui = saup.PHA_qui -- phoneprice demographics income已处理
WHERE ncp.createdate = 20211101 -- newly created PHA 20211101
AND saup.date IN (20211101, 20220501, 20221101, 20230501, 20231101)
GROUP bY saup.date, ncp.pha

-- 20220501
SELECT saup.date,
       ncp.pha,
       AVG(phoneprice_level_num) AS avg_income
FROM shenzhen_app_use_people_10month saup -- APP use
JOIN newlycreatedPHA ncp ON ncp.pha = saup.lcode -- newly created PHA
JOIN shenzhen_people_phoneprice_10monthavg_level_num sp on sp.PHA_qui = saup.PHA_qui -- phoneprice demographics income已处理
WHERE ncp.createdate = 20220501 -- newly created PHA 20220501
AND saup.date IN (20220501, 20221101, 20230501, 20231101)
GROUP bY saup.date, ncp.pha

-- 20221101
SELECT saup.date,
       ncp.pha,
       AVG(phoneprice_level_num) AS avg_income
FROM shenzhen_app_use_people_10month saup -- APP use
JOIN newlycreatedPHA ncp ON ncp.pha = saup.lcode -- newly created PHA
JOIN shenzhen_people_phoneprice_10monthavg_level_num sp on sp.PHA_qui = saup.PHA_qui -- phoneprice demographics income已处理
WHERE ncp.createdate = 20221101 -- newly created PHA 20221101
AND saup.date IN (20221101, 20230501, 20231101)
GROUP bY saup.date, ncp.pha

-- 20230501
SELECT saup.date,
       ncp.pha,
       AVG(phoneprice_level_num) AS avg_income
FROM shenzhen_app_use_people_10month saup -- APP use
JOIN newlycreatedPHA ncp ON ncp.pha = saup.lcode -- newly created PHA
JOIN shenzhen_people_phoneprice_10monthavg_level_num sp on sp.PHA_qui = saup.PHA_qui -- phoneprice demographics income已处理
WHERE ncp.createdate = 20230501 -- newly created PHA 20230501
AND saup.date IN (20230501, 20231101)
GROUP bY saup.date, ncp.pha

-- 20231101

SELECT saup.date,
       ncp.pha,
       AVG(phoneprice_level_num) AS avg_income
FROM shenzhen_app_use_people_10month saup -- APP use
JOIN newlycreatedPHA ncp ON ncp.pha = saup.lcode -- newly created PHA
JOIN shenzhen_people_phoneprice_10monthavg_level_num sp on sp.PHA_qui = saup.PHA_qui -- phoneprice demographics income已处理
WHERE ncp.createdate = 20231101 -- newly created PHA 20231101
AND saup.date = 20231101
GROUP bY saup.date, ncp.pha
