
-- 一、 population

-- STEP1：限定时间段、所需变量（缺少居住位置变量）
DROP TABLE IF EXISTS shenzhen_people;
CREATE TABLE shenzhen_people AS
SELECT oqc.qui AS PHA_qui,
       ua.id_area,
       ua.date,
       ua.age,
       ua.gender,
       ua.brand,
       ua.type
FROM user_attribute ua
JOIN our_quant_cover oqc ON ua.uid = oqc.uid
WHERE ua.date IN (20190501, 20191101, 20200501, 20201101, 20210501, 20211101, 20220501, 20221101, 20230501, 20231101);


-- STEP2：创建临时表-身份证号不变的（避免假用户）
DROP TABLE IF EXISTS shenzhen_people_1id_area_filtered0;
CREATE TABLE shenzhen_people_1id_area_filtered0 AS
SELECT PHA_qui,
       COUNT(DISTINCT id_area) AS unique_id_areas
FROM shenzhen_people      
GROUP BY PHA_qui
HAVING COUNT(DISTINCT id_area) = 1


-- 得到满足身份不变条件的剩余人群
DROP TABLE IF EXISTS shenzhen_people_1id_area_filtered;
CREATE TABLE shenzhen_people_1id_area_filtered AS
SELECT iaf.PHA_qui, 
       date,
       age,
       gender,
       brand,
       type
FROM shenzhen_people_1id_area_filtered0 iaf
INNER JOIN shenzhen_people sp ON iaf.PHA_qui = sp.PHA_qui


-- STEP3：创建临时表-保存年龄变化在允许范围内的
ROP TABLE IF EXISTS shenzhen_people_2age_filtered0;
CREATE TABLE shenzhen_people_2age_filtered0 AS
SELECT PHA_qui
FROM shenzhen_people_1id_area_filtered
GROUP BY PHA_qui
HAVING (MAX(age) - MIN(age) <= 1)


-- 得到满足年龄变化合理的剩余人群
DROP TABLE IF EXISTS shenzhen_people_2age_filtered;
CREATE TABLE shenzhen_people_2age_filtered AS
SELECT af.PHA_qui, 
       date,
       age,
       gender,
       brand,
       type
FROM shenzhen_people_2age_filtered0 af
INNER JOIN shenzhen_people_1id_area_filtered spia ON af.PHA_qui = spia.PHA_qui
WHERE spia.age NOT IN ('01', '02', '03', '04', '16')


-- STEP4：创建临时表-保存性别没有变化的（可能存在03性别未知，先保留）
DROP TABLE IF EXISTS shenzhen_people_3gender_filtered0;
CREATE TABLE shenzhen_people_3gender_filtered0 AS
SELECT PHA_qui,
       COUNT(DISTINCT gender) AS gender_count
FROM shenzhen_people_2age_filtered
GROUP BY PHA_qui
HAVING COUNT(DISTINCT gender) = 1



-- 得到满足性别不变的剩余人群
DROP TABLE IF EXISTS shenzhen_people_3gender_filtered;
CREATE TABLE shenzhen_people_3gender_filtered AS
SELECT gf.PHA_qui, 
       date,
       age,
       gender,
       brand,
       type
FROM shenzhen_people_3gender_filtered0 gf
INNER JOIN shenzhen_people_2age_filtered spaf ON gf.PHA_qui = spaf.PHA_qui
WHERE spaf.gender != '03'


-- STEP5：合并所有筛选条件
DROP TABLE IF EXISTS shenzhen_people_filtered;
CREATE TABLE shenzhen_people_filtered AS
SELECT PHA_qui, 
       date,
       age,
       gender,
       brand,
       type
FROM shenzhen_people_3gender_filtered

-- 留存符合条件的人
DROP TABLE IF EXISTS shenzhen_people_filtered_qui;
CREATE TABLE shenzhen_people_filtered_qui AS
SELECT DISTINCT PHA_qui
FROM shenzhen_people_filtered
-- 70383818

-- 和驻留表match，定义每个月都在深圳的人

-- STEP1：处理qui，并和上述筛选后的人match，筛掉不满足筛选条件的人
DROP TABLE IF EXISTS stay_month_people_qui;
CREATE TABLE stay_month_people_qui AS
SELECT oqc.qui AS PHA_qui,
       sm.stime
FROM stay_month sm
JOIN our_quant_cover oqc ON oqc.uid = sm.uid
INNER JOIN shenzhen_people_filtered_qui spfq ON spfq.PHA_qui = oqc.qui
-- 一些满足筛选条件的人没有驻留记录，一些驻留的人不满足筛选条件，取交集
-- 依然可能存在满足筛选条件，但是驻留记录不全的人


-- STEP2：筛选规定内的月份，同时每个人每个日期的数据只保留一行，去重
DROP TABLE IF EXISTS stay_month_people;
CREATE TABLE stay_month_people AS
SELECT PHA_qui,
       DATE(stime) AS appear_date,
       COUNT(*) as appear_count
FROM stay_month_people_qui
WHERE MONTH(stime) IN(5,11) AND YEAR(stime) BETWEEN 2019 AND 2023
GROUP BY PHA_qui, DATE(stime)


-- STEP2：统计每个月出现天数，大于等于15天的记为1，否则为0
DROP TABLE IF EXISTS shenzhen_monthly_stay;
create table shenzhen_monthly_stay AS
SELECT PHA_qui,
       YEAR(appear_date) as year,
       MONTH(appear_date) as month,
       COUNT(*) as appear_days,
       CASE WHEN COUNT(*) >=15 THEN 1 ELSE 0 END AS if_frequent
FROM stay_month_people
GROUP BY PHA_qui, YEAR(appear_date), MONTH(appear_date)
-- 存在驻留记录本身就少于10个月的人

  
-- STEP3：统计超过n天frequent的用户数量
DROP TABLE IF EXISTS shenzhen_frequent_users;
create table shenzhen_frequent_users AS
SELECT PHA_qui,
       SUM(if_frequent) AS frequent_count
FROM shenzhen_monthly_stay
GROUP BY PHA_qui
HAVING SUM(if_frequent) = 10;
-- 10个月都frequent

SELECT COUNT(*) AS shenzhen_people_num
FROM shenzhen_frequent_users
-- 745174









-- APP_USE处理
-- STEP1：看每个月份每人使用全部APP数量总和（看一下average）
-- ua表中有date，spf表中也有date（需要给demographics选一个时间点的值采用）
DROP TABLE IF EXISTS shenzhen_app_use_people_10month;
CREATE TABLE shenzhen_app_use_people_10month AS
SELECT oqc.qui AS PHA_qui,
       ua.lcode,
       ua.ltime,
       ua.lflux,
       ua.date
FROM user_app ua
JOIN our_quant_cover oqc ON oqc.uid = ua.uid
JOIN shenzhen_frequent_users_joinall sfuj ON sfuj.PHA_qui = oqc.qui
-- date是按月计算的


-- 每个人每个月使用app个数(包含其他月份)
DROP TABLE IF EXISTS shenzhen_app_use_eachmonth_count;
CREATE TABLE shenzhen_app_use_eachmonth_count AS
SELECT PHA_qui,
       date,
       COUNT(DISTINCT lcode) AS app_eachmonth_count
FROM shenzhen_app_use_people_10month
GROUP BY PHA_qui, date

-- APP USE表也有数据缺失（为筛选10个月都在的做准备，限制时间、id）
DROP TABLE IF EXISTS shenzhen_app_use_eachmonth_count_filter0;
CREATE TABLE shenzhen_app_use_eachmonth_count_filter0 AS
SELECT uec.PHA_qui,
       date,
       app_eachmonth_count
