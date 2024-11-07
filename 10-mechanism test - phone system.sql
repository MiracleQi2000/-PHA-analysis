-- phone system

-- extract user number of each age/gender/income group at each time
-- for weighted average


-- age
SELECT spi.date,
       suf.age,
       spi.phonesystem,
       COUNT(*) as age_usernum
FROM shenzhen_20190501_users_filtered suf
JOIN shenzhen_phonesystem_ifios spi ON spi.PHA_qui = suf.PHA_qui
GROUP BY spi.date, suf.age, spi.phonesystem


-- gender
SELECT spi.date,
       suf.gender,
       phonesystem,
       COUNT(*) as gender_usernum
FROM shenzhen_20190501_users_filtered suf
JOIN shenzhen_phonesystem_ifios spi ON spi.PHA_qui = suf.PHA_qui
GROUP BY spi.date, suf.gender, spi.phonesystem



-- income
SELECT spi.date,
       phoneprice_level,
       phonesystem,
       COUNT(*) as income_usernum
FROM shenzhen_people_phoneprice_10monthavg_level sppl-- income level 每个人只有一条记录
JOIN shenzhen_phonesystem_ifios spi ON spi.PHA_qui = sppl.PHA_qui -- phone system
GROUP BY spi.date, phoneprice_level, phonesystem




-- 每个系统的用户使用PHA num的平均值
SELECT spi.phonesystem,
       AVG(t.PHA_num) AS avg_system20190501
FROM shenzhen_phonesystem_ifios spi
JOIN (SELECT PHA_qui, PHA_num
      FROM shenzhen_PHAuse_20190501_all) t on t.PHA_qui = spi.PHA_qui
WHERE spi.date = 20190501
GROUP BY spi.phonesystem

-- 每个系统的用户，分income level，使用PHA num的平均值
SELECT spi.phonesystem,
       phoneprice_level,
       AVG(t.PHA_num) AS avg_system20190501
FROM shenzhen_phonesystem_ifios spi
JOIN (SELECT PHA_qui, PHA_num
      FROM shenzhen_PHAuse_20190501_all) t on t.PHA_qui = spi.PHA_qui
JOIN shenzhen_people_phoneprice_10monthavg_level sppl ON sppl.PHA_qui = t.PHA_qui -- income level 每个人只有一条记录
WHERE spi.date = 20190501
GROUP BY spi.phonesystem, phoneprice_level


-- whether ios system leads to less PHA use?

-- define variable 'phonesystem'
-- JOIN income level 把手机数据不全的人剔除
DROP TABLE IF EXISTS shenzhen_phonesystem_ifios;
CREATE TABLE shenzhen_phonesystem_ifios AS
SELECT spf.PHA_qui,
       spf.date,
       spf.age,
       spf.gender,
       spf.brand,
        CASE
            WHEN spf.brand = '苹果' THEN 'ios' -- ios
            ELSE 'Android'
        END AS phonesystem
FROM shenzhen_people_filtered spf
JOIN shenzhen_20190501_users_filtered suf ON spf.PHA_qui = suf.PHA_qui
JOIN shenzhen_people_phoneprice_10monthavg_level sppl ON sppl.PHA_qui = spf.PHA_qui

-- user num of each system at 10 months
SELECT date,
       phonesystem,
       COUNT(*) AS system_num
FROM shenzhen_phonesystem_ifios
GROUP BY date, phonesystem



-- 每个系统的用户使用PHA num的平均值
SELECT spi.phonesystem,
       AVG(t.PHA_num) AS avg_system20190501
FROM shenzhen_phonesystem_ifios spi
JOIN (SELECT PHA_qui, PHA_num
      FROM shenzhen_PHAuse_20190501_all) t on t.PHA_qui = spi.PHA_qui
WHERE spi.date = 20190501
GROUP BY spi.phonesystem

SELECT spi.phonesystem,
       AVG(t.PHA_num) AS avg_system20191101
FROM shenzhen_phonesystem_ifios spi
JOIN (SELECT PHA_qui, PHA_num
      FROM shenzhen_PHAuse_20191101_all) t on t.PHA_qui = spi.PHA_qui
WHERE spi.date = 20191101
GROUP BY spi.phonesystem

SELECT spi.phonesystem,
       AVG(t.PHA_num) AS avg_system20200501
FROM shenzhen_phonesystem_ifios spi
JOIN (SELECT PHA_qui, PHA_num
      FROM shenzhen_PHAuse_20200501_all) t on t.PHA_qui = spi.PHA_qui
WHERE spi.date = 20200501
GROUP BY spi.phonesystem

SELECT spi.phonesystem,
       AVG(t.PHA_num) AS avg_system20201101
FROM shenzhen_phonesystem_ifios spi
JOIN (SELECT PHA_qui, PHA_num
      FROM shenzhen_PHAuse_20201101_all) t on t.PHA_qui = spi.PHA_qui
WHERE spi.date = 20201101
GROUP BY spi.phonesystem

SELECT spi.phonesystem,
       AVG(t.PHA_num) AS avg_system20210501
FROM shenzhen_phonesystem_ifios spi
JOIN (SELECT PHA_qui, PHA_num
      FROM shenzhen_PHAuse_20210501_all) t on t.PHA_qui = spi.PHA_qui
WHERE spi.date = 20210501
GROUP BY spi.phonesystem

SELECT spi.phonesystem,
       AVG(t.PHA_num) AS avg_system20211101
FROM shenzhen_phonesystem_ifios spi
JOIN (SELECT PHA_qui, PHA_num
      FROM shenzhen_PHAuse_20211101_all) t on t.PHA_qui = spi.PHA_qui
WHERE spi.date = 20211101
GROUP BY spi.phonesystem

SELECT spi.phonesystem,
       AVG(t.PHA_num) AS avg_system20220501
FROM shenzhen_phonesystem_ifios spi
JOIN (SELECT PHA_qui, PHA_num
      FROM shenzhen_PHAuse_20220501_all) t on t.PHA_qui = spi.PHA_qui
WHERE spi.date = 20220501
GROUP BY spi.phonesystem

SELECT spi.phonesystem,
       AVG(t.PHA_num) AS avg_system20221101
FROM shenzhen_phonesystem_ifios spi
JOIN (SELECT PHA_qui, PHA_num
      FROM shenzhen_PHAuse_20221101_all) t on t.PHA_qui = spi.PHA_qui
WHERE spi.date = 20221101
GROUP BY spi.phonesystem

SELECT spi.phonesystem,
       AVG(t.PHA_num) AS avg_system20230501
FROM shenzhen_phonesystem_ifios spi
JOIN (SELECT PHA_qui, PHA_num
      FROM shenzhen_PHAuse_20230501_all) t on t.PHA_qui = spi.PHA_qui
WHERE spi.date = 20230501
GROUP BY spi.phonesystem

SELECT spi.phonesystem,
       AVG(t.PHA_num) AS avg_system20231101
FROM shenzhen_phonesystem_ifios spi
JOIN (SELECT PHA_qui, PHA_num
      FROM shenzhen_PHAuse_20231101_all) t on t.PHA_qui = spi.PHA_qui
WHERE spi.date = 20231101
GROUP BY spi.phonesystem



-- original PHA phone system
SELECT saup.date,
       sa.lcode,
       spi.phonesystem,
       COUNT(*) AS system_user_num
FROM shenzhen_app_use_people_10month saup -- APP use
JOIN shenzhen_20190501_activePHA sa ON saup.lcode = sa.lcode -- 筛选original PHA
JOIN shenzhen_phonesystem_ifios spi ON spi.PHA_qui = saup.PHA_qui
JOIN shenzhen_20190501_users_filtered suf ON saup.PHA_qui = suf.PHA_qui
WHERE saup.date IN (20190501, 20191101, 20200501, 20201101, 20210501, 20211101, 20220501, 20221101, 20230501, 20231101)
GROUP bY saup.date, sa.lcode, spi.phonesystem



-- newly created PHA phone system
-- 20191101
SELECT saup.date,
       ncp.pha,
       spi.phonesystem,
       COUNT(*) AS system_user_num
FROM shenzhen_app_use_people_10month saup -- APP use
JOIN newlycreatedPHA ncp ON ncp.pha = saup.lcode -- newly created PHA
JOIN shenzhen_phonesystem_ifios spi on spi.PHA_qui = saup.PHA_qui
JOIN shenzhen_20190501_users_filtered suf ON saup.PHA_qui = suf.PHA_qui
WHERE ncp.createdate = 20191101 -- newly created PHA 20191101
AND saup.date IN (20191101, 20200501, 20201101, 20210501, 20211101, 20220501, 20221101, 20230501, 20231101)
GROUP bY saup.date, ncp.pha, spi.phonesystem

-- 20200501
SELECT saup.date,
       ncp.pha,
       spi.phonesystem,
       COUNT(*) AS system_user_num
FROM shenzhen_app_use_people_10month saup -- APP use
JOIN newlycreatedPHA ncp ON ncp.pha = saup.lcode -- newly created PHA
JOIN shenzhen_phonesystem_ifios spi on spi.PHA_qui = saup.PHA_qui
JOIN shenzhen_20190501_users_filtered suf ON saup.PHA_qui = suf.PHA_qui
WHERE ncp.createdate = 20200501 -- newly created PHA 20200501
AND saup.date IN (20200501, 20201101, 20210501, 20211101, 20220501, 20221101, 20230501, 20231101)
GROUP bY saup.date, ncp.pha, spi.phonesystem

-- 20201101
SELECT saup.date,
       ncp.pha,
       spi.phonesystem,
       COUNT(*) AS system_user_num
FROM shenzhen_app_use_people_10month saup -- APP use
JOIN newlycreatedPHA ncp ON ncp.pha = saup.lcode -- newly created PHA
JOIN shenzhen_phonesystem_ifios spi on spi.PHA_qui = saup.PHA_qui
JOIN shenzhen_20190501_users_filtered suf ON saup.PHA_qui = suf.PHA_qui
WHERE ncp.createdate = 20201101 -- newly created PHA 20201101
AND saup.date IN (20201101, 20210501, 20211101, 20220501, 20221101, 20230501, 20231101)
GROUP bY saup.date, ncp.pha, spi.phonesystem

-- 20210501
SELECT saup.date,
       ncp.pha,
       spi.phonesystem,
       COUNT(*) AS system_user_num
FROM shenzhen_app_use_people_10month saup -- APP use
JOIN newlycreatedPHA ncp ON ncp.pha = saup.lcode -- newly created PHA
JOIN shenzhen_phonesystem_ifios spi on spi.PHA_qui = saup.PHA_qui
JOIN shenzhen_20190501_users_filtered suf ON saup.PHA_qui = suf.PHA_qui
WHERE ncp.createdate = 20210501 -- newly created PHA 20210501
AND saup.date IN (20210501, 20211101, 20220501, 20221101, 20230501, 20231101)
GROUP bY saup.date, ncp.pha, spi.phonesystem

-- 20211101
SELECT saup.date,
       ncp.pha,
       spi.phonesystem,
       COUNT(*) AS system_user_num
FROM shenzhen_app_use_people_10month saup -- APP use
JOIN newlycreatedPHA ncp ON ncp.pha = saup.lcode -- newly created PHA
JOIN shenzhen_phonesystem_ifios spi on spi.PHA_qui = saup.PHA_qui
JOIN shenzhen_20190501_users_filtered suf ON saup.PHA_qui = suf.PHA_qui
WHERE ncp.createdate = 20211101 -- newly created PHA 20211101
AND saup.date IN (20211101, 20220501, 20221101, 20230501, 20231101)
GROUP bY saup.date, ncp.pha, spi.phonesystem


-- 20220501
SELECT saup.date,
       ncp.pha,
       spi.phonesystem,
       COUNT(*) AS system_user_num
FROM shenzhen_app_use_people_10month saup -- APP use
JOIN newlycreatedPHA ncp ON ncp.pha = saup.lcode -- newly created PHA
JOIN shenzhen_phonesystem_ifios spi on spi.PHA_qui = saup.PHA_qui
JOIN shenzhen_20190501_users_filtered suf ON saup.PHA_qui = suf.PHA_qui
WHERE ncp.createdate = 20220501 -- newly created PHA 20220501
AND saup.date IN (20220501, 20221101, 20230501, 20231101)
GROUP bY saup.date, ncp.pha, spi.phonesystem

-- 20221101
SELECT saup.date,
       ncp.pha,
       spi.phonesystem,
       COUNT(*) AS system_user_num
FROM shenzhen_app_use_people_10month saup -- APP use
JOIN newlycreatedPHA ncp ON ncp.pha = saup.lcode -- newly created PHA
JOIN shenzhen_phonesystem_ifios spi on spi.PHA_qui = saup.PHA_qui
JOIN shenzhen_20190501_users_filtered suf ON saup.PHA_qui = suf.PHA_qui
WHERE ncp.createdate = 20221101 -- newly created PHA 20221101
AND saup.date IN (20221101, 20230501, 20231101)
GROUP bY saup.date, ncp.pha, spi.phonesystem


-- 20230501
SELECT saup.date,
       ncp.pha,
       spi.phonesystem,
       COUNT(*) AS system_user_num
