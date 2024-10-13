-- 1010

-- 每个group使用的TOP50 PHA & APP
-- age 05-15
-- gender 01,02
-- income level1 - level10

-- 计算每个Group使用各APP的总人数和

-- original PHA age user_num
SELECT saup.date,
       suf.age,
       sa.lcode,
       COUNT(*) AS PHA_usernum_age
FROM shenzhen_app_use_people_10month saup -- APP use
JOIN shenzhen_20190501_activePHA sa ON saup.lcode = sa.lcode -- 筛选original PHA
JOIN shenzhen_20190501_users_filtered suf ON suf.PHA_qui = saup.PHA_qui -- 使用20190501的demographics，同时筛选出567101人
WHERE saup.date IN (20190501, 20191101, 20200501, 20201101, 20210501, 20211101, 20220501, 20221101, 20230501, 20231101)
GROUP BY saup.date, suf.age, sa.lcode
ORDER BY saup.date, suf.age, PHA_usernum_age
-- 205*11*10

-- original PHA gender user_num
SELECT saup.date,
       suf.gender,
       sa.lcode,
       COUNT(*) AS PHA_usernum_gender
FROM shenzhen_app_use_people_10month saup -- APP use
JOIN shenzhen_20190501_activePHA sa ON saup.lcode = sa.lcode -- 筛选original PHA
JOIN shenzhen_20190501_users_filtered suf ON suf.PHA_qui = saup.PHA_qui -- 使用20190501的demographics，同时筛选出567101人
WHERE saup.date IN (20190501, 20191101, 20200501, 20201101, 20210501, 20211101, 20220501, 20221101, 20230501, 20231101)
GROUP BY saup.date, suf.gender, sa.lcode
ORDER BY saup.date, suf.gender, PHA_usernum_gender
-- 205*2*10

-- original PHA income user_num
SELECT saup.date,
       sp.phoneprice_level,
       sa.lcode,
       COUNT(*) as PHA_usernum_income
FROM shenzhen_app_use_people_10month saup -- APP use
JOIN shenzhen_20190501_activePHA sa ON saup.lcode = sa.lcode -- original PHA
JOIN shenzhen_people_phoneprice_10monthavg_level sp on sp.PHA_qui = saup.PHA_qui -- phoneprice demographics
WHERE saup.date IN (20190501, 20191101, 20200501, 20201101, 20210501, 20211101, 20220501, 20221101, 20230501, 20231101)
GROUP BY saup.date, sp.phoneprice_level, sa.lcode
ORDER BY saup.date, sp.phoneprice_level, PHA_usernum_income



-- 所有PHA的使用总人数
-- age
SELECT saup.date,
       suf.age,
       pad.PHA_APP,
       COUNT(DISTINCT suf.PHA_qui) AS PHA_usernum_age
FROM shenzhen_app_use_people_10month saup -- APP use
JOIN PHA_APPlist_distinct pad ON saup.lcode = pad.PHA_APP -- 所有的 PHA
JOIN shenzhen_20190501_users_filtered suf ON suf.PHA_qui = saup.PHA_qui -- 使用20190501的demographics，同时筛选出567101人
WHERE suf.age IN ('05', '06', '07', '08', '09', '10', '11', '12', '13', '14', '15')
AND saup.date IN (20190501, 20191101, 20200501, 20201101, 20210501, 20211101, 20220501, 20221101, 20230501, 20231101)
GROUP BY saup.date, suf.age, pad.PHA_APP
ORDER BY saup.date, suf.age, PHA_usernum_age

-- gender
SELECT saup.date,
       suf.gender,
       pad.PHA_APP,
       COUNT(DISTINCT suf.PHA_qui) AS PHA_usernum_gender