FROM shenzhen_app_use_eachmonth_count uec
JOIN shenzhen_frequent_users_qui sfuq ON sfuq.PHA_qui = uec.PHA_qui
WHERE uec.date IN (20190501, 20191101, 20200501, 20201101, 20210501, 20211101, 20220501, 20221101, 20230501, 20231101);

-- 仅保留10个月都有app使用记录的人的qui（和demographics匹配用）
DROP TABLE IF EXISTS shenzhen_app_use_filtered;
CREATE TABLE shenzhen_app_use_filtered AS
SELECT PHA_qui
FROM shenzhen_app_use_eachmonth_count_filter0
GROUP BY PHA_qui
HAVING COUNT (*) = 10
-- population

SELECT COUNT(*) AS num
FROM shenzhen_app_use_filtered
-- 538434










-- Demographic in the 10 shenzhen_monthly_stay
-- 和shenzhen_people_filtered_qui表合并，只保留所有date中都符合筛选条件的人群
-- user attribute表中有信息丢失，不是每个frequent user都有10条记录，因此再次过滤
DROP TABLE IF EXISTS shenzhen_frequent_users_qui;
create table shenzhen_frequent_users_qui AS
SELECT sfu.PHA_qui,
       COUNT(*) AS attribute_rownumber
FROM shenzhen_frequent_users sfu
JOIN shenzhen_people_filtered spf ON spf.PHA_qui = sfu.PHA_qui
GROUP BY sfu.PHA_qui
HAVING COUNT(*) = 10
-- 696999


-- Demographic in the 10 shenzhen_monthly_stay
-- 和shenzhen_people_filtered_qui表合并，只保留所有date中都符合筛选条件的人群
DROP TABLE IF EXISTS shenzhen_20190501_frequent_users;
create table shenzhen_20190501_frequent_users AS
SELECT sfu.PHA_qui
FROM shenzhen_frequent_users_qui sfu --只有qui
JOIN shenzhen_people_filtered spf ON spf.PHA_qui = sfu.PHA_qui
JOIN shenzhen_app_use_filtered sauf ON sauf.PHA_qui = sfu.PHA_qui --只有qui
WHERE date = 20190501

DROP TABLE IF EXISTS shenzhen_20191101_frequent_users;
create table shenzhen_20191101_frequent_users AS
SELECT sfu.PHA_qui
FROM shenzhen_frequent_users_qui sfu
JOIN shenzhen_people_filtered spf ON spf.PHA_qui = sfu.PHA_qui
JOIN shenzhen_app_use_filtered sauf ON sauf.PHA_qui = sfu.PHA_qui --只有qui
WHERE date = 20191101

DROP TABLE IF EXISTS shenzhen_20200501_frequent_users;
create table shenzhen_20200501_frequent_users AS
SELECT sfu.PHA_qui
FROM shenzhen_frequent_users_qui sfu
JOIN shenzhen_people_filtered spf ON spf.PHA_qui = sfu.PHA_qui
JOIN shenzhen_app_use_filtered sauf ON sauf.PHA_qui = sfu.PHA_qui --只有qui
WHERE date = 20200501

DROP TABLE IF EXISTS shenzhen_20201101_frequent_users;
create table shenzhen_20201101_frequent_users AS
SELECT sfu.PHA_qui
FROM shenzhen_frequent_users_qui sfu
JOIN shenzhen_people_filtered spf ON spf.PHA_qui = sfu.PHA_qui
JOIN shenzhen_app_use_filtered sauf ON sauf.PHA_qui = sfu.PHA_qui --只有qui
WHERE date = 20201101

DROP TABLE IF EXISTS shenzhen_20210501_frequent_users;
create table shenzhen_20210501_frequent_users AS
SELECT sfu.PHA_qui
FROM shenzhen_frequent_users_qui sfu
JOIN shenzhen_people_filtered spf ON spf.PHA_qui = sfu.PHA_qui
JOIN shenzhen_app_use_filtered sauf ON sauf.PHA_qui = sfu.PHA_qui --只有qui
WHERE date = 20210501

DROP TABLE IF EXISTS shenzhen_20211101_frequent_users;
create table shenzhen_20211101_frequent_users AS
SELECT sfu.PHA_qui
FROM shenzhen_frequent_users_qui sfu
JOIN shenzhen_people_filtered spf ON spf.PHA_qui = sfu.PHA_qui
JOIN shenzhen_app_use_filtered sauf ON sauf.PHA_qui = sfu.PHA_qui --只有qui
WHERE date = 20211101

DROP TABLE IF EXISTS shenzhen_20220501_frequent_users;
create table shenzhen_20220501_frequent_users AS
SELECT sfu.PHA_qui
FROM shenzhen_frequent_users_qui sfu
JOIN shenzhen_people_filtered spf ON spf.PHA_qui = sfu.PHA_qui
JOIN shenzhen_app_use_filtered sauf ON sauf.PHA_qui = sfu.PHA_qui --只有qui
WHERE date = 20220501

DROP TABLE IF EXISTS shenzhen_20221101_frequent_users;
create table shenzhen_20221101_frequent_users AS
SELECT sfu.PHA_qui
FROM shenzhen_frequent_users_qui sfu
JOIN shenzhen_people_filtered spf ON spf.PHA_qui = sfu.PHA_qui
JOIN shenzhen_app_use_filtered sauf ON sauf.PHA_qui = sfu.PHA_qui --只有qui
WHERE date = 20221101

DROP TABLE IF EXISTS shenzhen_20230501_frequent_users;
create table shenzhen_20230501_frequent_users AS
SELECT sfu.PHA_qui
FROM shenzhen_frequent_users_qui sfu
JOIN shenzhen_people_filtered spf ON spf.PHA_qui = sfu.PHA_qui
JOIN shenzhen_app_use_filtered sauf ON sauf.PHA_qui = sfu.PHA_qui --只有qui
WHERE date = 20230501

DROP TABLE IF EXISTS shenzhen_20231101_frequent_users;
create table shenzhen_20231101_frequent_users AS
SELECT sfu.PHA_qui
FROM shenzhen_frequent_users_qui sfu
JOIN shenzhen_people_filtered spf ON spf.PHA_qui = sfu.PHA_qui
JOIN shenzhen_app_use_filtered sauf ON sauf.PHA_qui = sfu.PHA_qui --只有qui
WHERE date = 20231101

DROP TABLE IF EXISTS shenzhen_frequent_users_joinall;
create table shenzhen_frequent_users_joinall AS
SELECT a.PHA_qui
FROM shenzhen_20190501_frequent_users a 
JOIN shenzhen_20191101_frequent_users b ON a.PHA_qui = b.PHA_qui
JOIN shenzhen_20200501_frequent_users c ON a.PHA_qui = c.PHA_qui
JOIN shenzhen_20201101_frequent_users d ON a.PHA_qui = d.PHA_qui
JOIN shenzhen_20210501_frequent_users e ON a.PHA_qui = e.PHA_qui
JOIN shenzhen_20211101_frequent_users f ON a.PHA_qui = f.PHA_qui
JOIN shenzhen_20220501_frequent_users g ON a.PHA_qui = g.PHA_qui
JOIN shenzhen_20221101_frequent_users h ON a.PHA_qui = h.PHA_qui
JOIN shenzhen_20230501_frequent_users i ON a.PHA_qui = i.PHA_qui
JOIN shenzhen_20231101_frequent_users j ON a.PHA_qui = j.PHA_qui

--  Q： 每个月的frequent user应该完全一致？


-- Demographics
-- 20190501
DROP TABLE IF EXISTS shenzhen_20190501_users_filtered;
create table shenzhen_20190501_users_filtered AS
SELECT sfuj.PHA_qui,
       spf.date,
       spf.age,
       spf.gender,
       spf.brand,
       spf.type