FROM shenzhen_app_use_people_10month saup -- APP use
JOIN newlycreatedPHA ncp ON ncp.pha = saup.lcode -- newly created PHA
JOIN shenzhen_phonesystem_ifios spi on spi.PHA_qui = saup.PHA_qui
JOIN shenzhen_20190501_users_filtered suf ON saup.PHA_qui = suf.PHA_qui
WHERE ncp.createdate = 20230501 -- newly created PHA 20230501
AND saup.date IN (20230501, 20231101)
GROUP bY saup.date, ncp.pha, spi.phonesystem


-- 20231101
SELECT saup.date,
       ncp.pha,
       spi.phonesystem,
       COUNT(*) AS system_user_num
FROM shenzhen_app_use_people_10month saup -- APP use
JOIN newlycreatedPHA ncp ON ncp.pha = saup.lcode -- newly created PHA
JOIN shenzhen_phonesystem_ifios spi on spi.PHA_qui = saup.PHA_qui
JOIN shenzhen_20190501_users_filtered suf ON saup.PHA_qui = suf.PHA_qui
WHERE ncp.createdate = 20231101 -- newly created PHA 20231101
AND saup.date = 20231101
GROUP bY saup.date, ncp.pha, spi.phonesystem



-- 每个系统的用户使用all APP num的平均值, 10 months
SELECT spi.date,
       spi.phonesystem,
       AVG(t.app_eachmonth_count) AS avg_all_system
FROM shenzhen_phonesystem_ifios spi
JOIN (SELECT PHA_qui, date, app_eachmonth_count
      FROM shenzhen_app_use_eachmonth_count_filtered) t on t.PHA_qui = spi.PHA_qui
JOIN shenzhen_20190501_users_filtered suf ON spi.PHA_qui = suf.PHA_qui
GROUP BY spi.date, spi.phonesystem


-- original other APP phonesystem
SELECT
    saup.date,
    so.lcode,
    spi.phonesystem,
    COUNT(*) AS system_user_num
FROM shenzhen_app_use_people_10month saup  -- APP use
JOIN shenzhen_otherapp_createtime_largerthan50 so ON saup.lcode = so.lcode  -- original other APP 
JOIN shenzhen_phonesystem_ifios spi ON spi.PHA_qui = saup.PHA_qui
JOIN shenzhen_20190501_users_filtered suf ON spi.PHA_qui = suf.PHA_qui
WHERE so.createdtime = 20190501 -- original other APP
AND saup.date IN (20190501, 20191101, 20200501, 20201101, 20210501, 20211101, 20220501, 20221101, 20230501, 20231101)
GROUP BY saup.date, so.lcode, spi.phonesystem

-- other APP phonesystem
-- 20191101
SELECT
    saup.date,
    so.lcode,
    spi.phonesystem,
    COUNT(*) AS system_user_num
FROM shenzhen_app_use_people_10month saup  -- APP use
JOIN shenzhen_otherapp_createtime_largerthan50 so ON saup.lcode = so.lcode  -- original other APP 
JOIN shenzhen_phonesystem_ifios spi ON spi.PHA_qui = saup.PHA_qui
JOIN shenzhen_20190501_users_filtered suf ON spi.PHA_qui = suf.PHA_qui
WHERE so.createdtime = 20191101
AND saup.date IN (20191101, 20200501, 20201101, 20210501, 20211101, 20220501, 20221101, 20230501, 20231101)
GROUP BY saup.date, so.lcode, spi.phonesystem


-- 20200501
SELECT
    saup.date,
    so.lcode,
    spi.phonesystem,
    COUNT(*) AS system_user_num
FROM shenzhen_app_use_people_10month saup  -- APP use
JOIN shenzhen_otherapp_createtime_largerthan50 so ON saup.lcode = so.lcode  -- original other APP 
JOIN shenzhen_phonesystem_ifios spi ON spi.PHA_qui = saup.PHA_qui
JOIN shenzhen_20190501_users_filtered suf ON spi.PHA_qui = suf.PHA_qui
WHERE so.createdtime = 20200501
AND saup.date IN (20200501, 20201101, 20210501, 20211101, 20220501, 20221101, 20230501, 20231101)
GROUP BY saup.date, so.lcode, spi.phonesystem

-- 20201101
SELECT
    saup.date,
    so.lcode,
    spi.phonesystem,
    COUNT(*) AS system_user_num
FROM shenzhen_app_use_people_10month saup  -- APP use
JOIN shenzhen_otherapp_createtime_largerthan50 so ON saup.lcode = so.lcode  -- original other APP 
JOIN shenzhen_phonesystem_ifios spi ON spi.PHA_qui = saup.PHA_qui
JOIN shenzhen_20190501_users_filtered suf ON spi.PHA_qui = suf.PHA_qui
WHERE so.createdtime = 20201101
AND saup.date IN (20201101, 20210501, 20211101, 20220501, 20221101, 20230501, 20231101)
GROUP BY saup.date, so.lcode, spi.phonesystem

-- 20210501
SELECT
    saup.date,
    so.lcode,
    spi.phonesystem,
    COUNT(*) AS system_user_num
FROM shenzhen_app_use_people_10month saup  -- APP use
JOIN shenzhen_otherapp_createtime_largerthan50 so ON saup.lcode = so.lcode  -- original other APP 
JOIN shenzhen_phonesystem_ifios spi ON spi.PHA_qui = saup.PHA_qui
JOIN shenzhen_20190501_users_filtered suf ON spi.PHA_qui = suf.PHA_qui
WHERE so.createdtime = 20210501
AND saup.date IN (20210501, 20211101, 20220501, 20221101, 20230501, 20231101)
GROUP BY saup.date, so.lcode, spi.phonesystem

-- 20211101
SELECT
    saup.date,
    so.lcode,
    spi.phonesystem,
    COUNT(*) AS system_user_num
FROM shenzhen_app_use_people_10month saup  -- APP use
JOIN shenzhen_otherapp_createtime_largerthan50 so ON saup.lcode = so.lcode  -- original other APP 
JOIN shenzhen_phonesystem_ifios spi ON spi.PHA_qui = saup.PHA_qui
JOIN shenzhen_20190501_users_filtered suf ON spi.PHA_qui = suf.PHA_qui
WHERE so.createdtime = 20211101
AND saup.date IN (20211101, 20220501, 20221101, 20230501, 20231101)
GROUP BY saup.date, so.lcode, spi.phonesystem

-- 20220501
SELECT
    saup.date,
    so.lcode,
    spi.phonesystem,
    COUNT(*) AS system_user_num
FROM shenzhen_app_use_people_10month saup  -- APP use
JOIN shenzhen_otherapp_createtime_largerthan50 so ON saup.lcode = so.lcode  -- original other APP 
JOIN shenzhen_phonesystem_ifios spi ON spi.PHA_qui = saup.PHA_qui
JOIN shenzhen_20190501_users_filtered suf ON spi.PHA_qui = suf.PHA_qui
WHERE so.createdtime = 20220501
AND saup.date IN (20220501, 20221101, 20230501, 20231101)
GROUP BY saup.date, so.lcode, spi.phonesystem

-- 20221101
SELECT
    saup.date,
    so.lcode,
    spi.phonesystem,
    COUNT(*) AS system_user_num
FROM shenzhen_app_use_people_10month saup  -- APP use
JOIN shenzhen_otherapp_createtime_largerthan50 so ON saup.lcode = so.lcode  -- original other APP 
JOIN shenzhen_phonesystem_ifios spi ON spi.PHA_qui = saup.PHA_qui
JOIN shenzhen_20190501_users_filtered suf ON spi.PHA_qui = suf.PHA_qui
WHERE so.createdtime = 20221101
AND saup.date IN (20221101, 20230501, 20231101)
GROUP BY saup.date, so.lcode, spi.phonesystem

-- 20230501
SELECT
    saup.date,
    so.lcode,
    spi.phonesystem,
    COUNT(*) AS system_user_num
FROM shenzhen_app_use_people_10month saup  -- APP use
JOIN shenzhen_otherapp_createtime_largerthan50 so ON saup.lcode = so.lcode  -- original other APP 
JOIN shenzhen_phonesystem_ifios spi ON spi.PHA_qui = saup.PHA_qui
JOIN shenzhen_20190501_users_filtered suf ON spi.PHA_qui = suf.PHA_qui
WHERE so.createdtime = 20230501
AND saup.date IN (20230501, 20231101)
GROUP BY saup.date, so.lcode, spi.phonesystem

-- 20231101
SELECT
    saup.date,
    so.lcode,
    spi.phonesystem,
    COUNT(*) AS system_user_num
FROM shenzhen_app_use_people_10month saup  -- APP use
JOIN shenzhen_otherapp_createtime_largerthan50 so ON saup.lcode = so.lcode  -- original other APP 
JOIN shenzhen_phonesystem_ifios spi ON spi.PHA_qui = saup.PHA_qui
JOIN shenzhen_20190501_users_filtered suf ON spi.PHA_qui = suf.PHA_qui
WHERE so.createdtime = 20231101
AND saup.date = 20231101
GROUP BY saup.date, so.lcode, spi.phonesystem


-- PHA usage & phone system

-- ios

-- 20190501
-- PHA
-- age
SELECT uf.age,
       AVG(t.PHA_num) AS avg_pha_age_ios_20190501
FROM shenzhen_20190501_users_filtered uf  -- 567101人
JOIN (SELECT PHA_qui, PHA_num
      FROM shenzhen_PHAuse_20190501_all) t on t.PHA_qui = uf.PHA_qui -- PHA count
JOIN shenzhen_phonesystem_ifios spi ON spi.PHA_qui = uf.PHA_qui
WHERE spi.date = 20190501
AND spi.phonesystem = "ios"
GROUP BY uf.age

-- 20191101
-- PHA
-- age
SELECT uf.age,
       AVG(t.PHA_num) AS avg_pha_age_ios_20191101
FROM shenzhen_20190501_users_filtered uf  -- 567101人 不用改table
JOIN (SELECT PHA_qui, PHA_num
      FROM shenzhen_PHAuse_20191101_all) t on t.PHA_qui = uf.PHA_qui -- PHA count 要改table
JOIN shenzhen_phonesystem_ifios spi ON spi.PHA_qui = uf.PHA_qui
WHERE spi.date = 20191101
AND spi.phonesystem = "ios"
GROUP BY uf.age


-- 20200501
-- PHA
-- age
SELECT uf.age,
       AVG(t.PHA_num) AS avg_pha_age_ios_20200501
FROM shenzhen_20190501_users_filtered uf  -- 567101人 不用改table
JOIN (SELECT PHA_qui, PHA_num
      FROM shenzhen_PHAuse_20200501_all) t on t.PHA_qui = uf.PHA_qui -- PHA count 要改table
JOIN shenzhen_phonesystem_ifios spi ON spi.PHA_qui = uf.PHA_qui
WHERE spi.date = 20200501
AND spi.phonesystem = "ios"
GROUP BY uf.age



-- 20201101
-- PHA
-- age
SELECT uf.age,
       AVG(t.PHA_num) AS avg_pha_age_ios_20201101
FROM shenzhen_20190501_users_filtered uf  -- 567101人 不用改table
JOIN (SELECT PHA_qui, PHA_num
      FROM shenzhen_PHAuse_20201101_all) t on t.PHA_qui = uf.PHA_qui -- PHA count 要改table
JOIN shenzhen_phonesystem_ifios spi ON spi.PHA_qui = uf.PHA_qui
WHERE spi.date = 20201101
AND spi.phonesystem = "ios"
GROUP BY uf.age



-- 20210501
-- PHA
-- age
SELECT uf.age,
       AVG(t.PHA_num) AS avg_pha_age_ios_20210501
FROM shenzhen_20190501_users_filtered uf  -- 567101人 不用改table
JOIN (SELECT PHA_qui, PHA_num
      FROM shenzhen_PHAuse_20210501_all) t on t.PHA_qui = uf.PHA_qui -- PHA count 要改table
JOIN shenzhen_phonesystem_ifios spi ON spi.PHA_qui = uf.PHA_qui
WHERE spi.date = 20210501
AND spi.phonesystem = "ios"
GROUP BY uf.age



-- 20211101
-- PHA
-- age
SELECT uf.age,
       AVG(t.PHA_num) AS avg_pha_age_ios_20211101
FROM shenzhen_20190501_users_filtered uf  -- 567101人 不用改table
JOIN (SELECT PHA_qui, PHA_num
      FROM shenzhen_PHAuse_20211101_all) t on t.PHA_qui = uf.PHA_qui -- PHA count 要改table
JOIN shenzhen_phonesystem_ifios spi ON spi.PHA_qui = uf.PHA_qui
WHERE spi.date = 20211101
AND spi.phonesystem = "ios"
GROUP BY uf.age



-- 20220501
-- PHA
-- age
SELECT uf.age,
       AVG(t.PHA_num) AS avg_pha_age_ios_20220501
FROM shenzhen_20190501_users_filtered uf  -- 567101人 不用改table
JOIN (SELECT PHA_qui, PHA_num
      FROM shenzhen_PHAuse_20220501_all) t on t.PHA_qui = uf.PHA_qui -- PHA count 要改table
JOIN shenzhen_phonesystem_ifios spi ON spi.PHA_qui = uf.PHA_qui
WHERE spi.date = 20220501
AND spi.phonesystem = "ios"
GROUP BY uf.age



-- 20221101
-- PHA
-- age
SELECT uf.age,
       AVG(t.PHA_num) AS avg_pha_age_ios_20221101
FROM shenzhen_20190501_users_filtered uf  -- 567101人 不用改table
JOIN (SELECT PHA_qui, PHA_num
      FROM shenzhen_PHAuse_20221101_all) t on t.PHA_qui = uf.PHA_qui -- PHA count 要改table