FROM shenzhen_app_use_people_10month saup -- APP use
JOIN PHA_APPlist_distinct pad ON saup.lcode = pad.PHA_APP -- 所有的 PHA
JOIN shenzhen_20190501_users_filtered suf ON suf.PHA_qui = saup.PHA_qui -- 使用20190501的demographics，同时筛选出567101人
WHERE suf.gender IN ('01','02')
AND saup.date IN (20190501, 20191101, 20200501, 20201101, 20210501, 20211101, 20220501, 20221101, 20230501, 20231101)
GROUP BY saup.date, suf.gender, pad.PHA_APP
ORDER BY saup.date, suf.gender, PHA_usernum_gender

-- income
SELECT saup.date,
       sp.phoneprice_level,
       pad.PHA_APP,
       COUNT(DISTINCT sp.PHA_qui) as PHA_usernum_income
FROM shenzhen_app_use_people_10month saup -- APP use
JOIN PHA_APPlist_distinct pad ON saup.lcode = pad.PHA_APP -- 所有的 PHA
JOIN shenzhen_people_phoneprice_10monthavg_level sp ON sp. PHA_qui = saup.PHA_qui -- income level
WHERE saup.date IN (20190501, 20191101, 20200501, 20201101, 20210501, 20211101, 20220501, 20221101, 20230501, 20231101)
GROUP BY saup.date, sp.phoneprice_level, pad.PHA_APP
ORDER BY saup.date, sp.phoneprice_level, PHA_usernum_income


-- other APP 的使用总人数
-- age

SELECT
    saup.date,
    suf.age,
    so.lcode,
    COUNT(DISTINCT suf.PHA_qui) AS Other_usernum_age
FROM shenzhen_app_use_people_10month saup  -- APP use
JOIN shenzhen_otherapp_createtime_largerthan50 so ON saup.lcode = so.lcode  -- all other APP 
JOIN shenzhen_20190501_users_filtered suf ON suf.PHA_qui = saup.PHA_qui -- 使用20190501的demographics，同时筛选出567101人
WHERE suf.age IN ('05', '06', '07', '08', '09', '10', '11', '12', '13', '14', '15')
AND saup.date IN (20190501, 20191101, 20200501, 20201101, 20210501, 20211101, 20220501, 20221101, 20230501, 20231101)
GROUP BY saup.date, suf.age, so.lcode
ORDER BY saup.date, suf.age, Other_usernum_age

-- 可能文件太大无法导出
SELECT
    saup.date,
    suf.age,
    so.lcode,
    COUNT(DISTINCT suf.PHA_qui) AS Other_usernum_age20190501
FROM shenzhen_app_use_people_10month saup  -- APP use
JOIN shenzhen_otherapp_createtime_largerthan50 so ON saup.lcode = so.lcode  -- all other APP 
JOIN shenzhen_20190501_users_filtered suf ON suf.PHA_qui = saup.PHA_qui -- 使用20190501的demographics，同时筛选出567101人
WHERE suf.age IN ('05', '06', '07', '08', '09', '10', '11', '12', '13', '14', '15')
AND saup.date = 20190501
GROUP BY saup.date, suf.age, so.lcode
ORDER BY saup.date, suf.age, Other_usernum_age20190501

SELECT
    saup.date,
    suf.age,
    so.lcode,
    COUNT(DISTINCT suf.PHA_qui) AS Other_usernum_age20191101
FROM shenzhen_app_use_people_10month saup  -- APP use
JOIN shenzhen_otherapp_createtime_largerthan50 so ON saup.lcode = so.lcode  -- all other APP 
JOIN shenzhen_20190501_users_filtered suf ON suf.PHA_qui = saup.PHA_qui -- 使用20190501的demographics，同时筛选出567101人
WHERE suf.age IN ('05', '06', '07', '08', '09', '10', '11', '12', '13', '14', '15')
AND saup.date = 20191101
GROUP BY saup.date, suf.age, so.lcode
ORDER BY saup.date, suf.age, Other_usernum_age20191101