FROM shenzhen_frequent_users_joinall sfuj
JOIN shenzhen_people_filtered spf ON spf.PHA_qui = sfuj.PHA_qui -- demographic
WHERE date = 20190501


-- 20191101
DROP TABLE IF EXISTS shenzhen_20191101_users_filtered;
create table shenzhen_20191101_users_filtered AS
SELECT sfuj.PHA_qui,
       spf.date,
       spf.age,
       spf.gender,
       spf.brand,
       spf.type
FROM shenzhen_frequent_users_joinall sfuj
JOIN shenzhen_people_filtered spf ON spf.PHA_qui = sfuj.PHA_qui
WHERE date = 20191101


-- 20200501
DROP TABLE IF EXISTS shenzhen_20200501_users_filtered;
create table shenzhen_20200501_users_filtered AS
SELECT sfuj.PHA_qui,
       spf.date,
       spf.age,
       spf.gender,
       spf.brand,
       spf.type
FROM shenzhen_frequent_users_joinall sfuj
JOIN shenzhen_people_filtered spf ON spf.PHA_qui = sfuj.PHA_qui
WHERE date = 20200501


-- 20201101
DROP TABLE IF EXISTS shenzhen_20201101_users_filtered;
create table shenzhen_20201101_users_filtered AS
SELECT sfuj.PHA_qui,
       spf.date,
       spf.age,
       spf.gender,
       spf.brand,
       spf.type
FROM shenzhen_frequent_users_joinall sfuj
JOIN shenzhen_people_filtered spf ON spf.PHA_qui = sfuj.PHA_qui
WHERE date = 20201101



-- 20210501
DROP TABLE IF EXISTS shenzhen_20210501_users_filtered;
create table shenzhen_20210501_users_filtered AS
SELECT sfuj.PHA_qui,
       spf.date,
       spf.age,
       spf.gender,
       spf.brand,
       spf.type
FROM shenzhen_frequent_users_joinall sfuj
JOIN shenzhen_people_filtered spf ON spf.PHA_qui = sfuj.PHA_qui
WHERE date = 20210501


-- 20211101
DROP TABLE IF EXISTS shenzhen_20211101_users_filtered;
create table shenzhen_20211101_users_filtered AS
SELECT sfuj.PHA_qui,
       spf.date,
       spf.age,
       spf.gender,
       spf.brand,
       spf.type
FROM shenzhen_frequent_users_joinall sfuj
JOIN shenzhen_people_filtered spf ON spf.PHA_qui = sfuj.PHA_qui
WHERE date = 20211101


-- 20220501
DROP TABLE IF EXISTS shenzhen_20220501_users_filtered;
create table shenzhen_20220501_users_filtered AS
SELECT sfuj.PHA_qui,
       spf.date,
       spf.age,
       spf.gender,
       spf.brand,
       spf.type
FROM shenzhen_frequent_users_joinall sfuj
JOIN shenzhen_people_filtered spf ON spf.PHA_qui = sfuj.PHA_qui
WHERE date = 20220501



-- 20221101
DROP TABLE IF EXISTS shenzhen_20221101_users_filtered;
create table shenzhen_20221101_users_filtered AS
SELECT sfuj.PHA_qui,
       spf.date,
       spf.age,
       spf.gender,
       spf.brand,
       spf.type
FROM shenzhen_frequent_users_joinall sfuj
JOIN shenzhen_people_filtered spf ON spf.PHA_qui = sfuj.PHA_qui
WHERE date = 20221101


-- 20230501
DROP TABLE IF EXISTS shenzhen_20230501_users_filtered;
create table shenzhen_20230501_users_filtered AS
SELECT sfuj.PHA_qui,
       spf.date,
       spf.age,
       spf.gender,
       spf.brand,
       spf.type
FROM shenzhen_frequent_users_joinall sfuj
JOIN shenzhen_people_filtered spf ON spf.PHA_qui = sfuj.PHA_qui
WHERE date = 20230501


-- 20231101
DROP TABLE IF EXISTS shenzhen_20231101_users_filtered;
create table shenzhen_20231101_users_filtered AS
SELECT sfuj.PHA_qui,
       spf.date,
       spf.age,
       spf.gender,
       spf.brand,
       spf.type
FROM shenzhen_frequent_users_joinall sfuj
JOIN shenzhen_people_filtered spf ON spf.PHA_qui = sfuj.PHA_qui
WHERE date = 20231101




-- 和count表匹配，找到每个人每个月的app使用数量
DROP TABLE IF EXISTS shenzhen_app_use_eachmonth_count_filtered;
CREATE TABLE shenzhen_app_use_eachmonth_count_filtered AS
SELECT uec.PHA_qui,
       date,
       app_eachmonth_count
FROM shenzhen_app_use_eachmonth_count uec
JOIN shenzhen_app_use_filtered sauf ON sauf.PHA_qui = uec.PHA_qui



-- 各时间点App list及使用人数（看不出使用次数）
DROP TABLE IF EXISTS shenzhen_app_list;
CREATE TABLE shenzhen_app_list AS
SELECT saup.date,
       saup.lcode,
       COUNT(*) AS num
FROM shenzhen_app_use_people_10month saup
JOIN shenzhen_app_use_eachmonth_count_filtered ecf ON ecf.PHA_qui = saup.PHA_qui
WHERE saup.date IN (20190501, 20191101, 20200501, 20201101, 20210501, 20211101, 20220501, 20221101, 20230501, 20231101)
GROUP BY saup.date， saup.lcode





-- 二、App Use

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








-- 三、PHA Use

-- STEP2：和PHA APP list Join

-- 找到538434个人每个月使用的所有app并去重，每个app只保留一条
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



-- PHA list 应该包含全部567101人，没有匹配到的记为0

-- 每个人用了多少个PHA
DROP TABLE IF EXISTS shenzhen_PHAuse_20190501_all;
CREATE TABLE shenzhen_PHAuse_20190501_all AS
SELECT sauf.PHA_qui,
       IF(sp.PHA_num is null, 0, sp.PHA_num) AS PHA_num
FROM shenzhen_app_use_filtered sauf
LEFT JOIN shenzhen_PHAuse_20190501 sp on sauf.PHA_qui = sp.PHA_qui


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









-- 四、 PHA supply

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






-- diffusion of newly created PHA

-- extract newly created PHA
DROP TABLE IF EXISTS shenzhen_20191101_newlycreated_PHA;
CREATE TABLE shenzhen_20191101_newlycreated_PHA AS
SELECT pha AS lcode
FROM newlycreatedPHA
WHERE createdate = 20191101

DROP TABLE IF EXISTS shenzhen_20200501_newlycreated_PHA;
CREATE TABLE shenzhen_20200501_newlycreated_PHA AS
SELECT pha AS lcode
FROM newlycreatedPHA
WHERE createdate = 20200501

DROP TABLE IF EXISTS shenzhen_20201101_newlycreated_PHA;
CREATE TABLE shenzhen_20201101_newlycreated_PHA AS
SELECT pha AS lcode
FROM newlycreatedPHA
WHERE createdate = 20201101

DROP TABLE IF EXISTS shenzhen_20210501_newlycreated_PHA;
CREATE TABLE shenzhen_20210501_newlycreated_PHA AS
SELECT pha AS lcode
FROM newlycreatedPHA
WHERE createdate = 20210501

DROP TABLE IF EXISTS shenzhen_20211101_newlycreated_PHA;
CREATE TABLE shenzhen_20211101_newlycreated_PHA AS
SELECT pha AS lcode
FROM newlycreatedPHA
WHERE createdate = 20211101