JOIN shenzhen_phonesystem_ifios spi ON spi.PHA_qui = uf.PHA_qui
WHERE spi.date = 20221101
AND spi.phonesystem = "ios"
GROUP BY uf.age


-- 20230501
-- PHA
-- age
SELECT uf.age,
       AVG(t.PHA_num) AS avg_pha_age_ios_20230501
FROM shenzhen_20190501_users_filtered uf  -- 567101人 不用改table
JOIN (SELECT PHA_qui, PHA_num
      FROM shenzhen_PHAuse_20230501_all) t on t.PHA_qui = uf.PHA_qui -- PHA count 要改table
JOIN shenzhen_phonesystem_ifios spi ON spi.PHA_qui = uf.PHA_qui
WHERE spi.date = 20230501
AND spi.phonesystem = "ios"
GROUP BY uf.age



-- 20231101
-- PHA
-- age
SELECT uf.age,
       AVG(t.PHA_num) AS avg_pha_age_ios_20231101
FROM shenzhen_20190501_users_filtered uf  -- 567101人 不用改table
JOIN (SELECT PHA_qui, PHA_num
      FROM shenzhen_PHAuse_20231101_all) t on t.PHA_qui = uf.PHA_qui -- PHA count 要改table
JOIN shenzhen_phonesystem_ifios spi ON spi.PHA_qui = uf.PHA_qui
WHERE spi.date = 20231101
AND spi.phonesystem = "ios"
GROUP BY uf.age



-- 20190501
-- All
-- age
SELECT uf.age,
       AVG(t.app_eachmonth_count) AS  avg_all_age_ios_20190501
FROM shenzhen_20190501_users_filtered uf  -- 567101人 不用改table
JOIN (SELECT PHA_qui, app_eachmonth_count
      FROM shenzhen_app_use_eachmonth_count_filtered
      WHERE date = 20190501) t ON t.PHA_qui = uf.PHA_qui -- All count 要改date
JOIN shenzhen_phonesystem_ifios spi ON spi.PHA_qui = uf.PHA_qui
WHERE spi.date = 20190501
AND spi.phonesystem = "ios"
GROUP BY uf.age


-- 20191101
-- All
-- age
SELECT uf.age,
       AVG(t.app_eachmonth_count) AS  avg_all_age_ios_20191101
FROM shenzhen_20190501_users_filtered uf  -- 567101人 不用改table
JOIN (SELECT PHA_qui, app_eachmonth_count
      FROM shenzhen_app_use_eachmonth_count_filtered
      WHERE date = 20191101) t ON t.PHA_qui = uf.PHA_qui -- All count 要改date
JOIN shenzhen_phonesystem_ifios spi ON spi.PHA_qui = uf.PHA_qui
WHERE spi.date = 20191101
AND spi.phonesystem = "ios"
GROUP BY uf.age



-- 20200501
-- All
-- age
SELECT uf.age,
       AVG(t.app_eachmonth_count) AS  avg_all_age_ios_20200501
FROM shenzhen_20190501_users_filtered uf  -- 567101人 不用改table
JOIN (SELECT PHA_qui, app_eachmonth_count
      FROM shenzhen_app_use_eachmonth_count_filtered
      WHERE date = 20200501) t ON t.PHA_qui = uf.PHA_qui -- All count 要改date
JOIN shenzhen_phonesystem_ifios spi ON spi.PHA_qui = uf.PHA_qui
WHERE spi.date = 20200501
AND spi.phonesystem = "ios"
GROUP BY uf.age


-- 20201101
-- All
-- age
SELECT uf.age,
       AVG(t.app_eachmonth_count) AS  avg_all_age_ios_20201101
FROM shenzhen_20190501_users_filtered uf  -- 567101人 不用改table
JOIN (SELECT PHA_qui, app_eachmonth_count
      FROM shenzhen_app_use_eachmonth_count_filtered
      WHERE date = 20201101) t ON t.PHA_qui = uf.PHA_qui -- All count 要改date
JOIN shenzhen_phonesystem_ifios spi ON spi.PHA_qui = uf.PHA_qui
WHERE spi.date = 20201101
AND spi.phonesystem = "ios"
GROUP BY uf.age


-- 20210501
-- All
-- age
SELECT uf.age,
       AVG(t.app_eachmonth_count) AS  avg_all_age_ios_20210501
FROM shenzhen_20190501_users_filtered uf  -- 567101人 不用改table
JOIN (SELECT PHA_qui, app_eachmonth_count
      FROM shenzhen_app_use_eachmonth_count_filtered
      WHERE date = 20210501) t ON t.PHA_qui = uf.PHA_qui -- All count 要改date
JOIN shenzhen_phonesystem_ifios spi ON spi.PHA_qui = uf.PHA_qui
WHERE spi.date = 20210501
AND spi.phonesystem = "ios"
GROUP BY uf.age


-- 20211101
-- All
-- age
SELECT uf.age,
       AVG(t.app_eachmonth_count) AS  avg_all_age_ios_20211101
FROM shenzhen_20190501_users_filtered uf  -- 567101人 不用改table
JOIN (SELECT PHA_qui, app_eachmonth_count
      FROM shenzhen_app_use_eachmonth_count_filtered
      WHERE date = 20211101) t ON t.PHA_qui = uf.PHA_qui -- All count 要改date
JOIN shenzhen_phonesystem_ifios spi ON spi.PHA_qui = uf.PHA_qui
WHERE spi.date = 20211101
AND spi.phonesystem = "ios"
GROUP BY uf.age


-- 20220501
-- All
-- age
SELECT uf.age,
       AVG(t.app_eachmonth_count) AS  avg_all_age_ios_20220501
FROM shenzhen_20190501_users_filtered uf  -- 567101人 不用改table
JOIN (SELECT PHA_qui, app_eachmonth_count
      FROM shenzhen_app_use_eachmonth_count_filtered
      WHERE date = 20220501) t ON t.PHA_qui = uf.PHA_qui -- All count 要改date
JOIN shenzhen_phonesystem_ifios spi ON spi.PHA_qui = uf.PHA_qui
WHERE spi.date = 20220501
AND spi.phonesystem = "ios"
GROUP BY uf.age


-- 20221101
-- All
-- age
SELECT uf.age,
       AVG(t.app_eachmonth_count) AS  avg_all_age_ios_20221101
FROM shenzhen_20190501_users_filtered uf  -- 567101人 不用改table
JOIN (SELECT PHA_qui, app_eachmonth_count
      FROM shenzhen_app_use_eachmonth_count_filtered
      WHERE date = 20221101) t ON t.PHA_qui = uf.PHA_qui -- All count 要改date
JOIN shenzhen_phonesystem_ifios spi ON spi.PHA_qui = uf.PHA_qui
WHERE spi.date = 20221101
AND spi.phonesystem = "ios"
GROUP BY uf.age


-- 20230501
-- All
-- age
SELECT uf.age,
       AVG(t.app_eachmonth_count) AS  avg_all_age_ios_20230501
FROM shenzhen_20190501_users_filtered uf  -- 567101人 不用改table
JOIN (SELECT PHA_qui, app_eachmonth_count
      FROM shenzhen_app_use_eachmonth_count_filtered
      WHERE date = 20230501) t ON t.PHA_qui = uf.PHA_qui -- All count 要改date
JOIN shenzhen_phonesystem_ifios spi ON spi.PHA_qui = uf.PHA_qui
WHERE spi.date = 20230501
AND spi.phonesystem = "ios"
GROUP BY uf.age


-- 20231101
-- All
-- age
SELECT uf.age,
       AVG(t.app_eachmonth_count) AS  avg_all_age_ios_20231101
FROM shenzhen_20190501_users_filtered uf  -- 567101人 不用改table
JOIN (SELECT PHA_qui, app_eachmonth_count
      FROM shenzhen_app_use_eachmonth_count_filtered
      WHERE date = 20231101) t ON t.PHA_qui = uf.PHA_qui -- All count 要改date
JOIN shenzhen_phonesystem_ifios spi ON spi.PHA_qui = uf.PHA_qui
WHERE spi.date = 20231101
AND spi.phonesystem = "ios"
GROUP BY uf.age







-- ios

-- 20190501
-- PHA
-- gender

SELECT uf.gender,
       AVG(t.PHA_num) AS avg_pha_gender_ios_20190501
FROM shenzhen_20190501_users_filtered uf  -- 567101人
JOIN (SELECT PHA_qui, PHA_num
      FROM shenzhen_PHAuse_20190501_all) t on t.PHA_qui = uf.PHA_qui -- PHA count
JOIN shenzhen_phonesystem_ifios spi ON spi.PHA_qui = uf.PHA_qui
WHERE spi.date = 20190501
AND spi.phonesystem = "ios"
GROUP BY uf.gender

-- 20191101
-- PHA
-- gender
SELECT uf.gender,
       AVG(t.PHA_num) AS avg_pha_gender_ios_20191101
FROM shenzhen_20190501_users_filtered uf  -- 567101人 不用改table
JOIN (SELECT PHA_qui, PHA_num
      FROM shenzhen_PHAuse_20191101_all) t on t.PHA_qui = uf.PHA_qui -- PHA count 要改table
JOIN shenzhen_phonesystem_ifios spi ON spi.PHA_qui = uf.PHA_qui
WHERE spi.date = 20191101
AND spi.phonesystem = "ios"
GROUP BY uf.gender


-- 20200501
-- PHA
-- gender
SELECT uf.gender,
       AVG(t.PHA_num) AS avg_pha_gender_ios_20200501
FROM shenzhen_20190501_users_filtered uf  -- 567101人 不用改table
JOIN (SELECT PHA_qui, PHA_num
      FROM shenzhen_PHAuse_20200501_all) t on t.PHA_qui = uf.PHA_qui -- PHA count 要改table
JOIN shenzhen_phonesystem_ifios spi ON spi.PHA_qui = uf.PHA_qui
WHERE spi.date = 20200501
AND spi.phonesystem = "ios"
GROUP BY uf.gender



-- 20201101
-- PHA
-- gender
SELECT uf.gender,
       AVG(t.PHA_num) AS avg_pha_gender_ios_20201101
FROM shenzhen_20190501_users_filtered uf  -- 567101人 不用改table
JOIN (SELECT PHA_qui, PHA_num
      FROM shenzhen_PHAuse_20201101_all) t on t.PHA_qui = uf.PHA_qui -- PHA count 要改table
JOIN shenzhen_phonesystem_ifios spi ON spi.PHA_qui = uf.PHA_qui
WHERE spi.date = 20201101
AND spi.phonesystem = "ios"
GROUP BY uf.gender



-- 20210501
-- PHA
-- gender
SELECT uf.gender,
       AVG(t.PHA_num) AS avg_pha_gender_ios_20210501
FROM shenzhen_20190501_users_filtered uf  -- 567101人 不用改table
JOIN (SELECT PHA_qui, PHA_num
      FROM shenzhen_PHAuse_20210501_all) t on t.PHA_qui = uf.PHA_qui -- PHA count 要改table
JOIN shenzhen_phonesystem_ifios spi ON spi.PHA_qui = uf.PHA_qui
WHERE spi.date = 20210501
AND spi.phonesystem = "ios"
GROUP BY uf.gender



-- 20211101
-- PHA
-- gender
SELECT uf.gender,
       AVG(t.PHA_num) AS avg_pha_gender_ios_20211101
FROM shenzhen_20190501_users_filtered uf  -- 567101人 不用改table
JOIN (SELECT PHA_qui, PHA_num
      FROM shenzhen_PHAuse_20211101_all) t on t.PHA_qui = uf.PHA_qui -- PHA count 要改table
JOIN shenzhen_phonesystem_ifios spi ON spi.PHA_qui = uf.PHA_qui
WHERE spi.date = 20211101
AND spi.phonesystem = "ios"
GROUP BY uf.gender



-- 20220501
-- PHA
-- gender
SELECT uf.gender,
       AVG(t.PHA_num) AS avg_pha_gender_ios_20220501
FROM shenzhen_20190501_users_filtered uf  -- 567101人 不用改table
JOIN (SELECT PHA_qui, PHA_num
      FROM shenzhen_PHAuse_20220501_all) t on t.PHA_qui = uf.PHA_qui -- PHA count 要改table
JOIN shenzhen_phonesystem_ifios spi ON spi.PHA_qui = uf.PHA_qui
WHERE spi.date = 20220501
AND spi.phonesystem = "ios"
GROUP BY uf.gender



-- 20221101
-- PHA
-- gender
SELECT uf.gender,
       AVG(t.PHA_num) AS avg_pha_gender_ios_20221101
FROM shenzhen_20190501_users_filtered uf  -- 567101人 不用改table
JOIN (SELECT PHA_qui, PHA_num
      FROM shenzhen_PHAuse_20221101_all) t on t.PHA_qui = uf.PHA_qui -- PHA count 要改table
JOIN shenzhen_phonesystem_ifios spi ON spi.PHA_qui = uf.PHA_qui
WHERE spi.date = 20221101
AND spi.phonesystem = "ios"
GROUP BY uf.gender


-- 20230501
-- PHA
-- gender
SELECT uf.gender,
       AVG(t.PHA_num) AS avg_pha_gender_ios_20230501