SELECT
    saup.date,
    suf.age,
    so.lcode,
    COUNT(DISTINCT suf.PHA_qui) AS Other_usernum_age20200501
FROM shenzhen_app_use_people_10month saup  -- APP use
JOIN shenzhen_otherapp_createtime_largerthan50 so ON saup.lcode = so.lcode  -- all other APP 
JOIN shenzhen_20190501_users_filtered suf ON suf.PHA_qui = saup.PHA_qui -- 使用20190501的demographics，同时筛选出567101人
WHERE suf.age IN ('05', '06', '07', '08', '09', '10', '11', '12', '13', '14', '15')
AND saup.date = 20200501
GROUP BY saup.date, suf.age, so.lcode
ORDER BY saup.date, suf.age, Other_usernum_age20200501

SELECT
    saup.date,
    suf.age,
    so.lcode,
    COUNT(DISTINCT suf.PHA_qui) AS Other_usernum_age20201101
FROM shenzhen_app_use_people_10month saup  -- APP use
JOIN shenzhen_otherapp_createtime_largerthan50 so ON saup.lcode = so.lcode  -- all other APP 
JOIN shenzhen_20190501_users_filtered suf ON suf.PHA_qui = saup.PHA_qui -- 使用20190501的demographics，同时筛选出567101人
WHERE suf.age IN ('05', '06', '07', '08', '09', '10', '11', '12', '13', '14', '15')
AND saup.date = 20201101
GROUP BY saup.date, suf.age, so.lcode
ORDER BY saup.date, suf.age, Other_usernum_age20201101

SELECT
    saup.date,
    suf.age,
    so.lcode,
    COUNT(DISTINCT suf.PHA_qui) AS Other_usernum_age20210501
FROM shenzhen_app_use_people_10month saup  -- APP use
JOIN shenzhen_otherapp_createtime_largerthan50 so ON saup.lcode = so.lcode  -- all other APP 
JOIN shenzhen_20190501_users_filtered suf ON suf.PHA_qui = saup.PHA_qui -- 使用20190501的demographics，同时筛选出567101人
WHERE suf.age IN ('05', '06', '07', '08', '09', '10', '11', '12', '13', '14', '15')
AND saup.date = 20210501
GROUP BY saup.date, suf.age, so.lcode
ORDER BY saup.date, suf.age, Other_usernum_age20210501

SELECT
    saup.date,
    suf.age,
    so.lcode,
    COUNT(DISTINCT suf.PHA_qui) AS Other_usernum_age20211101
FROM shenzhen_app_use_people_10month saup  -- APP use
JOIN shenzhen_otherapp_createtime_largerthan50 so ON saup.lcode = so.lcode  -- all other APP 
JOIN shenzhen_20190501_users_filtered suf ON suf.PHA_qui = saup.PHA_qui -- 使用20190501的demographics，同时筛选出567101人
WHERE suf.age IN ('05', '06', '07', '08', '09', '10', '11', '12', '13', '14', '15')
AND saup.date = 20211101
GROUP BY saup.date, suf.age, so.lcode
ORDER BY saup.date, suf.age, Other_usernum_age20211101

SELECT
    saup.date,
    suf.age,
    so.lcode,
    COUNT(DISTINCT suf.PHA_qui) AS Other_usernum_age20220501
FROM shenzhen_app_use_people_10month saup  -- APP use
JOIN shenzhen_otherapp_createtime_largerthan50 so ON saup.lcode = so.lcode  -- all other APP 
JOIN shenzhen_20190501_users_filtered suf ON suf.PHA_qui = saup.PHA_qui -- 使用20190501的demographics，同时筛选出567101人
WHERE suf.age IN ('05', '06', '07', '08', '09', '10', '11', '12', '13', '14', '15')
AND saup.date = 20220501
GROUP BY saup.date, suf.age, so.lcode
ORDER BY saup.date, suf.age, Other_usernum_age20220501