DROP TABLE IF EXISTS shenzhen_20220501_newlycreated_PHA;
CREATE TABLE shenzhen_20220501_newlycreated_PHA AS
SELECT pha AS lcode
FROM newlycreatedPHA
WHERE createdate = 20220501

DROP TABLE IF EXISTS shenzhen_20221101_newlycreated_PHA;
CREATE TABLE shenzhen_20221101_newlycreated_PHA AS
SELECT pha AS lcode
FROM newlycreatedPHA
WHERE createdate = 20221101


DROP TABLE IF EXISTS shenzhen_20230501_newlycreated_PHA;
CREATE TABLE shenzhen_20230501_newlycreated_PHA AS
SELECT pha AS lcode
FROM newlycreatedPHA
WHERE createdate = 20230501

DROP TABLE IF EXISTS shenzhen_20231101_newlycreated_PHA;
CREATE TABLE shenzhen_20231101_newlycreated_PHA AS
SELECT pha AS lcode
FROM newlycreatedPHA
WHERE createdate = 20231101








-- newly created PHA user demographic

DROP TABLE IF EXISTS 20191101PHA_20191101user;
CREATE TABLE 20191101PHA_20191101user AS
SELECT t.pha_qui, t.lcode -- 每个人用了哪个20191101PHA
FROM(
  -- 20191101 PHA user at 20191101
  SELECT DISTINCT sauf.pha_qui, sa.lcode
  FROM shenzhen_app_use_people_10month saupm
  JOIN shenzhen_app_use_filtered sauf ON sauf.PHA_qui = saupm.PHA_qui -- population
  JOIN shenzhen_20191101_newlycreated_PHA sa on sa.lcode = saupm.lcode
  WHERE saupm.date = 20191101
) t

DROP TABLE IF EXISTS 20191101PHA_20191101user_demographics;
create table 20191101PHA_20191101user_demographics AS
SELECT pu.PHA_qui, pu.lcode,
       spf.date,
       spf.age,
       spf.gender,
       spf.brand,
       spf.type
FROM 20191101PHA_20191101user pu
JOIN shenzhen_people_filtered spf ON spf.PHA_qui = pu.PHA_qui -- demographic
WHERE spf.date = 20191101


DROP TABLE IF EXISTS 20191101PHA_20200501user;
CREATE TABLE 20191101PHA_20200501user AS
SELECT t.pha_qui, t.lcode
FROM(
  -- 20191101 PHA user at 20200501
  SELECT DISTINCT sauf.pha_qui, sa.lcode
  FROM shenzhen_app_use_people_10month saupm
  JOIN shenzhen_app_use_filtered sauf ON sauf.PHA_qui = saupm.PHA_qui -- population
  JOIN shenzhen_20191101_newlycreated_PHA sa on sa.lcode = saupm.lcode
  WHERE saupm.date = 20200501
) t


DROP TABLE IF EXISTS 20191101PHA_20200501user_demographics;
create table 20191101PHA_20200501user_demographics AS
SELECT pu.PHA_qui, pu.lcode,
       spf.date,
       spf.age,
       spf.gender,
       spf.brand,
       spf.type
FROM 20191101PHA_20200501user pu
JOIN shenzhen_people_filtered spf ON spf.PHA_qui = pu.PHA_qui
WHERE spf.date = 20200501


DROP TABLE IF EXISTS 20191101PHA_20201101user;
CREATE TABLE 20191101PHA_20201101user AS
SELECT t.pha_qui, t.lcode
FROM(
  -- 20191101 PHA user at 20201101
  SELECT DISTINCT sauf.pha_qui, sa.lcode
  FROM shenzhen_app_use_people_10month saupm
  JOIN shenzhen_app_use_filtered sauf ON sauf.PHA_qui = saupm.PHA_qui -- population
  JOIN shenzhen_20191101_newlycreated_PHA sa on sa.lcode = saupm.lcode
  WHERE saupm.date = 20201101
) t


DROP TABLE IF EXISTS 20191101PHA_20201101user_demographics;
create table 20191101PHA_20201101user_demographics AS
SELECT pu.PHA_qui, pu.lcode,
       spf.date,
       spf.age,
       spf.gender,
       spf.brand,
       spf.type
FROM 20191101PHA_20201101user pu
JOIN shenzhen_people_filtered spf ON spf.PHA_qui = pu.PHA_qui
WHERE spf.date = 20201101


DROP TABLE IF EXISTS 20191101PHA_20210501user;
CREATE TABLE 20191101PHA_20210501user AS
SELECT t.pha_qui, t.lcode
FROM(
  -- 20191101 PHA user at 20210501
  SELECT DISTINCT sauf.pha_qui, sa.lcode
  FROM shenzhen_app_use_people_10month saupm
  JOIN shenzhen_app_use_filtered sauf ON sauf.PHA_qui = saupm.PHA_qui -- population
  JOIN shenzhen_20191101_newlycreated_PHA sa on sa.lcode = saupm.lcode
  WHERE saupm.date = 20210501
) t


DROP TABLE IF EXISTS 20191101PHA_20210501user_demographics;
create table 20191101PHA_20210501user_demographics AS
SELECT pu.PHA_qui, pu.lcode,
       spf.date,
       spf.age,
       spf.gender,
       spf.brand,
       spf.type
FROM 20191101PHA_20210501user pu
JOIN shenzhen_people_filtered spf ON spf.PHA_qui = pu.PHA_qui
WHERE spf.date = 20210501


DROP TABLE IF EXISTS 20191101PHA_20211101user;
CREATE TABLE 20191101PHA_20211101user AS
SELECT t.pha_qui, t.lcode
FROM(
  -- 20191101 PHA user at 20211101
  SELECT DISTINCT sauf.pha_qui, sa.lcode
  FROM shenzhen_app_use_people_10month saupm
  JOIN shenzhen_app_use_filtered sauf ON sauf.PHA_qui = saupm.PHA_qui -- population
  JOIN shenzhen_20191101_newlycreated_PHA sa on sa.lcode = saupm.lcode
  WHERE saupm.date = 20211101
) t


DROP TABLE IF EXISTS 20191101PHA_20211101user_demographics;
create table 20191101PHA_20211101user_demographics AS
SELECT pu.PHA_qui, pu.lcode,
       spf.date,
       spf.age,
       spf.gender,
       spf.brand,
       spf.type
FROM 20191101PHA_20211101user pu
JOIN shenzhen_people_filtered spf ON spf.PHA_qui = pu.PHA_qui
WHERE spf.date = 20211101


DROP TABLE IF EXISTS 20191101PHA_20220501user;
CREATE TABLE 20191101PHA_20220501user AS
SELECT t.pha_qui, t.lcode
FROM(
  -- 20191101 PHA user at 20220501
  SELECT DISTINCT sauf.pha_qui, sa.lcode
  FROM shenzhen_app_use_people_10month saupm
  JOIN shenzhen_app_use_filtered sauf ON sauf.PHA_qui = saupm.PHA_qui -- population
  JOIN shenzhen_20191101_newlycreated_PHA sa on sa.lcode = saupm.lcode
  WHERE saupm.date = 20220501
) t


DROP TABLE IF EXISTS 20191101PHA_20220501user_demographics;
create table 20191101PHA_20220501user_demographics AS
SELECT pu.PHA_qui, pu.lcode,
       spf.date,
       spf.age,
       spf.gender,
       spf.brand,
       spf.type
FROM 20191101PHA_20220501user pu
JOIN shenzhen_people_filtered spf ON spf.PHA_qui = pu.PHA_qui
WHERE spf.date = 20220501