FROM shenzhen_20190501_users_filtered uf  -- 567101人 不用改table
JOIN (SELECT PHA_qui, PHA_num
      FROM shenzhen_PHAuse_20230501_all) t on t.PHA_qui = uf.PHA_qui -- PHA count 要改table
JOIN shenzhen_phonesystem_ifios spi ON spi.PHA_qui = uf.PHA_qui
WHERE spi.date = 20230501
AND spi.phonesystem = "ios"
GROUP BY uf.gender



-- 20231101
-- PHA
-- gender
SELECT uf.gender,
       AVG(t.PHA_num) AS avg_pha_gender_ios_20231101
FROM shenzhen_20190501_users_filtered uf  -- 567101人 不用改table
JOIN (SELECT PHA_qui, PHA_num
      FROM shenzhen_PHAuse_20231101_all) t on t.PHA_qui = uf.PHA_qui -- PHA count 要改table
JOIN shenzhen_phonesystem_ifios spi ON spi.PHA_qui = uf.PHA_qui
WHERE spi.date = 20231101
AND spi.phonesystem = "ios"
GROUP BY uf.gender



-- 20190501
-- All
-- gender
SELECT uf.gender,
       AVG(t.app_eachmonth_count) AS  avg_all_gender_ios_20190501
FROM shenzhen_20190501_users_filtered uf  -- 567101人 不用改table
JOIN (SELECT PHA_qui, app_eachmonth_count
      FROM shenzhen_app_use_eachmonth_count_filtered
      WHERE date = 20190501) t ON t.PHA_qui = uf.PHA_qui -- All count 要改date
JOIN shenzhen_phonesystem_ifios spi ON spi.PHA_qui = uf.PHA_qui
WHERE spi.date = 20190501
AND spi.phonesystem = "ios"
GROUP BY uf.gender


-- 20191101
-- All
-- gender
SELECT uf.gender,
       AVG(t.app_eachmonth_count) AS  avg_all_gender_ios_20191101
FROM shenzhen_20190501_users_filtered uf  -- 567101人 不用改table
JOIN (SELECT PHA_qui, app_eachmonth_count
      FROM shenzhen_app_use_eachmonth_count_filtered
      WHERE date = 20191101) t ON t.PHA_qui = uf.PHA_qui -- All count 要改date
JOIN shenzhen_phonesystem_ifios spi ON spi.PHA_qui = uf.PHA_qui
WHERE spi.date = 20191101
AND spi.phonesystem = "ios"
GROUP BY uf.gender



-- 20200501
-- All
-- gender
SELECT uf.gender,
       AVG(t.app_eachmonth_count) AS  avg_all_gender_ios_20200501
FROM shenzhen_20190501_users_filtered uf  -- 567101人 不用改table
JOIN (SELECT PHA_qui, app_eachmonth_count
      FROM shenzhen_app_use_eachmonth_count_filtered
      WHERE date = 20200501) t ON t.PHA_qui = uf.PHA_qui -- All count 要改date
JOIN shenzhen_phonesystem_ifios spi ON spi.PHA_qui = uf.PHA_qui
WHERE spi.date = 20200501
AND spi.phonesystem = "ios"
GROUP BY uf.gender


-- 20201101
-- All
-- gender
SELECT uf.gender,
       AVG(t.app_eachmonth_count) AS  avg_all_gender_ios_20201101
FROM shenzhen_20190501_users_filtered uf  -- 567101人 不用改table
JOIN (SELECT PHA_qui, app_eachmonth_count
      FROM shenzhen_app_use_eachmonth_count_filtered
      WHERE date = 20201101) t ON t.PHA_qui = uf.PHA_qui -- All count 要改date
JOIN shenzhen_phonesystem_ifios spi ON spi.PHA_qui = uf.PHA_qui
WHERE spi.date = 20201101
AND spi.phonesystem = "ios"
GROUP BY uf.gender


-- 20210501
-- All
-- gender
SELECT uf.gender,
       AVG(t.app_eachmonth_count) AS  avg_all_gender_ios_20210501
FROM shenzhen_20190501_users_filtered uf  -- 567101人 不用改table
JOIN (SELECT PHA_qui, app_eachmonth_count
      FROM shenzhen_app_use_eachmonth_count_filtered
      WHERE date = 20210501) t ON t.PHA_qui = uf.PHA_qui -- All count 要改date
JOIN shenzhen_phonesystem_ifios spi ON spi.PHA_qui = uf.PHA_qui
WHERE spi.date = 20210501
AND spi.phonesystem = "ios"
GROUP BY uf.gender


-- 20211101
-- All
-- gender
SELECT uf.gender,
       AVG(t.app_eachmonth_count) AS  avg_all_gender_ios_20211101
FROM shenzhen_20190501_users_filtered uf  -- 567101人 不用改table
JOIN (SELECT PHA_qui, app_eachmonth_count
      FROM shenzhen_app_use_eachmonth_count_filtered
      WHERE date = 20211101) t ON t.PHA_qui = uf.PHA_qui -- All count 要改date
JOIN shenzhen_phonesystem_ifios spi ON spi.PHA_qui = uf.PHA_qui
WHERE spi.date = 20211101
AND spi.phonesystem = "ios"
GROUP BY uf.gender


-- 20220501
-- All
-- gender
SELECT uf.gender,
       AVG(t.app_eachmonth_count) AS  avg_all_gender_ios_20220501
FROM shenzhen_20190501_users_filtered uf  -- 567101人 不用改table
JOIN (SELECT PHA_qui, app_eachmonth_count
      FROM shenzhen_app_use_eachmonth_count_filtered
      WHERE date = 20220501) t ON t.PHA_qui = uf.PHA_qui -- All count 要改date
JOIN shenzhen_phonesystem_ifios spi ON spi.PHA_qui = uf.PHA_qui
WHERE spi.date = 20220501
AND spi.phonesystem = "ios"
GROUP BY uf.gender


-- 20221101
-- All
-- gender
SELECT uf.gender,
       AVG(t.app_eachmonth_count) AS  avg_all_gender_ios_20221101
FROM shenzhen_20190501_users_filtered uf  -- 567101人 不用改table
JOIN (SELECT PHA_qui, app_eachmonth_count
      FROM shenzhen_app_use_eachmonth_count_filtered
      WHERE date = 20221101) t ON t.PHA_qui = uf.PHA_qui -- All count 要改date
JOIN shenzhen_phonesystem_ifios spi ON spi.PHA_qui = uf.PHA_qui
WHERE spi.date = 20221101
AND spi.phonesystem = "ios"
GROUP BY uf.gender


-- 20230501
-- All
-- gender
SELECT uf.gender,
       AVG(t.app_eachmonth_count) AS  avg_all_gender_ios_20230501
FROM shenzhen_20190501_users_filtered uf  -- 567101人 不用改table
JOIN (SELECT PHA_qui, app_eachmonth_count
      FROM shenzhen_app_use_eachmonth_count_filtered
      WHERE date = 20230501) t ON t.PHA_qui = uf.PHA_qui -- All count 要改date
JOIN shenzhen_phonesystem_ifios spi ON spi.PHA_qui = uf.PHA_qui
WHERE spi.date = 20230501
AND spi.phonesystem = "ios"
GROUP BY uf.gender


-- 20231101
-- All
-- gender
SELECT uf.gender,
       AVG(t.app_eachmonth_count) AS  avg_all_gender_ios_20231101
FROM shenzhen_20190501_users_filtered uf  -- 567101人 不用改table
JOIN (SELECT PHA_qui, app_eachmonth_count
      FROM shenzhen_app_use_eachmonth_count_filtered
      WHERE date = 20231101) t ON t.PHA_qui = uf.PHA_qui -- All count 要改date
JOIN shenzhen_phonesystem_ifios spi ON spi.PHA_qui = uf.PHA_qui
WHERE spi.date = 20231101
AND spi.phonesystem = "ios"
GROUP BY uf.gender




-- ios

-- 20190501
-- PHA
-- income
SELECT phoneprice_level,
       AVG(t.PHA_num) AS avg_pha_income_ios_20190501
FROM shenzhen_20190501_users_filtered uf  -- 567101人
JOIN (SELECT PHA_qui, PHA_num
      FROM shenzhen_PHAuse_20190501_all) t on t.PHA_qui = uf.PHA_qui -- PHA count 要改table
JOIN shenzhen_people_phoneprice_10monthavg_level sppl ON sppl.PHA_qui = uf.PHA_qui -- income level 每个人只有一条记录
JOIN shenzhen_phonesystem_ifios spi ON spi.PHA_qui = uf.PHA_qui -- phone system
WHERE spi.date = 20190501
AND spi.phonesystem = "ios"
GROUP BY phoneprice_level


-- 20191101
-- PHA
-- income
SELECT phoneprice_level,
       AVG(t.PHA_num) AS avg_pha_income_ios_20191101
FROM shenzhen_20190501_users_filtered uf  -- 567101人
JOIN (SELECT PHA_qui, PHA_num
      FROM shenzhen_PHAuse_20191101_all) t on t.PHA_qui = uf.PHA_qui -- PHA count 要改table
JOIN shenzhen_people_phoneprice_10monthavg_level sppl ON sppl.PHA_qui = uf.PHA_qui -- income level 每个人只有一条记录
JOIN shenzhen_phonesystem_ifios spi ON spi.PHA_qui = uf.PHA_qui -- phone system
WHERE spi.date = 20191101
AND spi.phonesystem = "ios"
GROUP BY phoneprice_level


-- 20200501
-- PHA
-- income
SELECT phoneprice_level,
       AVG(t.PHA_num) AS avg_pha_income_ios_20200501
FROM shenzhen_20190501_users_filtered uf  -- 567101人
JOIN (SELECT PHA_qui, PHA_num
      FROM shenzhen_PHAuse_20200501_all) t on t.PHA_qui = uf.PHA_qui -- PHA count 要改table
JOIN shenzhen_people_phoneprice_10monthavg_level sppl ON sppl.PHA_qui = uf.PHA_qui -- income level 每个人只有一条记录
JOIN shenzhen_phonesystem_ifios spi ON spi.PHA_qui = uf.PHA_qui -- phone system
WHERE spi.date = 20200501
AND spi.phonesystem = "ios"
GROUP BY phoneprice_level


-- 20201101
-- PHA
-- income
SELECT phoneprice_level,
       AVG(t.PHA_num) AS avg_pha_income_ios_20201101
FROM shenzhen_20201101_users_filtered uf  -- 567101人
JOIN (SELECT PHA_qui, PHA_num
      FROM shenzhen_PHAuse_20201101_all) t on t.PHA_qui = uf.PHA_qui -- PHA count 要改table
JOIN shenzhen_people_phoneprice_10monthavg_level sppl ON sppl.PHA_qui = uf.PHA_qui -- income level 每个人只有一条记录
JOIN shenzhen_phonesystem_ifios spi ON spi.PHA_qui = uf.PHA_qui -- phone system
WHERE spi.date = 20201101
AND spi.phonesystem = "ios"
GROUP BY phoneprice_level


-- 20210501
-- PHA
-- income
SELECT phoneprice_level,
       AVG(t.PHA_num) AS avg_pha_income_ios_20210501
FROM shenzhen_20190501_users_filtered uf  -- 567101人
JOIN (SELECT PHA_qui, PHA_num
      FROM shenzhen_PHAuse_20210501_all) t on t.PHA_qui = uf.PHA_qui -- PHA count 要改table
JOIN shenzhen_people_phoneprice_10monthavg_level sppl ON sppl.PHA_qui = uf.PHA_qui -- income level 每个人只有一条记录
JOIN shenzhen_phonesystem_ifios spi ON spi.PHA_qui = uf.PHA_qui -- phone system
WHERE spi.date = 20210501
AND spi.phonesystem = "ios"
GROUP BY phoneprice_level


-- 20211101
-- PHA
-- income
SELECT phoneprice_level,
       AVG(t.PHA_num) AS avg_pha_income_ios_20211101
FROM shenzhen_20201101_users_filtered uf  -- 567101人
JOIN (SELECT PHA_qui, PHA_num
      FROM shenzhen_PHAuse_20211101_all) t on t.PHA_qui = uf.PHA_qui -- PHA count 要改table
JOIN shenzhen_people_phoneprice_10monthavg_level sppl ON sppl.PHA_qui = uf.PHA_qui -- income level 每个人只有一条记录
JOIN shenzhen_phonesystem_ifios spi ON spi.PHA_qui = uf.PHA_qui -- phone system
WHERE spi.date = 20211101
AND spi.phonesystem = "ios"
GROUP BY phoneprice_level



-- 20220501
-- PHA
-- income
SELECT phoneprice_level,
       AVG(t.PHA_num) AS avg_pha_income_ios_20220501
FROM shenzhen_20190501_users_filtered uf  -- 567101人
JOIN (SELECT PHA_qui, PHA_num
      FROM shenzhen_PHAuse_20220501_all) t on t.PHA_qui = uf.PHA_qui -- PHA count 要改table
JOIN shenzhen_people_phoneprice_10monthavg_level sppl ON sppl.PHA_qui = uf.PHA_qui -- income level 每个人只有一条记录
JOIN shenzhen_phonesystem_ifios spi ON spi.PHA_qui = uf.PHA_qui -- phone system
WHERE spi.date = 20220501
AND spi.phonesystem = "ios"
GROUP BY phoneprice_level


-- 20221101
-- PHA
-- income
SELECT phoneprice_level,
       AVG(t.PHA_num) AS avg_pha_income_ios_20221101