SELECT
    saup.date,
    suf.age,
    so.lcode,
    COUNT(DISTINCT suf.PHA_qui) AS Other_usernum_age20221101
FROM shenzhen_app_use_people_10month saup  -- APP use
JOIN shenzhen_otherapp_createtime_largerthan50 so ON saup.lcode = so.lcode  -- all other APP 
JOIN shenzhen_20190501_users_filtered suf ON suf.PHA_qui = saup.PHA_qui -- 使用20190501的demographics，同时筛选出567101人
WHERE suf.age IN ('05', '06', '07', '08', '09', '10', '11', '12', '13', '14', '15')
AND saup.date = 20221101
GROUP BY saup.date, suf.age, so.lcode
ORDER BY saup.date, suf.age, Other_usernum_age20221101

SELECT
    saup.date,
    suf.age,
    so.lcode,
    COUNT(DISTINCT suf.PHA_qui) AS Other_usernum_age20230501
FROM shenzhen_app_use_people_10month saup  -- APP use
JOIN shenzhen_otherapp_createtime_largerthan50 so ON saup.lcode = so.lcode  -- all other APP 
JOIN shenzhen_20190501_users_filtered suf ON suf.PHA_qui = saup.PHA_qui -- 使用20190501的demographics，同时筛选出567101人
WHERE suf.age IN ('05', '06', '07', '08', '09', '10', '11', '12', '13', '14', '15')
AND saup.date = 20230501
GROUP BY saup.date, suf.age, so.lcode
ORDER BY saup.date, suf.age, Other_usernum_age20230501

SELECT
    saup.date,
    suf.age,
    so.lcode,
    COUNT(DISTINCT suf.PHA_qui) AS Other_usernum_age20231101
FROM shenzhen_app_use_people_10month saup  -- APP use
JOIN shenzhen_otherapp_createtime_largerthan50 so ON saup.lcode = so.lcode  -- all other APP 
JOIN shenzhen_20190501_users_filtered suf ON suf.PHA_qui = saup.PHA_qui -- 使用20190501的demographics，同时筛选出567101人
WHERE suf.age IN ('05', '06', '07', '08', '09', '10', '11', '12', '13', '14', '15')
AND saup.date = 20231101
GROUP BY saup.date, suf.age, so.lcode
ORDER BY saup.date, suf.age, Other_usernum_age20231101



-- gender01
SELECT
    saup.date,
    suf.gender,
    so.lcode,
    COUNT(DISTINCT suf.PHA_qui) AS Other_usernum_gender01
FROM shenzhen_app_use_people_10month saup  -- APP使用记录
JOIN shenzhen_otherapp_createtime_largerthan50 so ON saup.lcode = so.lcode  -- 所有其他APP
JOIN shenzhen_20190501_users_filtered suf ON suf.PHA_qui = saup.PHA_qui -- 20190501的用户信息
WHERE suf.gender = '01' 
AND saup.date IN (20190501, 20191101, 20200501, 20201101, 20210501, 20211101, 20220501, 20221101, 20230501, 20231101)  -- 筛选日期
GROUP BY saup.date, suf.gender, so.lcode
ORDER BY saup.date, suf.gender, Other_usernum_gender01

-- gender02
SELECT
    saup.date,
    suf.gender,
    so.lcode,
    COUNT(DISTINCT suf.PHA_qui) AS Other_usernum_gender02
FROM shenzhen_app_use_people_10month saup  -- APP使用记录
JOIN shenzhen_otherapp_createtime_largerthan50 so ON saup.lcode = so.lcode  -- 所有其他APP
JOIN shenzhen_20190501_users_filtered suf ON suf.PHA_qui = saup.PHA_qui -- 20190501的用户信息
WHERE suf.gender = '02' 
AND saup.date IN (20190501, 20191101, 20200501, 20201101, 20210501, 20211101, 20220501, 20221101, 20230501, 20231101)  -- 筛选日期
GROUP BY saup.date, suf.gender, so.lcode
ORDER BY saup.date, suf.gender, Other_usernum_gender02