DROP TABLE IF EXISTS 20191101PHA_20221101user;
CREATE TABLE 20191101PHA_20221101user AS
SELECT t.pha_qui, t.lcode
FROM(
  -- 20191101 PHA user at 20221101
  SELECT DISTINCT sauf.pha_qui, sa.lcode
  FROM shenzhen_app_use_people_10month saupm
  JOIN shenzhen_app_use_filtered sauf ON sauf.PHA_qui = saupm.PHA_qui -- population
  JOIN shenzhen_20191101_newlycreated_PHA sa on sa.lcode = saupm.lcode
  WHERE saupm.date = 20221101
) t


DROP TABLE IF EXISTS 20191101PHA_20221101user_demographics;
create table 20191101PHA_20221101user_demographics AS
SELECT pu.PHA_qui, pu.lcode,
       spf.date,
       spf.age,
       spf.gender,
       spf.brand,
       spf.type
FROM 20191101PHA_20221101user pu
JOIN shenzhen_people_filtered spf ON spf.PHA_qui = pu.PHA_qui
WHERE spf.date = 20221101


DROP TABLE IF EXISTS 20191101PHA_20230501user;
CREATE TABLE 20191101PHA_20230501user AS
SELECT t.pha_qui, t.lcode
FROM(
  -- 20191101 PHA user at 20230501
  SELECT DISTINCT sauf.pha_qui, sa.lcode
  FROM shenzhen_app_use_people_10month saupm
  JOIN shenzhen_app_use_filtered sauf ON sauf.PHA_qui = saupm.PHA_qui -- population
  JOIN shenzhen_20191101_newlycreated_PHA sa on sa.lcode = saupm.lcode
  WHERE saupm.date = 20230501
) t


DROP TABLE IF EXISTS 20191101PHA_20230501user_demographics;
create table 20191101PHA_20230501user_demographics AS
SELECT pu.PHA_qui, pu.lcode,
       spf.date,
       spf.age,
       spf.gender,
       spf.brand,
       spf.type
FROM 20191101PHA_20230501user pu
JOIN shenzhen_people_filtered spf ON spf.PHA_qui = pu.PHA_qui
WHERE spf.date = 20230501


DROP TABLE IF EXISTS 20191101PHA_20231101user;
CREATE TABLE 20191101PHA_20231101user AS
SELECT t.pha_qui, t.lcode
FROM(
  -- 20191101 PHA user at 20231101
  SELECT DISTINCT sauf.pha_qui, sa.lcode
  FROM shenzhen_app_use_people_10month saupm
  JOIN shenzhen_app_use_filtered sauf ON sauf.PHA_qui = saupm.PHA_qui -- population
  JOIN shenzhen_20191101_newlycreated_PHA sa on sa.lcode = saupm.lcode
  WHERE saupm.date = 20231101
) t


DROP TABLE IF EXISTS 20191101PHA_20231101user_demographics;
create table 20191101PHA_20231101user_demographics AS
SELECT pu.PHA_qui, pu.lcode,
       spf.date,
       spf.age,
       spf.gender,
       spf.brand,
       spf.type
FROM 20191101PHA_20231101user pu
JOIN shenzhen_people_filtered spf ON spf.PHA_qui = pu.PHA_qui
WHERE spf.date = 20231101






-- 20200501 PHA - user demographic at each time point

DROP TABLE IF EXISTS 20200501PHA_20200501user;
CREATE TABLE 20200501PHA_20200501user AS
SELECT t.pha_qui, t.lcode
FROM(
  -- 20200501 PHA user at 20200501
  SELECT DISTINCT sauf.pha_qui, sa.lcode
  FROM shenzhen_app_use_people_10month saupm
  JOIN shenzhen_app_use_filtered sauf ON sauf.PHA_qui = saupm.PHA_qui -- population
  JOIN shenzhen_20200501_newlycreated_PHA sa on sa.lcode = saupm.lcode
  WHERE saupm.date = 20200501
) t


DROP TABLE IF EXISTS 20200501PHA_20200501user_demographics;
create table 20200501PHA_20200501user_demographics AS
SELECT pu.PHA_qui, pu.lcode,
       spf.date,
       spf.age,
       spf.gender,
       spf.brand,
       spf.type
FROM 20200501PHA_20200501user pu
JOIN shenzhen_people_filtered spf ON spf.PHA_qui = pu.PHA_qui
WHERE spf.date = 20200501


DROP TABLE IF EXISTS 20200501PHA_20201101user;
CREATE TABLE 20200501PHA_20201101user AS
SELECT t.pha_qui, t.lcode
FROM(
  -- 20200501 PHA user at 20201101
  SELECT DISTINCT sauf.pha_qui, sa.lcode
  FROM shenzhen_app_use_people_10month saupm
  JOIN shenzhen_app_use_filtered sauf ON sauf.PHA_qui = saupm.PHA_qui -- population
  JOIN shenzhen_20200501_newlycreated_PHA sa on sa.lcode = saupm.lcode
  WHERE saupm.date = 20201101
) t


DROP TABLE IF EXISTS 20200501PHA_20201101user_demographics;
create table 20200501PHA_20201101user_demographics AS
SELECT pu.PHA_qui, pu.lcode,
       spf.date,
       spf.age,
       spf.gender,
       spf.brand,
       spf.type
FROM 20200501PHA_20201101user pu
JOIN shenzhen_people_filtered spf ON spf.PHA_qui = pu.PHA_qui
WHERE spf.date = 20201101


DROP TABLE IF EXISTS 20200501PHA_20210501user;
CREATE TABLE 20200501PHA_20210501user AS
SELECT t.pha_qui, t.lcode
FROM(
  -- 20200501 PHA user at 20210501
  SELECT DISTINCT sauf.pha_qui, sa.lcode
  FROM shenzhen_app_use_people_10month saupm
  JOIN shenzhen_app_use_filtered sauf ON sauf.PHA_qui = saupm.PHA_qui -- population
  JOIN shenzhen_20200501_newlycreated_PHA sa on sa.lcode = saupm.lcode
  WHERE saupm.date = 20210501
) t


DROP TABLE IF EXISTS 20200501PHA_20210501user_demographics;
create table 20200501PHA_20210501user_demographics AS
SELECT pu.PHA_qui, pu.lcode,
       spf.date,
       spf.age,
       spf.gender,
       spf.brand,
       spf.type
FROM 20200501PHA_20210501user pu
JOIN shenzhen_people_filtered spf ON spf.PHA_qui = pu.PHA_qui
WHERE spf.date = 20210501


DROP TABLE IF EXISTS 20200501PHA_20211101user;
CREATE TABLE 20200501PHA_20211101user AS
SELECT t.pha_qui, t.lcode
FROM(
  -- 20200501 PHA user at 20211101
  SELECT DISTINCT sauf.pha_qui, sa.lcode
  FROM shenzhen_app_use_people_10month saupm
  JOIN shenzhen_app_use_filtered sauf ON sauf.PHA_qui = saupm.PHA_qui -- population
  JOIN shenzhen_20200501_newlycreated_PHA sa on sa.lcode = saupm.lcode
  WHERE saupm.date = 20211101
) t


DROP TABLE IF EXISTS 20200501PHA_20211101user_demographics;
create table 20200501PHA_20211101user_demographics AS
SELECT pu.PHA_qui, pu.lcode,
       spf.date,
       spf.age,
       spf.gender,
       spf.brand,
       spf.type
FROM 20200501PHA_20211101user pu
JOIN shenzhen_people_filtered spf ON spf.PHA_qui = pu.PHA_qui
WHERE spf.date = 20211101


DROP TABLE IF EXISTS 20200501PHA_20220501user;
CREATE TABLE 20200501PHA_20220501user AS
SELECT t.pha_qui, t.lcode
FROM(
  -- 20200501 PHA user at 20220501
  SELECT DISTINCT sauf.pha_qui, sa.lcode
  FROM shenzhen_app_use_people_10month saupm
  JOIN shenzhen_app_use_filtered sauf ON sauf.PHA_qui = saupm.PHA_qui -- population
  JOIN shenzhen_20200501_newlycreated_PHA sa on sa.lcode = saupm.lcode
  WHERE saupm.date = 20220501
) t