FROM shenzhen_20201101_users_filtered uf  -- 567101人
JOIN (SELECT PHA_qui, PHA_num
      FROM shenzhen_PHAuse_20221101_all) t on t.PHA_qui = uf.PHA_qui -- PHA count 要改table
JOIN shenzhen_people_phoneprice_10monthavg_level sppl ON sppl.PHA_qui = uf.PHA_qui -- income level 每个人只有一条记录
JOIN shenzhen_phonesystem_ifios spi ON spi.PHA_qui = uf.PHA_qui -- phone system
WHERE spi.date = 20221101
AND spi.phonesystem = "ios"
GROUP BY phoneprice_level


-- 20230501
-- PHA
-- income
SELECT phoneprice_level,
       AVG(t.PHA_num) AS avg_pha_income_ios_20230501
FROM shenzhen_20190501_users_filtered uf  -- 567101人
JOIN (SELECT PHA_qui, PHA_num
      FROM shenzhen_PHAuse_20230501_all) t on t.PHA_qui = uf.PHA_qui -- PHA count 要改table
JOIN shenzhen_people_phoneprice_10monthavg_level sppl ON sppl.PHA_qui = uf.PHA_qui -- income level 每个人只有一条记录
JOIN shenzhen_phonesystem_ifios spi ON spi.PHA_qui = uf.PHA_qui -- phone system
WHERE spi.date = 20230501
AND spi.phonesystem = "ios"
GROUP BY phoneprice_level


-- 20231101
-- PHA
-- income
SELECT phoneprice_level,
       AVG(t.PHA_num) AS avg_pha_income_ios_20231101
FROM shenzhen_20201101_users_filtered uf  -- 567101人
JOIN (SELECT PHA_qui, PHA_num
      FROM shenzhen_PHAuse_20231101_all) t on t.PHA_qui = uf.PHA_qui -- PHA count 要改table
JOIN shenzhen_people_phoneprice_10monthavg_level sppl ON sppl.PHA_qui = uf.PHA_qui -- income level 每个人只有一条记录
JOIN shenzhen_phonesystem_ifios spi ON spi.PHA_qui = uf.PHA_qui -- phone system
WHERE spi.date = 20231101
AND spi.phonesystem = "ios"
GROUP BY phoneprice_level






-- 20190501
-- ALL
-- income
SELECT phoneprice_level,
       AVG(t.app_eachmonth_count) AS  avg_all_income_ios_20190501
FROM shenzhen_20190501_users_filtered uf  -- 567101人 不用改table
JOIN (SELECT PHA_qui, app_eachmonth_count
      FROM shenzhen_app_use_eachmonth_count_filtered
      WHERE date = 20190501) t ON t.PHA_qui = uf.PHA_qui -- All count 要改date
JOIN shenzhen_people_phoneprice_10monthavg_level sppl ON sppl.PHA_qui = uf.PHA_qui -- income level 每个人只有一条记录
JOIN shenzhen_phonesystem_ifios spi ON spi.PHA_qui = uf.PHA_qui -- phone system
WHERE spi.date = 20190501
AND spi.phonesystem = "ios"
GROUP BY phoneprice_level



-- 20191101
-- ALL
-- income
SELECT phoneprice_level,
       AVG(t.app_eachmonth_count) AS  avg_all_income_ios_20191101
FROM shenzhen_20190501_users_filtered uf  -- 567101人 不用改table
JOIN (SELECT PHA_qui, app_eachmonth_count
      FROM shenzhen_app_use_eachmonth_count_filtered
      WHERE date = 20191101) t ON t.PHA_qui = uf.PHA_qui -- All count 要改date
JOIN shenzhen_people_phoneprice_10monthavg_level sppl ON sppl.PHA_qui = uf.PHA_qui -- income level 每个人只有一条记录
JOIN shenzhen_phonesystem_ifios spi ON spi.PHA_qui = uf.PHA_qui -- phone system
WHERE spi.date = 20191101
AND spi.phonesystem = "ios"
GROUP BY phoneprice_level



-- 20200501
-- ALL
-- income
SELECT phoneprice_level,
       AVG(t.app_eachmonth_count) AS  avg_all_income_ios_20200501
FROM shenzhen_20190501_users_filtered uf  -- 567101人 不用改table
JOIN (SELECT PHA_qui, app_eachmonth_count
      FROM shenzhen_app_use_eachmonth_count_filtered
      WHERE date = 20200501) t ON t.PHA_qui = uf.PHA_qui -- All count 要改date
JOIN shenzhen_people_phoneprice_10monthavg_level sppl ON sppl.PHA_qui = uf.PHA_qui -- income level 每个人只有一条记录
JOIN shenzhen_phonesystem_ifios spi ON spi.PHA_qui = uf.PHA_qui -- phone system
WHERE spi.date = 20200501
AND spi.phonesystem = "ios"
GROUP BY phoneprice_level


-- 20201101
-- ALL
-- income
SELECT phoneprice_level,
       AVG(t.app_eachmonth_count) AS  avg_all_income_ios_20201101
FROM shenzhen_20190501_users_filtered uf  -- 567101人 不用改table
JOIN (SELECT PHA_qui, app_eachmonth_count
      FROM shenzhen_app_use_eachmonth_count_filtered
      WHERE date = 20201101) t ON t.PHA_qui = uf.PHA_qui -- All count 要改date
JOIN shenzhen_people_phoneprice_10monthavg_level sppl ON sppl.PHA_qui = uf.PHA_qui -- income level 每个人只有一条记录
JOIN shenzhen_phonesystem_ifios spi ON spi.PHA_qui = uf.PHA_qui -- phone system
WHERE spi.date = 20201101
AND spi.phonesystem = "ios"
GROUP BY phoneprice_level


-- 20210501
-- ALL
-- income
SELECT phoneprice_level,
       AVG(t.app_eachmonth_count) AS  avg_all_income_ios_20210501
FROM shenzhen_20190501_users_filtered uf  -- 567101人 不用改table
JOIN (SELECT PHA_qui, app_eachmonth_count
      FROM shenzhen_app_use_eachmonth_count_filtered
      WHERE date = 20210501) t ON t.PHA_qui = uf.PHA_qui -- All count 要改date
JOIN shenzhen_people_phoneprice_10monthavg_level sppl ON sppl.PHA_qui = uf.PHA_qui -- income level 每个人只有一条记录
JOIN shenzhen_phonesystem_ifios spi ON spi.PHA_qui = uf.PHA_qui -- phone system
WHERE spi.date = 20210501
AND spi.phonesystem = "ios"
GROUP BY phoneprice_level


-- 20211101
-- ALL
-- income
SELECT phoneprice_level,
       AVG(t.app_eachmonth_count) AS  avg_all_income_ios_20211101
FROM shenzhen_20190501_users_filtered uf  -- 567101人 不用改table
JOIN (SELECT PHA_qui, app_eachmonth_count
      FROM shenzhen_app_use_eachmonth_count_filtered
      WHERE date = 20211101) t ON t.PHA_qui = uf.PHA_qui -- All count 要改date
JOIN shenzhen_people_phoneprice_10monthavg_level sppl ON sppl.PHA_qui = uf.PHA_qui -- income level 每个人只有一条记录
JOIN shenzhen_phonesystem_ifios spi ON spi.PHA_qui = uf.PHA_qui -- phone system
WHERE spi.date = 20211101
AND spi.phonesystem = "ios"
GROUP BY phoneprice_level


-- 20220501
-- ALL
-- income
SELECT phoneprice_level,
       AVG(t.app_eachmonth_count) AS  avg_all_income_ios_20220501
FROM shenzhen_20190501_users_filtered uf  -- 567101人 不用改table
JOIN (SELECT PHA_qui, app_eachmonth_count
      FROM shenzhen_app_use_eachmonth_count_filtered
      WHERE date = 20220501) t ON t.PHA_qui = uf.PHA_qui -- All count 要改date
JOIN shenzhen_people_phoneprice_10monthavg_level sppl ON sppl.PHA_qui = uf.PHA_qui -- income level 每个人只有一条记录
JOIN shenzhen_phonesystem_ifios spi ON spi.PHA_qui = uf.PHA_qui -- phone system
WHERE spi.date = 20220501
AND spi.phonesystem = "ios"
GROUP BY phoneprice_level


-- 20221101
-- ALL
-- income
SELECT phoneprice_level,
       AVG(t.app_eachmonth_count) AS  avg_all_income_ios_20221101
FROM shenzhen_20190501_users_filtered uf  -- 567101人 不用改table
JOIN (SELECT PHA_qui, app_eachmonth_count
      FROM shenzhen_app_use_eachmonth_count_filtered
      WHERE date = 20221101) t ON t.PHA_qui = uf.PHA_qui -- All count 要改date
JOIN shenzhen_people_phoneprice_10monthavg_level sppl ON sppl.PHA_qui = uf.PHA_qui -- income level 每个人只有一条记录
JOIN shenzhen_phonesystem_ifios spi ON spi.PHA_qui = uf.PHA_qui -- phone system
WHERE spi.date = 20221101
AND spi.phonesystem = "ios"
GROUP BY phoneprice_level



-- 20230501
-- ALL
-- income
SELECT phoneprice_level,
       AVG(t.app_eachmonth_count) AS  avg_all_income_ios_20230501
FROM shenzhen_20190501_users_filtered uf  -- 567101人 不用改table
JOIN (SELECT PHA_qui, app_eachmonth_count
      FROM shenzhen_app_use_eachmonth_count_filtered
      WHERE date = 20230501) t ON t.PHA_qui = uf.PHA_qui -- All count 要改date
JOIN shenzhen_people_phoneprice_10monthavg_level sppl ON sppl.PHA_qui = uf.PHA_qui -- income level 每个人只有一条记录
JOIN shenzhen_phonesystem_ifios spi ON spi.PHA_qui = uf.PHA_qui -- phone system
WHERE spi.date = 20230501
AND spi.phonesystem = "ios"
GROUP BY phoneprice_level


-- 20231101
-- ALL
-- income
SELECT phoneprice_level,
       AVG(t.app_eachmonth_count) AS  avg_all_income_ios_20231101
FROM shenzhen_20190501_users_filtered uf  -- 567101人 不用改table
JOIN (SELECT PHA_qui, app_eachmonth_count
      FROM shenzhen_app_use_eachmonth_count_filtered
      WHERE date = 20231101) t ON t.PHA_qui = uf.PHA_qui -- All count 要改date
JOIN shenzhen_people_phoneprice_10monthavg_level sppl ON sppl.PHA_qui = uf.PHA_qui -- income level 每个人只有一条记录
JOIN shenzhen_phonesystem_ifios spi ON spi.PHA_qui = uf.PHA_qui -- phone system
WHERE spi.date = 20231101
AND spi.phonesystem = "ios"
GROUP BY phoneprice_level


-- relationship between income level and phone system (whether iphone are more expensive)
SELECT
      date,
      phonesystem,
      phoneprice_level,
      COUNT(*) AS user_num
FROM shenzhen_phonesystem_ifios spi
JOIN shenzhen_people_phoneprice_10monthavg_level sppl ON sppl.PHA_qui = spi.PHA_qui
GROUP BY date, phonesystem, phoneprice_level



-- Android

ios
-- PHA
-- age
SELECT uf.age,
       AVG(t.PHA_num) AS avg_pha_age_Andorid_20190501
FROM shenzhen_20190501_users_filtered uf  -- 567101人
JOIN (SELECT PHA_qui, PHA_num
      FROM shenzhen_PHAuse_20190501_all) t on t.PHA_qui = uf.PHA_qui -- PHA count
JOIN shenzhen_phonesystem_ifios spi ON spi.PHA_qui = uf.PHA_qui
WHERE spi.date = 20190501
AND spi.phonesystem = "Android"
GROUP BY uf.age

-- 20191101
-- PHA
-- age
SELECT uf.age,
       AVG(t.PHA_num) AS avg_pha_age_Andorid_20191101
FROM shenzhen_20190501_users_filtered uf  -- 567101人 不用改table
JOIN (SELECT PHA_qui, PHA_num
      FROM shenzhen_PHAuse_20191101_all) t on t.PHA_qui = uf.PHA_qui -- PHA count 要改table
JOIN shenzhen_phonesystem_ifios spi ON spi.PHA_qui = uf.PHA_qui
WHERE spi.date = 20191101
AND spi.phonesystem = "Android"
GROUP BY uf.age

-- 20200501
-- PHA
-- age
SELECT uf.age,
       AVG(t.PHA_num) AS avg_pha_age_Andorid_20200501
FROM shenzhen_20190501_users_filtered uf  -- 567101人 不用改table
JOIN (SELECT PHA_qui, PHA_num
      FROM shenzhen_PHAuse_20200501_all) t on t.PHA_qui = uf.PHA_qui -- PHA count 要改table
JOIN shenzhen_phonesystem_ifios spi ON spi.PHA_qui = uf.PHA_qui
WHERE spi.date = 20200501
AND spi.phonesystem = "Android"
GROUP BY uf.age


-- 20201101
-- PHA
-- age
SELECT uf.age,
       AVG(t.PHA_num) AS avg_pha_age_Andorid_20201101
FROM shenzhen_20190501_users_filtered uf  -- 567101人 不用改table
JOIN (SELECT PHA_qui, PHA_num
      FROM shenzhen_PHAuse_20201101_all) t on t.PHA_qui = uf.PHA_qui -- PHA count 要改table