-- income
SELECT
    saup.date,
    sp.phoneprice_level,
    so.lcode,
    COUNT(DISTINCT sp.PHA_qui) AS Other_usernum_income
FROM shenzhen_app_use_people_10month saup -- APP use
JOIN shenzhen_otherapp_createtime_largerthan50 so ON saup.lcode = so.lcode -- original other APP 
JOIN shenzhen_people_phoneprice_10monthavg_level sp ON sp. PHA_qui = saup.PHA_qui -- income level
WHERE saup.date IN (20190501, 20191101, 20200501, 20201101, 20210501, 20211101, 20220501, 20221101, 20230501, 20231101)
GROUP BY saup.date, sp.phoneprice_level, so.lcode
ORDER BY saup.date, sp.phoneprice_level, Other_usernum_income


-- 可能文件太大无法导出
-- income
SELECT
    saup.date,
    sp.phoneprice_level,
    so.lcode,
    COUNT(DISTINCT sp.PHA_qui) AS Other_usernum_income20190501
FROM shenzhen_app_use_people_10month saup -- APP use
JOIN shenzhen_otherapp_createtime_largerthan50 so ON saup.lcode = so.lcode -- original other APP 
JOIN shenzhen_people_phoneprice_10monthavg_level sp ON sp. PHA_qui = saup.PHA_qui -- income level
WHERE saup.date = 20190501
GROUP BY saup.date, sp.phoneprice_level, so.lcode
ORDER BY saup.date, sp.phoneprice_level, Other_usernum_income20190501


SELECT
    saup.date,
    sp.phoneprice_level,
    so.lcode,
    COUNT(DISTINCT sp.PHA_qui) AS Other_usernum_income20191101
FROM shenzhen_app_use_people_10month saup -- APP use
JOIN shenzhen_otherapp_createtime_largerthan50 so ON saup.lcode = so.lcode -- original other APP 
JOIN shenzhen_people_phoneprice_10monthavg_level sp ON sp. PHA_qui = saup.PHA_qui -- income level
WHERE saup.date = 20191101
GROUP BY saup.date, sp.phoneprice_level, so.lcode
ORDER BY saup.date, sp.phoneprice_level, Other_usernum_income20191101

SELECT
    saup.date,
    sp.phoneprice_level,
    so.lcode,
    COUNT(DISTINCT sp.PHA_qui) AS Other_usernum_income20200501
FROM shenzhen_app_use_people_10month saup -- APP use
JOIN shenzhen_otherapp_createtime_largerthan50 so ON saup.lcode = so.lcode -- original other APP 
JOIN shenzhen_people_phoneprice_10monthavg_level sp ON sp. PHA_qui = saup.PHA_qui -- income level
WHERE saup.date = 20200501
GROUP BY saup.date, sp.phoneprice_level, so.lcode
ORDER BY saup.date, sp.phoneprice_level, Other_usernum_income20200501

SELECT
    saup.date,
    sp.phoneprice_level,
    so.lcode,
    COUNT(DISTINCT sp.PHA_qui) AS Other_usernum_income20201101
FROM shenzhen_app_use_people_10month saup -- APP use
JOIN shenzhen_otherapp_createtime_largerthan50 so ON saup.lcode = so.lcode -- original other APP 
JOIN shenzhen_people_phoneprice_10monthavg_level sp ON sp. PHA_qui = saup.PHA_qui -- income level
WHERE saup.date = 20201101
GROUP BY saup.date, sp.phoneprice_level, so.lcode
ORDER BY saup.date, sp.phoneprice_level, Other_usernum_income20201101

SELECT
    saup.date,
    sp.phoneprice_level,
    so.lcode,
    COUNT(DISTINCT sp.PHA_qui) AS Other_usernum_income20210501