DROP TABLE IF EXISTS 20200501PHA_20220501user_demographics;
create table 20200501PHA_20220501user_demographics AS
SELECT pu.PHA_qui, pu.lcode,
       spf.date,
       spf.age,
       spf.gender,
       spf.brand,
       spf.type
FROM 20200501PHA_20220501user pu
JOIN shenzhen_people_filtered spf ON spf.PHA_qui = pu.PHA_qui
WHERE spf.date = 20220501


DROP TABLE IF EXISTS 20200501PHA_20221101user;
CREATE TABLE 20200501PHA_20221101user AS
SELECT t.pha_qui, t.lcode
FROM(
  -- 20200501 PHA user at 20221101
  SELECT DISTINCT sauf.pha_qui, sa.lcode
  FROM shenzhen_app_use_people_10month saupm
  JOIN shenzhen_app_use_filtered sauf ON sauf.PHA_qui = saupm.PHA_qui -- population
  JOIN shenzhen_20200501_newlycreated_PHA sa on sa.lcode = saupm.lcode
  WHERE saupm.date = 20221101
) t


DROP TABLE IF EXISTS 20200501PHA_20221101user_demographics;
create table 20200501PHA_20221101user_demographics AS
SELECT pu.PHA_qui, pu.lcode,
       spf.date,
       spf.age,
       spf.gender,
       spf.brand,
       spf.type
FROM 20200501PHA_20221101user pu
JOIN shenzhen_people_filtered spf ON spf.PHA_qui = pu.PHA_qui
WHERE spf.date = 20221101


DROP TABLE IF EXISTS 20200501PHA_20230501user;
CREATE TABLE 20200501PHA_20230501user AS
SELECT t.pha_qui, t.lcode
FROM(
  -- 20200501 PHA user at 20230501
  SELECT DISTINCT sauf.pha_qui, sa.lcode
  FROM shenzhen_app_use_people_10month saupm
  JOIN shenzhen_app_use_filtered sauf ON sauf.PHA_qui = saupm.PHA_qui -- population
  JOIN shenzhen_20200501_newlycreated_PHA sa on sa.lcode = saupm.lcode
  WHERE saupm.date = 20230501
) t


DROP TABLE IF EXISTS 20200501PHA_20230501user_demographics;
create table 20200501PHA_20230501user_demographics AS
SELECT pu.PHA_qui, pu.lcode,
       spf.date,
       spf.age,
       spf.gender,
       spf.brand,
       spf.type
FROM 20200501PHA_20230501user pu
JOIN shenzhen_people_filtered spf ON spf.PHA_qui = pu.PHA_qui
WHERE spf.date = 20230501


DROP TABLE IF EXISTS 20200501PHA_20231101user;
CREATE TABLE 20200501PHA_20231101user AS
SELECT t.pha_qui, t.lcode
FROM(
  -- 20200501 PHA user at 20231101
  SELECT DISTINCT sauf.pha_qui, sa.lcode
  FROM shenzhen_app_use_people_10month saupm
  JOIN shenzhen_app_use_filtered sauf ON sauf.PHA_qui = saupm.PHA_qui -- population
  JOIN shenzhen_20200501_newlycreated_PHA sa on sa.lcode = saupm.lcode
  WHERE saupm.date = 20231101
) t


DROP TABLE IF EXISTS 20200501PHA_20231101user_demographics;
create table 20200501PHA_20231101user_demographics AS
SELECT pu.PHA_qui, pu.lcode,
       spf.date,
       spf.age,
       spf.gender,
       spf.brand,
       spf.type
FROM 20200501PHA_20231101user pu
JOIN shenzhen_people_filtered spf ON spf.PHA_qui = pu.PHA_qui
WHERE spf.date = 20231101





-- 20201101 PHA - user demographic at each time point

DROP TABLE IF EXISTS 20201101PHA_20201101user;
CREATE TABLE 20201101PHA_20201101user AS
SELECT t.pha_qui, t.lcode
FROM(
  -- 20201101 PHA user at 20201101
  SELECT DISTINCT sauf.pha_qui, sa.lcode
  FROM shenzhen_app_use_people_10month saupm
  JOIN shenzhen_app_use_filtered sauf ON sauf.PHA_qui = saupm.PHA_qui -- population
  JOIN shenzhen_20201101_newlycreated_PHA sa on sa.lcode = saupm.lcode
  WHERE saupm.date = 20201101
) t


DROP TABLE IF EXISTS 20201101PHA_20201101user_demographics;
create table 20201101PHA_20201101user_demographics AS
SELECT pu.PHA_qui, pu.lcode,
       spf.date,
       spf.age,
       spf.gender,
       spf.brand,
       spf.type
FROM 20201101PHA_20201101user pu
JOIN shenzhen_people_filtered spf ON spf.PHA_qui = pu.PHA_qui
WHERE spf.date = 20201101


DROP TABLE IF EXISTS 20201101PHA_20210501user;
CREATE TABLE 20201101PHA_20210501user AS
SELECT t.pha_qui, t.lcode
FROM(
  -- 20201101 PHA user at 20210501
  SELECT DISTINCT sauf.pha_qui, sa.lcode
  FROM shenzhen_app_use_people_10month saupm
  JOIN shenzhen_app_use_filtered sauf ON sauf.PHA_qui = saupm.PHA_qui -- population
  JOIN shenzhen_20201101_newlycreated_PHA sa on sa.lcode = saupm.lcode
  WHERE saupm.date = 20210501
) t


DROP TABLE IF EXISTS 20201101PHA_20210501user_demographics;
create table 20201101PHA_20210501user_demographics AS
SELECT pu.PHA_qui, pu.lcode,
       spf.date,
       spf.age,
       spf.gender,
       spf.brand,
       spf.type
FROM 20201101PHA_20210501user pu
JOIN shenzhen_people_filtered spf ON spf.PHA_qui = pu.PHA_qui
WHERE spf.date = 20210501


DROP TABLE IF EXISTS 20201101PHA_20211101user;
CREATE TABLE 20201101PHA_20211101user AS
SELECT t.pha_qui, t.lcode
FROM(
  -- 20201101 PHA user at 20211101
  SELECT DISTINCT sauf.pha_qui, sa.lcode
  FROM shenzhen_app_use_people_10month saupm
  JOIN shenzhen_app_use_filtered sauf ON sauf.PHA_qui = saupm.PHA_qui -- population
  JOIN shenzhen_20201101_newlycreated_PHA sa on sa.lcode = saupm.lcode
  WHERE saupm.date = 20211101
) t


DROP TABLE IF EXISTS 20201101PHA_20211101user_demographics;
create table 20201101PHA_20211101user_demographics AS
SELECT pu.PHA_qui, pu.lcode,
       spf.date,
       spf.age,
       spf.gender,
       spf.brand,
       spf.type
FROM 20201101PHA_20211101user pu
JOIN shenzhen_people_filtered spf ON spf.PHA_qui = pu.PHA_qui
WHERE spf.date = 20211101


DROP TABLE IF EXISTS 20201101PHA_20220501user;
CREATE TABLE 20201101PHA_20220501user AS
SELECT t.pha_qui, t.lcode
FROM(
  -- 20201101 PHA user at 20220501
  SELECT DISTINCT sauf.pha_qui, sa.lcode
  FROM shenzhen_app_use_people_10month saupm
  JOIN shenzhen_app_use_filtered sauf ON sauf.PHA_qui = saupm.PHA_qui -- population
  JOIN shenzhen_20201101_newlycreated_PHA sa on sa.lcode = saupm.lcode
  WHERE saupm.date = 20220501
) t