JOIN shenzhen_phonesystem_ifios spi ON spi.PHA_qui = uf.PHA_qui
WHERE spi.date = 20201101
AND spi.phonesystem = "Android"
GROUP BY uf.age


-- 20210501
-- PHA
-- age
SELECT uf.age,
       AVG(t.PHA_num) AS avg_pha_age_Andorid_20210501
FROM shenzhen_20190501_users_filtered uf  -- 567101人 不用改table
JOIN (SELECT PHA_qui, PHA_num
      FROM shenzhen_PHAuse_20210501_all) t on t.PHA_qui = uf.PHA_qui -- PHA count 要改table
JOIN shenzhen_phonesystem_ifios spi ON spi.PHA_qui = uf.PHA_qui
WHERE spi.date = 20210501
AND spi.phonesystem = "Android"
GROUP BY uf.age


-- 20211101
-- PHA
-- age
SELECT uf.age,
       AVG(t.PHA_num) AS avg_pha_age_Andorid_20211101
FROM shenzhen_20190501_users_filtered uf  -- 567101人 不用改table
JOIN (SELECT PHA_qui, PHA_num
      FROM shenzhen_PHAuse_20211101_all) t on t.PHA_qui = uf.PHA_qui -- PHA count 要改table
JOIN shenzhen_phonesystem_ifios spi ON spi.PHA_qui = uf.PHA_qui
WHERE spi.date = 20211101
AND spi.phonesystem = "Android"
GROUP BY uf.age


-- 20220501
-- PHA
-- age
SELECT uf.age,
       AVG(t.PHA_num) AS avg_pha_age_Andorid_20220501
FROM shenzhen_20190501_users_filtered uf  -- 567101人 不用改table
JOIN (SELECT PHA_qui, PHA_num
      FROM shenzhen_PHAuse_20220501_all) t on t.PHA_qui = uf.PHA_qui -- PHA count 要改table
JOIN shenzhen_phonesystem_ifios spi ON spi.PHA_qui = uf.PHA_qui
WHERE spi.date = 20220501
AND spi.phonesystem = "Android"
GROUP BY uf.age


-- 20221101
-- PHA
-- age
SELECT uf.age,
       AVG(t.PHA_num) AS avg_pha_age_Andorid_20221101
FROM shenzhen_20190501_users_filtered uf  -- 567101人 不用改table
JOIN (SELECT PHA_qui, PHA_num
      FROM shenzhen_PHAuse_20221101_all) t on t.PHA_qui = uf.PHA_qui -- PHA count 要改table
JOIN shenzhen_phonesystem_ifios spi ON spi.PHA_qui = uf.PHA_qui
WHERE spi.date = 20221101
AND spi.phonesystem = "Android"
GROUP BY uf.age

-- 20230501
-- PHA
-- age
SELECT uf.age,
       AVG(t.PHA_num) AS avg_pha_age_Andorid_20230501
FROM shenzhen_20190501_users_filtered uf  -- 567101人 不用改table
JOIN (SELECT PHA_qui, PHA_num
      FROM shenzhen_PHAuse_20230501_all) t on t.PHA_qui = uf.PHA_qui -- PHA count 要改table
JOIN shenzhen_phonesystem_ifios spi ON spi.PHA_qui = uf.PHA_qui
WHERE spi.date = 20230501
AND spi.phonesystem = "Android"
GROUP BY uf.age


-- 20231101
-- PHA
-- age
SELECT uf.age,
       AVG(t.PHA_num) AS avg_pha_age_Andorid_20231101
FROM shenzhen_20190501_users_filtered uf  -- 567101人 不用改table
JOIN (SELECT PHA_qui, PHA_num
      FROM shenzhen_PHAuse_20231101_all) t on t.PHA_qui = uf.PHA_qui -- PHA count 要改table
JOIN shenzhen_phonesystem_ifios spi ON spi.PHA_qui = uf.PHA_qui
WHERE spi.date = 20231101
AND spi.phonesystem = "Android"
GROUP BY uf.age


-- 20190501
-- All
-- age
SELECT uf.age,
       AVG(t.app_eachmonth_count) AS  avg_all_age_Andorid_20190501
FROM shenzhen_20190501_users_filtered uf  -- 567101人 不用改table
JOIN (SELECT PHA_qui, app_eachmonth_count
      FROM shenzhen_app_use_eachmonth_count_filtered
      WHERE date = 20190501) t ON t.PHA_qui = uf.PHA_qui -- All count 要改date
JOIN shenzhen_phonesystem_ifios spi ON spi.PHA_qui = uf.PHA_qui
WHERE spi.date = 20190501
AND spi.phonesystem = "Android"
GROUP BY uf.age

-- 20191101
-- All
-- age
SELECT uf.age,
       AVG(t.app_eachmonth_count) AS  avg_all_age_Andorid_20191101
FROM shenzhen_20190501_users_filtered uf  -- 567101人 不用改table
JOIN (SELECT PHA_qui, app_eachmonth_count
      FROM shenzhen_app_use_eachmonth_count_filtered
      WHERE date = 20191101) t ON t.PHA_qui = uf.PHA_qui -- All count 要改date
JOIN shenzhen_phonesystem_ifios spi ON spi.PHA_qui = uf.PHA_qui
WHERE spi.date = 20191101
AND spi.phonesystem = "Android"
GROUP BY uf.age


-- 20200501
-- All
-- age
SELECT uf.age,
       AVG(t.app_eachmonth_count) AS  avg_all_age_Andorid_20200501
FROM shenzhen_20190501_users_filtered uf  -- 567101人 不用改table
JOIN (SELECT PHA_qui, app_eachmonth_count
      FROM shenzhen_app_use_eachmonth_count_filtered
      WHERE date = 20200501) t ON t.PHA_qui = uf.PHA_qui -- All count 要改date
JOIN shenzhen_phonesystem_ifios spi ON spi.PHA_qui = uf.PHA_qui
WHERE spi.date = 20200501
AND spi.phonesystem = "Android"
GROUP BY uf.age

-- 20201101
-- All
-- age
SELECT uf.age,
       AVG(t.app_eachmonth_count) AS  avg_all_age_Andorid_20201101
FROM shenzhen_20190501_users_filtered uf  -- 567101人 不用改table
JOIN (SELECT PHA_qui, app_eachmonth_count
      FROM shenzhen_app_use_eachmonth_count_filtered
      WHERE date = 20201101) t ON t.PHA_qui = uf.PHA_qui -- All count 要改date
JOIN shenzhen_phonesystem_ifios spi ON spi.PHA_qui = uf.PHA_qui
WHERE spi.date = 20201101
AND spi.phonesystem = "Android"
GROUP BY uf.age

-- 20210501
-- All
-- age
SELECT uf.age,
       AVG(t.app_eachmonth_count) AS  avg_all_age_Andorid_20210501
FROM shenzhen_20190501_users_filtered uf  -- 567101人 不用改table
JOIN (SELECT PHA_qui, app_eachmonth_count
      FROM shenzhen_app_use_eachmonth_count_filtered
      WHERE date = 20210501) t ON t.PHA_qui = uf.PHA_qui -- All count 要改date
JOIN shenzhen_phonesystem_ifios spi ON spi.PHA_qui = uf.PHA_qui
WHERE spi.date = 20210501
AND spi.phonesystem = "Android"
GROUP BY uf.age

-- 20211101
-- All
-- age
SELECT uf.age,
       AVG(t.app_eachmonth_count) AS  avg_all_age_Andorid_20211101
FROM shenzhen_20190501_users_filtered uf  -- 567101人 不用改table
JOIN (SELECT PHA_qui, app_eachmonth_count
      FROM shenzhen_app_use_eachmonth_count_filtered
      WHERE date = 20211101) t ON t.PHA_qui = uf.PHA_qui -- All count 要改date
JOIN shenzhen_phonesystem_ifios spi ON spi.PHA_qui = uf.PHA_qui
WHERE spi.date = 20211101
AND spi.phonesystem = "Android"
GROUP BY uf.age

-- 20220501
-- All
-- age
SELECT uf.age,
       AVG(t.app_eachmonth_count) AS  avg_all_age_Andorid_20220501
FROM shenzhen_20190501_users_filtered uf  -- 567101人 不用改table
JOIN (SELECT PHA_qui, app_eachmonth_count
      FROM shenzhen_app_use_eachmonth_count_filtered
      WHERE date = 20220501) t ON t.PHA_qui = uf.PHA_qui -- All count 要改date
JOIN shenzhen_phonesystem_ifios spi ON spi.PHA_qui = uf.PHA_qui
WHERE spi.date = 20220501
AND spi.phonesystem = "Android"
GROUP BY uf.age

-- 20221101
-- All
-- age
SELECT uf.age,
       AVG(t.app_eachmonth_count) AS  avg_all_age_Andorid_20221101
FROM shenzhen_20190501_users_filtered uf  -- 567101人 不用改table
JOIN (SELECT PHA_qui, app_eachmonth_count
      FROM shenzhen_app_use_eachmonth_count_filtered
      WHERE date = 20221101) t ON t.PHA_qui = uf.PHA_qui -- All count 要改date
JOIN shenzhen_phonesystem_ifios spi ON spi.PHA_qui = uf.PHA_qui
WHERE spi.date = 20221101
AND spi.phonesystem = "Android"
GROUP BY uf.age

-- 20230501
-- All
-- age
SELECT uf.age,
       AVG(t.app_eachmonth_count) AS  avg_all_age_Andorid_20230501
FROM shenzhen_20190501_users_filtered uf  -- 567101人 不用改table
JOIN (SELECT PHA_qui, app_eachmonth_count
      FROM shenzhen_app_use_eachmonth_count_filtered
      WHERE date = 20230501) t ON t.PHA_qui = uf.PHA_qui -- All count 要改date
JOIN shenzhen_phonesystem_ifios spi ON spi.PHA_qui = uf.PHA_qui
WHERE spi.date = 20230501
AND spi.phonesystem = "Android"
GROUP BY uf.age

-- 20231101
-- All
-- age
SELECT uf.age,
       AVG(t.app_eachmonth_count) AS  avg_all_age_Andorid_20231101
FROM shenzhen_20190501_users_filtered uf  -- 567101人 不用改table
JOIN (SELECT PHA_qui, app_eachmonth_count
      FROM shenzhen_app_use_eachmonth_count_filtered
      WHERE date = 20231101) t ON t.PHA_qui = uf.PHA_qui -- All count 要改date
JOIN shenzhen_phonesystem_ifios spi ON spi.PHA_qui = uf.PHA_qui
WHERE spi.date = 20231101
AND spi.phonesystem = "Android"
GROUP BY uf.age






-- Android

-- 20190501
-- PHA
-- gender

SELECT uf.gender,
       AVG(t.PHA_num) AS avg_pha_gender_Andorid_20190501
FROM shenzhen_20190501_users_filtered uf  -- 567101人
JOIN (SELECT PHA_qui, PHA_num
      FROM shenzhen_PHAuse_20190501_all) t on t.PHA_qui = uf.PHA_qui -- PHA count
JOIN shenzhen_phonesystem_ifios spi ON spi.PHA_qui = uf.PHA_qui
WHERE spi.date = 20190501
AND spi.phonesystem = "Android"
GROUP BY uf.gender

-- 20191101
-- PHA
-- gender
SELECT uf.gender,
       AVG(t.PHA_num) AS avg_pha_gender_Andorid_20191101
FROM shenzhen_20190501_users_filtered uf  -- 567101人 不用改table
JOIN (SELECT PHA_qui, PHA_num
      FROM shenzhen_PHAuse_20191101_all) t on t.PHA_qui = uf.PHA_qui -- PHA count 要改table
JOIN shenzhen_phonesystem_ifios spi ON spi.PHA_qui = uf.PHA_qui
WHERE spi.date = 20191101
AND spi.phonesystem = "Android"
GROUP BY uf.gender

-- 20200501
-- PHA
-- gender
SELECT uf.gender,
       AVG(t.PHA_num) AS avg_pha_gender_Andorid_20200501
FROM shenzhen_20190501_users_filtered uf  -- 567101人 不用改table
JOIN (SELECT PHA_qui, PHA_num
      FROM shenzhen_PHAuse_20200501_all) t on t.PHA_qui = uf.PHA_qui -- PHA count 要改table
JOIN shenzhen_phonesystem_ifios spi ON spi.PHA_qui = uf.PHA_qui
WHERE spi.date = 20200501
AND spi.phonesystem = "Android"
GROUP BY uf.gender


-- 20201101
-- PHA
-- gender
SELECT uf.gender,
       AVG(t.PHA_num) AS avg_pha_gender_Andorid_20201101
FROM shenzhen_20190501_users_filtered uf  -- 567101人 不用改table
JOIN (SELECT PHA_qui, PHA_num
      FROM shenzhen_PHAuse_20201101_all) t on t.PHA_qui = uf.PHA_qui -- PHA count 要改table
JOIN shenzhen_phonesystem_ifios spi ON spi.PHA_qui = uf.PHA_qui
WHERE spi.date = 20201101
AND spi.phonesystem = "Android"
GROUP BY uf.gender


-- 20210501
-- PHA
-- gender
SELECT uf.gender,
       AVG(t.PHA_num) AS avg_pha_gender_Andorid_20210501
FROM shenzhen_20190501_users_filtered uf  -- 567101人 不用改table
JOIN (SELECT PHA_qui, PHA_num
      FROM shenzhen_PHAuse_20210501_all) t on t.PHA_qui = uf.PHA_qui -- PHA count 要改table
