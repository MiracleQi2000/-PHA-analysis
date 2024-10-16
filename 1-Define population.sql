
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
DROP TABLE IF EXISTS shenzhen_people_id_area_filtered0;
CREATE TABLE shenzhen_people_id_area_filtered0 AS
SELECT PHA_qui,
       COUNT(DISTINCT id_area) AS unique_id_areas
FROM shenzhen_people      
GROUP BY PHA_qui
HAVING COUNT(DISTINCT id_area) = 1


-- 得到满足身份不变条件的剩余人群
DROP TABLE IF EXISTS shenzhen_people_id_area_filtered;
CREATE TABLE shenzhen_people_id_area_filtered AS
SELECT iaf.PHA_qui, 
       date,
       age,
       gender,
       brand,
       type
FROM shenzhen_people_id_area_filtered0 iaf
INNER JOIN shenzhen_people sp ON iaf.PHA_qui = sp.PHA_qui


-- STEP3：创建临时表-保存年龄变化在允许范围内的
DROP TABLE IF EXISTS shenzhen_people_age_filtered0;
CREATE TABLE shenzhen_people_age_filtered0 AS
SELECT PHA_qui
FROM shenzhen_people
GROUP BY PHA_qui
HAVING (MAX(age) - MIN(age) <= 1)

-- 得到满足年龄变化合理的剩余人群
DROP TABLE IF EXISTS shenzhen_people_age_filtered;
CREATE TABLE shenzhen_people_age_filtered AS
SELECT af.PHA_qui, 
       date,
       age,
       gender,
       brand,
       type
FROM shenzhen_people_age_filtered0 af
INNER JOIN shenzhen_people sp ON af.PHA_qui = sp.PHA_qui


-- STEP4：创建临时表-保存性别没有变化的（可能存在03性别未知，先保留）
DROP TABLE IF EXISTS shenzhen_people_gender_filtered0;
CREATE TABLE shenzhen_people_gender_filtered0 AS
SELECT PHA_qui,
       COUNT(DISTINCT gender) AS gender_count
FROM shenzhen_people
GROUP BY PHA_qui
HAVING COUNT(DISTINCT gender) = 1

-- 得到满足性别不变的剩余人群
DROP TABLE IF EXISTS shenzhen_people_gender_filtered;
CREATE TABLE shenzhen_people_gender_filtered AS
SELECT gf.PHA_qui, 
       date,
       age,
       gender,
       brand,
       type
FROM shenzhen_people_gender_filtered0 gf
INNER JOIN shenzhen_people sp ON gf.PHA_qui = sp.PHA_qui


-- STEP5：合并所有筛选条件
DROP TABLE IF EXISTS shenzhen_people_filtered;
CREATE TABLE shenzhen_people_filtered AS
SELECT PHA_qui, 
       date,
       age,
       gender,
       brand,
       type
FROM shenzhen_people_gender_filtered

-- 留存符合条件的人
DROP TABLE IF EXISTS shenzhen_people_filtered_qui;
CREATE TABLE shenzhen_people_filtered_qui AS
SELECT DISTINCT PHA_qui
FROM shenzhen_people_gender_filtered


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

-- 全时段中，满足以上筛选条件的，出现过的总人数
SELECT COUNT(*) as total_user_count
FROM (
  SELECT PHA_qui
  FROM shenzhen_monthly_stay
  GROUP BY PHA_qui
  ) t
-- 32461903
  
-- STEP3：统计超过n天frequent的用户数量(尝试n = 6,7,8,9,10)
DROP TABLE IF EXISTS shenzhen_frequent_users;
create table shenzhen_frequent_users AS
SELECT PHA_qui,
       SUM(if_frequent) AS frequent_count
FROM shenzhen_monthly_stay
GROUP BY PHA_qui
HAVING SUM(if_frequent) >= 6;

SELECT COUNT(*) AS shenzhen_people_num
FROM shenzhen_frequent_users
-- 2785285
  
DROP TABLE IF EXISTS shenzhen_frequent_users;
create table shenzhen_frequent_users AS
SELECT PHA_qui,
       SUM(if_frequent) AS frequent_count
FROM shenzhen_monthly_stay
GROUP BY PHA_qui
HAVING SUM(if_frequent) >= 7;

SELECT COUNT(*) AS shenzhen_people_num
FROM shenzhen_frequent_users
-- 2170966

    
DROP TABLE IF EXISTS shenzhen_frequent_users;
create table shenzhen_frequent_users AS
SELECT PHA_qui,
       SUM(if_frequent) AS frequent_count
FROM shenzhen_monthly_stay
GROUP BY PHA_qui
HAVING SUM(if_frequent) >= 8;

SELECT COUNT(*) AS shenzhen_people_num
FROM shenzhen_frequent_users
-- 1669947