DROP TABLE IF EXISTS 20201101PHA_20220501user_demographics;
create table 20201101PHA_20220501user_demographics AS
SELECT pu.PHA_qui, pu.lcode,
       spf.date,
       spf.age,
       spf.gender,
       spf.brand,
       spf.type
FROM 20201101PHA_20220501user pu
JOIN shenzhen_people_filtered spf ON spf.PHA_qui = pu.PHA_qui
WHERE spf.date = 20220501


DROP TABLE IF EXISTS 20201101PHA_20221101user;
CREATE TABLE 20201101PHA_20221101user AS
SELECT t.pha_qui, t.lcode
FROM(
  -- 20201101 PHA user at 20221101
  SELECT DISTINCT sauf.pha_qui, sa.lcode
  FROM shenzhen_app_use_people_10month saupm
  JOIN shenzhen_app_use_filtered sauf ON sauf.PHA_qui = saupm.PHA_qui -- population
  JOIN shenzhen_20201101_newlycreated_PHA sa on sa.lcode = saupm.lcode
  WHERE saupm.date = 20221101
) t


DROP TABLE IF EXISTS 20201101PHA_20221101user_demographics;
create table 20201101PHA_20221101user_demographics AS
SELECT pu.PHA_qui, pu.lcode,
       spf.date,
       spf.age,
       spf.gender,
       spf.brand,
       spf.type
FROM 20201101PHA_20221101user pu
JOIN shenzhen_people_filtered spf ON spf.PHA_qui = pu.PHA_qui
WHERE spf.date = 20221101


DROP TABLE IF EXISTS 20201101PHA_20230501user;
CREATE TABLE 20201101PHA_20230501user AS
SELECT t.pha_qui, t.lcode
FROM(
  -- 20201101 PHA user at 20230501
  SELECT DISTINCT sauf.pha_qui, sa.lcode
  FROM shenzhen_app_use_people_10month saupm
  JOIN shenzhen_app_use_filtered sauf ON sauf.PHA_qui = saupm.PHA_qui -- population
  JOIN shenzhen_20201101_newlycreated_PHA sa on sa.lcode = saupm.lcode
  WHERE saupm.date = 20230501
) t


DROP TABLE IF EXISTS 20201101PHA_20230501user_demographics;
create table 20201101PHA_20230501user_demographics AS
SELECT pu.PHA_qui, pu.lcode,
       spf.date,
       spf.age,
       spf.gender,
       spf.brand,
       spf.type
FROM 20201101PHA_20230501user pu
JOIN shenzhen_people_filtered spf ON spf.PHA_qui = pu.PHA_qui
WHERE spf.date = 20230501


DROP TABLE IF EXISTS 20201101PHA_20231101user;
CREATE TABLE 20201101PHA_20231101user AS
SELECT t.pha_qui, t.lcode
FROM(
  -- 20201101 PHA user at 20231101
  SELECT DISTINCT sauf.pha_qui, sa.lcode
  FROM shenzhen_app_use_people_10month saupm
  JOIN shenzhen_app_use_filtered sauf ON sauf.PHA_qui = saupm.PHA_qui -- population
  JOIN shenzhen_20201101_newlycreated_PHA sa on sa.lcode = saupm.lcode
  WHERE saupm.date = 20231101
) t


DROP TABLE IF EXISTS 20201101PHA_20231101user_demographics;
create table 20201101PHA_20231101user_demographics AS
SELECT pu.PHA_qui, pu.lcode,
       spf.date,
       spf.age,
       spf.gender,
       spf.brand,
       spf.type
FROM 20201101PHA_20231101user pu
JOIN shenzhen_people_filtered spf ON spf.PHA_qui = pu.PHA_qui
WHERE spf.date = 20231101











-- 五、 income


-- 需要知道不同手机品牌、型号 - 不同income人的APP use & PHA APP use

-- income
-- 每个人的人均手机价格（不是每个人都有记录，只有同类型手机数目大于50的才有价格）
-- 有些型号没有价格，不会被匹配到，不会被计入均值
DROP TABLE IF EXISTS shenzhen_people_phoneprice_10monthavg;
CREATE TABLE shenzhen_people_phoneprice_10monthavg AS
SELECT sauf.PHA_qui,
       AVG(pp.price) AS average_price
FROM shenzhen_people_filtered spf -- 有demographics
JOIN shenzhen_app_use_filtered sauf ON spf.PHA_qui = sauf.PHA_qui -- population qui
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



-- 每个qui只有一个phone price level
DROP TABLE IF EXISTS shenzhen_people_phoneprice_10monthavg_level;
CREATE TABLE shenzhen_people_phoneprice_10monthavg_level AS
SELECT PHA_qui,
       average_price,
CASE
      WHEN average_price > 7718.3888. THEN 'level10'
      WHEN average_price > 6412.9982. THEN 'level9'
      WHEN average_price > 5868.5368. THEN 'level8'
      WHEN average_price > 5338.1849. THEN 'level7'
      WHEN average_price > 4488.4666. THEN 'level6'
      WHEN average_price > 3726.7890. THEN 'level5'
      WHEN average_price > 3057.9597. THEN 'level4'
      WHEN average_price > 2498.8371. THEN 'level3'
      WHEN average_price > 1818.7848 THEN 'level2'
      ELSE 'level1'
      END AS phoneprice_level
FROM shenzhen_people_phoneprice_10monthavg




-- 六、 phone system

-- define variable 'phonesystem'
-- JOIN income level 把手机数据不全的人剔除
DROP TABLE IF EXISTS shenzhen_phonesystem_ifios;
CREATE TABLE shenzhen_phonesystem_ifios AS
SELECT spf.PHA_qui,
       spf.date,
       spf.age,
       spf.gender,
       sppl.phoneprice_level,
       spf.brand,
        CASE
            WHEN spf.brand = '苹果' THEN 'ios' -- ios
            ELSE 'Android'
        END AS phonesystem
FROM shenzhen_people_filtered spf -- demographic
JOIN shenzhen_20190501_users_filtered suf ON spf.PHA_qui = suf.PHA_qui -- population的qui
JOIN shenzhen_people_phoneprice_10monthavg_level sppl ON sppl.PHA_qui = spf.PHA_qui -- 有 pirce level
-- 每个人的system可能会变动










-- SI1

-- APP
-- traffic

-- 每个人每个APP 每个时间点的traffic总量
-- 所有APP 每个时间点的traffic总量

DROP TABLE IF EXISTS shenzhen_sumtraffic_each;
CREATE TABLE shenzhen_sumtraffic_each AS
SELECT saupm.date,
       SUM(lflux) AS sum_traffic
FROM shenzhen_app_use_people_10month saupm
JOIN shenzhen_app_use_filtered sauf ON sauf.PHA_qui = saupm.PHA_qui
WHERE saupm.date IN (20190501, 20191101, 20200501, 20201101, 20210501, 20211101, 20220501, 20221101, 20230501, 20231101)
GROUP BY saupm.pha_qui, saupm.date;


-- percentile of sum traffic used per user
SELECT date,
       PERCENTILE_APPROX(CAST(sum_traffic AS DOUBLE), 0.25) AS p25,
       PERCENTILE_APPROX(CAST(sum_traffic AS DOUBLE), 0.50) AS p50,
       PERCENTILE_APPROX(CAST(sum_traffic AS DOUBLE), 0.75) AS p75,
       PERCENTILE_APPROX(CAST(sum_traffic AS DOUBLE), 0.99) AS p99
FROM shenzhen_sumtraffic_each
GROUP BY date
ORDER BY date;





-- time