JOIN shenzhen_phonesystem_ifios spi ON spi.PHA_qui = uf.PHA_qui
WHERE spi.date = 20210501
AND spi.phonesystem = "Android"
GROUP BY uf.gender


-- 20211101
-- PHA
-- gender
SELECT uf.gender,
       AVG(t.PHA_num) AS avg_pha_gender_Andorid_20211101
FROM shenzhen_20190501_users_filtered uf  -- 567101人 不用改table
JOIN (SELECT PHA_qui, PHA_num
      FROM shenzhen_PHAuse_20211101_all) t on t.PHA_qui = uf.PHA_qui -- PHA count 要改table
JOIN shenzhen_phonesystem_ifios spi ON spi.PHA_qui = uf.PHA_qui
WHERE spi.date = 20211101
AND spi.phonesystem = "Android"
GROUP BY uf.gender


-- 20220501
-- PHA
-- gender
SELECT uf.gender,
       AVG(t.PHA_num) AS avg_pha_gender_Andorid_20220501
FROM shenzhen_20190501_users_filtered uf  -- 567101人 不用改table
JOIN (SELECT PHA_qui, PHA_num
      FROM shenzhen_PHAuse_20220501_all) t on t.PHA_qui = uf.PHA_qui -- PHA count 要改table
JOIN shenzhen_phonesystem_ifios spi ON spi.PHA_qui = uf.PHA_qui
WHERE spi.date = 20220501
AND spi.phonesystem = "Android"
GROUP BY uf.gender


-- 20221101
-- PHA
-- gender
SELECT uf.gender,
       AVG(t.PHA_num) AS avg_pha_gender_Andorid_20221101
FROM shenzhen_20190501_users_filtered uf  -- 567101人 不用改table
JOIN (SELECT PHA_qui, PHA_num
      FROM shenzhen_PHAuse_20221101_all) t on t.PHA_qui = uf.PHA_qui -- PHA count 要改table
JOIN shenzhen_phonesystem_ifios spi ON spi.PHA_qui = uf.PHA_qui
WHERE spi.date = 20221101
AND spi.phonesystem = "Android"
GROUP BY uf.gender

-- 20230501
-- PHA
-- gender
SELECT uf.gender,
       AVG(t.PHA_num) AS avg_pha_gender_Andorid_20230501
FROM shenzhen_20190501_users_filtered uf  -- 567101人 不用改table
JOIN (SELECT PHA_qui, PHA_num
      FROM shenzhen_PHAuse_20230501_all) t on t.PHA_qui = uf.PHA_qui -- PHA count 要改table
JOIN shenzhen_phonesystem_ifios spi ON spi.PHA_qui = uf.PHA_qui
WHERE spi.date = 20230501
AND spi.phonesystem = "Android"
GROUP BY uf.gender


-- 20231101
-- PHA
-- gender
SELECT uf.gender,
       AVG(t.PHA_num) AS avg_pha_gender_Andorid_20231101
FROM shenzhen_20190501_users_filtered uf  -- 567101人 不用改table
JOIN (SELECT PHA_qui, PHA_num
      FROM shenzhen_PHAuse_20231101_all) t on t.PHA_qui = uf.PHA_qui -- PHA count 要改table
JOIN shenzhen_phonesystem_ifios spi ON spi.PHA_qui = uf.PHA_qui
WHERE spi.date = 20231101
AND spi.phonesystem = "Android"
GROUP BY uf.gender


-- 20190501
-- All
-- gender
SELECT uf.gender,
       AVG(t.app_eachmonth_count) AS  avg_all_gender_Andorid_20190501
FROM shenzhen_20190501_users_filtered uf  -- 567101人 不用改table
JOIN (SELECT PHA_qui, app_eachmonth_count
      FROM shenzhen_app_use_eachmonth_count_filtered
      WHERE date = 20190501) t ON t.PHA_qui = uf.PHA_qui -- All count 要改date
JOIN shenzhen_phonesystem_ifios spi ON spi.PHA_qui = uf.PHA_qui
WHERE spi.date = 20190501
AND spi.phonesystem = "Android"
GROUP BY uf.gender

-- 20191101
-- All
-- gender
SELECT uf.gender,
       AVG(t.app_eachmonth_count) AS  avg_all_gender_Andorid_20191101
FROM shenzhen_20190501_users_filtered uf  -- 567101人 不用改table
JOIN (SELECT PHA_qui, app_eachmonth_count
      FROM shenzhen_app_use_eachmonth_count_filtered
      WHERE date = 20191101) t ON t.PHA_qui = uf.PHA_qui -- All count 要改date
JOIN shenzhen_phonesystem_ifios spi ON spi.PHA_qui = uf.PHA_qui
WHERE spi.date = 20191101
AND spi.phonesystem = "Android"
GROUP BY uf.gender


-- 20200501
-- All
-- gender
SELECT uf.gender,
       AVG(t.app_eachmonth_count) AS  avg_all_gender_Andorid_20200501
FROM shenzhen_20190501_users_filtered uf  -- 567101人 不用改table
JOIN (SELECT PHA_qui, app_eachmonth_count
      FROM shenzhen_app_use_eachmonth_count_filtered
      WHERE date = 20200501) t ON t.PHA_qui = uf.PHA_qui -- All count 要改date
JOIN shenzhen_phonesystem_ifios spi ON spi.PHA_qui = uf.PHA_qui
WHERE spi.date = 20200501
AND spi.phonesystem = "Android"
GROUP BY uf.gender

-- 20201101
-- All
-- gender
SELECT uf.gender,
       AVG(t.app_eachmonth_count) AS  avg_all_gender_Andorid_20201101
FROM shenzhen_20190501_users_filtered uf  -- 567101人 不用改table
JOIN (SELECT PHA_qui, app_eachmonth_count
      FROM shenzhen_app_use_eachmonth_count_filtered
      WHERE date = 20201101) t ON t.PHA_qui = uf.PHA_qui -- All count 要改date
JOIN shenzhen_phonesystem_ifios spi ON spi.PHA_qui = uf.PHA_qui
WHERE spi.date = 20201101
AND spi.phonesystem = "Android"
GROUP BY uf.gender

-- 20210501
-- All
-- gender
SELECT uf.gender,
       AVG(t.app_eachmonth_count) AS  avg_all_gender_Andorid_20210501
FROM shenzhen_20190501_users_filtered uf  -- 567101人 不用改table
JOIN (SELECT PHA_qui, app_eachmonth_count
      FROM shenzhen_app_use_eachmonth_count_filtered
      WHERE date = 20210501) t ON t.PHA_qui = uf.PHA_qui -- All count 要改date
JOIN shenzhen_phonesystem_ifios spi ON spi.PHA_qui = uf.PHA_qui
WHERE spi.date = 20210501
AND spi.phonesystem = "Android"
GROUP BY uf.gender

-- 20211101
-- All
-- gender
SELECT uf.gender,
       AVG(t.app_eachmonth_count) AS  avg_all_gender_Andorid_20211101
FROM shenzhen_20190501_users_filtered uf  -- 567101人 不用改table
JOIN (SELECT PHA_qui, app_eachmonth_count
      FROM shenzhen_app_use_eachmonth_count_filtered
      WHERE date = 20211101) t ON t.PHA_qui = uf.PHA_qui -- All count 要改date
JOIN shenzhen_phonesystem_ifios spi ON spi.PHA_qui = uf.PHA_qui
WHERE spi.date = 20211101
AND spi.phonesystem = "Android"
GROUP BY uf.gender

-- 20220501
-- All
-- gender
SELECT uf.gender,
       AVG(t.app_eachmonth_count) AS  avg_all_gender_Andorid_20220501
FROM shenzhen_20190501_users_filtered uf  -- 567101人 不用改table
JOIN (SELECT PHA_qui, app_eachmonth_count
      FROM shenzhen_app_use_eachmonth_count_filtered
      WHERE date = 20220501) t ON t.PHA_qui = uf.PHA_qui -- All count 要改date
JOIN shenzhen_phonesystem_ifios spi ON spi.PHA_qui = uf.PHA_qui
WHERE spi.date = 20220501
AND spi.phonesystem = "Android"
GROUP BY uf.gender

-- 20221101
-- All
-- gender
SELECT uf.gender,
       AVG(t.app_eachmonth_count) AS  avg_all_gender_Andorid_20221101
FROM shenzhen_20190501_users_filtered uf  -- 567101人 不用改table
JOIN (SELECT PHA_qui, app_eachmonth_count
      FROM shenzhen_app_use_eachmonth_count_filtered
      WHERE date = 20221101) t ON t.PHA_qui = uf.PHA_qui -- All count 要改date
JOIN shenzhen_phonesystem_ifios spi ON spi.PHA_qui = uf.PHA_qui
WHERE spi.date = 20221101
AND spi.phonesystem = "Android"
GROUP BY uf.gender

-- 20230501
-- All
-- gender
SELECT uf.gender,
       AVG(t.app_eachmonth_count) AS  avg_all_gender_Andorid_20230501
FROM shenzhen_20190501_users_filtered uf  -- 567101人 不用改table
JOIN (SELECT PHA_qui, app_eachmonth_count
      FROM shenzhen_app_use_eachmonth_count_filtered
      WHERE date = 20230501) t ON t.PHA_qui = uf.PHA_qui -- All count 要改date
JOIN shenzhen_phonesystem_ifios spi ON spi.PHA_qui = uf.PHA_qui
WHERE spi.date = 20230501
AND spi.phonesystem = "Android"
GROUP BY uf.gender

-- 20231101
-- All
-- gender
SELECT uf.gender,
       AVG(t.app_eachmonth_count) AS  avg_all_gender_Andorid_20231101
FROM shenzhen_20190501_users_filtered uf  -- 567101人 不用改table
JOIN (SELECT PHA_qui, app_eachmonth_count
      FROM shenzhen_app_use_eachmonth_count_filtered
      WHERE date = 20231101) t ON t.PHA_qui = uf.PHA_qui -- All count 要改date
JOIN shenzhen_phonesystem_ifios spi ON spi.PHA_qui = uf.PHA_qui
WHERE spi.date = 20231101
AND spi.phonesystem = "Android"
GROUP BY uf.gender







-- Android

-- 20190501
-- PHA
-- income
SELECT phoneprice_level,
       AVG(t.PHA_num) AS avg_pha_income_Andorid_20190501
FROM shenzhen_20190501_users_filtered uf  -- 567101人
JOIN (SELECT PHA_qui, PHA_num
      FROM shenzhen_PHAuse_20190501_all) t on t.PHA_qui = uf.PHA_qui -- PHA count 要改table
JOIN shenzhen_people_phoneprice_10monthavg_level sppl ON sppl.PHA_qui = uf.PHA_qui -- income level 每个人只有一条记录
JOIN shenzhen_phonesystem_ifios spi ON spi.PHA_qui = uf.PHA_qui -- phone system
WHERE spi.date = 20190501
AND spi.phonesystem = "Android"
GROUP BY phoneprice_level

-- 20191101
-- PHA
-- income
SELECT phoneprice_level,
       AVG(t.PHA_num) AS avg_pha_income_Andorid_20191101
FROM shenzhen_20190501_users_filtered uf  -- 567101人
JOIN (SELECT PHA_qui, PHA_num
      FROM shenzhen_PHAuse_20191101_all) t on t.PHA_qui = uf.PHA_qui -- PHA count 要改table
JOIN shenzhen_people_phoneprice_10monthavg_level sppl ON sppl.PHA_qui = uf.PHA_qui -- income level 每个人只有一条记录
JOIN shenzhen_phonesystem_ifios spi ON spi.PHA_qui = uf.PHA_qui -- phone system
WHERE spi.date = 20191101
AND spi.phonesystem = "Android"
GROUP BY phoneprice_level

-- 20200501
-- PHA
-- income
SELECT phoneprice_level,
       AVG(t.PHA_num) AS avg_pha_income_Andorid_20200501
FROM shenzhen_20190501_users_filtered uf  -- 567101人
JOIN (SELECT PHA_qui, PHA_num
      FROM shenzhen_PHAuse_20200501_all) t on t.PHA_qui = uf.PHA_qui -- PHA count 要改table
JOIN shenzhen_people_phoneprice_10monthavg_level sppl ON sppl.PHA_qui = uf.PHA_qui -- income level 每个人只有一条记录
JOIN shenzhen_phonesystem_ifios spi ON spi.PHA_qui = uf.PHA_qui -- phone system
WHERE spi.date = 20200501
AND spi.phonesystem = "Android"
GROUP BY phoneprice_level

-- 20201101
-- PHA
-- income
SELECT phoneprice_level,
       AVG(t.PHA_num) AS avg_pha_income_Andorid_20201101
FROM shenzhen_20201101_users_filtered uf  -- 567101人
JOIN (SELECT PHA_qui, PHA_num
      FROM shenzhen_PHAuse_20201101_all) t on t.PHA_qui = uf.PHA_qui -- PHA count 要改table
JOIN shenzhen_people_phoneprice_10monthavg_level sppl ON sppl.PHA_qui = uf.PHA_qui -- income level 每个人只有一条记录
JOIN shenzhen_phonesystem_ifios spi ON spi.PHA_qui = uf.PHA_qui -- phone system
WHERE spi.date = 20201101
AND spi.phonesystem = "Android"
GROUP BY phoneprice_level