FROM shenzhen_app_use_people_10month saup -- APP use
JOIN shenzhen_otherapp_createtime_largerthan50 so ON saup.lcode = so.lcode -- original other APP 
JOIN shenzhen_people_phoneprice_10monthavg_level sp ON sp. PHA_qui = saup.PHA_qui -- income level
WHERE saup.date = 20210501
GROUP BY saup.date, sp.phoneprice_level, so.lcode
ORDER BY saup.date, sp.phoneprice_level, Other_usernum_income20210501

SELECT
    saup.date,
    sp.phoneprice_level,
    so.lcode,
    COUNT(DISTINCT sp.PHA_qui) AS Other_usernum_income20211101
FROM shenzhen_app_use_people_10month saup -- APP use
JOIN shenzhen_otherapp_createtime_largerthan50 so ON saup.lcode = so.lcode -- original other APP 
JOIN shenzhen_people_phoneprice_10monthavg_level sp ON sp. PHA_qui = saup.PHA_qui -- income level
WHERE saup.date = 20211101
GROUP BY saup.date, sp.phoneprice_level, so.lcode
ORDER BY saup.date, sp.phoneprice_level, Other_usernum_income20211101

SELECT
    saup.date,
    sp.phoneprice_level,
    so.lcode,
    COUNT(DISTINCT sp.PHA_qui) AS Other_usernum_income20220501
FROM shenzhen_app_use_people_10month saup -- APP use
JOIN shenzhen_otherapp_createtime_largerthan50 so ON saup.lcode = so.lcode -- original other APP 
JOIN shenzhen_people_phoneprice_10monthavg_level sp ON sp. PHA_qui = saup.PHA_qui -- income level
WHERE saup.date = 20220501
GROUP BY saup.date, sp.phoneprice_level, so.lcode
ORDER BY saup.date, sp.phoneprice_level, Other_usernum_income20220501

SELECT
    saup.date,
    sp.phoneprice_level,
    so.lcode,
    COUNT(DISTINCT sp.PHA_qui) AS Other_usernum_income20221101
FROM shenzhen_app_use_people_10month saup -- APP use
JOIN shenzhen_otherapp_createtime_largerthan50 so ON saup.lcode = so.lcode -- original other APP 
JOIN shenzhen_people_phoneprice_10monthavg_level sp ON sp. PHA_qui = saup.PHA_qui -- income level
WHERE saup.date = 20221101
GROUP BY saup.date, sp.phoneprice_level, so.lcode
ORDER BY saup.date, sp.phoneprice_level, Other_usernum_income20221101

SELECT
    saup.date,
    sp.phoneprice_level,
    so.lcode,
    COUNT(DISTINCT sp.PHA_qui) AS Other_usernum_income20230501
FROM shenzhen_app_use_people_10month saup -- APP use
JOIN shenzhen_otherapp_createtime_largerthan50 so ON saup.lcode = so.lcode -- original other APP 
JOIN shenzhen_people_phoneprice_10monthavg_level sp ON sp. PHA_qui = saup.PHA_qui -- income level
WHERE saup.date = 20230501
GROUP BY saup.date, sp.phoneprice_level, so.lcode
ORDER BY saup.date, sp.phoneprice_level, Other_usernum_income20230501

SELECT
    saup.date,
    sp.phoneprice_level,
    so.lcode,
    COUNT(DISTINCT sp.PHA_qui) AS Other_usernum_income20231101
FROM shenzhen_app_use_people_10month saup -- APP use
JOIN shenzhen_otherapp_createtime_largerthan50 so ON saup.lcode = so.lcode -- original other APP 
JOIN shenzhen_people_phoneprice_10monthavg_level sp ON sp. PHA_qui = saup.PHA_qui -- income level
WHERE saup.date = 20231101
GROUP BY saup.date, sp.phoneprice_level, so.lcode
ORDER BY saup.date, sp.phoneprice_level, Other_usernum_income20231101