-- Drop the table if it exists
DROP TABLE IF EXISTS shenzhen_sumtime_each
CREATE TABLE shenzhen_sumtime_each AS
SELECT saupm.date,
       SUM(ltime) AS sum_time
FROM shenzhen_app_use_people_10month saupm
JOIN shenzhen_app_use_filtered sauf ON sauf.PHA_qui = saupm.PHA_qui
WHERE saupm.date IN (20190501, 20191101, 20200501, 20201101, 20210501, 20211101, 20220501, 20221101, 20230501, 20231101)
GROUP BY saupm.pha_qui, saupm.date;


-- percentile of sum time used per user
SELECT date,
       PERCENTILE_APPROX(CAST(sum_time AS DOUBLE), 0.25) AS p25,
       PERCENTILE_APPROX(CAST(sum_time AS DOUBLE), 0.50) AS p50,
       PERCENTILE_APPROX(CAST(sum_time AS DOUBLE), 0.75) AS p75,
       PERCENTILE_APPROX(CAST(sum_time AS DOUBLE), 0.99) AS p99
FROM shenzhen_sumtime_each
WHERE date IN (20211101, 20220501, 20221101, 20230501, 20231101)
GROUP BY date
ORDER BY date;


SELECT date,
       PERCENTILE_APPROX(CAST(sum_time AS DOUBLE), 0.25) AS p25,
       PERCENTILE_APPROX(CAST(sum_time AS DOUBLE), 0.50) AS p50,
       PERCENTILE_APPROX(CAST(sum_time AS DOUBLE), 0.75) AS p75,
       PERCENTILE_APPROX(CAST(sum_time AS DOUBLE), 0.99) AS p99
FROM shenzhen_sumtime_each
where date IN (20190501, 20191101, 20200501, 20201101, 20210501)
GROUP BY date
ORDER BY date






--PHA
-- traffic

-- 每个人每个APP 每个时间点的traffic总量
-- 所有APP 每个时间点的traffic总量

DROP TABLE IF EXISTS shenzhen_sumtraffic_each_PHA;
CREATE TABLE shenzhen_sumtraffic_each_PHA AS
SELECT saupm.date,
       SUM(lflux) AS sum_traffic
FROM shenzhen_app_use_people_10month saupm -- APP use
JOIN shenzhen_app_use_filtered sauf ON sauf.PHA_qui = saupm.PHA_qui -- population
JOIN PHA_APPlist_distinct pd ON pd.PHA_APP = saupm.lcode
WHERE saupm.date IN (20190501, 20191101, 20200501, 20201101, 20210501, 20211101, 20220501, 20221101, 20230501, 20231101)
GROUP BY saupm.pha_qui, saupm.date;


-- percentile of sum traffic used per user
SELECT date,
       PERCENTILE_APPROX(CAST(sum_traffic AS DOUBLE), 0.25) AS p25,
       PERCENTILE_APPROX(CAST(sum_traffic AS DOUBLE), 0.50) AS p50,
       PERCENTILE_APPROX(CAST(sum_traffic AS DOUBLE), 0.75) AS p75,
       PERCENTILE_APPROX(CAST(sum_traffic AS DOUBLE), 0.99) AS p99
FROM shenzhen_sumtraffic_each_PHA
GROUP BY date
ORDER BY date;



-- time

-- Drop the table if it exists
DROP TABLE IF EXISTS shenzhen_sumtime_each_PHA;
CREATE TABLE shenzhen_sumtime_each_PHA AS
SELECT saupm.date,
       SUM(ltime) AS sum_time
FROM shenzhen_app_use_people_10month saupm
JOIN shenzhen_app_use_filtered sauf ON sauf.PHA_qui = saupm.PHA_qui
JOIN PHA_APPlist_distinct pd ON pd.PHA_APP = saupm.lcode
WHERE saupm.date IN (20190501, 20191101, 20200501, 20201101, 20210501, 20211101, 20220501, 20221101, 20230501, 20231101)
GROUP BY saupm.pha_qui, saupm.date;


-- percentile of sum time used per user
SELECT date,
       PERCENTILE_APPROX(CAST(sum_time AS DOUBLE), 0.25) AS p25,
       PERCENTILE_APPROX(CAST(sum_time AS DOUBLE), 0.50) AS p50,
       PERCENTILE_APPROX(CAST(sum_time AS DOUBLE), 0.75) AS p75,
       PERCENTILE_APPROX(CAST(sum_time AS DOUBLE), 0.99) AS p99
FROM shenzhen_sumtime_each_PHA
WHERE date IN (20211101, 20220501, 20221101, 20230501, 20231101)
GROUP BY date
ORDER BY date;


SELECT date,
       PERCENTILE_APPROX(CAST(sum_time AS DOUBLE), 0.25) AS p25,
       PERCENTILE_APPROX(CAST(sum_time AS DOUBLE), 0.50) AS p50,
       PERCENTILE_APPROX(CAST(sum_time AS DOUBLE), 0.75) AS p75,
       PERCENTILE_APPROX(CAST(sum_time AS DOUBLE), 0.99) AS p99
FROM shenzhen_sumtime_each_PHA
where date IN (20190501, 20191101, 20200501, 20201101, 20210501)
GROUP BY date
ORDER BY date



-- system & phone price

-- income
-- 每个人的人均手机价格（不是每个人都有记录，只有同类型手机数目大于50的才有价格）
-- 有些型号没有价格，不会被匹配到，不会被计入均值
DROP TABLE IF EXISTS shenzhen_people_phoneprice_10monthavg;
CREATE TABLE shenzhen_people_phoneprice_10monthavg AS
SELECT sauf.PHA_qui,
       AVG(pp.price) AS average_price
FROM shenzhen_people_filtered spf -- 有demographics
JOIN shenzhen_app_use_filtered sauf ON spf.PHA_qui = sauf.PHA_qui -- population qui
JOIN phoneprice pp ON pp.brand = spf.brand
     AND pp.type = spf.type
     AND pp.date = spf.date
WHERE spf.date IN (20190501, 20191101, 20200501, 20201101, 20210501, 20211101, 20220501, 20221101, 20230501, 20231101) -- 得到567101人十个月的phone
GROUP BY sauf.PHA_qui


SELECT spi.phonesystem,
       pp.brand,
       pp.type,
       pp.price,
       COUNT(*) AS num
FROM shenzhen_people_filtered spf
JOIN shenzhen_20190501_users_filtered suf ON spf.PHA_qui = suf.PHA_qui -- population
JOIN shenzhen_phonesystem_ifios spi ON spf.PHA_qui = spi.PHA_qui AND spf.date = spi.date -- phone system
JOIN phoneprice pp ON pp.brand = spf.brand
     AND pp.type = spf.type
     AND pp.date = spf.date
GROUP BY spi.phonesystem,
         pp.brand,
         pp.type,
         pp.price,


-- define variable 'phonesystem'
-- JOIN income level 把手机数据不全的人剔除
DROP TABLE IF EXISTS shenzhen_phonesystem_ifios;
CREATE TABLE shenzhen_phonesystem_ifios AS
SELECT spf.PHA_qui,
       spf.date,
       spf.age,
       spf.gender,
       sppl.phoneprice_level,
       spf.brand,
        CASE
            WHEN spf.brand = '苹果' THEN 'ios' -- ios
            ELSE 'Android'
        END AS phonesystem
FROM shenzhen_people_filtered spf -- demographic
JOIN shenzhen_20190501_users_filtered suf ON spf.PHA_qui = suf.PHA_qui -- population的qui
JOIN shenzhen_people_phoneprice_10monthavg_level sppl ON sppl.PHA_qui = spf.PHA_qui -- 有 pirce level
-- 每个人的system可能会变动