DROP TABLE IF EXISTS shenzhen_frequent_users;
create table shenzhen_frequent_users AS
SELECT PHA_qui,
       SUM(if_frequent) AS frequent_count
FROM shenzhen_monthly_stay
GROUP BY PHA_qui
HAVING SUM(if_frequent) >= 9;

SELECT COUNT(*) AS shenzhen_people_num
FROM shenzhen_frequent_users
-- 1248698


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
-- 801016

DROP TABLE IF EXISTS shenzhen_non_frequent_users;
create table shenzhen_non_frequent_users AS
SELECT PHA_qui,
       SUM(if_frequent) AS frequent_count
FROM shenzhen_monthly_stay
GROUP BY PHA_qui
HAVING SUM(if_frequent) < 1;

SELECT COUNT(*) AS non_shenzhen_people_num
FROM shenzhen_non_frequent_users
-- 16759230


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
-- 761982


-- Demographic in the 10 shenzhen_monthly_stay
-- 和shenzhen_people_filtered_qui表合并，只保留所有date中都符合筛选条件的人群
DROP TABLE IF EXISTS shenzhen_20190501_frequent_users;
create table shenzhen_20190501_frequent_users AS
SELECT sfu.PHA_qui
FROM shenzhen_frequent_users sfu
JOIN shenzhen_people_filtered spf ON spf.PHA_qui = sfu.PHA_qui
WHERE date = 20190501

DROP TABLE IF EXISTS shenzhen_20191101_frequent_users;
create table shenzhen_20191101_frequent_users AS
SELECT sfu.PHA_qui
FROM shenzhen_frequent_users sfu
JOIN shenzhen_people_filtered spf ON spf.PHA_qui = sfu.PHA_qui
WHERE date = 20191101

DROP TABLE IF EXISTS shenzhen_20200501_frequent_users;
create table shenzhen_20200501_frequent_users AS
SELECT sfu.PHA_qui
FROM shenzhen_frequent_users sfu
JOIN shenzhen_people_filtered spf ON spf.PHA_qui = sfu.PHA_qui
WHERE date = 20200501

DROP TABLE IF EXISTS shenzhen_20201101_frequent_users;
create table shenzhen_20201101_frequent_users AS
SELECT sfu.PHA_qui
FROM shenzhen_frequent_users sfu
JOIN shenzhen_people_filtered spf ON spf.PHA_qui = sfu.PHA_qui
WHERE date = 20201101

DROP TABLE IF EXISTS shenzhen_20210501_frequent_users;
create table shenzhen_20210501_frequent_users AS
SELECT sfu.PHA_qui
FROM shenzhen_frequent_users sfu
JOIN shenzhen_people_filtered spf ON spf.PHA_qui = sfu.PHA_qui
WHERE date = 20210501

DROP TABLE IF EXISTS shenzhen_20211101_frequent_users;
create table shenzhen_20211101_frequent_users AS
SELECT sfu.PHA_qui
FROM shenzhen_frequent_users sfu
JOIN shenzhen_people_filtered spf ON spf.PHA_qui = sfu.PHA_qui
WHERE date = 20211101

DROP TABLE IF EXISTS shenzhen_20220501_frequent_users;
create table shenzhen_20220501_frequent_users AS
SELECT sfu.PHA_qui
FROM shenzhen_frequent_users sfu
JOIN shenzhen_people_filtered spf ON spf.PHA_qui = sfu.PHA_qui
WHERE date = 20220501

DROP TABLE IF EXISTS shenzhen_20221101_frequent_users;
create table shenzhen_20221101_frequent_users AS
SELECT sfu.PHA_qui
FROM shenzhen_frequent_users sfu
JOIN shenzhen_people_filtered spf ON spf.PHA_qui = sfu.PHA_qui
WHERE date = 20221101

DROP TABLE IF EXISTS shenzhen_20230501_frequent_users;
create table shenzhen_20230501_frequent_users AS
SELECT sfu.PHA_qui
FROM shenzhen_frequent_users sfu
JOIN shenzhen_people_filtered spf ON spf.PHA_qui = sfu.PHA_qui
WHERE date = 20230501

DROP TABLE IF EXISTS shenzhen_20231101_frequent_users;
create table shenzhen_20231101_frequent_users AS
SELECT sfu.PHA_qui
FROM shenzhen_frequent_users sfu
JOIN shenzhen_people_filtered spf ON spf.PHA_qui = sfu.PHA_qui
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
JOIN shenzhen_people_filtered spf ON spf.PHA_qui = sfuj.PHA_qui
WHERE date = 20190501

-- gender
SELECT gender,
       COUNT(*) as num
FROM shenzhen_20190501_users_filtered
GROUP BY gender

-- age
SELECT age,
       COUNT(*) as num
FROM shenzhen_20190501_users_filtered
GROUP BY age

-- phone
SELECT brand,
       type,
       COUNT(*) as num