-- 20210501
-- PHA
-- income
SELECT phoneprice_level,
       AVG(t.PHA_num) AS avg_pha_income_Andorid_20210501
FROM shenzhen_20190501_users_filtered uf  -- 567101人
JOIN (SELECT PHA_qui, PHA_num
      FROM shenzhen_PHAuse_20210501_all) t on t.PHA_qui = uf.PHA_qui -- PHA count 要改table
JOIN shenzhen_people_phoneprice_10monthavg_level sppl ON sppl.PHA_qui = uf.PHA_qui -- income level 每个人只有一条记录
JOIN shenzhen_phonesystem_ifios spi ON spi.PHA_qui = uf.PHA_qui -- phone system
WHERE spi.date = 20210501
AND spi.phonesystem = "Android"
GROUP BY phoneprice_level

-- 20211101
-- PHA
-- income
SELECT phoneprice_level,
       AVG(t.PHA_num) AS avg_pha_income_Andorid_20211101
FROM shenzhen_20201101_users_filtered uf  -- 567101人
JOIN (SELECT PHA_qui, PHA_num
      FROM shenzhen_PHAuse_20211101_all) t on t.PHA_qui = uf.PHA_qui -- PHA count 要改table
JOIN shenzhen_people_phoneprice_10monthavg_level sppl ON sppl.PHA_qui = uf.PHA_qui -- income level 每个人只有一条记录
JOIN shenzhen_phonesystem_ifios spi ON spi.PHA_qui = uf.PHA_qui -- phone system
WHERE spi.date = 20211101
AND spi.phonesystem = "Android"
GROUP BY phoneprice_level


-- 20220501
-- PHA
-- income
SELECT phoneprice_level,
       AVG(t.PHA_num) AS avg_pha_income_Andorid_20220501
FROM shenzhen_20190501_users_filtered uf  -- 567101人
JOIN (SELECT PHA_qui, PHA_num
      FROM shenzhen_PHAuse_20220501_all) t on t.PHA_qui = uf.PHA_qui -- PHA count 要改table
JOIN shenzhen_people_phoneprice_10monthavg_level sppl ON sppl.PHA_qui = uf.PHA_qui -- income level 每个人只有一条记录
JOIN shenzhen_phonesystem_ifios spi ON spi.PHA_qui = uf.PHA_qui -- phone system
WHERE spi.date = 20220501
AND spi.phonesystem = "Android"
GROUP BY phoneprice_level

-- 20221101
-- PHA
-- income
SELECT phoneprice_level,
       AVG(t.PHA_num) AS avg_pha_income_Andorid_20221101
FROM shenzhen_20201101_users_filtered uf  -- 567101人
JOIN (SELECT PHA_qui, PHA_num
      FROM shenzhen_PHAuse_20221101_all) t on t.PHA_qui = uf.PHA_qui -- PHA count 要改table
JOIN shenzhen_people_phoneprice_10monthavg_level sppl ON sppl.PHA_qui = uf.PHA_qui -- income level 每个人只有一条记录
JOIN shenzhen_phonesystem_ifios spi ON spi.PHA_qui = uf.PHA_qui -- phone system
WHERE spi.date = 20221101
AND spi.phonesystem = "Android"
GROUP BY phoneprice_level

-- 20230501
-- PHA
-- income
SELECT phoneprice_level,
       AVG(t.PHA_num) AS avg_pha_income_Andorid_20230501
FROM shenzhen_20190501_users_filtered uf  -- 567101人
JOIN (SELECT PHA_qui, PHA_num
      FROM shenzhen_PHAuse_20230501_all) t on t.PHA_qui = uf.PHA_qui -- PHA count 要改table
JOIN shenzhen_people_phoneprice_10monthavg_level sppl ON sppl.PHA_qui = uf.PHA_qui -- income level 每个人只有一条记录
JOIN shenzhen_phonesystem_ifios spi ON spi.PHA_qui = uf.PHA_qui -- phone system
WHERE spi.date = 20230501
AND spi.phonesystem = "Android"
GROUP BY phoneprice_level

-- 20231101
-- PHA
-- income
SELECT phoneprice_level,
       AVG(t.PHA_num) AS avg_pha_income_Andorid_20231101
FROM shenzhen_20201101_users_filtered uf  -- 567101人
JOIN (SELECT PHA_qui, PHA_num
      FROM shenzhen_PHAuse_20231101_all) t on t.PHA_qui = uf.PHA_qui -- PHA count 要改table
JOIN shenzhen_people_phoneprice_10monthavg_level sppl ON sppl.PHA_qui = uf.PHA_qui -- income level 每个人只有一条记录
JOIN shenzhen_phonesystem_ifios spi ON spi.PHA_qui = uf.PHA_qui -- phone system
WHERE spi.date = 20231101
AND spi.phonesystem = "Android"
GROUP BY phoneprice_level





-- 20190501
-- ALL
-- income
SELECT phoneprice_level,
       AVG(t.app_eachmonth_count) AS  avg_all_income_Andorid_20190501
FROM shenzhen_20190501_users_filtered uf  -- 567101人 不用改table
JOIN (SELECT PHA_qui, app_eachmonth_count
      FROM shenzhen_app_use_eachmonth_count_filtered
      WHERE date = 20190501) t ON t.PHA_qui = uf.PHA_qui -- All count 要改date
JOIN shenzhen_people_phoneprice_10monthavg_level sppl ON sppl.PHA_qui = uf.PHA_qui -- income level 每个人只有一条记录
JOIN shenzhen_phonesystem_ifios spi ON spi.PHA_qui = uf.PHA_qui -- phone system
WHERE spi.date = 20190501
AND spi.phonesystem = "Android"
GROUP BY phoneprice_level

-- 20191101
-- ALL
-- income
SELECT phoneprice_level,
       AVG(t.app_eachmonth_count) AS  avg_all_income_Andorid_20191101
FROM shenzhen_20190501_users_filtered uf  -- 567101人 不用改table
JOIN (SELECT PHA_qui, app_eachmonth_count
      FROM shenzhen_app_use_eachmonth_count_filtered
      WHERE date = 20191101) t ON t.PHA_qui = uf.PHA_qui -- All count 要改date
JOIN shenzhen_people_phoneprice_10monthavg_level sppl ON sppl.PHA_qui = uf.PHA_qui -- income level 每个人只有一条记录
JOIN shenzhen_phonesystem_ifios spi ON spi.PHA_qui = uf.PHA_qui -- phone system
WHERE spi.date = 20191101
AND spi.phonesystem = "Android"
GROUP BY phoneprice_level


-- 20200501
-- ALL
-- income
SELECT phoneprice_level,
       AVG(t.app_eachmonth_count) AS  avg_all_income_Andorid_20200501
FROM shenzhen_20190501_users_filtered uf  -- 567101人 不用改table
JOIN (SELECT PHA_qui, app_eachmonth_count
      FROM shenzhen_app_use_eachmonth_count_filtered
      WHERE date = 20200501) t ON t.PHA_qui = uf.PHA_qui -- All count 要改date
JOIN shenzhen_people_phoneprice_10monthavg_level sppl ON sppl.PHA_qui = uf.PHA_qui -- income level 每个人只有一条记录
JOIN shenzhen_phonesystem_ifios spi ON spi.PHA_qui = uf.PHA_qui -- phone system
WHERE spi.date = 20200501
AND spi.phonesystem = "Android"
GROUP BY phoneprice_level

-- 20201101
-- ALL
-- income
SELECT phoneprice_level,
       AVG(t.app_eachmonth_count) AS  avg_all_income_Andorid_20201101
FROM shenzhen_20190501_users_filtered uf  -- 567101人 不用改table
JOIN (SELECT PHA_qui, app_eachmonth_count
      FROM shenzhen_app_use_eachmonth_count_filtered
      WHERE date = 20201101) t ON t.PHA_qui = uf.PHA_qui -- All count 要改date
JOIN shenzhen_people_phoneprice_10monthavg_level sppl ON sppl.PHA_qui = uf.PHA_qui -- income level 每个人只有一条记录
JOIN shenzhen_phonesystem_ifios spi ON spi.PHA_qui = uf.PHA_qui -- phone system
WHERE spi.date = 20201101
AND spi.phonesystem = "Android"
GROUP BY phoneprice_level

-- 20210501
-- ALL
-- income
SELECT phoneprice_level,
       AVG(t.app_eachmonth_count) AS  avg_all_income_Andorid_20210501
FROM shenzhen_20190501_users_filtered uf  -- 567101人 不用改table
JOIN (SELECT PHA_qui, app_eachmonth_count
      FROM shenzhen_app_use_eachmonth_count_filtered
      WHERE date = 20210501) t ON t.PHA_qui = uf.PHA_qui -- All count 要改date
JOIN shenzhen_people_phoneprice_10monthavg_level sppl ON sppl.PHA_qui = uf.PHA_qui -- income level 每个人只有一条记录
JOIN shenzhen_phonesystem_ifios spi ON spi.PHA_qui = uf.PHA_qui -- phone system
WHERE spi.date = 20210501
AND spi.phonesystem = "Android"
GROUP BY phoneprice_level

-- 20211101
-- ALL
-- income
SELECT phoneprice_level,
       AVG(t.app_eachmonth_count) AS  avg_all_income_Andorid_20211101
FROM shenzhen_20190501_users_filtered uf  -- 567101人 不用改table
JOIN (SELECT PHA_qui, app_eachmonth_count
      FROM shenzhen_app_use_eachmonth_count_filtered
      WHERE date = 20211101) t ON t.PHA_qui = uf.PHA_qui -- All count 要改date
JOIN shenzhen_people_phoneprice_10monthavg_level sppl ON sppl.PHA_qui = uf.PHA_qui -- income level 每个人只有一条记录
JOIN shenzhen_phonesystem_ifios spi ON spi.PHA_qui = uf.PHA_qui -- phone system
WHERE spi.date = 20211101
AND spi.phonesystem = "Android"
GROUP BY phoneprice_level

-- 20220501
-- ALL
-- income
SELECT phoneprice_level,
       AVG(t.app_eachmonth_count) AS  avg_all_income_Andorid_20220501
FROM shenzhen_20190501_users_filtered uf  -- 567101人 不用改table
JOIN (SELECT PHA_qui, app_eachmonth_count
      FROM shenzhen_app_use_eachmonth_count_filtered
      WHERE date = 20220501) t ON t.PHA_qui = uf.PHA_qui -- All count 要改date
JOIN shenzhen_people_phoneprice_10monthavg_level sppl ON sppl.PHA_qui = uf.PHA_qui -- income level 每个人只有一条记录
JOIN shenzhen_phonesystem_ifios spi ON spi.PHA_qui = uf.PHA_qui -- phone system
WHERE spi.date = 20220501
AND spi.phonesystem = "Android"
GROUP BY phoneprice_level

-- 20221101
-- ALL
-- income
SELECT phoneprice_level,
       AVG(t.app_eachmonth_count) AS  avg_all_income_Andorid_20221101
FROM shenzhen_20190501_users_filtered uf  -- 567101人 不用改table
JOIN (SELECT PHA_qui, app_eachmonth_count
      FROM shenzhen_app_use_eachmonth_count_filtered
      WHERE date = 20221101) t ON t.PHA_qui = uf.PHA_qui -- All count 要改date
JOIN shenzhen_people_phoneprice_10monthavg_level sppl ON sppl.PHA_qui = uf.PHA_qui -- income level 每个人只有一条记录
JOIN shenzhen_phonesystem_ifios spi ON spi.PHA_qui = uf.PHA_qui -- phone system
WHERE spi.date = 20221101
AND spi.phonesystem = "Android"
GROUP BY phoneprice_level


-- 20230501
-- ALL
-- income
SELECT phoneprice_level,
       AVG(t.app_eachmonth_count) AS  avg_all_income_Andorid_20230501
FROM shenzhen_20190501_users_filtered uf  -- 567101人 不用改table
JOIN (SELECT PHA_qui, app_eachmonth_count
      FROM shenzhen_app_use_eachmonth_count_filtered
      WHERE date = 20230501) t ON t.PHA_qui = uf.PHA_qui -- All count 要改date
JOIN shenzhen_people_phoneprice_10monthavg_level sppl ON sppl.PHA_qui = uf.PHA_qui -- income level 每个人只有一条记录
JOIN shenzhen_phonesystem_ifios spi ON spi.PHA_qui = uf.PHA_qui -- phone system
WHERE spi.date = 20230501
AND spi.phonesystem = "Android"
GROUP BY phoneprice_level

-- 20231101
-- ALL
-- income
SELECT phoneprice_level,
       AVG(t.app_eachmonth_count) AS  avg_all_income_Andorid_20231101
FROM shenzhen_20190501_users_filtered uf  -- 567101人 不用改table
JOIN (SELECT PHA_qui, app_eachmonth_count
      FROM shenzhen_app_use_eachmonth_count_filtered
      WHERE date = 20231101) t ON t.PHA_qui = uf.PHA_qui -- All count 要改date
JOIN shenzhen_people_phoneprice_10monthavg_level sppl ON sppl.PHA_qui = uf.PHA_qui -- income level 每个人只有一条记录
JOIN shenzhen_phonesystem_ifios spi ON spi.PHA_qui = uf.PHA_qui -- phone system
WHERE spi.date = 20231101
AND spi.phonesystem = "Android"
GROUP BY phoneprice_level