FROM shenzhen_20190501_users_filtered
GROUP BY brand, type

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

-- gender
SELECT gender,
       COUNT(*) as num
FROM shenzhen_20191101_users_filtered
GROUP BY gender

-- age
SELECT age,
       COUNT(*) as num
FROM shenzhen_20191101_users_filtered
GROUP BY age

-- phone
SELECT brand,
       type,
       COUNT(*) as num
FROM shenzhen_20191101_users_filtered
GROUP BY brand, type


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

-- gender
SELECT gender,
       COUNT(*) as num
FROM shenzhen_20200501_users_filtered
GROUP BY gender

-- age
SELECT age,
       COUNT(*) as num
FROM shenzhen_20200501_users_filtered
GROUP BY age

-- phone
SELECT brand,
       type,
       COUNT(*) as num
FROM shenzhen_20200501_users_filtered
GROUP BY brand, type


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

-- gender
SELECT gender,
       COUNT(*) as num
FROM shenzhen_20201101_users_filtered
GROUP BY gender

-- age
SELECT age,
       COUNT(*) as num
FROM shenzhen_20201101_users_filtered
GROUP BY age

-- phone
SELECT brand,
       type,
       COUNT(*) as num
FROM shenzhen_20201101_users_filtered
GROUP BY brand, type


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

-- gender
SELECT gender,
       COUNT(*) as num
FROM shenzhen_20210501_users_filtered
GROUP BY gender

-- age
SELECT age,
       COUNT(*) as num
FROM shenzhen_20210501_users_filtered
GROUP BY age

-- phone
SELECT brand,
       type,
       COUNT(*) as num
FROM shenzhen_20210501_users_filtered
GROUP BY brand, type


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

-- gender
SELECT gender,
       COUNT(*) as num
FROM shenzhen_20211101_users_filtered
GROUP BY gender

-- age
SELECT age,
       COUNT(*) as num
FROM shenzhen_20211101_users_filtered
GROUP BY age

-- phone
SELECT brand,
       type,
       COUNT(*) as num
FROM shenzhen_20211101_users_filtered
GROUP BY brand, type


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

-- gender
SELECT gender,
       COUNT(*) as num
FROM shenzhen_20220501_users_filtered
GROUP BY gender

-- age
SELECT age,
       COUNT(*) as num
FROM shenzhen_20220501_users_filtered
GROUP BY age

-- phone
SELECT brand,
       type,
       COUNT(*) as num
FROM shenzhen_20220501_users_filtered
GROUP BY brand, type


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

-- gender
SELECT gender,
       COUNT(*) as num
FROM shenzhen_20221101_users_filtered
GROUP BY gender

-- age
SELECT age,
       COUNT(*) as num
FROM shenzhen_20221101_users_filtered
GROUP BY age

-- phone
SELECT brand,
       type,
       COUNT(*) as num
FROM shenzhen_20221101_users_filtered
GROUP BY brand, type


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

-- gender
SELECT gender,
       COUNT(*) as num
FROM shenzhen_20230501_users_filtered
GROUP BY gender

-- age
SELECT age,
       COUNT(*) as num
FROM shenzhen_20230501_users_filtered
GROUP BY age

-- phone
SELECT brand,
       type,
       COUNT(*) as num
FROM shenzhen_20230501_users_filtered
GROUP BY brand, type


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

-- gender
SELECT gender,
       COUNT(*) as num
FROM shenzhen_20231101_users_filtered
GROUP BY gender

-- age
SELECT age,
       COUNT(*) as num
FROM shenzhen_20231101_users_filtered
GROUP BY age

-- phone
SELECT brand,
       type,
       COUNT(*) as num
FROM shenzhen_20231101_users_filtered
GROUP BY brand, type



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

DROP TABLE IF EXISTS shenzhen_app_list;
CREATE TABLE shenzhen_app_list AS
SELECT saup.lcode,
       COUNT(*) AS num
FROM shenzhen_app_use_people_10month saup
JOIN shenzhen_app_use_eachmonth_count_filtered ecf ON ecf.PHA_qui = saup.PHA_qui
WHERE saup.date IN (20190501, 20191101, 20200501, 20201101, 20210501, 20211101, 20220501, 20221101, 20230501, 20231101)
GROUP BY saup.lcode

SELECT lcode,
       num
FROM shenzhen_app_list


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

SELECT COUNT(*) AS num
FROM shenzhen_app_use_filtered

-- 和count表匹配，找到每个人每个月的app使用数量
DROP TABLE IF EXISTS shenzhen_app_use_eachmonth_count_filtered;
CREATE TABLE shenzhen_app_use_eachmonth_count_filtered AS
SELECT uec.PHA_qui,
       date,
       app_eachmonth_count
FROM shenzhen_app_use_eachmonth_count uec
JOIN shenzhen_app_use_filtered sauf ON sauf.PHA_qui = uec.PHA_qui

