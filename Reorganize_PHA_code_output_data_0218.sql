-- population
SELECT COUNT(*) AS num
FROM shenzhen_app_use_filtered
-- 538434



-- Demographics

-- gender
SELECT gender,
       COUNT(*) as num20190501
FROM shenzhen_20190501_users_filtered
GROUP BY gender

-- gender
SELECT gender,
       COUNT(*) as num20191101
FROM shenzhen_20191101_users_filtered
GROUP BY gender

-- gender
SELECT gender,
       COUNT(*) as num20200501
FROM shenzhen_20200501_users_filtered
GROUP BY gender

-- gender
SELECT gender,
       COUNT(*) as num20201101
FROM shenzhen_20201101_users_filtered
GROUP BY gender

-- gender
SELECT gender,
       COUNT(*) as num20210501
FROM shenzhen_20210501_users_filtered
GROUP BY gender

-- gender
SELECT gender,
       COUNT(*) as num20211101
FROM shenzhen_20211101_users_filtered
GROUP BY gender

-- gender
SELECT gender,
       COUNT(*) as num20220501
FROM shenzhen_20220501_users_filtered
GROUP BY gender

-- gender
SELECT gender,
       COUNT(*) as num20221101
FROM shenzhen_20221101_users_filtered
GROUP BY gender

-- gender
SELECT gender,
       COUNT(*) as num20230501
FROM shenzhen_20230501_users_filtered
GROUP BY gender

-- gender
SELECT gender,
       COUNT(*) as num20231101
FROM shenzhen_20231101_users_filtered
GROUP BY gender




-- age
SELECT age,
       COUNT(*) as num20190501
FROM shenzhen_20190501_users_filtered
GROUP BY age

-- age
SELECT age,
       COUNT(*) as num20191101
FROM shenzhen_20191101_users_filtered
GROUP BY age

-- age
SELECT age,
       COUNT(*) as num20200501
FROM shenzhen_20200501_users_filtered
GROUP BY age

-- age
SELECT age,
       COUNT(*) as num20201101
FROM shenzhen_20201101_users_filtered
GROUP BY age

-- age
SELECT age,
       COUNT(*) as num20210501
FROM shenzhen_20210501_users_filtered
GROUP BY age

-- age
SELECT age,
       COUNT(*) as num20211101
FROM shenzhen_20211101_users_filtered
GROUP BY age

-- age
SELECT age,
       COUNT(*) as num20220501
FROM shenzhen_20220501_users_filtered
GROUP BY age

-- age
SELECT age,
       COUNT(*) as num20221101
FROM shenzhen_20221101_users_filtered
GROUP BY age

-- age
SELECT age,
       COUNT(*) as num20230501
FROM shenzhen_20230501_users_filtered
GROUP BY age


-- age
SELECT age,
       COUNT(*) as num20231101
FROM shenzhen_20231101_users_filtered
GROUP BY age



-- phone
SELECT brand,
       type,
       COUNT(*) as num20190501
FROM shenzhen_20190501_users_filtered
GROUP BY brand, type

-- phone
SELECT brand,
       type,
       COUNT(*) as num20191101
FROM shenzhen_20191101_users_filtered
GROUP BY brand, type

-- phone
SELECT brand,
       type,
       COUNT(*) as num20200501
FROM shenzhen_20200501_users_filtered
GROUP BY brand, type

-- phone
SELECT brand,
       type,
       COUNT(*) as num20201101
FROM shenzhen_20201101_users_filtered
GROUP BY brand, type

-- phone
SELECT brand,
       type,
       COUNT(*) as num20210501
FROM shenzhen_20210501_users_filtered
GROUP BY brand, type

-- phone
SELECT brand,
       type,
       COUNT(*) as num20211101
FROM shenzhen_20211101_users_filtered
GROUP BY brand, type

-- phone
SELECT brand,
       type,
       COUNT(*) as num20220501
FROM shenzhen_20220501_users_filtered
GROUP BY brand, type

-- phone
SELECT brand,
       type,
       COUNT(*) as num20221101
FROM shenzhen_20221101_users_filtered
GROUP BY brand, type

-- phone
SELECT brand,
       type,
       COUNT(*) as num20230501
FROM shenzhen_20230501_users_filtered
GROUP BY brand, type

-- phone
SELECT brand,
       type,
       COUNT(*) as num20231101
FROM shenzhen_20231101_users_filtered
GROUP BY brand, type



-- 各时间点App list及使用人数（看不出使用次数） F2a
SELECT date, lcode, num
FROM shenzhen_app_list



-- distribution of number of app used each time point F1a
-- 可以计算平均值
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





-- demographic & avg app used F3 1A 1B 2A 2B

-- user一直是同一群人，只是不同时间点demographic不同

-- 20190501 JOIN demographics
-- 每个age group的平均count
SELECT uf.age,
       AVG(t.app_eachmonth_count) AS avg_age20190501
FROM shenzhen_20190501_users_filtered uf
JOIN (SELECT PHA_qui, app_eachmonth_count
      FROM shenzhen_app_use_eachmonth_count_filtered
      WHERE date = 20190501) t ON t.PHA_qui = uf.PHA_qui
GROUP BY age

-- 每个gender group的平均count
SELECT uf.gender,
       AVG(t.app_eachmonth_count) AS avg_gender20190501
FROM shenzhen_20190501_users_filtered uf
JOIN (SELECT PHA_qui, app_eachmonth_count
      FROM shenzhen_app_use_eachmonth_count_filtered
      WHERE date = 20190501) t ON t.PHA_qui = uf.PHA_qui
GROUP BY gender


-- 20190501 JOIN demographics
-- 每个price level group的平均count
SELECT sppl.phoneprice_level,
       AVG(t.app_eachmonth_count) AS avg_pricelevel20190501
FROM shenzhen_20190501_users_filtered uf
JOIN shenzhen_people_phoneprice_10monthavg_level sppl ON sppl.PHA_qui = uf.PHA_qui
JOIN (SELECT PHA_qui, app_eachmonth_count
      FROM shenzhen_app_use_eachmonth_count_filtered
      WHERE date = 20190501) t ON t.PHA_qui = uf.PHA_qui
GROUP BY phoneprice_level


-- 20191101
SELECT uf.age,
       AVG(t.app_eachmonth_count) AS avg_age20191101
FROM shenzhen_20191101_users_filtered uf
JOIN (SELECT PHA_qui, app_eachmonth_count
      FROM shenzhen_app_use_eachmonth_count_filtered
      WHERE date = 20191101) t ON t.PHA_qui = uf.PHA_qui
GROUP BY age

SELECT uf.gender,
       AVG(t.app_eachmonth_count) AS avg_gender20191101
FROM shenzhen_20191101_users_filtered uf
JOIN (SELECT PHA_qui, app_eachmonth_count
      FROM shenzhen_app_use_eachmonth_count_filtered
      WHERE date = 20191101) t ON t.PHA_qui = uf.PHA_qui
GROUP BY gender

SELECT sppl.phoneprice_level,
       AVG(t.app_eachmonth_count) AS avg_pricelevel20191101
FROM shenzhen_20191101_users_filtered uf
JOIN shenzhen_people_phoneprice_10monthavg_level sppl ON sppl.PHA_qui = uf.PHA_qui
JOIN (SELECT PHA_qui, app_eachmonth_count
      FROM shenzhen_app_use_eachmonth_count_filtered
      WHERE date = 20191101) t ON t.PHA_qui = uf.PHA_qui
GROUP BY phoneprice_level
      

-- 20200501
SELECT uf.age,
       AVG(t.app_eachmonth_count) AS avg_age20200501
FROM shenzhen_20200501_users_filtered uf
JOIN (SELECT PHA_qui, app_eachmonth_count
      FROM shenzhen_app_use_eachmonth_count_filtered
      WHERE date = 20200501) t ON t.PHA_qui = uf.PHA_qui
GROUP BY age

SELECT uf.gender,
       AVG(t.app_eachmonth_count) AS avg_gender20200501
FROM shenzhen_20200501_users_filtered uf
JOIN (SELECT PHA_qui, app_eachmonth_count
      FROM shenzhen_app_use_eachmonth_count_filtered
      WHERE date = 20200501) t ON t.PHA_qui = uf.PHA_qui
GROUP BY gender
      
SELECT sppl.phoneprice_level,
       AVG(t.app_eachmonth_count) AS avg_pricelevel20200501
FROM shenzhen_20200501_users_filtered uf
JOIN shenzhen_people_phoneprice_10monthavg_level sppl ON sppl.PHA_qui = uf.PHA_qui
JOIN (SELECT PHA_qui, app_eachmonth_count
      FROM shenzhen_app_use_eachmonth_count_filtered
      WHERE date = 20200501) t ON t.PHA_qui = uf.PHA_qui
GROUP BY phoneprice_level
      

-- 20201101
SELECT uf.age,
       AVG(t.app_eachmonth_count) AS avg_age20201101
FROM shenzhen_20201101_users_filtered uf
JOIN (SELECT PHA_qui, app_eachmonth_count
      FROM shenzhen_app_use_eachmonth_count_filtered
      WHERE date = 20201101) t ON t.PHA_qui = uf.PHA_qui
GROUP BY age

SELECT uf.gender,
       AVG(t.app_eachmonth_count) AS avg_gender20201101
FROM shenzhen_20201101_users_filtered uf
JOIN (SELECT PHA_qui, app_eachmonth_count
      FROM shenzhen_app_use_eachmonth_count_filtered
      WHERE date = 20201101) t ON t.PHA_qui = uf.PHA_qui
GROUP BY gender

SELECT sppl.phoneprice_level,
       AVG(t.app_eachmonth_count) AS avg_pricelevel20201101
FROM shenzhen_20201101_users_filtered uf
JOIN shenzhen_people_phoneprice_10monthavg_level sppl ON sppl.PHA_qui = uf.PHA_qui
JOIN (SELECT PHA_qui, app_eachmonth_count
      FROM shenzhen_app_use_eachmonth_count_filtered
      WHERE date = 20201101) t ON t.PHA_qui = uf.PHA_qui
GROUP BY phoneprice_level
        


-- 20210501
SELECT uf.age,
       AVG(t.app_eachmonth_count) AS avg_age20210501
FROM shenzhen_20210501_users_filtered uf
JOIN (SELECT PHA_qui, app_eachmonth_count
      FROM shenzhen_app_use_eachmonth_count_filtered
      WHERE date = 20210501) t ON t.PHA_qui = uf.PHA_qui
GROUP BY age

SELECT uf.gender,
       AVG(t.app_eachmonth_count) AS avg_gender20210501
FROM shenzhen_20210501_users_filtered uf
JOIN (SELECT PHA_qui, app_eachmonth_count
      FROM shenzhen_app_use_eachmonth_count_filtered
      WHERE date = 20210501) t ON t.PHA_qui = uf.PHA_qui
GROUP BY gender

SELECT sppl.phoneprice_level,
       AVG(t.app_eachmonth_count) AS avg_pricelevel20210501
FROM shenzhen_20210501_users_filtered uf
JOIN shenzhen_people_phoneprice_10monthavg_level sppl ON sppl.PHA_qui = uf.PHA_qui
JOIN (SELECT PHA_qui, app_eachmonth_count
      FROM shenzhen_app_use_eachmonth_count_filtered
      WHERE date = 20210501) t ON t.PHA_qui = uf.PHA_qui
GROUP BY phoneprice_level


-- 20211101
SELECT uf.age,
       AVG(t.app_eachmonth_count) AS avg_age20211101
FROM shenzhen_20211101_users_filtered uf
JOIN (SELECT PHA_qui, app_eachmonth_count
      FROM shenzhen_app_use_eachmonth_count_filtered
      WHERE date = 20211101) t ON t.PHA_qui = uf.PHA_qui
GROUP BY age

SELECT uf.gender,
       AVG(t.app_eachmonth_count) AS avg_gender20211101
FROM shenzhen_20211101_users_filtered uf
JOIN (SELECT PHA_qui, app_eachmonth_count
      FROM shenzhen_app_use_eachmonth_count_filtered
      WHERE date = 20211101) t ON t.PHA_qui = uf.PHA_qui
GROUP BY gender
      
SELECT sppl.phoneprice_level,
       AVG(t.app_eachmonth_count) AS avg_pricelevel20211101
FROM shenzhen_20211101_users_filtered uf
JOIN shenzhen_people_phoneprice_10monthavg_level sppl ON sppl.PHA_qui = uf.PHA_qui
JOIN (SELECT PHA_qui, app_eachmonth_count
      FROM shenzhen_app_use_eachmonth_count_filtered
      WHERE date = 20211101) t ON t.PHA_qui = uf.PHA_qui
GROUP BY phoneprice_level

      

-- 20220501
SELECT uf.age,
       AVG(t.app_eachmonth_count) AS avg_age20220501
FROM shenzhen_20220501_users_filtered uf
JOIN (SELECT PHA_qui, app_eachmonth_count
      FROM shenzhen_app_use_eachmonth_count_filtered
      WHERE date = 20220501) t ON t.PHA_qui = uf.PHA_qui
GROUP BY age

SELECT uf.gender,
       AVG(t.app_eachmonth_count) AS avg_gender20220501
FROM shenzhen_20220501_users_filtered uf
JOIN (SELECT PHA_qui, app_eachmonth_count
      FROM shenzhen_app_use_eachmonth_count_filtered
      WHERE date = 20220501) t ON t.PHA_qui = uf.PHA_qui
GROUP BY gender

SELECT sppl.phoneprice_level,
       AVG(t.app_eachmonth_count) AS avg_pricelevel20220501
FROM shenzhen_20220501_users_filtered uf
JOIN shenzhen_people_phoneprice_10monthavg_level sppl ON sppl.PHA_qui = uf.PHA_qui
JOIN (SELECT PHA_qui, app_eachmonth_count
      FROM shenzhen_app_use_eachmonth_count_filtered
      WHERE date = 20220501) t ON t.PHA_qui = uf.PHA_qui
GROUP BY phoneprice_level




-- 20221101
SELECT uf.age,
       AVG(t.app_eachmonth_count) AS avg_age20221101
FROM shenzhen_20221101_users_filtered uf
JOIN (SELECT PHA_qui, app_eachmonth_count
      FROM shenzhen_app_use_eachmonth_count_filtered
      WHERE date = 20221101) t ON t.PHA_qui = uf.PHA_qui
GROUP BY age

SELECT uf.gender,
       AVG(t.app_eachmonth_count) AS avg_gender20221101
FROM shenzhen_20221101_users_filtered uf
JOIN (SELECT PHA_qui, app_eachmonth_count
      FROM shenzhen_app_use_eachmonth_count_filtered
      WHERE date = 20221101) t ON t.PHA_qui = uf.PHA_qui
GROUP BY gender
      
SELECT sppl.phoneprice_level,
       AVG(t.app_eachmonth_count) AS avg_pricelevel20221101
FROM shenzhen_20221101_users_filtered uf
JOIN shenzhen_people_phoneprice_10monthavg_level sppl ON sppl.PHA_qui = uf.PHA_qui
JOIN (SELECT PHA_qui, app_eachmonth_count
      FROM shenzhen_app_use_eachmonth_count_filtered
      WHERE date = 20221101) t ON t.PHA_qui = uf.PHA_qui
GROUP BY phoneprice_level



-- 20230501
SELECT uf.age,
       AVG(t.app_eachmonth_count) AS avg_age20230501
FROM shenzhen_20230501_users_filtered uf
JOIN (SELECT PHA_qui, app_eachmonth_count
      FROM shenzhen_app_use_eachmonth_count_filtered
      WHERE date = 20230501) t ON t.PHA_qui = uf.PHA_qui
GROUP BY age

SELECT uf.gender,
       AVG(t.app_eachmonth_count) AS avg_gender20230501
FROM shenzhen_20230501_users_filtered uf
JOIN (SELECT PHA_qui, app_eachmonth_count
      FROM shenzhen_app_use_eachmonth_count_filtered
      WHERE date = 20230501) t ON t.PHA_qui = uf.PHA_qui
GROUP BY gender
      

SELECT sppl.phoneprice_level,
       AVG(t.app_eachmonth_count) AS avg_pricelevel20230501
FROM shenzhen_20230501_users_filtered uf
JOIN shenzhen_people_phoneprice_10monthavg_level sppl ON sppl.PHA_qui = uf.PHA_qui
JOIN (SELECT PHA_qui, app_eachmonth_count
      FROM shenzhen_app_use_eachmonth_count_filtered
      WHERE date = 20230501) t ON t.PHA_qui = uf.PHA_qui
GROUP BY phoneprice_level



-- 20231101
SELECT uf.age,
       AVG(t.app_eachmonth_count) AS avg_age20231101
FROM shenzhen_20231101_users_filtered uf
JOIN (SELECT PHA_qui, app_eachmonth_count
      FROM shenzhen_app_use_eachmonth_count_filtered
      WHERE date = 20231101) t ON t.PHA_qui = uf.PHA_qui
GROUP BY age

SELECT uf.gender,
       AVG(t.app_eachmonth_count) AS avg_gender20231101
FROM shenzhen_20231101_users_filtered uf
JOIN (SELECT PHA_qui, app_eachmonth_count
      FROM shenzhen_app_use_eachmonth_count_filtered
      WHERE date = 20231101) t ON t.PHA_qui = uf.PHA_qui
GROUP BY gender
      
SELECT sppl.phoneprice_level,
       AVG(t.app_eachmonth_count) AS avg_pricelevel20231101
FROM shenzhen_20231101_users_filtered uf
JOIN shenzhen_people_phoneprice_10monthavg_level sppl ON sppl.PHA_qui = uf.PHA_qui
JOIN (SELECT PHA_qui, app_eachmonth_count
      FROM shenzhen_app_use_eachmonth_count_filtered
      WHERE date = 20231101) t ON t.PHA_qui = uf.PHA_qui
GROUP BY phoneprice_level






-- distribution of number of PHA used at each time point F1b
-- 可以计算平均值
SELECT PHA_num,
       COUNT(*) AS num
FROM shenzhen_PHAuse_20190501_all
GROUP BY PHA_num

SELECT PHA_num,
       COUNT(*) AS num
FROM shenzhen_PHAuse_20191101_all
GROUP BY PHA_num

SELECT PHA_num,
       COUNT(*) AS num
FROM shenzhen_PHAuse_20200501_all
GROUP BY PHA_num

SELECT PHA_num,
       COUNT(*) AS num
FROM shenzhen_PHAuse_20201101_all
GROUP BY PHA_num

SELECT PHA_num,
       COUNT(*) AS num
FROM shenzhen_PHAuse_20210501_all
GROUP BY PHA_num

SELECT PHA_num,
       COUNT(*) AS num
FROM shenzhen_PHAuse_20211101_all
GROUP BY PHA_num

SELECT PHA_num,
       COUNT(*) AS num
FROM shenzhen_PHAuse_20220501_all
GROUP BY PHA_num

SELECT PHA_num,
       COUNT(*) AS num
FROM shenzhen_PHAuse_20221101_all
GROUP BY PHA_num

SELECT PHA_num,
       COUNT(*) AS num
FROM shenzhen_PHAuse_20230501_all
GROUP BY PHA_num

SELECT PHA_num,
       COUNT(*) AS num
FROM shenzhen_PHAuse_20231101_all
GROUP BY PHA_num





      
-- PHA use & demographic F3 1A 1B 2A 2B 3A 3B
      
-- 20190501
SELECT uf.age,
       AVG(t.PHA_num) AS avg_age
FROM shenzhen_20190501_users_filtered uf
JOIN (SELECT PHA_qui, PHA_num
      FROM shenzhen_PHAuse_20190501_all) t on t.PHA_qui = uf.PHA_qui
GROUP BY age

SELECT uf.gender,
       AVG(t.PHA_num) AS avg_gender
FROM shenzhen_20190501_users_filtered uf
JOIN (SELECT PHA_qui, PHA_num
      FROM shenzhen_PHAuse_20190501_all) t on t.PHA_qui = uf.PHA_qui
GROUP BY gender

SELECT sppl.phoneprice_level,
       AVG(t.PHA_num) AS avg_pricelevel
FROM shenzhen_20190501_users_filtered uf
JOIN shenzhen_people_phoneprice_10monthavg_level sppl ON sppl.PHA_qui = uf.PHA_qui
JOIN (SELECT PHA_qui, PHA_num
      FROM shenzhen_PHAuse_20190501_all) t on t.PHA_qui = uf.PHA_qui
GROUP BY phoneprice_level


-- 20191101
SELECT uf.age,
       AVG(t.PHA_num) AS avg_age
FROM shenzhen_20191101_users_filtered uf
JOIN (SELECT PHA_qui, PHA_num
      FROM shenzhen_PHAuse_20191101_all) t on t.PHA_qui = uf.PHA_qui
GROUP BY age

SELECT uf.gender,
       AVG(t.PHA_num) AS avg_gender
FROM shenzhen_20191101_users_filtered uf
JOIN (SELECT PHA_qui, PHA_num
      FROM shenzhen_PHAuse_20191101_all) t on t.PHA_qui = uf.PHA_qui
GROUP BY gender

SELECT sppl.phoneprice_level,
       AVG(t.PHA_num) AS avg_pricelevel
FROM shenzhen_20191101_users_filtered uf
JOIN shenzhen_people_phoneprice_10monthavg_level sppl ON sppl.PHA_qui = uf.PHA_qui
JOIN (SELECT PHA_qui, PHA_num
      FROM shenzhen_PHAuse_20191101_all) t on t.PHA_qui = uf.PHA_qui
GROUP BY phoneprice_level


-- 20200501
SELECT uf.age,
       AVG(t.PHA_num) AS avg_age
FROM shenzhen_20200501_users_filtered uf
JOIN (SELECT PHA_qui, PHA_num
      FROM shenzhen_PHAuse_20200501_all) t on t.PHA_qui = uf.PHA_qui
GROUP BY age

SELECT uf.gender,
       AVG(t.PHA_num) AS avg_gender
FROM shenzhen_20200501_users_filtered uf
JOIN (SELECT PHA_qui, PHA_num
      FROM shenzhen_PHAuse_20200501_all) t on t.PHA_qui = uf.PHA_qui
GROUP BY gender

SELECT sppl.phoneprice_level,
       AVG(t.PHA_num) AS avg_pricelevel
FROM shenzhen_20200501_users_filtered uf
JOIN shenzhen_people_phoneprice_10monthavg_level sppl ON sppl.PHA_qui = uf.PHA_qui
JOIN (SELECT PHA_qui, PHA_num
      FROM shenzhen_PHAuse_20200501_all) t on t.PHA_qui = uf.PHA_qui
GROUP BY phoneprice_level


-- 20201101
SELECT uf.age,
       AVG(t.PHA_num) AS avg_age
FROM shenzhen_20201101_users_filtered uf
JOIN (SELECT PHA_qui, PHA_num
      FROM shenzhen_PHAuse_20201101_all) t on t.PHA_qui = uf.PHA_qui
GROUP BY age

SELECT uf.gender,
       AVG(t.PHA_num) AS avg_gender
FROM shenzhen_20201101_users_filtered uf
JOIN (SELECT PHA_qui, PHA_num
      FROM shenzhen_PHAuse_20201101_all) t on t.PHA_qui = uf.PHA_qui
GROUP BY gender

SELECT sppl.phoneprice_level,
       AVG(t.PHA_num) AS avg_pricelevel
FROM shenzhen_20201101_users_filtered uf
JOIN shenzhen_people_phoneprice_10monthavg_level sppl ON sppl.PHA_qui = uf.PHA_qui
JOIN (SELECT PHA_qui, PHA_num
      FROM shenzhen_PHAuse_20201101_all) t on t.PHA_qui = uf.PHA_qui
GROUP BY phoneprice_level


-- 20210501
SELECT uf.age,
       AVG(t.PHA_num) AS avg_age
FROM shenzhen_20210501_users_filtered uf
JOIN (SELECT PHA_qui, PHA_num
      FROM shenzhen_PHAuse_20210501_all) t on t.PHA_qui = uf.PHA_qui
GROUP BY age

SELECT uf.gender,
       AVG(t.PHA_num) AS avg_gender
FROM shenzhen_20210501_users_filtered uf
JOIN (SELECT PHA_qui, PHA_num
      FROM shenzhen_PHAuse_20210501_all) t on t.PHA_qui = uf.PHA_qui
GROUP BY gender

SELECT sppl.phoneprice_level,
       AVG(t.PHA_num) AS avg_pricelevel
FROM shenzhen_20210501_users_filtered uf
JOIN shenzhen_people_phoneprice_10monthavg_level sppl ON sppl.PHA_qui = uf.PHA_qui
JOIN (SELECT PHA_qui, PHA_num
      FROM shenzhen_PHAuse_20210501_all) t on t.PHA_qui = uf.PHA_qui
GROUP BY phoneprice_level



-- 20211101
SELECT uf.age,
       AVG(t.PHA_num) AS avg_age
FROM shenzhen_20211101_users_filtered uf
JOIN (SELECT PHA_qui, PHA_num
      FROM shenzhen_PHAuse_20211101_all) t on t.PHA_qui = uf.PHA_qui
GROUP BY age

SELECT uf.gender,
       AVG(t.PHA_num) AS avg_gender
FROM shenzhen_20211101_users_filtered uf
JOIN (SELECT PHA_qui, PHA_num
      FROM shenzhen_PHAuse_20211101_all) t on t.PHA_qui = uf.PHA_qui
GROUP BY gender

SELECT sppl.phoneprice_level,
       AVG(t.PHA_num) AS avg_pricelevel
FROM shenzhen_20211101_users_filtered uf
JOIN shenzhen_people_phoneprice_10monthavg_level sppl ON sppl.PHA_qui = uf.PHA_qui
JOIN (SELECT PHA_qui, PHA_num
      FROM shenzhen_PHAuse_20211101_all) t on t.PHA_qui = uf.PHA_qui
GROUP BY phoneprice_level



-- 20220501
SELECT uf.age,
       AVG(t.PHA_num) AS avg_age
FROM shenzhen_20220501_users_filtered uf
JOIN (SELECT PHA_qui, PHA_num
      FROM shenzhen_PHAuse_20220501_all) t on t.PHA_qui = uf.PHA_qui
GROUP BY age

SELECT uf.gender,
       AVG(t.PHA_num) AS avg_gender
FROM shenzhen_20220501_users_filtered uf
JOIN (SELECT PHA_qui, PHA_num
      FROM shenzhen_PHAuse_20220501_all) t on t.PHA_qui = uf.PHA_qui
GROUP BY gender

SELECT sppl.phoneprice_level,
       AVG(t.PHA_num) AS avg_pricelevel
FROM shenzhen_20220501_users_filtered uf
JOIN shenzhen_people_phoneprice_10monthavg_level sppl ON sppl.PHA_qui = uf.PHA_qui
JOIN (SELECT PHA_qui, PHA_num
      FROM shenzhen_PHAuse_20220501_all) t on t.PHA_qui = uf.PHA_qui
GROUP BY phoneprice_level


-- 20221101
SELECT uf.age,
       AVG(t.PHA_num) AS avg_age
FROM shenzhen_20221101_users_filtered uf
JOIN (SELECT PHA_qui, PHA_num
      FROM shenzhen_PHAuse_20221101_all) t on t.PHA_qui = uf.PHA_qui
GROUP BY age

SELECT uf.gender,
       AVG(t.PHA_num) AS avg_gender
FROM shenzhen_20221101_users_filtered uf
JOIN (SELECT PHA_qui, PHA_num
      FROM shenzhen_PHAuse_20221101_all) t on t.PHA_qui = uf.PHA_qui
GROUP BY gender

SELECT sppl.phoneprice_level,
       AVG(t.PHA_num) AS avg_pricelevel
FROM shenzhen_20221101_users_filtered uf
JOIN shenzhen_people_phoneprice_10monthavg_level sppl ON sppl.PHA_qui = uf.PHA_qui
JOIN (SELECT PHA_qui, PHA_num
      FROM shenzhen_PHAuse_20221101_all) t on t.PHA_qui = uf.PHA_qui
GROUP BY phoneprice_level


-- 20230501
SELECT uf.age,
       AVG(t.PHA_num) AS avg_age
FROM shenzhen_20230501_users_filtered uf
JOIN (SELECT PHA_qui, PHA_num
      FROM shenzhen_PHAuse_20230501_all) t on t.PHA_qui = uf.PHA_qui
GROUP BY age

SELECT uf.gender,
       AVG(t.PHA_num) AS avg_gender
FROM shenzhen_20230501_users_filtered uf
JOIN (SELECT PHA_qui, PHA_num
      FROM shenzhen_PHAuse_20230501_all) t on t.PHA_qui = uf.PHA_qui
GROUP BY gender

SELECT sppl.phoneprice_level,
       AVG(t.PHA_num) AS avg_pricelevel
FROM shenzhen_20230501_users_filtered uf
JOIN shenzhen_people_phoneprice_10monthavg_level sppl ON sppl.PHA_qui = uf.PHA_qui
JOIN (SELECT PHA_qui, PHA_num
      FROM shenzhen_PHAuse_20230501_all) t on t.PHA_qui = uf.PHA_qui
GROUP BY phoneprice_level



-- 20231101
SELECT uf.age,
       AVG(t.PHA_num) AS avg_age
FROM shenzhen_20231101_users_filtered uf
JOIN (SELECT PHA_qui, PHA_num
      FROM shenzhen_PHAuse_20231101_all) t on t.PHA_qui = uf.PHA_qui
GROUP BY age

SELECT uf.gender,
       AVG(t.PHA_num) AS avg_gender
FROM shenzhen_20231101_users_filtered uf
JOIN (SELECT PHA_qui, PHA_num
      FROM shenzhen_PHAuse_20231101_all) t on t.PHA_qui = uf.PHA_qui
GROUP BY gender

SELECT sppl.phoneprice_level,
       AVG(t.PHA_num) AS avg_pricelevel
FROM shenzhen_20231101_users_filtered uf
JOIN shenzhen_people_phoneprice_10monthavg_level sppl ON sppl.PHA_qui = uf.PHA_qui
JOIN (SELECT PHA_qui, PHA_num
      FROM shenzhen_PHAuse_20231101_all) t on t.PHA_qui = uf.PHA_qui
GROUP BY phoneprice_level





-- 导出active PHA list F2b
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








-- PHA diffusion demographic distribution F5


-- 20191101 PHA
-- 20191101PHA_20191101user_demographics
SELECT lcode, age, COUNT(*) as num
FROM 20191101PHA_20191101user_demographics
GROUP BY lcode, age


SELECT lcode, gender, COUNT(*) as num
FROM 20191101PHA_20191101user_demographics
GROUP BY lcode, gender

SELECT lcode, phoneprice_level, COUNT(*) as num
FROM 20191101PHA_20191101user_demographics t
JOIN shenzhen_people_phoneprice_10monthavg_level sppl ON sppl.PHA_qui = t.PHA_qui
GROUP BY lcode, phoneprice_level



-- 20191101PHA_20200501user_demographics
SELECT lcode, age, COUNT(*) as num
FROM 20191101PHA_20200501user_demographics
GROUP BY lcode, age

SELECT lcode, gender, COUNT(*) as num
FROM 20191101PHA_20200501user_demographics
GROUP BY lcode, gender

SELECT lcode, phoneprice_level, COUNT(*) as num
FROM 20191101PHA_20200501user_demographics t
JOIN shenzhen_people_phoneprice_10monthavg_level sppl ON sppl.PHA_qui = t.PHA_qui
GROUP BY lcode, phoneprice_level



-- 20191101PHA_20201101user_demographics
SELECT lcode, age, COUNT(*) as num
FROM 20191101PHA_20201101user_demographics
GROUP BY lcode, age

SELECT lcode, gender, COUNT(*) as num
FROM 20191101PHA_20201101user_demographics
GROUP BY lcode, gender

SELECT lcode, phoneprice_level, COUNT(*) as num
FROM 20191101PHA_20201101user_demographics t
JOIN shenzhen_people_phoneprice_10monthavg_level sppl ON sppl.PHA_qui = t.PHA_qui
GROUP BY lcode, phoneprice_level


-- 20191101PHA_20210501user_demographics
SELECT lcode, age, COUNT(*) as num
FROM 20191101PHA_20210501user_demographics
GROUP BY lcode, age

SELECT lcode, gender, COUNT(*) as num
FROM 20191101PHA_20210501user_demographics
GROUP BY lcode, gender

SELECT lcode, phoneprice_level, COUNT(*) as num
FROM 20191101PHA_20210501user_demographics t
JOIN shenzhen_people_phoneprice_10monthavg_level sppl ON sppl.PHA_qui = t.PHA_qui
GROUP BY lcode, phoneprice_level


-- 20191101PHA_20211101user_demographics
SELECT lcode, age, COUNT(*) as num
FROM 20191101PHA_20211101user_demographics
GROUP BY lcode, age

SELECT lcode, gender, COUNT(*) as num
FROM 20191101PHA_20211101user_demographics
GROUP BY lcode, gender

SELECT lcode, phoneprice_level, COUNT(*) as num
FROM 20191101PHA_20211101user_demographics t
JOIN shenzhen_people_phoneprice_10monthavg_level sppl ON sppl.PHA_qui = t.PHA_qui
GROUP BY lcode, phoneprice_level


-- 20191101PHA_20220501user_demographics
SELECT lcode, age, COUNT(*) as num
FROM 20191101PHA_20220501user_demographics
GROUP BY lcode, age

SELECT lcode, gender, COUNT(*) as num
FROM 20191101PHA_20220501user_demographics
GROUP BY lcode, gender

SELECT lcode, phoneprice_level, COUNT(*) as num
FROM 20191101PHA_20220501user_demographics t
JOIN shenzhen_people_phoneprice_10monthavg_level sppl ON sppl.PHA_qui = t.PHA_qui
GROUP BY lcode, phoneprice_level


-- 20191101PHA_20221101user_demographics
SELECT lcode, age, COUNT(*) as num
FROM 20191101PHA_20221101user_demographics
GROUP BY lcode, age

SELECT lcode, gender, COUNT(*) as num
FROM 20191101PHA_20221101user_demographics
GROUP BY lcode, gender

SELECT lcode, phoneprice_level, COUNT(*) as num
FROM 20191101PHA_20221101user_demographics t
JOIN shenzhen_people_phoneprice_10monthavg_level sppl ON sppl.PHA_qui = t.PHA_qui
GROUP BY lcode, phoneprice_level


-- 20191101PHA_20230501user_demographics
SELECT lcode, age, COUNT(*) as num
FROM 20191101PHA_20230501user_demographics
GROUP BY lcode, age

SELECT lcode, gender, COUNT(*) as num
FROM 20191101PHA_20230501user_demographics
GROUP BY lcode, gender

SELECT lcode, phoneprice_level, COUNT(*) as num
FROM 20191101PHA_20230501user_demographics t
JOIN shenzhen_people_phoneprice_10monthavg_level sppl ON sppl.PHA_qui = t.PHA_qui
GROUP BY lcode, phoneprice_level



-- 20191101PHA_20231101user_demographics
SELECT lcode, age, COUNT(*) as num
FROM 20191101PHA_20231101user_demographics
GROUP BY lcode, age

SELECT lcode, gender, COUNT(*) as num
FROM 20191101PHA_20231101user_demographics
GROUP BY lcode, gender

SELECT lcode, phoneprice_level, COUNT(*) as num
FROM 20191101PHA_20231101user_demographics t
JOIN shenzhen_people_phoneprice_10monthavg_level sppl ON sppl.PHA_qui = t.PHA_qui
GROUP BY lcode, phoneprice_level



-- 20200501 PHA

-- 20200501PHA_20200501user_demographics
SELECT lcode, age, COUNT(*) as num
FROM 20200501PHA_20200501user_demographics
GROUP BY lcode, age

SELECT lcode, gender, COUNT(*) as num
FROM 20200501PHA_20200501user_demographics
GROUP BY lcode, gender

SELECT lcode, phoneprice_level, COUNT(*) as num
FROM 20200501PHA_20200501user_demographics t
JOIN shenzhen_people_phoneprice_10monthavg_level sppl ON sppl.PHA_qui = t.PHA_qui
GROUP BY lcode, phoneprice_level


-- 20200501PHA_20201101user_demographics
SELECT lcode, age, COUNT(*) as num
FROM 20200501PHA_20201101user_demographics
GROUP BY lcode, age

SELECT lcode, gender, COUNT(*) as num
FROM 20200501PHA_20201101user_demographics
GROUP BY lcode, gender

SELECT lcode, phoneprice_level, COUNT(*) as num
FROM 20200501PHA_20201101user_demographics t
JOIN shenzhen_people_phoneprice_10monthavg_level sppl ON sppl.PHA_qui = t.PHA_qui
GROUP BY lcode, phoneprice_level



-- 20200501PHA_20210501user_demographics
SELECT lcode, age, COUNT(*) as num
FROM 20200501PHA_20210501user_demographics
GROUP BY lcode, age

SELECT lcode, gender, COUNT(*) as num
FROM 20200501PHA_20210501user_demographics
GROUP BY lcode, gender

SELECT lcode, phoneprice_level, COUNT(*) as num
FROM 20200501PHA_20210501user_demographics t
JOIN shenzhen_people_phoneprice_10monthavg_level sppl ON sppl.PHA_qui = t.PHA_qui
GROUP BY lcode, phoneprice_level


-- 20200501PHA_20211101user_demographics
SELECT lcode, age, COUNT(*) as num
FROM 20200501PHA_20211101user_demographics
GROUP BY lcode, age

SELECT lcode, gender, COUNT(*) as num
FROM 20200501PHA_20211101user_demographics
GROUP BY lcode, gender

SELECT lcode, phoneprice_level, COUNT(*) as num
FROM 20200501PHA_20211101user_demographics t
JOIN shenzhen_people_phoneprice_10monthavg_level sppl ON sppl.PHA_qui = t.PHA_qui
GROUP BY lcode, phoneprice_level



-- 20200501PHA_20220501user_demographics
SELECT lcode, age, COUNT(*) as num
FROM 20200501PHA_20220501user_demographics
GROUP BY lcode, age

SELECT lcode, gender, COUNT(*) as num
FROM 20200501PHA_20220501user_demographics
GROUP BY lcode, gender

SELECT lcode, phoneprice_level, COUNT(*) as num
FROM 20200501PHA_20220501user_demographics t
JOIN shenzhen_people_phoneprice_10monthavg_level sppl ON sppl.PHA_qui = t.PHA_qui
GROUP BY lcode, phoneprice_level


-- 20200501PHA_20221101user_demographics
SELECT lcode, age, COUNT(*) as num
FROM 20200501PHA_20221101user_demographics
GROUP BY lcode, age

SELECT lcode, gender, COUNT(*) as num
FROM 20200501PHA_20221101user_demographics
GROUP BY lcode, gender

SELECT lcode, phoneprice_level, COUNT(*) as num
FROM 20200501PHA_20221101user_demographics t
JOIN shenzhen_people_phoneprice_10monthavg_level sppl ON sppl.PHA_qui = t.PHA_qui
GROUP BY lcode, phoneprice_level


-- 20200501PHA_20230501user_demographics
SELECT lcode, age, COUNT(*) as num
FROM 20200501PHA_20230501user_demographics
GROUP BY lcode, age

SELECT lcode, gender, COUNT(*) as num
FROM 20200501PHA_20230501user_demographics
GROUP BY lcode, gender

SELECT lcode, phoneprice_level, COUNT(*) as num
FROM 20200501PHA_20230501user_demographics t
JOIN shenzhen_people_phoneprice_10monthavg_level sppl ON sppl.PHA_qui = t.PHA_qui
GROUP BY lcode, phoneprice_level



-- 20200501PHA_20231101user_demographics
SELECT lcode, age, COUNT(*) as num
FROM 20200501PHA_20231101user_demographics
GROUP BY lcode, age

SELECT lcode, gender, COUNT(*) as num
FROM 20200501PHA_20231101user_demographics
GROUP BY lcode, gender

SELECT lcode, phoneprice_level, COUNT(*) as num
FROM 20200501PHA_20231101user_demographics t
JOIN shenzhen_people_phoneprice_10monthavg_level sppl ON sppl.PHA_qui = t.PHA_qui
GROUP BY lcode, phoneprice_level






-- 20201101 PHA

-- 20201101PHA_20201101user_demographics
SELECT lcode, age, COUNT(*) as num
FROM 20201101PHA_20201101user_demographics
GROUP BY lcode, age

SELECT lcode, gender, COUNT(*) as num
FROM 20201101PHA_20201101user_demographics
GROUP BY lcode, gender

SELECT lcode, phoneprice_level, COUNT(*) as num
FROM 20201101PHA_20201101user_demographics t
JOIN shenzhen_people_phoneprice_10monthavg_level sppl ON sppl.PHA_qui = t.PHA_qui
GROUP BY lcode, phoneprice_level


-- 20201101PHA_20210501user_demographics
SELECT lcode, age, COUNT(*) as num
FROM 20201101PHA_20210501user_demographics
GROUP BY lcode, age

SELECT lcode, gender, COUNT(*) as num
FROM 20201101PHA_20210501user_demographics
GROUP BY lcode, gender

SELECT lcode, phoneprice_level, COUNT(*) as num
FROM 20201101PHA_20210501user_demographics t
JOIN shenzhen_people_phoneprice_10monthavg_level sppl ON sppl.PHA_qui = t.PHA_qui
GROUP BY lcode, phoneprice_level



-- 20201101PHA_20211101user_demographics
SELECT lcode, age, COUNT(*) as num
FROM 20201101PHA_20211101user_demographics
GROUP BY lcode, age

SELECT lcode, gender, COUNT(*) as num
FROM 20201101PHA_20211101user_demographics
GROUP BY lcode, gender

SELECT lcode, phoneprice_level, COUNT(*) as num
FROM 20201101PHA_20211101user_demographics t
JOIN shenzhen_people_phoneprice_10monthavg_level sppl ON sppl.PHA_qui = t.PHA_qui
GROUP BY lcode, phoneprice_level


-- 20201101PHA_20220501user_demographics
SELECT lcode, age, COUNT(*) as num
FROM 20201101PHA_20220501user_demographics
GROUP BY lcode, age

SELECT lcode, gender, COUNT(*) as num
FROM 20201101PHA_20220501user_demographics
GROUP BY lcode, gender

SELECT lcode, phoneprice_level, COUNT(*) as num
FROM 20201101PHA_20220501user_demographics t
JOIN shenzhen_people_phoneprice_10monthavg_level sppl ON sppl.PHA_qui = t.PHA_qui
GROUP BY lcode, phoneprice_level



-- 20201101PHA_20221101user_demographics
SELECT lcode, age, COUNT(*) as num
FROM 20201101PHA_20221101user_demographics
GROUP BY lcode, age

SELECT lcode, gender, COUNT(*) as num
FROM 20201101PHA_20221101user_demographics
GROUP BY lcode, gender

SELECT lcode, phoneprice_level, COUNT(*) as num
FROM 20201101PHA_20221101user_demographics t
JOIN shenzhen_people_phoneprice_10monthavg_level sppl ON sppl.PHA_qui = t.PHA_qui
GROUP BY lcode, phoneprice_level



-- 20201101PHA_20230501user_demographics
SELECT lcode, age, COUNT(*) as num
FROM 20201101PHA_20230501user_demographics
GROUP BY lcode, age

SELECT lcode, gender, COUNT(*) as num
FROM 20201101PHA_20230501user_demographics
GROUP BY lcode, gender

SELECT lcode, phoneprice_level, COUNT(*) as num
FROM 20201101PHA_20230501user_demographics t
JOIN shenzhen_people_phoneprice_10monthavg_level sppl ON sppl.PHA_qui = t.PHA_qui
GROUP BY lcode, phoneprice_level


-- 20201101PHA_20231101user_demographics
SELECT lcode, age, COUNT(*) as num
FROM 20201101PHA_20231101user_demographics
GROUP BY lcode, age

SELECT lcode, gender, COUNT(*) as num
FROM 20201101PHA_20231101user_demographics
GROUP BY lcode, gender

SELECT lcode, phoneprice_level, COUNT(*) as num
FROM 20201101PHA_20231101user_demographics t
JOIN shenzhen_people_phoneprice_10monthavg_level sppl ON sppl.PHA_qui = t.PHA_qui
GROUP BY lcode, phoneprice_level





-- Avg APP usage - phone type F3 A3 B3


-- 20190501
-- 不同品牌对应的平均使用
SELECT uf.brand,
       AVG(t.app_eachmonth_count) AS 20190501avg_phone
FROM shenzhen_20190501_users_filtered uf
JOIN shenzhen_app_use_eachmonth_count_filtered t
      ON t.PHA_qui = uf.PHA_qui
      AND t.date = uf.date
GROUP BY uf.brand
ORDER BY 20190501avg_phone


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
SELECT uf.brand,
       AVG(t.app_eachmonth_count) AS 20200501avg_phone
FROM shenzhen_20200501_users_filtered uf
JOIN shenzhen_app_use_eachmonth_count_filtered t
      ON t.PHA_qui = uf.PHA_qui
      AND t.date = uf.date
GROUP BY uf.brand
ORDER BY 20200501avg_phone


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
SELECT uf.brand,
       AVG(t.app_eachmonth_count) AS 20210501avg_phone
FROM shenzhen_20210501_users_filtered uf
JOIN shenzhen_app_use_eachmonth_count_filtered t
      ON t.PHA_qui = uf.PHA_qui
      AND t.date = uf.date
GROUP BY uf.brand
ORDER BY 20210501avg_phone



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
SELECT uf.brand,
       AVG(t.app_eachmonth_count) AS 20220501avg_phone
FROM shenzhen_20220501_users_filtered uf
JOIN shenzhen_app_use_eachmonth_count_filtered t
      ON t.PHA_qui = uf.PHA_qui
      AND t.date = uf.date
GROUP BY uf.brand
ORDER BY 20220501avg_phone


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
SELECT uf.brand,
       AVG(t.app_eachmonth_count) AS 20230501avg_phone
FROM shenzhen_20230501_users_filtered uf
JOIN shenzhen_app_use_eachmonth_count_filtered t
      ON t.PHA_qui = uf.PHA_qui
      AND t.date = uf.date
GROUP BY uf.brand
ORDER BY 20230501avg_phone


-- 20231101
SELECT uf.brand,
       AVG(t.app_eachmonth_count) AS 20231101avg_phone
FROM shenzhen_20231101_users_filtered uf
JOIN shenzhen_app_use_eachmonth_count_filtered t
      ON t.PHA_qui = uf.PHA_qui
      AND t.date = uf.date
GROUP BY uf.brand
ORDER BY 20231101avg_phone




-- phone system realted

-- user num of each system at 10 months
SELECT date,
       phonesystem,
       COUNT(*) AS system_num
FROM shenzhen_phonesystem_ifios
GROUP BY date, phonesystem




-- 每个系统的用户使用PHA num的平均值 F4A
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



-- 每个系统的用户使用all APP num的平均值, 10 months F4A
SELECT spi.date,
       spi.phonesystem,
       AVG(t.app_eachmonth_count) AS avg_all_system
FROM shenzhen_phonesystem_ifios spi
JOIN (SELECT PHA_qui, date, app_eachmonth_count
      FROM shenzhen_app_use_eachmonth_count_filtered) t on t.PHA_qui = spi.PHA_qui
JOIN shenzhen_20190501_users_filtered suf ON spi.PHA_qui = suf.PHA_qui
GROUP BY spi.date, spi.phonesystem







-- system & demographic -- F4 C D E

-- each system age & gender & income

SELECT date, age, phonesystem, COUNT(*) AS num
FROM shenzhen_phonesystem_ifios
GROUP BY date, age, phonesystem

SELECT date, gender, phonesystem, COUNT(*) AS num
FROM shenzhen_phonesystem_ifios
GROUP BY date, gender, phonesystem

SELECT date, income, phonesystem, COUNT(*) AS num
FROM shenzhen_phonesystem_ifios
GROUP BY date, income, phonesystem






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
SELECT sppl.phoneprice_level,
       AVG(t.PHA_num) AS avg_pha_income_ios_20190501
FROM shenzhen_20190501_users_filtered uf  -- 567101人
JOIN (SELECT PHA_qui, PHA_num
      FROM shenzhen_PHAuse_20190501_all) t on t.PHA_qui = uf.PHA_qui -- PHA count 要改table
JOIN shenzhen_people_phoneprice_10monthavg_level sppl ON sppl.PHA_qui = uf.PHA_qui -- income level 每个人只有一条记录
JOIN shenzhen_phonesystem_ifios spi ON spi.PHA_qui = uf.PHA_qui -- phone system
WHERE spi.date = 20190501
AND spi.phonesystem = "ios"
GROUP BY sppl.phoneprice_level


-- 20191101
-- PHA
-- income
SELECT sppl.phoneprice_level,
       AVG(t.PHA_num) AS avg_pha_income_ios_20191101
FROM shenzhen_20190501_users_filtered uf  -- 567101人
JOIN (SELECT PHA_qui, PHA_num
      FROM shenzhen_PHAuse_20191101_all) t on t.PHA_qui = uf.PHA_qui -- PHA count 要改table
JOIN shenzhen_people_phoneprice_10monthavg_level sppl ON sppl.PHA_qui = uf.PHA_qui -- income level 每个人只有一条记录
JOIN shenzhen_phonesystem_ifios spi ON spi.PHA_qui = uf.PHA_qui -- phone system
WHERE spi.date = 20191101
AND spi.phonesystem = "ios"
GROUP BY sppl.phoneprice_level


-- 20200501
-- PHA
-- income
SELECT sppl.phoneprice_level,
       AVG(t.PHA_num) AS avg_pha_income_ios_20200501
FROM shenzhen_20190501_users_filtered uf  -- 567101人
JOIN (SELECT PHA_qui, PHA_num
      FROM shenzhen_PHAuse_20200501_all) t on t.PHA_qui = uf.PHA_qui -- PHA count 要改table
JOIN shenzhen_people_phoneprice_10monthavg_level sppl ON sppl.PHA_qui = uf.PHA_qui -- income level 每个人只有一条记录
JOIN shenzhen_phonesystem_ifios spi ON spi.PHA_qui = uf.PHA_qui -- phone system
WHERE spi.date = 20200501
AND spi.phonesystem = "ios"
GROUP BY sppl.phoneprice_level


-- 20201101
-- PHA
-- income
SELECT sppl.phoneprice_level,
       AVG(t.PHA_num) AS avg_pha_income_ios_20201101
FROM shenzhen_20201101_users_filtered uf  -- 567101人
JOIN (SELECT PHA_qui, PHA_num
      FROM shenzhen_PHAuse_20201101_all) t on t.PHA_qui = uf.PHA_qui -- PHA count 要改table
JOIN shenzhen_people_phoneprice_10monthavg_level sppl ON sppl.PHA_qui = uf.PHA_qui -- income level 每个人只有一条记录
JOIN shenzhen_phonesystem_ifios spi ON spi.PHA_qui = uf.PHA_qui -- phone system
WHERE spi.date = 20201101
AND spi.phonesystem = "ios"
GROUP BY sppl.phoneprice_level


-- 20210501
-- PHA
-- income
SELECT sppl.phoneprice_level,
       AVG(t.PHA_num) AS avg_pha_income_ios_20210501
FROM shenzhen_20190501_users_filtered uf  -- 567101人
JOIN (SELECT PHA_qui, PHA_num
      FROM shenzhen_PHAuse_20210501_all) t on t.PHA_qui = uf.PHA_qui -- PHA count 要改table
JOIN shenzhen_people_phoneprice_10monthavg_level sppl ON sppl.PHA_qui = uf.PHA_qui -- income level 每个人只有一条记录
JOIN shenzhen_phonesystem_ifios spi ON spi.PHA_qui = uf.PHA_qui -- phone system
WHERE spi.date = 20210501
AND spi.phonesystem = "ios"
GROUP BY sppl.phoneprice_level


-- 20211101
-- PHA
-- income
SELECT sppl.phoneprice_level,
       AVG(t.PHA_num) AS avg_pha_income_ios_20211101
FROM shenzhen_20201101_users_filtered uf  -- 567101人
JOIN (SELECT PHA_qui, PHA_num
      FROM shenzhen_PHAuse_20211101_all) t on t.PHA_qui = uf.PHA_qui -- PHA count 要改table
JOIN shenzhen_people_phoneprice_10monthavg_level sppl ON sppl.PHA_qui = uf.PHA_qui -- income level 每个人只有一条记录
JOIN shenzhen_phonesystem_ifios spi ON spi.PHA_qui = uf.PHA_qui -- phone system
WHERE spi.date = 20211101
AND spi.phonesystem = "ios"
GROUP BY sppl.phoneprice_level



-- 20220501
-- PHA
-- income
SELECT sppl.phoneprice_level,
       AVG(t.PHA_num) AS avg_pha_income_ios_20220501
FROM shenzhen_20190501_users_filtered uf  -- 567101人
JOIN (SELECT PHA_qui, PHA_num
      FROM shenzhen_PHAuse_20220501_all) t on t.PHA_qui = uf.PHA_qui -- PHA count 要改table
JOIN shenzhen_people_phoneprice_10monthavg_level sppl ON sppl.PHA_qui = uf.PHA_qui -- income level 每个人只有一条记录
JOIN shenzhen_phonesystem_ifios spi ON spi.PHA_qui = uf.PHA_qui -- phone system
WHERE spi.date = 20220501
AND spi.phonesystem = "ios"
GROUP BY sppl.phoneprice_level


-- 20221101
-- PHA
-- income
SELECT sppl.phoneprice_level,
       AVG(t.PHA_num) AS avg_pha_income_ios_20221101
FROM shenzhen_20201101_users_filtered uf  -- 567101人
JOIN (SELECT PHA_qui, PHA_num
      FROM shenzhen_PHAuse_20221101_all) t on t.PHA_qui = uf.PHA_qui -- PHA count 要改table
JOIN shenzhen_people_phoneprice_10monthavg_level sppl ON sppl.PHA_qui = uf.PHA_qui -- income level 每个人只有一条记录
JOIN shenzhen_phonesystem_ifios spi ON spi.PHA_qui = uf.PHA_qui -- phone system
WHERE spi.date = 20221101
AND spi.phonesystem = "ios"
GROUP BY sppl.phoneprice_level


-- 20230501
-- PHA
-- income
SELECT sppl.phoneprice_level,
       AVG(t.PHA_num) AS avg_pha_income_ios_20230501
FROM shenzhen_20190501_users_filtered uf  -- 567101人
JOIN (SELECT PHA_qui, PHA_num
      FROM shenzhen_PHAuse_20230501_all) t on t.PHA_qui = uf.PHA_qui -- PHA count 要改table
JOIN shenzhen_people_phoneprice_10monthavg_level sppl ON sppl.PHA_qui = uf.PHA_qui -- income level 每个人只有一条记录
JOIN shenzhen_phonesystem_ifios spi ON spi.PHA_qui = uf.PHA_qui -- phone system
WHERE spi.date = 20230501
AND spi.phonesystem = "ios"
GROUP BY sppl.phoneprice_level


-- 20231101
-- PHA
-- income
SELECT sppl.phoneprice_level,
       AVG(t.PHA_num) AS avg_pha_income_ios_20231101
FROM shenzhen_20201101_users_filtered uf  -- 567101人
JOIN (SELECT PHA_qui, PHA_num
      FROM shenzhen_PHAuse_20231101_all) t on t.PHA_qui = uf.PHA_qui -- PHA count 要改table
JOIN shenzhen_people_phoneprice_10monthavg_level sppl ON sppl.PHA_qui = uf.PHA_qui -- income level 每个人只有一条记录
JOIN shenzhen_phonesystem_ifios spi ON spi.PHA_qui = uf.PHA_qui -- phone system
WHERE spi.date = 20231101
AND spi.phonesystem = "ios"
GROUP BY sppl.phoneprice_level






-- 20190501
-- ALL
-- income
SELECT sppl.phoneprice_level,
       AVG(t.app_eachmonth_count) AS  avg_all_income_ios_20190501
FROM shenzhen_20190501_users_filtered uf  -- 567101人 不用改table
JOIN (SELECT PHA_qui, app_eachmonth_count
      FROM shenzhen_app_use_eachmonth_count_filtered
      WHERE date = 20190501) t ON t.PHA_qui = uf.PHA_qui -- All count 要改date
JOIN shenzhen_people_phoneprice_10monthavg_level sppl ON sppl.PHA_qui = uf.PHA_qui -- income level 每个人只有一条记录
JOIN shenzhen_phonesystem_ifios spi ON spi.PHA_qui = uf.PHA_qui -- phone system
WHERE spi.date = 20190501
AND spi.phonesystem = "ios"
GROUP BY sppl.phoneprice_level



-- 20191101
-- ALL
-- income
SELECT sppl.phoneprice_level,
       AVG(t.app_eachmonth_count) AS  avg_all_income_ios_20191101
FROM shenzhen_20190501_users_filtered uf  -- 567101人 不用改table
JOIN (SELECT PHA_qui, app_eachmonth_count
      FROM shenzhen_app_use_eachmonth_count_filtered
      WHERE date = 20191101) t ON t.PHA_qui = uf.PHA_qui -- All count 要改date
JOIN shenzhen_people_phoneprice_10monthavg_level sppl ON sppl.PHA_qui = uf.PHA_qui -- income level 每个人只有一条记录
JOIN shenzhen_phonesystem_ifios spi ON spi.PHA_qui = uf.PHA_qui -- phone system
WHERE spi.date = 20191101
AND spi.phonesystem = "ios"
GROUP BY sppl.phoneprice_level



-- 20200501
-- ALL
-- income
SELECT sppl.phoneprice_level,
       AVG(t.app_eachmonth_count) AS  avg_all_income_ios_20200501
FROM shenzhen_20190501_users_filtered uf  -- 567101人 不用改table
JOIN (SELECT PHA_qui, app_eachmonth_count
      FROM shenzhen_app_use_eachmonth_count_filtered
      WHERE date = 20200501) t ON t.PHA_qui = uf.PHA_qui -- All count 要改date
JOIN shenzhen_people_phoneprice_10monthavg_level sppl ON sppl.PHA_qui = uf.PHA_qui -- income level 每个人只有一条记录
JOIN shenzhen_phonesystem_ifios spi ON spi.PHA_qui = uf.PHA_qui -- phone system
WHERE spi.date = 20200501
AND spi.phonesystem = "ios"
GROUP BY sppl.phoneprice_level


-- 20201101
-- ALL
-- income
SELECT sppl.phoneprice_level,
       AVG(t.app_eachmonth_count) AS  avg_all_income_ios_20201101
FROM shenzhen_20190501_users_filtered uf  -- 567101人 不用改table
JOIN (SELECT PHA_qui, app_eachmonth_count
      FROM shenzhen_app_use_eachmonth_count_filtered
      WHERE date = 20201101) t ON t.PHA_qui = uf.PHA_qui -- All count 要改date
JOIN shenzhen_people_phoneprice_10monthavg_level sppl ON sppl.PHA_qui = uf.PHA_qui -- income level 每个人只有一条记录
JOIN shenzhen_phonesystem_ifios spi ON spi.PHA_qui = uf.PHA_qui -- phone system
WHERE spi.date = 20201101
AND spi.phonesystem = "ios"
GROUP BY sppl.phoneprice_level


-- 20210501
-- ALL
-- income
SELECT sppl.phoneprice_level,
       AVG(t.app_eachmonth_count) AS  avg_all_income_ios_20210501
FROM shenzhen_20190501_users_filtered uf  -- 567101人 不用改table
JOIN (SELECT PHA_qui, app_eachmonth_count
      FROM shenzhen_app_use_eachmonth_count_filtered
      WHERE date = 20210501) t ON t.PHA_qui = uf.PHA_qui -- All count 要改date
JOIN shenzhen_people_phoneprice_10monthavg_level sppl ON sppl.PHA_qui = uf.PHA_qui -- income level 每个人只有一条记录
JOIN shenzhen_phonesystem_ifios spi ON spi.PHA_qui = uf.PHA_qui -- phone system
WHERE spi.date = 20210501
AND spi.phonesystem = "ios"
GROUP BY sppl.phoneprice_level


-- 20211101
-- ALL
-- income
SELECT sppl.phoneprice_level,
       AVG(t.app_eachmonth_count) AS  avg_all_income_ios_20211101
FROM shenzhen_20190501_users_filtered uf  -- 567101人 不用改table
JOIN (SELECT PHA_qui, app_eachmonth_count
      FROM shenzhen_app_use_eachmonth_count_filtered
      WHERE date = 20211101) t ON t.PHA_qui = uf.PHA_qui -- All count 要改date
JOIN shenzhen_people_phoneprice_10monthavg_level sppl ON sppl.PHA_qui = uf.PHA_qui -- income level 每个人只有一条记录
JOIN shenzhen_phonesystem_ifios spi ON spi.PHA_qui = uf.PHA_qui -- phone system
WHERE spi.date = 20211101
AND spi.phonesystem = "ios"
GROUP BY sppl.phoneprice_level


-- 20220501
-- ALL
-- income
SELECT sppl.phoneprice_level,
       AVG(t.app_eachmonth_count) AS  avg_all_income_ios_20220501
FROM shenzhen_20190501_users_filtered uf  -- 567101人 不用改table
JOIN (SELECT PHA_qui, app_eachmonth_count
      FROM shenzhen_app_use_eachmonth_count_filtered
      WHERE date = 20220501) t ON t.PHA_qui = uf.PHA_qui -- All count 要改date
JOIN shenzhen_people_phoneprice_10monthavg_level sppl ON sppl.PHA_qui = uf.PHA_qui -- income level 每个人只有一条记录
JOIN shenzhen_phonesystem_ifios spi ON spi.PHA_qui = uf.PHA_qui -- phone system
WHERE spi.date = 20220501
AND spi.phonesystem = "ios"
GROUP BY sppl.phoneprice_level


-- 20221101
-- ALL
-- income
SELECT sppl.phoneprice_level,
       AVG(t.app_eachmonth_count) AS  avg_all_income_ios_20221101
FROM shenzhen_20190501_users_filtered uf  -- 567101人 不用改table
JOIN (SELECT PHA_qui, app_eachmonth_count
      FROM shenzhen_app_use_eachmonth_count_filtered
      WHERE date = 20221101) t ON t.PHA_qui = uf.PHA_qui -- All count 要改date
JOIN shenzhen_people_phoneprice_10monthavg_level sppl ON sppl.PHA_qui = uf.PHA_qui -- income level 每个人只有一条记录
JOIN shenzhen_phonesystem_ifios spi ON spi.PHA_qui = uf.PHA_qui -- phone system
WHERE spi.date = 20221101
AND spi.phonesystem = "ios"
GROUP BY sppl.phoneprice_level



-- 20230501
-- ALL
-- income
SELECT sppl.phoneprice_level,
       AVG(t.app_eachmonth_count) AS  avg_all_income_ios_20230501
FROM shenzhen_20190501_users_filtered uf  -- 567101人 不用改table
JOIN (SELECT PHA_qui, app_eachmonth_count
      FROM shenzhen_app_use_eachmonth_count_filtered
      WHERE date = 20230501) t ON t.PHA_qui = uf.PHA_qui -- All count 要改date
JOIN shenzhen_people_phoneprice_10monthavg_level sppl ON sppl.PHA_qui = uf.PHA_qui -- income level 每个人只有一条记录
JOIN shenzhen_phonesystem_ifios spi ON spi.PHA_qui = uf.PHA_qui -- phone system
WHERE spi.date = 20230501
AND spi.phonesystem = "ios"
GROUP BY sppl.phoneprice_level

-- 20231101
-- ALL
-- income
SELECT sppl.phoneprice_level,
       AVG(t.app_eachmonth_count) AS  avg_all_income_ios_20231101
FROM shenzhen_20190501_users_filtered uf  -- 567101人 不用改table
JOIN (SELECT PHA_qui, app_eachmonth_count
      FROM shenzhen_app_use_eachmonth_count_filtered
      WHERE date = 20231101) t ON t.PHA_qui = uf.PHA_qui -- All count 要改date
JOIN shenzhen_people_phoneprice_10monthavg_level sppl ON sppl.PHA_qui = uf.PHA_qui -- income level 每个人只有一条记录
JOIN shenzhen_phonesystem_ifios spi ON spi.PHA_qui = uf.PHA_qui -- phone system
WHERE spi.date = 20231101
AND spi.phonesystem = "ios"
GROUP BY sppl.phoneprice_level














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
SELECT sppl.phoneprice_level,
       AVG(t.PHA_num) AS avg_pha_income_Andorid_20190501
FROM shenzhen_20190501_users_filtered uf  -- 567101人
JOIN (SELECT PHA_qui, PHA_num
      FROM shenzhen_PHAuse_20190501_all) t on t.PHA_qui = uf.PHA_qui -- PHA count 要改table
JOIN shenzhen_people_phoneprice_10monthavg_level sppl ON sppl.PHA_qui = uf.PHA_qui -- income level 每个人只有一条记录
JOIN shenzhen_phonesystem_ifios spi ON spi.PHA_qui = uf.PHA_qui -- phone system
WHERE spi.date = 20190501
AND spi.phonesystem = "Android"
GROUP BY sppl.phoneprice_level


-- 20191101
-- PHA
-- income
SELECT sppl.phoneprice_level,
       AVG(t.PHA_num) AS avg_pha_income_Andorid_20191101
FROM shenzhen_20190501_users_filtered uf  -- 567101人
JOIN (SELECT PHA_qui, PHA_num
      FROM shenzhen_PHAuse_20191101_all) t on t.PHA_qui = uf.PHA_qui -- PHA count 要改table
JOIN shenzhen_people_phoneprice_10monthavg_level sppl ON sppl.PHA_qui = uf.PHA_qui -- income level 每个人只有一条记录
JOIN shenzhen_phonesystem_ifios spi ON spi.PHA_qui = uf.PHA_qui -- phone system
WHERE spi.date = 20191101
AND spi.phonesystem = "Android"
GROUP BY sppl.phoneprice_level


-- 20200501
-- PHA
-- income
SELECT sppl.phoneprice_level,
       AVG(t.PHA_num) AS avg_pha_income_Andorid_20200501
FROM shenzhen_20190501_users_filtered uf  -- 567101人
JOIN (SELECT PHA_qui, PHA_num
      FROM shenzhen_PHAuse_20200501_all) t on t.PHA_qui = uf.PHA_qui -- PHA count 要改table
JOIN shenzhen_people_phoneprice_10monthavg_level sppl ON sppl.PHA_qui = uf.PHA_qui -- income level 每个人只有一条记录
JOIN shenzhen_phonesystem_ifios spi ON spi.PHA_qui = uf.PHA_qui -- phone system
WHERE spi.date = 20200501
AND spi.phonesystem = "Android"
GROUP BY sppl.phoneprice_level


-- 20201101
-- PHA
-- income
SELECT sppl.phoneprice_level,
       AVG(t.PHA_num) AS avg_pha_income_Andorid_20201101
FROM shenzhen_20201101_users_filtered uf  -- 567101人
JOIN (SELECT PHA_qui, PHA_num
      FROM shenzhen_PHAuse_20201101_all) t on t.PHA_qui = uf.PHA_qui -- PHA count 要改table
JOIN shenzhen_people_phoneprice_10monthavg_level sppl ON sppl.PHA_qui = uf.PHA_qui -- income level 每个人只有一条记录
JOIN shenzhen_phonesystem_ifios spi ON spi.PHA_qui = uf.PHA_qui -- phone system
WHERE spi.date = 20201101
AND spi.phonesystem = "Android"
GROUP BY sppl.phoneprice_level


-- 20210501
-- PHA
-- income
SELECT sppl.phoneprice_level,
       AVG(t.PHA_num) AS avg_pha_income_Andorid_20210501
FROM shenzhen_20190501_users_filtered uf  -- 567101人
JOIN (SELECT PHA_qui, PHA_num
      FROM shenzhen_PHAuse_20210501_all) t on t.PHA_qui = uf.PHA_qui -- PHA count 要改table
JOIN shenzhen_people_phoneprice_10monthavg_level sppl ON sppl.PHA_qui = uf.PHA_qui -- income level 每个人只有一条记录
JOIN shenzhen_phonesystem_ifios spi ON spi.PHA_qui = uf.PHA_qui -- phone system
WHERE spi.date = 20210501
AND spi.phonesystem = "Android"
GROUP BY sppl.phoneprice_level


-- 20211101
-- PHA
-- income
SELECT sppl.phoneprice_level,
       AVG(t.PHA_num) AS avg_pha_income_Andorid_20211101
FROM shenzhen_20201101_users_filtered uf  -- 567101人
JOIN (SELECT PHA_qui, PHA_num
      FROM shenzhen_PHAuse_20211101_all) t on t.PHA_qui = uf.PHA_qui -- PHA count 要改table
JOIN shenzhen_people_phoneprice_10monthavg_level sppl ON sppl.PHA_qui = uf.PHA_qui -- income level 每个人只有一条记录
JOIN shenzhen_phonesystem_ifios spi ON spi.PHA_qui = uf.PHA_qui -- phone system
WHERE spi.date = 20211101
AND spi.phonesystem = "Android"
GROUP BY sppl.phoneprice_level


-- 20220501
-- PHA
-- income
SELECT sppl.phoneprice_level,
       AVG(t.PHA_num) AS avg_pha_income_Andorid_20220501
FROM shenzhen_20190501_users_filtered uf  -- 567101人
JOIN (SELECT PHA_qui, PHA_num
      FROM shenzhen_PHAuse_20220501_all) t on t.PHA_qui = uf.PHA_qui -- PHA count 要改table
JOIN shenzhen_people_phoneprice_10monthavg_level sppl ON sppl.PHA_qui = uf.PHA_qui -- income level 每个人只有一条记录
JOIN shenzhen_phonesystem_ifios spi ON spi.PHA_qui = uf.PHA_qui -- phone system
WHERE spi.date = 20220501
AND spi.phonesystem = "Android"
GROUP BY sppl.phoneprice_level


-- 20221101
-- PHA
-- income
SELECT sppl.phoneprice_level,
       AVG(t.PHA_num) AS avg_pha_income_Andorid_20221101
FROM shenzhen_20201101_users_filtered uf  -- 567101人
JOIN (SELECT PHA_qui, PHA_num
      FROM shenzhen_PHAuse_20221101_all) t on t.PHA_qui = uf.PHA_qui -- PHA count 要改table
JOIN shenzhen_people_phoneprice_10monthavg_level sppl ON sppl.PHA_qui = uf.PHA_qui -- income level 每个人只有一条记录
JOIN shenzhen_phonesystem_ifios spi ON spi.PHA_qui = uf.PHA_qui -- phone system
WHERE spi.date = 20221101
AND spi.phonesystem = "Android"
GROUP BY sppl.phoneprice_level


-- 20230501
-- PHA
-- income
SELECT sppl.phoneprice_level,
       AVG(t.PHA_num) AS avg_pha_income_Andorid_20230501
FROM shenzhen_20190501_users_filtered uf  -- 567101人
JOIN (SELECT PHA_qui, PHA_num
      FROM shenzhen_PHAuse_20230501_all) t on t.PHA_qui = uf.PHA_qui -- PHA count 要改table
JOIN shenzhen_people_phoneprice_10monthavg_level sppl ON sppl.PHA_qui = uf.PHA_qui -- income level 每个人只有一条记录
JOIN shenzhen_phonesystem_ifios spi ON spi.PHA_qui = uf.PHA_qui -- phone system
WHERE spi.date = 20230501
AND spi.phonesystem = "Android"
GROUP BY sppl.phoneprice_level


-- 20231101
-- PHA
-- income
SELECT sppl.phoneprice_level,
       AVG(t.PHA_num) AS avg_pha_income_Andorid_20231101
FROM shenzhen_20201101_users_filtered uf  -- 567101人
JOIN (SELECT PHA_qui, PHA_num
      FROM shenzhen_PHAuse_20231101_all) t on t.PHA_qui = uf.PHA_qui -- PHA count 要改table
JOIN shenzhen_people_phoneprice_10monthavg_level sppl ON sppl.PHA_qui = uf.PHA_qui -- income level 每个人只有一条记录
JOIN shenzhen_phonesystem_ifios spi ON spi.PHA_qui = uf.PHA_qui -- phone system
WHERE spi.date = 20231101
AND spi.phonesystem = "Android"
GROUP BY sppl.phoneprice_level





-- 20190501
-- ALL
-- income
SELECT sppl.phoneprice_level,
       AVG(t.app_eachmonth_count) AS  avg_all_income_Andorid_20190501
FROM shenzhen_20190501_users_filtered uf  -- 567101人 不用改table
JOIN (SELECT PHA_qui, app_eachmonth_count
      FROM shenzhen_app_use_eachmonth_count_filtered
      WHERE date = 20190501) t ON t.PHA_qui = uf.PHA_qui -- All count 要改date
JOIN shenzhen_people_phoneprice_10monthavg_level sppl ON sppl.PHA_qui = uf.PHA_qui -- income level 每个人只有一条记录
JOIN shenzhen_phonesystem_ifios spi ON spi.PHA_qui = uf.PHA_qui -- phone system
WHERE spi.date = 20190501
AND spi.phonesystem = "Android"
GROUP BY sppl.phoneprice_level

-- 20191101
-- ALL
-- income
SELECT sppl.phoneprice_level,
       AVG(t.app_eachmonth_count) AS  avg_all_income_Andorid_20191101
FROM shenzhen_20190501_users_filtered uf  -- 567101人 不用改table
JOIN (SELECT PHA_qui, app_eachmonth_count
      FROM shenzhen_app_use_eachmonth_count_filtered
      WHERE date = 20191101) t ON t.PHA_qui = uf.PHA_qui -- All count 要改date
JOIN shenzhen_people_phoneprice_10monthavg_level sppl ON sppl.PHA_qui = uf.PHA_qui -- income level 每个人只有一条记录
JOIN shenzhen_phonesystem_ifios spi ON spi.PHA_qui = uf.PHA_qui -- phone system
WHERE spi.date = 20191101
AND spi.phonesystem = "Android"
GROUP BY sppl.phoneprice_level


-- 20200501
-- ALL
-- income
SELECT sppl.phoneprice_level,
       AVG(t.app_eachmonth_count) AS  avg_all_income_Andorid_20200501
FROM shenzhen_20190501_users_filtered uf  -- 567101人 不用改table
JOIN (SELECT PHA_qui, app_eachmonth_count
      FROM shenzhen_app_use_eachmonth_count_filtered
      WHERE date = 20200501) t ON t.PHA_qui = uf.PHA_qui -- All count 要改date
JOIN shenzhen_people_phoneprice_10monthavg_level sppl ON sppl.PHA_qui = uf.PHA_qui -- income level 每个人只有一条记录
JOIN shenzhen_phonesystem_ifios spi ON spi.PHA_qui = uf.PHA_qui -- phone system
WHERE spi.date = 20200501
AND spi.phonesystem = "Android"
GROUP BY sppl.phoneprice_level

-- 20201101
-- ALL
-- income
SELECT sppl.phoneprice_level,
       AVG(t.app_eachmonth_count) AS  avg_all_income_Andorid_20201101
FROM shenzhen_20190501_users_filtered uf  -- 567101人 不用改table
JOIN (SELECT PHA_qui, app_eachmonth_count
      FROM shenzhen_app_use_eachmonth_count_filtered
      WHERE date = 20201101) t ON t.PHA_qui = uf.PHA_qui -- All count 要改date
JOIN shenzhen_people_phoneprice_10monthavg_level sppl ON sppl.PHA_qui = uf.PHA_qui -- income level 每个人只有一条记录
JOIN shenzhen_phonesystem_ifios spi ON spi.PHA_qui = uf.PHA_qui -- phone system
WHERE spi.date = 20201101
AND spi.phonesystem = "Android"
GROUP BY sppl.phoneprice_level

-- 20210501
-- ALL
-- income
SELECT sppl.phoneprice_level,
       AVG(t.app_eachmonth_count) AS  avg_all_income_Andorid_20210501
FROM shenzhen_20190501_users_filtered uf  -- 567101人 不用改table
JOIN (SELECT PHA_qui, app_eachmonth_count
      FROM shenzhen_app_use_eachmonth_count_filtered
      WHERE date = 20210501) t ON t.PHA_qui = uf.PHA_qui -- All count 要改date
JOIN shenzhen_people_phoneprice_10monthavg_level sppl ON sppl.PHA_qui = uf.PHA_qui -- income level 每个人只有一条记录
JOIN shenzhen_phonesystem_ifios spi ON spi.PHA_qui = uf.PHA_qui -- phone system
WHERE spi.date = 20210501
AND spi.phonesystem = "Android"
GROUP BY sppl.phoneprice_level

-- 20211101
-- ALL
-- income
SELECT sppl.phoneprice_level,
       AVG(t.app_eachmonth_count) AS  avg_all_income_Andorid_20211101
FROM shenzhen_20190501_users_filtered uf  -- 567101人 不用改table
JOIN (SELECT PHA_qui, app_eachmonth_count
      FROM shenzhen_app_use_eachmonth_count_filtered
      WHERE date = 20211101) t ON t.PHA_qui = uf.PHA_qui -- All count 要改date
JOIN shenzhen_people_phoneprice_10monthavg_level sppl ON sppl.PHA_qui = uf.PHA_qui -- income level 每个人只有一条记录
JOIN shenzhen_phonesystem_ifios spi ON spi.PHA_qui = uf.PHA_qui -- phone system
WHERE spi.date = 20211101
AND spi.phonesystem = "Android"
GROUP BY sppl.phoneprice_level

-- 20220501
-- ALL
-- income
SELECT sppl.phoneprice_level,
       AVG(t.app_eachmonth_count) AS  avg_all_income_Andorid_20220501
FROM shenzhen_20190501_users_filtered uf  -- 567101人 不用改table
JOIN (SELECT PHA_qui, app_eachmonth_count
      FROM shenzhen_app_use_eachmonth_count_filtered
      WHERE date = 20220501) t ON t.PHA_qui = uf.PHA_qui -- All count 要改date
JOIN shenzhen_people_phoneprice_10monthavg_level sppl ON sppl.PHA_qui = uf.PHA_qui -- income level 每个人只有一条记录
JOIN shenzhen_phonesystem_ifios spi ON spi.PHA_qui = uf.PHA_qui -- phone system
WHERE spi.date = 20220501
AND spi.phonesystem = "Android"
GROUP BY sppl.phoneprice_level


-- 20221101
-- ALL
-- income
SELECT sppl.phoneprice_level,
       AVG(t.app_eachmonth_count) AS  avg_all_income_Andorid_20221101
FROM shenzhen_20190501_users_filtered uf  -- 567101人 不用改table
JOIN (SELECT PHA_qui, app_eachmonth_count
      FROM shenzhen_app_use_eachmonth_count_filtered
      WHERE date = 20221101) t ON t.PHA_qui = uf.PHA_qui -- All count 要改date
JOIN shenzhen_people_phoneprice_10monthavg_level sppl ON sppl.PHA_qui = uf.PHA_qui -- income level 每个人只有一条记录
JOIN shenzhen_phonesystem_ifios spi ON spi.PHA_qui = uf.PHA_qui -- phone system
WHERE spi.date = 20221101
AND spi.phonesystem = "Android"
GROUP BY sppl.phoneprice_level


-- 20230501
-- ALL
-- income
SELECT sppl.phoneprice_level,
       AVG(t.app_eachmonth_count) AS  avg_all_income_Andorid_20230501
FROM shenzhen_20190501_users_filtered uf  -- 567101人 不用改table
JOIN (SELECT PHA_qui, app_eachmonth_count
      FROM shenzhen_app_use_eachmonth_count_filtered
      WHERE date = 20230501) t ON t.PHA_qui = uf.PHA_qui -- All count 要改date
JOIN shenzhen_people_phoneprice_10monthavg_level sppl ON sppl.PHA_qui = uf.PHA_qui -- income level 每个人只有一条记录
JOIN shenzhen_phonesystem_ifios spi ON spi.PHA_qui = uf.PHA_qui -- phone system
WHERE spi.date = 20230501
AND spi.phonesystem = "Android"
GROUP BY sppl.phoneprice_level

-- 20231101
-- ALL
-- income
SELECT sppl.phoneprice_level,
       AVG(t.app_eachmonth_count) AS  avg_all_income_Andorid_20231101
FROM shenzhen_20190501_users_filtered uf  -- 567101人 不用改table
JOIN (SELECT PHA_qui, app_eachmonth_count
      FROM shenzhen_app_use_eachmonth_count_filtered
      WHERE date = 20231101) t ON t.PHA_qui = uf.PHA_qui -- All count 要改date
JOIN shenzhen_people_phoneprice_10monthavg_level sppl ON sppl.PHA_qui = uf.PHA_qui -- income level 每个人只有一条记录
JOIN shenzhen_phonesystem_ifios spi ON spi.PHA_qui = uf.PHA_qui -- phone system
WHERE spi.date = 20231101
AND spi.phonesystem = "Android"
GROUP BY sppl.phoneprice_level





-- SI4

-- usernum system

SELECT spi.date,
       phonesystem,
       COUNT(*) as system_usernum
FROM shenzhen_people_phoneprice_10monthavg_level sppl -- income level 每个人只有一条记录
JOIN shenzhen_phonesystem_ifios spi ON spi.PHA_qui = sppl.PHA_qui -- phone system
GROUP BY spi.date, phonesystem







-- SI 6

-- usernum of each PHA at each time point
-- 20190501
SELECT t.lcode,
       COUNT(*) AS use_num20190501
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
GROUP BY t.lcode


-- 20191101
SELECT t.lcode,
       COUNT(*) AS use_num20191101
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
GROUP BY t.lcode



-- 20200501
SELECT t.lcode,
       COUNT(*) AS use_num20200501
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
GROUP BY t.lcode


-- 20201101
SELECT t.lcode,
       COUNT(*) AS use_num20201101
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
GROUP BY t.lcode



-- 20210501
SELECT t.lcode,
       COUNT(*) AS use_num20210501
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
GROUP BY t.lcode


-- 20211101
SELECT t.lcode,
       COUNT(*) AS use_num20211101
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
GROUP BY t.lcode



-- 20220501
SELECT t.lcode,
       COUNT(*) AS use_num20220501
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
GROUP BY t.lcode


-- 20221101
SELECT t.lcode,
       COUNT(*) AS use_num20221101
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
GROUP BY t.lcode



-- 20230501
SELECT t.lcode,
       COUNT(*) AS use_num20230501
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
GROUP BY t.lcode


-- 20231101
SELECT t.lcode,
       COUNT(*) AS use_num20231101
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
GROUP BY t.lcode





-- F5

-- newly other App

-- 20191101_newly_other_App age
-- 20191101
SELECT
    saup.date,
    so.lcode,
    spf.age,
    COUNT(*) as 20191101_newly_other_App_user_num20191101
FROM shenzhen_app_use_people_10month saup  -- APP use
JOIN shenzhen_otherapp_createtime so ON saup.lcode = so.lcode  -- 20191101 newly other APP 
JOIN shenzhen_app_use_filtered suf ON suf.PHA_qui = saup.PHA_qui -- population
JOIN shenzhen_people_filtered spf ON spf.PHA_qui = suf.PHA_qui -- demographic
WHERE so.createdtime = 20191101  -- 20191101 newly other APP 
AND saup.date = 20191101
AND spf.date = 20191101
GROUP BY saup.date, so.lcode, spf.age


-- 20200501
SELECT
    saup.date,
    so.lcode,
    spf.age,
    COUNT(*) as 20191101_newly_other_App_user_num20200501
FROM shenzhen_app_use_people_10month saup  -- APP use
JOIN shenzhen_otherapp_createtime so ON saup.lcode = so.lcode  -- 20191101 newly other APP 
JOIN shenzhen_app_use_filtered suf ON suf.PHA_qui = saup.PHA_qui -- population
JOIN shenzhen_people_filtered spf ON spf.PHA_qui = suf.PHA_qui -- demographic
WHERE so.createdtime = 20191101  -- 20191101 newly other APP 
AND saup.date = 20200501
AND spf.date = 20200501
GROUP BY saup.date, so.lcode, spf.age


-- 20201101
SELECT
    saup.date,
    so.lcode,
    spf.age,
    COUNT(*) as 20191101_newly_other_App_user_num20201101
FROM shenzhen_app_use_people_10month saup  -- APP use
JOIN shenzhen_otherapp_createtime so ON saup.lcode = so.lcode  -- 20191101 newly other APP 
JOIN shenzhen_app_use_filtered suf ON suf.PHA_qui = saup.PHA_qui -- population
JOIN shenzhen_people_filtered spf ON spf.PHA_qui = suf.PHA_qui -- demographic
WHERE so.createdtime = 20191101  -- 20191101 newly other APP 
AND saup.date = 20201101
AND spf.date = 20201101
GROUP BY saup.date, so.lcode, spf.age


-- 20210501
SELECT
    saup.date,
    so.lcode,
    spf.age,
    COUNT(*) as 20191101_newly_other_App_user_num20210501
FROM shenzhen_app_use_people_10month saup  -- APP use
JOIN shenzhen_otherapp_createtime so ON saup.lcode = so.lcode  -- 20191101 newly other APP 
JOIN shenzhen_app_use_filtered suf ON suf.PHA_qui = saup.PHA_qui -- population
JOIN shenzhen_people_filtered spf ON spf.PHA_qui = suf.PHA_qui -- demographic
WHERE so.createdtime = 20191101  -- 20191101 newly other APP 
AND saup.date = 20210501
AND spf.date = 20210501
GROUP BY saup.date, so.lcode, spf.age


-- 20211101
SELECT
    saup.date,
    so.lcode,
    spf.age,
    COUNT(*) as 20191101_newly_other_App_user_num20211101
FROM shenzhen_app_use_people_10month saup  -- APP use
JOIN shenzhen_otherapp_createtime so ON saup.lcode = so.lcode  -- 20191101 newly other APP 
JOIN shenzhen_app_use_filtered suf ON suf.PHA_qui = saup.PHA_qui -- population
JOIN shenzhen_people_filtered spf ON spf.PHA_qui = suf.PHA_qui -- demographic
WHERE so.createdtime = 20191101  -- 20191101 newly other APP 
AND saup.date = 20211101
AND spf.date = 20211101
GROUP BY saup.date, so.lcode, spf.age


-- 20220501
SELECT
    saup.date,
    so.lcode,
    spf.age,
    COUNT(*) as 20191101_newly_other_App_user_num20220501
FROM shenzhen_app_use_people_10month saup  -- APP use
JOIN shenzhen_otherapp_createtime so ON saup.lcode = so.lcode  -- 20191101 newly other APP 
JOIN shenzhen_app_use_filtered suf ON suf.PHA_qui = saup.PHA_qui -- population
JOIN shenzhen_people_filtered spf ON spf.PHA_qui = suf.PHA_qui -- demographic
WHERE so.createdtime = 20191101  -- 20191101 newly other APP 
AND saup.date = 20220501
AND spf.date = 20220501
GROUP BY saup.date, so.lcode, spf.age


-- 20221101
SELECT
    saup.date,
    so.lcode,
    spf.age,
    COUNT(*) as 20191101_newly_other_App_user_num20221101
FROM shenzhen_app_use_people_10month saup  -- APP use
JOIN shenzhen_otherapp_createtime so ON saup.lcode = so.lcode  -- 20191101 newly other APP 
JOIN shenzhen_app_use_filtered suf ON suf.PHA_qui = saup.PHA_qui -- population
JOIN shenzhen_people_filtered spf ON spf.PHA_qui = suf.PHA_qui -- demographic
WHERE so.createdtime = 20191101  -- 20191101 newly other APP 
AND saup.date = 20221101
AND spf.date = 20221101
GROUP BY saup.date, so.lcode, spf.age


-- 20230501
SELECT
    saup.date,
    so.lcode,
    spf.age,
    COUNT(*) as 20191101_newly_other_App_user_num20230501
FROM shenzhen_app_use_people_10month saup  -- APP use
JOIN shenzhen_otherapp_createtime so ON saup.lcode = so.lcode  -- 20191101 newly other APP 
JOIN shenzhen_app_use_filtered suf ON suf.PHA_qui = saup.PHA_qui -- population
JOIN shenzhen_people_filtered spf ON spf.PHA_qui = suf.PHA_qui -- demographic
WHERE so.createdtime = 20191101  -- 20191101 newly other APP 
AND saup.date = 20230501
AND spf.date = 20230501
GROUP BY saup.date, so.lcode, spf.age


-- 20231101
SELECT
    saup.date,
    so.lcode,
    spf.age,
    COUNT(*) as 20191101_newly_other_App_user_num20231101
FROM shenzhen_app_use_people_10month saup  -- APP use
JOIN shenzhen_otherapp_createtime so ON saup.lcode = so.lcode  -- 20191101 newly other APP 
JOIN shenzhen_app_use_filtered suf ON suf.PHA_qui = saup.PHA_qui -- population
JOIN shenzhen_people_filtered spf ON spf.PHA_qui = suf.PHA_qui -- demographic
WHERE so.createdtime = 20191101  -- 20191101 newly other APP 
AND saup.date = 20231101
AND spf.date = 20231101
GROUP BY saup.date, so.lcode, spf.age








-- 20191101_newly_other_App gender
-- 20191101
SELECT
    saup.date,
    so.lcode,
    spf.gender,
    COUNT(*) as 20191101_newly_other_App_user_num20191101
FROM shenzhen_app_use_people_10month saup  -- APP use
JOIN shenzhen_otherapp_createtime so ON saup.lcode = so.lcode  -- 20191101 newly other APP 
JOIN shenzhen_app_use_filtered suf ON suf.PHA_qui = saup.PHA_qui -- population
JOIN shenzhen_people_filtered spf ON spf.PHA_qui = suf.PHA_qui -- demographic
WHERE so.createdtime = 20191101  -- 20191101 newly other APP 
AND saup.date = 20191101
AND spf.date = 20191101
GROUP BY saup.date, so.lcode, spf.gender


-- 20200501
SELECT
    saup.date,
    so.lcode,
    spf.gender,
    COUNT(*) as 20191101_newly_other_App_user_num20200501
FROM shenzhen_app_use_people_10month saup  -- APP use
JOIN shenzhen_otherapp_createtime so ON saup.lcode = so.lcode  -- 20191101 newly other APP 
JOIN shenzhen_app_use_filtered suf ON suf.PHA_qui = saup.PHA_qui -- population
JOIN shenzhen_people_filtered spf ON spf.PHA_qui = suf.PHA_qui -- demographic
WHERE so.createdtime = 20191101  -- 20191101 newly other APP 
AND saup.date = 20200501
AND spf.date = 20200501
GROUP BY saup.date, so.lcode, spf.gender


-- 20201101
SELECT
    saup.date,
    so.lcode,
    spf.gender,
    COUNT(*) as 20191101_newly_other_App_user_num20201101
FROM shenzhen_app_use_people_10month saup  -- APP use
JOIN shenzhen_otherapp_createtime so ON saup.lcode = so.lcode  -- 20191101 newly other APP 
JOIN shenzhen_app_use_filtered suf ON suf.PHA_qui = saup.PHA_qui -- population
JOIN shenzhen_people_filtered spf ON spf.PHA_qui = suf.PHA_qui -- demographic
WHERE so.createdtime = 20191101  -- 20191101 newly other APP 
AND saup.date = 20201101
AND spf.date = 20201101
GROUP BY saup.date, so.lcode, spf.gender


-- 20210501
SELECT
    saup.date,
    so.lcode,
    spf.gender,
    COUNT(*) as 20191101_newly_other_App_user_num20210501
FROM shenzhen_app_use_people_10month saup  -- APP use
JOIN shenzhen_otherapp_createtime so ON saup.lcode = so.lcode  -- 20191101 newly other APP 
JOIN shenzhen_app_use_filtered suf ON suf.PHA_qui = saup.PHA_qui -- population
JOIN shenzhen_people_filtered spf ON spf.PHA_qui = suf.PHA_qui -- demographic
WHERE so.createdtime = 20191101  -- 20191101 newly other APP 
AND saup.date = 20210501
AND spf.date = 20210501
GROUP BY saup.date, so.lcode, spf.gender


-- 20211101
SELECT
    saup.date,
    so.lcode,
    spf.gender,
    COUNT(*) as 20191101_newly_other_App_user_num20211101
FROM shenzhen_app_use_people_10month saup  -- APP use
JOIN shenzhen_otherapp_createtime so ON saup.lcode = so.lcode  -- 20191101 newly other APP 
JOIN shenzhen_app_use_filtered suf ON suf.PHA_qui = saup.PHA_qui -- population
JOIN shenzhen_people_filtered spf ON spf.PHA_qui = suf.PHA_qui -- demographic
WHERE so.createdtime = 20191101  -- 20191101 newly other APP 
AND saup.date = 20211101
AND spf.date = 20211101
GROUP BY saup.date, so.lcode, spf.gender


-- 20220501
SELECT
    saup.date,
    so.lcode,
    spf.gender,
    COUNT(*) as 20191101_newly_other_App_user_num20220501
FROM shenzhen_app_use_people_10month saup  -- APP use
JOIN shenzhen_otherapp_createtime so ON saup.lcode = so.lcode  -- 20191101 newly other APP 
JOIN shenzhen_app_use_filtered suf ON suf.PHA_qui = saup.PHA_qui -- population
JOIN shenzhen_people_filtered spf ON spf.PHA_qui = suf.PHA_qui -- demographic
WHERE so.createdtime = 20191101  -- 20191101 newly other APP 
AND saup.date = 20220501
AND spf.date = 20220501
GROUP BY saup.date, so.lcode, spf.gender


-- 20221101
SELECT
    saup.date,
    so.lcode,
    spf.gender,
    COUNT(*) as 20191101_newly_other_App_user_num20221101
FROM shenzhen_app_use_people_10month saup  -- APP use
JOIN shenzhen_otherapp_createtime so ON saup.lcode = so.lcode  -- 20191101 newly other APP 
JOIN shenzhen_app_use_filtered suf ON suf.PHA_qui = saup.PHA_qui -- population
JOIN shenzhen_people_filtered spf ON spf.PHA_qui = suf.PHA_qui -- demographic
WHERE so.createdtime = 20191101  -- 20191101 newly other APP 
AND saup.date = 20221101
AND spf.date = 20221101
GROUP BY saup.date, so.lcode, spf.gender


-- 20230501
SELECT
    saup.date,
    so.lcode,
    spf.gender,
    COUNT(*) as 20191101_newly_other_App_user_num20230501
FROM shenzhen_app_use_people_10month saup  -- APP use
JOIN shenzhen_otherapp_createtime so ON saup.lcode = so.lcode  -- 20191101 newly other APP 
JOIN shenzhen_app_use_filtered suf ON suf.PHA_qui = saup.PHA_qui -- population
JOIN shenzhen_people_filtered spf ON spf.PHA_qui = suf.PHA_qui -- demographic
WHERE so.createdtime = 20191101  -- 20191101 newly other APP 
AND saup.date = 20230501
AND spf.date = 20230501
GROUP BY saup.date, so.lcode, spf.gender


-- 20231101
SELECT
    saup.date,
    so.lcode,
    spf.gender,
    COUNT(*) as 20191101_newly_other_App_user_num20231101
FROM shenzhen_app_use_people_10month saup  -- APP use
JOIN shenzhen_otherapp_createtime so ON saup.lcode = so.lcode  -- 20191101 newly other APP 
JOIN shenzhen_app_use_filtered suf ON suf.PHA_qui = saup.PHA_qui -- population
JOIN shenzhen_people_filtered spf ON spf.PHA_qui = suf.PHA_qui -- demographic
WHERE so.createdtime = 20191101  -- 20191101 newly other APP 
AND saup.date = 20231101
AND spf.date = 20231101
GROUP BY saup.date, so.lcode, spf.gender










-- 20191101_newly_other_App income
-- 20191101
SELECT
    saup.date,
    so.lcode,
    sppl.phoneprice_level,
    COUNT(*) as 20191101_newly_other_App_user_num20191101
FROM shenzhen_app_use_people_10month saup  -- APP use
JOIN shenzhen_otherapp_createtime so ON saup.lcode = so.lcode  -- 20191101 newly other APP 
JOIN shenzhen_app_use_filtered suf ON suf.PHA_qui = saup.PHA_qui -- population
JOIN shenzhen_people_filtered spf ON spf.PHA_qui = suf.PHA_qui -- demographic
JOIN shenzhen_people_phoneprice_10monthavg_level sppl ON sppl.PHA_qui = saup.PHA_qui -- phone price level
WHERE so.createdtime = 20191101  -- 20191101 newly other APP 
AND saup.date = 20191101
AND spf.date = 20191101
GROUP BY saup.date, so.lcode, sppl.phoneprice_level


-- 20200501
SELECT
    saup.date,
    so.lcode,
    sppl.phoneprice_level,
    COUNT(*) as 20191101_newly_other_App_user_num20200501
FROM shenzhen_app_use_people_10month saup  -- APP use
JOIN shenzhen_otherapp_createtime so ON saup.lcode = so.lcode  -- 20191101 newly other APP 
JOIN shenzhen_app_use_filtered suf ON suf.PHA_qui = saup.PHA_qui -- population
JOIN shenzhen_people_filtered spf ON spf.PHA_qui = suf.PHA_qui -- demographic
JOIN shenzhen_people_phoneprice_10monthavg_level sppl ON sppl.PHA_qui = saup.PHA_qui -- phone price level
WHERE so.createdtime = 20191101  -- 20191101 newly other APP 
AND saup.date = 20200501
AND spf.date = 20200501
GROUP BY saup.date, so.lcode, sppl.phoneprice_level


-- 20201101
SELECT
    saup.date,
    so.lcode,
    sppl.phoneprice_level,
    COUNT(*) as 20191101_newly_other_App_user_num20201101
FROM shenzhen_app_use_people_10month saup  -- APP use
JOIN shenzhen_otherapp_createtime so ON saup.lcode = so.lcode  -- 20191101 newly other APP 
JOIN shenzhen_app_use_filtered suf ON suf.PHA_qui = saup.PHA_qui -- population
JOIN shenzhen_people_filtered spf ON spf.PHA_qui = suf.PHA_qui -- demographic
JOIN shenzhen_people_phoneprice_10monthavg_level sppl ON sppl.PHA_qui = saup.PHA_qui -- phone price level
WHERE so.createdtime = 20191101  -- 20191101 newly other APP 
AND saup.date = 20201101
AND spf.date = 20201101
GROUP BY saup.date, so.lcode, sppl.phoneprice_level


-- 20210501
SELECT
    saup.date,
    so.lcode,
    sppl.phoneprice_level,
    COUNT(*) as 20191101_newly_other_App_user_num20210501
FROM shenzhen_app_use_people_10month saup  -- APP use
JOIN shenzhen_otherapp_createtime so ON saup.lcode = so.lcode  -- 20191101 newly other APP 
JOIN shenzhen_app_use_filtered suf ON suf.PHA_qui = saup.PHA_qui -- population
JOIN shenzhen_people_filtered spf ON spf.PHA_qui = suf.PHA_qui -- demographic
JOIN shenzhen_people_phoneprice_10monthavg_level sppl ON sppl.PHA_qui = saup.PHA_qui -- phone price level
WHERE so.createdtime = 20191101  -- 20191101 newly other APP 
AND saup.date = 20210501
AND spf.date = 20210501
GROUP BY saup.date, so.lcode, sppl.phoneprice_level


-- 20211101
SELECT
    saup.date,
    so.lcode,
    sppl.phoneprice_level,
    COUNT(*) as 20191101_newly_other_App_user_num20211101
FROM shenzhen_app_use_people_10month saup  -- APP use
JOIN shenzhen_otherapp_createtime so ON saup.lcode = so.lcode  -- 20191101 newly other APP 
JOIN shenzhen_app_use_filtered suf ON suf.PHA_qui = saup.PHA_qui -- population
JOIN shenzhen_people_filtered spf ON spf.PHA_qui = suf.PHA_qui -- demographic
JOIN shenzhen_people_phoneprice_10monthavg_level sppl ON sppl.PHA_qui = saup.PHA_qui -- phone price level
WHERE so.createdtime = 20191101  -- 20191101 newly other APP 
AND saup.date = 20211101
AND spf.date = 20211101
GROUP BY saup.date, so.lcode, sppl.phoneprice_level




-- 20220501
SELECT
    saup.date,
    so.lcode,
    sppl.phoneprice_level,
    COUNT(*) as 20191101_newly_other_App_user_num20220501
FROM shenzhen_app_use_people_10month saup  -- APP use
JOIN shenzhen_otherapp_createtime so ON saup.lcode = so.lcode  -- 20191101 newly other APP 
JOIN shenzhen_app_use_filtered suf ON suf.PHA_qui = saup.PHA_qui -- population
JOIN shenzhen_people_filtered spf ON spf.PHA_qui = suf.PHA_qui -- demographic
JOIN shenzhen_people_phoneprice_10monthavg_level sppl ON sppl.PHA_qui = saup.PHA_qui -- phone price level
WHERE so.createdtime = 20191101  -- 20191101 newly other APP 
AND saup.date = 20220501
AND spf.date = 20220501
GROUP BY saup.date, so.lcode, sppl.phoneprice_level




-- 20221101
SELECT
    saup.date,
    so.lcode,
    sppl.phoneprice_level,
    COUNT(*) as 20191101_newly_other_App_user_num20221101
FROM shenzhen_app_use_people_10month saup  -- APP use
JOIN shenzhen_otherapp_createtime so ON saup.lcode = so.lcode  -- 20191101 newly other APP 
JOIN shenzhen_app_use_filtered suf ON suf.PHA_qui = saup.PHA_qui -- population
JOIN shenzhen_people_filtered spf ON spf.PHA_qui = suf.PHA_qui -- demographic
JOIN shenzhen_people_phoneprice_10monthavg_level sppl ON sppl.PHA_qui = saup.PHA_qui -- phone price level
WHERE so.createdtime = 20191101  -- 20191101 newly other APP 
AND saup.date = 20221101
AND spf.date = 20221101
GROUP BY saup.date, so.lcode, sppl.phoneprice_level




-- 20230501
SELECT
    saup.date,
    so.lcode,
    sppl.phoneprice_level,
    COUNT(*) as 20191101_newly_other_App_user_num20230501
FROM shenzhen_app_use_people_10month saup  -- APP use
JOIN shenzhen_otherapp_createtime so ON saup.lcode = so.lcode  -- 20191101 newly other APP 
JOIN shenzhen_app_use_filtered suf ON suf.PHA_qui = saup.PHA_qui -- population
JOIN shenzhen_people_filtered spf ON spf.PHA_qui = suf.PHA_qui -- demographic
JOIN shenzhen_people_phoneprice_10monthavg_level sppl ON sppl.PHA_qui = saup.PHA_qui -- phone price level
WHERE so.createdtime = 20191101  -- 20191101 newly other APP 
AND saup.date = 20230501
AND spf.date = 20230501
GROUP BY saup.date, so.lcode, sppl.phoneprice_level



-- 20231101
SELECT
    saup.date,
    so.lcode,
    sppl.phoneprice_level,
    COUNT(*) as 20191101_newly_other_App_user_num20231101
FROM shenzhen_app_use_people_10month saup  -- APP use
JOIN shenzhen_otherapp_createtime so ON saup.lcode = so.lcode  -- 20191101 newly other APP 
JOIN shenzhen_app_use_filtered suf ON suf.PHA_qui = saup.PHA_qui -- population
JOIN shenzhen_people_filtered spf ON spf.PHA_qui = suf.PHA_qui -- demographic
JOIN shenzhen_people_phoneprice_10monthavg_level sppl ON sppl.PHA_qui = saup.PHA_qui -- phone price level
WHERE so.createdtime = 20191101  -- 20191101 newly other APP 
AND saup.date = 20231101
AND spf.date = 20231101
GROUP BY saup.date, so.lcode, sppl.phoneprice_level










-- 20200501_newly_other_App age
-- 20200501
SELECT
    saup.date,
    so.lcode,
    spf.age,
    COUNT(*) as 20200501_newly_other_App_user_num20200501
FROM shenzhen_app_use_people_10month saup  -- APP use
JOIN shenzhen_otherapp_createtime so ON saup.lcode = so.lcode  -- 20200501 newly other APP 
JOIN shenzhen_app_use_filtered suf ON suf.PHA_qui = saup.PHA_qui -- population
JOIN shenzhen_people_filtered spf ON spf.PHA_qui = suf.PHA_qui -- demographic
WHERE so.createdtime = 20200501  -- 20200501 newly other APP 
AND saup.date = 20200501
AND spf.date = 20200501
GROUP BY saup.date, so.lcode, spf.age


-- 20201101
SELECT
    saup.date,
    so.lcode,
    spf.age,
    COUNT(*) as 20200501_newly_other_App_user_num20201101
FROM shenzhen_app_use_people_10month saup  -- APP use
JOIN shenzhen_otherapp_createtime so ON saup.lcode = so.lcode  -- 20200501 newly other APP 
JOIN shenzhen_app_use_filtered suf ON suf.PHA_qui = saup.PHA_qui -- population
JOIN shenzhen_people_filtered spf ON spf.PHA_qui = suf.PHA_qui -- demographic
WHERE so.createdtime = 20200501  -- 20200501 newly other APP 
AND saup.date = 20201101
AND spf.date = 20201101
GROUP BY saup.date, so.lcode, spf.age


-- 20210501
SELECT
    saup.date,
    so.lcode,
    spf.age,
    COUNT(*) as 20200501_newly_other_App_user_num20210501
FROM shenzhen_app_use_people_10month saup  -- APP use
JOIN shenzhen_otherapp_createtime so ON saup.lcode = so.lcode  -- 20200501 newly other APP 
JOIN shenzhen_app_use_filtered suf ON suf.PHA_qui = saup.PHA_qui -- population
JOIN shenzhen_people_filtered spf ON spf.PHA_qui = suf.PHA_qui -- demographic
WHERE so.createdtime = 20200501  -- 20200501 newly other APP 
AND saup.date = 20210501
AND spf.date = 20210501
GROUP BY saup.date, so.lcode, spf.age


-- 20211101
SELECT
    saup.date,
    so.lcode,
    spf.age,
    COUNT(*) as 20200501_newly_other_App_user_num20211101
FROM shenzhen_app_use_people_10month saup  -- APP use
JOIN shenzhen_otherapp_createtime so ON saup.lcode = so.lcode  -- 20200501 newly other APP 
JOIN shenzhen_app_use_filtered suf ON suf.PHA_qui = saup.PHA_qui -- population
JOIN shenzhen_people_filtered spf ON spf.PHA_qui = suf.PHA_qui -- demographic
WHERE so.createdtime = 20200501  -- 20200501 newly other APP 
AND saup.date = 20211101
AND spf.date = 20211101
GROUP BY saup.date, so.lcode, spf.age


-- 20220501
SELECT
    saup.date,
    so.lcode,
    spf.age,
    COUNT(*) as 20200501_newly_other_App_user_num20220501
FROM shenzhen_app_use_people_10month saup  -- APP use
JOIN shenzhen_otherapp_createtime so ON saup.lcode = so.lcode  -- 20200501 newly other APP 
JOIN shenzhen_app_use_filtered suf ON suf.PHA_qui = saup.PHA_qui -- population
JOIN shenzhen_people_filtered spf ON spf.PHA_qui = suf.PHA_qui -- demographic
WHERE so.createdtime = 20200501  -- 20200501 newly other APP 
AND saup.date = 20220501
AND spf.date = 20220501
GROUP BY saup.date, so.lcode, spf.age


-- 20221101
SELECT
    saup.date,
    so.lcode,
    spf.age,
    COUNT(*) as 20200501_newly_other_App_user_num20221101
FROM shenzhen_app_use_people_10month saup  -- APP use
JOIN shenzhen_otherapp_createtime so ON saup.lcode = so.lcode  -- 20200501 newly other APP 
JOIN shenzhen_app_use_filtered suf ON suf.PHA_qui = saup.PHA_qui -- population
JOIN shenzhen_people_filtered spf ON spf.PHA_qui = suf.PHA_qui -- demographic
WHERE so.createdtime = 20200501  -- 20200501 newly other APP 
AND saup.date = 20221101
AND spf.date = 20221101
GROUP BY saup.date, so.lcode, spf.age


-- 20230501
SELECT
    saup.date,
    so.lcode,
    spf.age,
    COUNT(*) as 20200501_newly_other_App_user_num20230501
FROM shenzhen_app_use_people_10month saup  -- APP use
JOIN shenzhen_otherapp_createtime so ON saup.lcode = so.lcode  -- 20200501 newly other APP 
JOIN shenzhen_app_use_filtered suf ON suf.PHA_qui = saup.PHA_qui -- population
JOIN shenzhen_people_filtered spf ON spf.PHA_qui = suf.PHA_qui -- demographic
WHERE so.createdtime = 20200501  -- 20200501 newly other APP 
AND saup.date = 20230501
AND spf.date = 20230501
GROUP BY saup.date, so.lcode, spf.age


-- 20231101
SELECT
    saup.date,
    so.lcode,
    spf.age,
    COUNT(*) as 20200501_newly_other_App_user_num20231101
FROM shenzhen_app_use_people_10month saup  -- APP use
JOIN shenzhen_otherapp_createtime so ON saup.lcode = so.lcode  -- 20200501 newly other APP 
JOIN shenzhen_app_use_filtered suf ON suf.PHA_qui = saup.PHA_qui -- population
JOIN shenzhen_people_filtered spf ON spf.PHA_qui = suf.PHA_qui -- demographic
WHERE so.createdtime = 20200501  -- 20200501 newly other APP 
AND saup.date = 20231101
AND spf.date = 20231101
GROUP BY saup.date, so.lcode, spf.age








-- 20200501_newly_other_App gender
-- 20200501
SELECT
    saup.date,
    so.lcode,
    spf.gender,
    COUNT(*) as 20200501_newly_other_App_user_num20200501
FROM shenzhen_app_use_people_10month saup  -- APP use
JOIN shenzhen_otherapp_createtime so ON saup.lcode = so.lcode  -- 20200501 newly other APP 
JOIN shenzhen_app_use_filtered suf ON suf.PHA_qui = saup.PHA_qui -- population
JOIN shenzhen_people_filtered spf ON spf.PHA_qui = suf.PHA_qui -- demographic
WHERE so.createdtime = 20200501  -- 20200501 newly other APP 
AND saup.date = 20200501
AND spf.date = 20200501
GROUP BY saup.date, so.lcode, spf.gender


-- 20201101
SELECT
    saup.date,
    so.lcode,
    spf.gender,
    COUNT(*) as 20200501_newly_other_App_user_num20201101
FROM shenzhen_app_use_people_10month saup  -- APP use
JOIN shenzhen_otherapp_createtime so ON saup.lcode = so.lcode  -- 20200501 newly other APP 
JOIN shenzhen_app_use_filtered suf ON suf.PHA_qui = saup.PHA_qui -- population
JOIN shenzhen_people_filtered spf ON spf.PHA_qui = suf.PHA_qui -- demographic
WHERE so.createdtime = 20200501  -- 20200501 newly other APP 
AND saup.date = 20201101
AND spf.date = 20201101
GROUP BY saup.date, so.lcode, spf.gender


-- 20210501
SELECT
    saup.date,
    so.lcode,
    spf.gender,
    COUNT(*) as 20200501_newly_other_App_user_num20210501
FROM shenzhen_app_use_people_10month saup  -- APP use
JOIN shenzhen_otherapp_createtime so ON saup.lcode = so.lcode  -- 20200501 newly other APP 
JOIN shenzhen_app_use_filtered suf ON suf.PHA_qui = saup.PHA_qui -- population
JOIN shenzhen_people_filtered spf ON spf.PHA_qui = suf.PHA_qui -- demographic
WHERE so.createdtime = 20200501  -- 20200501 newly other APP 
AND saup.date = 20210501
AND spf.date = 20210501
GROUP BY saup.date, so.lcode, spf.gender


-- 20211101
SELECT
    saup.date,
    so.lcode,
    spf.gender,
    COUNT(*) as 20200501_newly_other_App_user_num20211101
FROM shenzhen_app_use_people_10month saup  -- APP use
JOIN shenzhen_otherapp_createtime so ON saup.lcode = so.lcode  -- 20200501 newly other APP 
JOIN shenzhen_app_use_filtered suf ON suf.PHA_qui = saup.PHA_qui -- population
JOIN shenzhen_people_filtered spf ON spf.PHA_qui = suf.PHA_qui -- demographic
WHERE so.createdtime = 20200501  -- 20200501 newly other APP 
AND saup.date = 20211101
AND spf.date = 20211101
GROUP BY saup.date, so.lcode, spf.gender


-- 20220501
SELECT
    saup.date,
    so.lcode,
    spf.gender,
    COUNT(*) as 20200501_newly_other_App_user_num20220501
FROM shenzhen_app_use_people_10month saup  -- APP use
JOIN shenzhen_otherapp_createtime so ON saup.lcode = so.lcode  -- 20200501 newly other APP 
JOIN shenzhen_app_use_filtered suf ON suf.PHA_qui = saup.PHA_qui -- population
JOIN shenzhen_people_filtered spf ON spf.PHA_qui = suf.PHA_qui -- demographic
WHERE so.createdtime = 20200501  -- 20200501 newly other APP 
AND saup.date = 20220501
AND spf.date = 20220501
GROUP BY saup.date, so.lcode, spf.gender


-- 20221101
SELECT
    saup.date,
    so.lcode,
    spf.gender,
    COUNT(*) as 20200501_newly_other_App_user_num20221101
FROM shenzhen_app_use_people_10month saup  -- APP use
JOIN shenzhen_otherapp_createtime so ON saup.lcode = so.lcode  -- 20200501 newly other APP 
JOIN shenzhen_app_use_filtered suf ON suf.PHA_qui = saup.PHA_qui -- population
JOIN shenzhen_people_filtered spf ON spf.PHA_qui = suf.PHA_qui -- demographic
WHERE so.createdtime = 20200501  -- 20200501 newly other APP 
AND saup.date = 20221101
AND spf.date = 20221101
GROUP BY saup.date, so.lcode, spf.gender


-- 20230501
SELECT
    saup.date,
    so.lcode,
    spf.gender,
    COUNT(*) as 20200501_newly_other_App_user_num20230501
FROM shenzhen_app_use_people_10month saup  -- APP use
JOIN shenzhen_otherapp_createtime so ON saup.lcode = so.lcode  -- 20200501 newly other APP 
JOIN shenzhen_app_use_filtered suf ON suf.PHA_qui = saup.PHA_qui -- population
JOIN shenzhen_people_filtered spf ON spf.PHA_qui = suf.PHA_qui -- demographic
WHERE so.createdtime = 20200501  -- 20200501 newly other APP 
AND saup.date = 20230501
AND spf.date = 20230501
GROUP BY saup.date, so.lcode, spf.gender


-- 20231101
SELECT
    saup.date,
    so.lcode,
    spf.gender,
    COUNT(*) as 20200501_newly_other_App_user_num20231101
FROM shenzhen_app_use_people_10month saup  -- APP use
JOIN shenzhen_otherapp_createtime so ON saup.lcode = so.lcode  -- 20200501 newly other APP 
JOIN shenzhen_app_use_filtered suf ON suf.PHA_qui = saup.PHA_qui -- population
JOIN shenzhen_people_filtered spf ON spf.PHA_qui = suf.PHA_qui -- demographic
WHERE so.createdtime = 20200501  -- 20200501 newly other APP 
AND saup.date = 20231101
AND spf.date = 20231101
GROUP BY saup.date, so.lcode, spf.gender








-- 20200501_newly_other_App income
-- 20200501
SELECT
    saup.date,
    so.lcode,
    sppl.phoneprice_level,
    COUNT(*) as 20200501_newly_other_App_user_num20200501
FROM shenzhen_app_use_people_10month saup  -- APP use
JOIN shenzhen_otherapp_createtime so ON saup.lcode = so.lcode  -- 20200501 newly other APP 
JOIN shenzhen_app_use_filtered suf ON suf.PHA_qui = saup.PHA_qui -- population
JOIN shenzhen_people_filtered spf ON spf.PHA_qui = suf.PHA_qui -- demographic
JOIN shenzhen_people_phoneprice_10monthavg_level sppl ON sppl.PHA_qui = saup.PHA_qui -- phone price level
WHERE so.createdtime = 20200501  -- 20200501 newly other APP 
AND saup.date = 20200501
AND spf.date = 20200501
GROUP BY saup.date, so.lcode, sppl.phoneprice_level


-- 20201101
SELECT
    saup.date,
    so.lcode,
    sppl.phoneprice_level,
    COUNT(*) as 20200501_newly_other_App_user_num20201101
FROM shenzhen_app_use_people_10month saup  -- APP use
JOIN shenzhen_otherapp_createtime so ON saup.lcode = so.lcode  -- 20200501 newly other APP 
JOIN shenzhen_app_use_filtered suf ON suf.PHA_qui = saup.PHA_qui -- population
JOIN shenzhen_people_filtered spf ON spf.PHA_qui = suf.PHA_qui -- demographic
JOIN shenzhen_people_phoneprice_10monthavg_level sppl ON sppl.PHA_qui = saup.PHA_qui -- phone price level
WHERE so.createdtime = 20200501  -- 20200501 newly other APP 
AND saup.date = 20201101
AND spf.date = 20201101
GROUP BY saup.date, so.lcode, sppl.phoneprice_level


-- 20210501
SELECT
    saup.date,
    so.lcode,
    sppl.phoneprice_level,
    COUNT(*) as 20200501_newly_other_App_user_num20210501
FROM shenzhen_app_use_people_10month saup  -- APP use
JOIN shenzhen_otherapp_createtime so ON saup.lcode = so.lcode  -- 20200501 newly other APP 
JOIN shenzhen_app_use_filtered suf ON suf.PHA_qui = saup.PHA_qui -- population
JOIN shenzhen_people_filtered spf ON spf.PHA_qui = suf.PHA_qui -- demographic
JOIN shenzhen_people_phoneprice_10monthavg_level sppl ON sppl.PHA_qui = saup.PHA_qui -- phone price level
WHERE so.createdtime = 20200501  -- 20200501 newly other APP 
AND saup.date = 20210501
AND spf.date = 20210501
GROUP BY saup.date, so.lcode, sppl.phoneprice_level


-- 20211101
SELECT
    saup.date,
    so.lcode,
    sppl.phoneprice_level,
    COUNT(*) as 20200501_newly_other_App_user_num20211101
FROM shenzhen_app_use_people_10month saup  -- APP use
JOIN shenzhen_otherapp_createtime so ON saup.lcode = so.lcode  -- 20200501 newly other APP 
JOIN shenzhen_app_use_filtered suf ON suf.PHA_qui = saup.PHA_qui -- population
JOIN shenzhen_people_filtered spf ON spf.PHA_qui = suf.PHA_qui -- demographic
JOIN shenzhen_people_phoneprice_10monthavg_level sppl ON sppl.PHA_qui = saup.PHA_qui -- phone price level
WHERE so.createdtime = 20200501  -- 20200501 newly other APP 
AND saup.date = 20211101
AND spf.date = 20211101
GROUP BY saup.date, so.lcode, sppl.phoneprice_level




-- 20220501
SELECT
    saup.date,
    so.lcode,
    sppl.phoneprice_level,
    COUNT(*) as 20200501_newly_other_App_user_num20220501
FROM shenzhen_app_use_people_10month saup  -- APP use
JOIN shenzhen_otherapp_createtime so ON saup.lcode = so.lcode  -- 20200501 newly other APP 
JOIN shenzhen_app_use_filtered suf ON suf.PHA_qui = saup.PHA_qui -- population
JOIN shenzhen_people_filtered spf ON spf.PHA_qui = suf.PHA_qui -- demographic
JOIN shenzhen_people_phoneprice_10monthavg_level sppl ON sppl.PHA_qui = saup.PHA_qui -- phone price level
WHERE so.createdtime = 20200501  -- 20200501 newly other APP 
AND saup.date = 20220501
AND spf.date = 20220501
GROUP BY saup.date, so.lcode, sppl.phoneprice_level




-- 20221101
SELECT
    saup.date,
    so.lcode,
    sppl.phoneprice_level,
    COUNT(*) as 20200501_newly_other_App_user_num20221101
FROM shenzhen_app_use_people_10month saup  -- APP use
JOIN shenzhen_otherapp_createtime so ON saup.lcode = so.lcode  -- 20200501 newly other APP 
JOIN shenzhen_app_use_filtered suf ON suf.PHA_qui = saup.PHA_qui -- population
JOIN shenzhen_people_filtered spf ON spf.PHA_qui = suf.PHA_qui -- demographic
JOIN shenzhen_people_phoneprice_10monthavg_level sppl ON sppl.PHA_qui = saup.PHA_qui -- phone price level
WHERE so.createdtime = 20200501  -- 20200501 newly other APP 
AND saup.date = 20221101
AND spf.date = 20221101
GROUP BY saup.date, so.lcode, sppl.phoneprice_level




-- 20230501
SELECT
    saup.date,
    so.lcode,
    sppl.phoneprice_level,
    COUNT(*) as 20200501_newly_other_App_user_num20230501
FROM shenzhen_app_use_people_10month saup  -- APP use
JOIN shenzhen_otherapp_createtime so ON saup.lcode = so.lcode  -- 20200501 newly other APP 
JOIN shenzhen_app_use_filtered suf ON suf.PHA_qui = saup.PHA_qui -- population
JOIN shenzhen_people_filtered spf ON spf.PHA_qui = suf.PHA_qui -- demographic
JOIN shenzhen_people_phoneprice_10monthavg_level sppl ON sppl.PHA_qui = saup.PHA_qui -- phone price level
WHERE so.createdtime = 20200501  -- 20200501 newly other APP 
AND saup.date = 20230501
AND spf.date = 20230501
GROUP BY saup.date, so.lcode, sppl.phoneprice_level



-- 20231101
SELECT
    saup.date,
    so.lcode,
    sppl.phoneprice_level,
    COUNT(*) as 20200501_newly_other_App_user_num20231101
FROM shenzhen_app_use_people_10month saup  -- APP use
JOIN shenzhen_otherapp_createtime so ON saup.lcode = so.lcode  -- 20200501 newly other APP 
JOIN shenzhen_app_use_filtered suf ON suf.PHA_qui = saup.PHA_qui -- population
JOIN shenzhen_people_filtered spf ON spf.PHA_qui = suf.PHA_qui -- demographic
JOIN shenzhen_people_phoneprice_10monthavg_level sppl ON sppl.PHA_qui = saup.PHA_qui -- phone price level
WHERE so.createdtime = 20200501  -- 20200501 newly other APP 
AND saup.date = 20231101
AND spf.date = 20231101
GROUP BY saup.date, so.lcode, sppl.phoneprice_level












-- 20201101_newly_other_App age
-- 20201101
SELECT
    saup.date,
    so.lcode,
    spf.age,
    COUNT(*) as 20201101_newly_other_App_user_num20201101
FROM shenzhen_app_use_people_10month saup  -- APP use
JOIN shenzhen_otherapp_createtime so ON saup.lcode = so.lcode  -- 20201101 newly other APP 
JOIN shenzhen_app_use_filtered suf ON suf.PHA_qui = saup.PHA_qui -- population
JOIN shenzhen_people_filtered spf ON spf.PHA_qui = suf.PHA_qui -- demographic
WHERE so.createdtime = 20201101  -- 20201101 newly other APP 
AND saup.date = 20201101
AND spf.date = 20201101
GROUP BY saup.date, so.lcode, spf.age


-- 20210501
SELECT
    saup.date,
    so.lcode,
    spf.age,
    COUNT(*) as 20201101_newly_other_App_user_num20210501
FROM shenzhen_app_use_people_10month saup  -- APP use
JOIN shenzhen_otherapp_createtime so ON saup.lcode = so.lcode  -- 20201101 newly other APP 
JOIN shenzhen_app_use_filtered suf ON suf.PHA_qui = saup.PHA_qui -- population
JOIN shenzhen_people_filtered spf ON spf.PHA_qui = suf.PHA_qui -- demographic
WHERE so.createdtime = 20201101  -- 20201101 newly other APP 
AND saup.date = 20210501
AND spf.date = 20210501
GROUP BY saup.date, so.lcode, spf.age


-- 20211101
SELECT
    saup.date,
    so.lcode,
    spf.age,
    COUNT(*) as 20201101_newly_other_App_user_num20211101
FROM shenzhen_app_use_people_10month saup  -- APP use
JOIN shenzhen_otherapp_createtime so ON saup.lcode = so.lcode  -- 20201101 newly other APP 
JOIN shenzhen_app_use_filtered suf ON suf.PHA_qui = saup.PHA_qui -- population
JOIN shenzhen_people_filtered spf ON spf.PHA_qui = suf.PHA_qui -- demographic
WHERE so.createdtime = 20201101  -- 20201101 newly other APP 
AND saup.date = 20211101
AND spf.date = 20211101
GROUP BY saup.date, so.lcode, spf.age


-- 20220501
SELECT
    saup.date,
    so.lcode,
    spf.age,
    COUNT(*) as 20201101_newly_other_App_user_num20220501
FROM shenzhen_app_use_people_10month saup  -- APP use
JOIN shenzhen_otherapp_createtime so ON saup.lcode = so.lcode  -- 20201101 newly other APP 
JOIN shenzhen_app_use_filtered suf ON suf.PHA_qui = saup.PHA_qui -- population
JOIN shenzhen_people_filtered spf ON spf.PHA_qui = suf.PHA_qui -- demographic
WHERE so.createdtime = 20201101  -- 20201101 newly other APP 
AND saup.date = 20220501
AND spf.date = 20220501
GROUP BY saup.date, so.lcode, spf.age


-- 20221101
SELECT
    saup.date,
    so.lcode,
    spf.age,
    COUNT(*) as 20201101_newly_other_App_user_num20221101
FROM shenzhen_app_use_people_10month saup  -- APP use
JOIN shenzhen_otherapp_createtime so ON saup.lcode = so.lcode  -- 20201101 newly other APP 
JOIN shenzhen_app_use_filtered suf ON suf.PHA_qui = saup.PHA_qui -- population
JOIN shenzhen_people_filtered spf ON spf.PHA_qui = suf.PHA_qui -- demographic
WHERE so.createdtime = 20201101  -- 20201101 newly other APP 
AND saup.date = 20221101
AND spf.date = 20221101
GROUP BY saup.date, so.lcode, spf.age


-- 20230501
SELECT
    saup.date,
    so.lcode,
    spf.age,
    COUNT(*) as 20201101_newly_other_App_user_num20230501
FROM shenzhen_app_use_people_10month saup  -- APP use
JOIN shenzhen_otherapp_createtime so ON saup.lcode = so.lcode  -- 20201101 newly other APP 
JOIN shenzhen_app_use_filtered suf ON suf.PHA_qui = saup.PHA_qui -- population
JOIN shenzhen_people_filtered spf ON spf.PHA_qui = suf.PHA_qui -- demographic
WHERE so.createdtime = 20201101  -- 20201101 newly other APP 
AND saup.date = 20230501
AND spf.date = 20230501
GROUP BY saup.date, so.lcode, spf.age


-- 20231101
SELECT
    saup.date,
    so.lcode,
    spf.age,
    COUNT(*) as 20201101_newly_other_App_user_num20231101
FROM shenzhen_app_use_people_10month saup  -- APP use
JOIN shenzhen_otherapp_createtime so ON saup.lcode = so.lcode  -- 20201101 newly other APP 
JOIN shenzhen_app_use_filtered suf ON suf.PHA_qui = saup.PHA_qui -- population
JOIN shenzhen_people_filtered spf ON spf.PHA_qui = suf.PHA_qui -- demographic
WHERE so.createdtime = 20201101  -- 20201101 newly other APP 
AND saup.date = 20231101
AND spf.date = 20231101
GROUP BY saup.date, so.lcode, spf.age








-- 20201101_newly_other_App gender
-- 20201101
SELECT
    saup.date,
    so.lcode,
    spf.gender,
    COUNT(*) as 20201101_newly_other_App_user_num20201101
FROM shenzhen_app_use_people_10month saup  -- APP use
JOIN shenzhen_otherapp_createtime so ON saup.lcode = so.lcode  -- 20201101 newly other APP 
JOIN shenzhen_app_use_filtered suf ON suf.PHA_qui = saup.PHA_qui -- population
JOIN shenzhen_people_filtered spf ON spf.PHA_qui = suf.PHA_qui -- demographic
WHERE so.createdtime = 20201101  -- 20201101 newly other APP 
AND saup.date = 20201101
AND spf.date = 20201101
GROUP BY saup.date, so.lcode, spf.gender


-- 20210501
SELECT
    saup.date,
    so.lcode,
    spf.gender,
    COUNT(*) as 20201101_newly_other_App_user_num20210501
FROM shenzhen_app_use_people_10month saup  -- APP use
JOIN shenzhen_otherapp_createtime so ON saup.lcode = so.lcode  -- 20201101 newly other APP 
JOIN shenzhen_app_use_filtered suf ON suf.PHA_qui = saup.PHA_qui -- population
JOIN shenzhen_people_filtered spf ON spf.PHA_qui = suf.PHA_qui -- demographic
WHERE so.createdtime = 20201101  -- 20201101 newly other APP 
AND saup.date = 20210501
AND spf.date = 20210501
GROUP BY saup.date, so.lcode, spf.gender


-- 20211101
SELECT
    saup.date,
    so.lcode,
    spf.gender,
    COUNT(*) as 20201101_newly_other_App_user_num20211101
FROM shenzhen_app_use_people_10month saup  -- APP use
JOIN shenzhen_otherapp_createtime so ON saup.lcode = so.lcode  -- 20201101 newly other APP 
JOIN shenzhen_app_use_filtered suf ON suf.PHA_qui = saup.PHA_qui -- population
JOIN shenzhen_people_filtered spf ON spf.PHA_qui = suf.PHA_qui -- demographic
WHERE so.createdtime = 20201101  -- 20201101 newly other APP 
AND saup.date = 20211101
AND spf.date = 20211101
GROUP BY saup.date, so.lcode, spf.gender


-- 20220501
SELECT
    saup.date,
    so.lcode,
    spf.gender,
    COUNT(*) as 20201101_newly_other_App_user_num20220501
FROM shenzhen_app_use_people_10month saup  -- APP use
JOIN shenzhen_otherapp_createtime so ON saup.lcode = so.lcode  -- 20201101 newly other APP 
JOIN shenzhen_app_use_filtered suf ON suf.PHA_qui = saup.PHA_qui -- population
JOIN shenzhen_people_filtered spf ON spf.PHA_qui = suf.PHA_qui -- demographic
WHERE so.createdtime = 20201101  -- 20201101 newly other APP 
AND saup.date = 20220501
AND spf.date = 20220501
GROUP BY saup.date, so.lcode, spf.gender


-- 20221101
SELECT
    saup.date,
    so.lcode,
    spf.gender,
    COUNT(*) as 20201101_newly_other_App_user_num20221101
FROM shenzhen_app_use_people_10month saup  -- APP use
JOIN shenzhen_otherapp_createtime so ON saup.lcode = so.lcode  -- 20201101 newly other APP 
JOIN shenzhen_app_use_filtered suf ON suf.PHA_qui = saup.PHA_qui -- population
JOIN shenzhen_people_filtered spf ON spf.PHA_qui = suf.PHA_qui -- demographic
WHERE so.createdtime = 20201101  -- 20201101 newly other APP 
AND saup.date = 20221101
AND spf.date = 20221101
GROUP BY saup.date, so.lcode, spf.gender


-- 20230501
SELECT
    saup.date,
    so.lcode,
    spf.gender,
    COUNT(*) as 20201101_newly_other_App_user_num20230501
FROM shenzhen_app_use_people_10month saup  -- APP use
JOIN shenzhen_otherapp_createtime so ON saup.lcode = so.lcode  -- 20201101 newly other APP 
JOIN shenzhen_app_use_filtered suf ON suf.PHA_qui = saup.PHA_qui -- population
JOIN shenzhen_people_filtered spf ON spf.PHA_qui = suf.PHA_qui -- demographic
WHERE so.createdtime = 20201101  -- 20201101 newly other APP 
AND saup.date = 20230501
AND spf.date = 20230501
GROUP BY saup.date, so.lcode, spf.gender


-- 20231101
SELECT
    saup.date,
    so.lcode,
    spf.gender,
    COUNT(*) as 20201101_newly_other_App_user_num20231101
FROM shenzhen_app_use_people_10month saup  -- APP use
JOIN shenzhen_otherapp_createtime so ON saup.lcode = so.lcode  -- 20201101 newly other APP 
JOIN shenzhen_app_use_filtered suf ON suf.PHA_qui = saup.PHA_qui -- population
JOIN shenzhen_people_filtered spf ON spf.PHA_qui = suf.PHA_qui -- demographic
WHERE so.createdtime = 20201101  -- 20201101 newly other APP
AND saup.date = 20231101
AND spf.date = 20231101
GROUP BY saup.date, so.lcode, spf.gender








-- 20201101_newly_other_App income
-- 20201101
SELECT
    saup.date,
    so.lcode,
    sppl.phoneprice_level,
    COUNT(*) as 20201101_newly_other_App_user_num20201101
FROM shenzhen_app_use_people_10month saup  -- APP use
JOIN shenzhen_otherapp_createtime so ON saup.lcode = so.lcode  -- 20201101 newly other APP 
JOIN shenzhen_app_use_filtered suf ON suf.PHA_qui = saup.PHA_qui -- population
JOIN shenzhen_people_filtered spf ON spf.PHA_qui = suf.PHA_qui -- demographic
JOIN shenzhen_people_phoneprice_10monthavg_level sppl ON sppl.PHA_qui = saup.PHA_qui -- phone price level
WHERE so.createdtime = 20201101  -- 20201101 newly other APP 
AND saup.date = 20201101
AND spf.date = 20201101
GROUP BY saup.date, so.lcode, sppl.phoneprice_level


-- 20210501
SELECT
    saup.date,
    so.lcode,
    sppl.phoneprice_level,
    COUNT(*) as 20201101_newly_other_App_user_num20210501
FROM shenzhen_app_use_people_10month saup  -- APP use
JOIN shenzhen_otherapp_createtime so ON saup.lcode = so.lcode  -- 20201101 newly other APP 
JOIN shenzhen_app_use_filtered suf ON suf.PHA_qui = saup.PHA_qui -- population
JOIN shenzhen_people_filtered spf ON spf.PHA_qui = suf.PHA_qui -- demographic
JOIN shenzhen_people_phoneprice_10monthavg_level sppl ON sppl.PHA_qui = saup.PHA_qui -- phone price level
WHERE so.createdtime = 20201101  -- 20201101 newly other APP P 
AND saup.date = 20210501
AND spf.date = 20210501
GROUP BY saup.date, so.lcode, sppl.phoneprice_level


-- 20211101
SELECT
    saup.date,
    so.lcode,
    sppl.phoneprice_level,
    COUNT(*) as 20201101_newly_other_App_user_num20211101
FROM shenzhen_app_use_people_10month saup  -- APP use
JOIN shenzhen_otherapp_createtime so ON saup.lcode = so.lcode  -- 20201101 newly other APP 
JOIN shenzhen_app_use_filtered suf ON suf.PHA_qui = saup.PHA_qui -- population
JOIN shenzhen_people_filtered spf ON spf.PHA_qui = suf.PHA_qui -- demographic
JOIN shenzhen_people_phoneprice_10monthavg_level sppl ON sppl.PHA_qui = saup.PHA_qui -- phone price level
WHERE so.createdtime = 20201101  -- 20201101 newly other APP 
AND saup.date = 20211101
AND spf.date = 20211101
GROUP BY saup.date, so.lcode, sppl.phoneprice_level




-- 20220501
SELECT
    saup.date,
    so.lcode,
    sppl.phoneprice_level,
    COUNT(*) as 20201101_newly_other_App_user_num20220501
FROM shenzhen_app_use_people_10month saup  -- APP use
JOIN shenzhen_otherapp_createtime so ON saup.lcode = so.lcode  -- 20201101 newly other APP 
JOIN shenzhen_app_use_filtered suf ON suf.PHA_qui = saup.PHA_qui -- population
JOIN shenzhen_people_filtered spf ON spf.PHA_qui = suf.PHA_qui -- demographic
JOIN shenzhen_people_phoneprice_10monthavg_level sppl ON sppl.PHA_qui = saup.PHA_qui -- phone price level
WHERE so.createdtime = 20201101  -- 20201101 newly other APP 
AND saup.date = 20220501
AND spf.date = 20220501
GROUP BY saup.date, so.lcode, sppl.phoneprice_level




-- 20221101
SELECT
    saup.date,
    so.lcode,
    sppl.phoneprice_level,
    COUNT(*) as 20201101_newly_other_App_user_num20221101
FROM shenzhen_app_use_people_10month saup  -- APP use
JOIN shenzhen_otherapp_createtime so ON saup.lcode = so.lcode  -- 20201101 newly other APP 
JOIN shenzhen_app_use_filtered suf ON suf.PHA_qui = saup.PHA_qui -- population
JOIN shenzhen_people_filtered spf ON spf.PHA_qui = suf.PHA_qui -- demographic
JOIN shenzhen_people_phoneprice_10monthavg_level sppl ON sppl.PHA_qui = saup.PHA_qui -- phone price level
WHERE so.createdtime = 20201101  -- 20201101 newly other APP 
AND saup.date = 20221101
AND spf.date = 20221101
GROUP BY saup.date, so.lcode, sppl.phoneprice_level




-- 20230501
SELECT
    saup.date,
    so.lcode,
    sppl.phoneprice_level,
    COUNT(*) as 20201101_newly_other_App_user_num20230501
FROM shenzhen_app_use_people_10month saup  -- APP use
JOIN shenzhen_otherapp_createtime so ON saup.lcode = so.lcode  -- 20201101 newly other APP 
JOIN shenzhen_app_use_filtered suf ON suf.PHA_qui = saup.PHA_qui -- population
JOIN shenzhen_people_filtered spf ON spf.PHA_qui = suf.PHA_qui -- demographic
JOIN shenzhen_people_phoneprice_10monthavg_level sppl ON sppl.PHA_qui = saup.PHA_qui -- phone price level
WHERE so.createdtime = 20201101  -- 20201101 newly other APP 
AND saup.date = 20230501
AND spf.date = 20230501
GROUP BY saup.date, so.lcode, sppl.phoneprice_level



-- 20231101
SELECT
    saup.date,
    so.lcode,
    sppl.phoneprice_level,
    COUNT(*) as 20201101_newly_other_App_user_num20231101
FROM shenzhen_app_use_people_10month saup  -- APP use
JOIN shenzhen_otherapp_createtime so ON saup.lcode = so.lcode  -- 20201101 newly other APP 
JOIN shenzhen_app_use_filtered suf ON suf.PHA_qui = saup.PHA_qui -- population
JOIN shenzhen_people_filtered spf ON spf.PHA_qui = suf.PHA_qui -- demographic
JOIN shenzhen_people_phoneprice_10monthavg_level sppl ON sppl.PHA_qui = saup.PHA_qui -- phone price level
WHERE so.createdtime = 20201101  -- 20201101 newly other APP 
AND saup.date = 20231101
AND spf.date = 20231101
GROUP BY saup.date, so.lcode, sppl.phoneprice_level











-- SI5

-- original other APP

-- 除去PHA
DROP TABLE IF EXISTS shenzhen_otherAPPuse;
create table shenzhen_otherAPPuse AS
SELECT DISTINCT saup.lcode
FROM shenzhen_app_use_people_10month saup -- APP use of all people
JOIN shenzhen_app_use_filtered sauf ON sauf.PHA_qui = saup.PHA_qui -- population
LEFT JOIN PHA_APPlist_distinct b ON saup.lcode = b.PHA_APP -- PHA list
WHERE b.PHA_APP IS NULL


DROP TABLE IF EXISTS shenzhen_otherAPP_createdtime;
CREATE TABLE shenzhen_otherAPP_createdtime AS
SELECT
    sad.lcode,
    date,
    ROW_NUMBER() OVER (PARTITION BY sadu.lcode ORDER BY date) AS appearorder
FROM shenzhen_APP_deduplicate sad -- all APP
JOIN shenzhen_otherAPPuse so ON so.lcode = sad.lcode -- other APP list
WHERE date IN (20190501, 20191101, 20200501, 20201101, 20210501, 20211101, 20220501, 20221101, 20230501, 20231101)


DROP TABLE IF EXISTS shenzhen_otherapp_createtime;
CREATE TABLE shenzhen_otherapp_createtime AS
SELECT
    lcode,
    date AS createdtime
FROM shenzhen_otherAPP_createdtime
WHERE appearorder = 1  -- 只选择每个 lcode 的首次出现
ORDER BY createdtime  -- 按日期排序

SELECT createdtime,
       count(*) as app_num
FROM shenzhen_otherapp_createtime
GROUP BY createdtime







-- original other APP age
-- 20190501
SELECT
    saup.date,
    so.lcode,
    spf.age,
    COUNT(*) as original_other_user_num20190501
FROM shenzhen_app_use_people_10month saup  -- APP use
JOIN shenzhen_otherapp_createtime so ON saup.lcode = so.lcode  -- original other APP 
JOIN shenzhen_app_use_filtered suf ON suf.PHA_qui = saup.PHA_qui -- population
JOIN shenzhen_people_filtered spf ON spf.PHA_qui = suf.PHA_qui -- demographic
WHERE so.createdtime = 20190501 -- original other APP
AND saup.date = 20190501
AND spf.date = 20190501
GROUP BY saup.date, so.lcode, spf.age


-- 20191101
SELECT
    saup.date,
    so.lcode,
    spf.age,
    COUNT(*) as original_other_user_num20191101
FROM shenzhen_app_use_people_10month saup  -- APP use
JOIN shenzhen_otherapp_createtime so ON saup.lcode = so.lcode  -- original other APP 
JOIN shenzhen_app_use_filtered suf ON suf.PHA_qui = saup.PHA_qui -- population
JOIN shenzhen_people_filtered spf ON spf.PHA_qui = suf.PHA_qui -- demographic
WHERE so.createdtime = 20190501 -- original other APP
AND saup.date = 20191101
AND spf.date = 20191101
GROUP BY saup.date, so.lcode, spf.age


-- 20200501
SELECT
    saup.date,
    so.lcode,
    spf.age,
    COUNT(*) as original_other_user_num20200501
FROM shenzhen_app_use_people_10month saup  -- APP use
JOIN shenzhen_otherapp_createtime so ON saup.lcode = so.lcode  -- original other APP 
JOIN shenzhen_app_use_filtered suf ON suf.PHA_qui = saup.PHA_qui -- population
JOIN shenzhen_people_filtered spf ON spf.PHA_qui = suf.PHA_qui -- demographic
WHERE so.createdtime = 20190501 -- original other APP
AND saup.date = 20200501
AND spf.date = 20200501
GROUP BY saup.date, so.lcode, spf.age


-- 20201101
SELECT
    saup.date,
    so.lcode,
    spf.age,
    COUNT(*) as original_other_user_num20201101
FROM shenzhen_app_use_people_10month saup  -- APP use
JOIN shenzhen_otherapp_createtime so ON saup.lcode = so.lcode  -- original other APP 
JOIN shenzhen_app_use_filtered suf ON suf.PHA_qui = saup.PHA_qui -- population
JOIN shenzhen_people_filtered spf ON spf.PHA_qui = suf.PHA_qui -- demographic
WHERE so.createdtime = 20190501 -- original other APP
AND saup.date = 20201101
AND spf.date = 20201101
GROUP BY saup.date, so.lcode, spf.age


-- 20210501
SELECT
    saup.date,
    so.lcode,
    spf.age,
    COUNT(*) as original_other_user_num20210501
FROM shenzhen_app_use_people_10month saup  -- APP use
JOIN shenzhen_otherapp_createtime so ON saup.lcode = so.lcode  -- original other APP 
JOIN shenzhen_app_use_filtered suf ON suf.PHA_qui = saup.PHA_qui -- population
JOIN shenzhen_people_filtered spf ON spf.PHA_qui = suf.PHA_qui -- demographic
WHERE so.createdtime = 20190501 -- original other APP
AND saup.date = 20210501
AND spf.date = 20210501
GROUP BY saup.date, so.lcode, spf.age


-- 20211101
SELECT
    saup.date,
    so.lcode,
    spf.age,
    COUNT(*) as original_other_user_num20211101
FROM shenzhen_app_use_people_10month saup  -- APP use
JOIN shenzhen_otherapp_createtime so ON saup.lcode = so.lcode  -- original other APP 
JOIN shenzhen_app_use_filtered suf ON suf.PHA_qui = saup.PHA_qui -- population
JOIN shenzhen_people_filtered spf ON spf.PHA_qui = suf.PHA_qui -- demographic
WHERE so.createdtime = 20190501 -- original other APP
AND saup.date = 20211101
AND spf.date = 20211101
GROUP BY saup.date, so.lcode, spf.age


-- 20220501
SELECT
    saup.date,
    so.lcode,
    spf.age,
    COUNT(*) as original_other_user_num20220501
FROM shenzhen_app_use_people_10month saup  -- APP use
JOIN shenzhen_otherapp_createtime so ON saup.lcode = so.lcode  -- original other APP 
JOIN shenzhen_app_use_filtered suf ON suf.PHA_qui = saup.PHA_qui -- population
JOIN shenzhen_people_filtered spf ON spf.PHA_qui = suf.PHA_qui -- demographic
WHERE so.createdtime = 20190501 -- original other APP
AND saup.date = 20220501
AND spf.date = 20220501
GROUP BY saup.date, so.lcode, spf.age


-- 20221101
SELECT
    saup.date,
    so.lcode,
    spf.age,
    COUNT(*) as original_other_user_num20221101
FROM shenzhen_app_use_people_10month saup  -- APP use
JOIN shenzhen_otherapp_createtime so ON saup.lcode = so.lcode  -- original other APP 
JOIN shenzhen_app_use_filtered suf ON suf.PHA_qui = saup.PHA_qui -- population
JOIN shenzhen_people_filtered spf ON spf.PHA_qui = suf.PHA_qui -- demographic
WHERE so.createdtime = 20190501 -- original other APP
AND saup.date = 20221101
AND spf.date = 20221101
GROUP BY saup.date, so.lcode, spf.age


-- 20230501
SELECT
    saup.date,
    so.lcode,
    spf.age,
    COUNT(*) as original_other_user_num20230501
FROM shenzhen_app_use_people_10month saup  -- APP use
JOIN shenzhen_otherapp_createtime so ON saup.lcode = so.lcode  -- original other APP 
JOIN shenzhen_app_use_filtered suf ON suf.PHA_qui = saup.PHA_qui -- population
JOIN shenzhen_people_filtered spf ON spf.PHA_qui = suf.PHA_qui -- demographic
WHERE so.createdtime = 20190501 -- original other APP
AND saup.date = 20230501
AND spf.date = 20230501
GROUP BY saup.date, so.lcode, spf.age


-- 20231101
SELECT
    saup.date,
    so.lcode,
    spf.age,
    COUNT(*) as original_other_user_num20231101
FROM shenzhen_app_use_people_10month saup  -- APP use
JOIN shenzhen_otherapp_createtime so ON saup.lcode = so.lcode  -- original other APP 
JOIN shenzhen_app_use_filtered suf ON suf.PHA_qui = saup.PHA_qui -- population
JOIN shenzhen_people_filtered spf ON spf.PHA_qui = suf.PHA_qui -- demographic
WHERE so.createdtime = 20190501 -- original other APP
AND saup.date = 20231101
AND spf.date = 20231101
GROUP BY saup.date, so.lcode, spf.age







-- original other APP gender
-- 20190501
SELECT
    saup.date,
    so.lcode,
    spf.gender,
    COUNT(*) as original_other_user_num20190501
FROM shenzhen_app_use_people_10month saup  -- APP use
JOIN shenzhen_otherapp_createtime so ON saup.lcode = so.lcode  -- original other APP 
JOIN shenzhen_app_use_filtered suf ON suf.PHA_qui = saup.PHA_qui -- population
JOIN shenzhen_people_filtered spf ON spf.PHA_qui = suf.PHA_qui -- demographic
WHERE so.createdtime = 20190501 -- original other APP
AND saup.date = 20190501
AND spf.date = 20190501
GROUP BY saup.date, so.lcode, spf.gender


-- 20191101
SELECT
    saup.date,
    so.lcode,
    spf.gender,
    COUNT(*) as original_other_user_num20191101
FROM shenzhen_app_use_people_10month saup  -- APP use
JOIN shenzhen_otherapp_createtime so ON saup.lcode = so.lcode  -- original other APP 
JOIN shenzhen_app_use_filtered suf ON suf.PHA_qui = saup.PHA_qui -- population
JOIN shenzhen_people_filtered spf ON spf.PHA_qui = suf.PHA_qui -- demographic
WHERE so.createdtime = 20190501 -- original other APP
AND saup.date = 20191101
AND spf.date = 20191101
GROUP BY saup.date, so.lcode, spf.gender


-- 20200501
SELECT
    saup.date,
    so.lcode,
    spf.gender,
    COUNT(*) as original_other_user_num20200501
FROM shenzhen_app_use_people_10month saup  -- APP use
JOIN shenzhen_otherapp_createtime so ON saup.lcode = so.lcode  -- original other APP 
JOIN shenzhen_app_use_filtered suf ON suf.PHA_qui = saup.PHA_qui -- population
JOIN shenzhen_people_filtered spf ON spf.PHA_qui = suf.PHA_qui -- demographic
WHERE so.createdtime = 20190501 -- original other APP
AND saup.date = 20200501
AND spf.date = 20200501
GROUP BY saup.date, so.lcode, spf.gender


-- 20201101
SELECT
    saup.date,
    so.lcode,
    spf.gender,
    COUNT(*) as original_other_user_num20201101
FROM shenzhen_app_use_people_10month saup  -- APP use
JOIN shenzhen_otherapp_createtime so ON saup.lcode = so.lcode  -- original other APP 
JOIN shenzhen_app_use_filtered suf ON suf.PHA_qui = saup.PHA_qui -- population
JOIN shenzhen_people_filtered spf ON spf.PHA_qui = suf.PHA_qui -- demographic
WHERE so.createdtime = 20190501 -- original other APP
AND saup.date = 20201101
AND spf.date = 20201101
GROUP BY saup.date, so.lcode, spf.gender


-- 20210501
SELECT
    saup.date,
    so.lcode,
    spf.gender,
    COUNT(*) as original_other_user_num20210501
FROM shenzhen_app_use_people_10month saup  -- APP use
JOIN shenzhen_otherapp_createtime so ON saup.lcode = so.lcode  -- original other APP 
JOIN shenzhen_app_use_filtered suf ON suf.PHA_qui = saup.PHA_qui -- population
JOIN shenzhen_people_filtered spf ON spf.PHA_qui = suf.PHA_qui -- demographic
WHERE so.createdtime = 20190501 -- original other APP
AND saup.date = 20210501
AND spf.date = 20210501
GROUP BY saup.date, so.lcode, spf.gender


-- 20211101
SELECT
    saup.date,
    so.lcode,
    spf.gender,
    COUNT(*) as original_other_user_num20211101
FROM shenzhen_app_use_people_10month saup  -- APP use
JOIN shenzhen_otherapp_createtime so ON saup.lcode = so.lcode  -- original other APP 
JOIN shenzhen_app_use_filtered suf ON suf.PHA_qui = saup.PHA_qui -- population
JOIN shenzhen_people_filtered spf ON spf.PHA_qui = suf.PHA_qui -- demographic
WHERE so.createdtime = 20190501 -- original other APP
AND saup.date = 20211101
AND spf.date = 20211101
GROUP BY saup.date, so.lcode, spf.gender


-- 20220501
SELECT
    saup.date,
    so.lcode,
    spf.gender,
    COUNT(*) as original_other_user_num20220501
FROM shenzhen_app_use_people_10month saup  -- APP use
JOIN shenzhen_otherapp_createtime so ON saup.lcode = so.lcode  -- original other APP 
JOIN shenzhen_app_use_filtered suf ON suf.PHA_qui = saup.PHA_qui -- population
JOIN shenzhen_people_filtered spf ON spf.PHA_qui = suf.PHA_qui -- demographic
WHERE so.createdtime = 20190501 -- original other APP
AND saup.date = 20220501
AND spf.date = 20220501
GROUP BY saup.date, so.lcode, spf.gender


-- 20221101
SELECT
    saup.date,
    so.lcode,
    spf.gender,
    COUNT(*) as original_other_user_num20221101
FROM shenzhen_app_use_people_10month saup  -- APP use
JOIN shenzhen_otherapp_createtime so ON saup.lcode = so.lcode  -- original other APP 
JOIN shenzhen_app_use_filtered suf ON suf.PHA_qui = saup.PHA_qui -- population
JOIN shenzhen_people_filtered spf ON spf.PHA_qui = suf.PHA_qui -- demographic
WHERE so.createdtime = 20190501 -- original other APP
AND saup.date = 20221101
AND spf.date = 20221101
GROUP BY saup.date, so.lcode, spf.gender


-- 20230501
SELECT
    saup.date,
    so.lcode,
    spf.gender,
    COUNT(*) as original_other_user_num20230501
FROM shenzhen_app_use_people_10month saup  -- APP use
JOIN shenzhen_otherapp_createtime so ON saup.lcode = so.lcode  -- original other APP 
JOIN shenzhen_app_use_filtered suf ON suf.PHA_qui = saup.PHA_qui -- population
JOIN shenzhen_people_filtered spf ON spf.PHA_qui = suf.PHA_qui -- demographic
WHERE so.createdtime = 20190501 -- original other APP
AND saup.date = 20230501
AND spf.date = 20230501
GROUP BY saup.date, so.lcode, spf.gender


-- 20231101
SELECT
    saup.date,
    so.lcode,
    spf.gender,
    COUNT(*) as original_other_user_num20231101
FROM shenzhen_app_use_people_10month saup  -- APP use
JOIN shenzhen_otherapp_createtime so ON saup.lcode = so.lcode  -- original other APP 
JOIN shenzhen_app_use_filtered suf ON suf.PHA_qui = saup.PHA_qui -- population
JOIN shenzhen_people_filtered spf ON spf.PHA_qui = suf.PHA_qui -- demographic
WHERE so.createdtime = 20190501 -- original other APP
AND saup.date = 20231101
AND spf.date = 20231101
GROUP BY saup.date, so.lcode, spf.gender











-- original other APP phone price
-- 20190501
SELECT
    saup.date,
    so.lcode,
    sppl.phoneprice_level,
    COUNT(*) as original_other_user_num20190501
FROM shenzhen_app_use_people_10month saup  -- APP use
JOIN shenzhen_otherapp_createtime so ON saup.lcode = so.lcode  -- original other APP 
JOIN shenzhen_app_use_filtered suf ON suf.PHA_qui = saup.PHA_qui -- population
JOIN shenzhen_people_filtered spf ON spf.PHA_qui = suf.PHA_qui -- demographic
JOIN shenzhen_people_phoneprice_10monthavg_level sppl ON sppl.PHA_qui = saup.PHA_qui -- phone price level
WHERE so.createdtime = 20190501 -- original other APP
AND saup.date = 20190501
AND spf.date = 20190501
GROUP BY saup.date, so.lcode, sppl.phoneprice_level


-- 20191101
SELECT
    saup.date,
    so.lcode,
    spf.gender,
    COUNT(*) as original_other_user_num20191101
FROM shenzhen_app_use_people_10month saup  -- APP use
JOIN shenzhen_otherapp_createtime so ON saup.lcode = so.lcode  -- original other APP 
JOIN shenzhen_app_use_filtered suf ON suf.PHA_qui = saup.PHA_qui -- population
JOIN shenzhen_people_filtered spf ON spf.PHA_qui = suf.PHA_qui -- demographic
JOIN shenzhen_people_phoneprice_10monthavg_level sppl ON sppl.PHA_qui = saup.PHA_qui -- phone price level
WHERE so.createdtime = 20190501 -- original other APP
AND saup.date = 20191101
AND spf.date = 20191101
GROUP BY saup.date, so.lcode, spf.gender


-- 20200501
SELECT
    saup.date,
    so.lcode,
    sppl.phoneprice_level,
    COUNT(*) as original_other_user_num20200501
FROM shenzhen_app_use_people_10month saup  -- APP use
JOIN shenzhen_otherapp_createtime so ON saup.lcode = so.lcode  -- original other APP 
JOIN shenzhen_app_use_filtered suf ON suf.PHA_qui = saup.PHA_qui -- population
JOIN shenzhen_people_filtered spf ON spf.PHA_qui = suf.PHA_qui -- demographic
JOIN shenzhen_people_phoneprice_10monthavg_level sppl ON sppl.PHA_qui = saup.PHA_qui -- phone price level
WHERE so.createdtime = 20190501 -- original other APP
AND saup.date = 20200501
AND spf.date = 20200501
GROUP BY saup.date, so.lcode, sppl.phoneprice_level


-- 20201101
SELECT
    saup.date,
    so.lcode,
    sppl.phoneprice_level,
    COUNT(*) as original_other_user_num20201101
FROM shenzhen_app_use_people_10month saup  -- APP use
JOIN shenzhen_otherapp_createtime so ON saup.lcode = so.lcode  -- original other APP 
JOIN shenzhen_app_use_filtered suf ON suf.PHA_qui = saup.PHA_qui -- population
JOIN shenzhen_people_filtered spf ON spf.PHA_qui = suf.PHA_qui -- demographic
JOIN shenzhen_people_phoneprice_10monthavg_level sppl ON sppl.PHA_qui = saup.PHA_qui -- phone price level
WHERE so.createdtime = 20190501 -- original other APP
AND saup.date = 20201101
AND spf.date = 20201101
GROUP BY saup.date, so.lcode, sppl.phoneprice_level


-- 20210501
SELECT
    saup.date,
    so.lcode,
    sppl.phoneprice_level,
    COUNT(*) as original_other_user_num20210501
FROM shenzhen_app_use_people_10month saup  -- APP use
JOIN shenzhen_otherapp_createtime so ON saup.lcode = so.lcode  -- original other APP 
JOIN shenzhen_app_use_filtered suf ON suf.PHA_qui = saup.PHA_qui -- population
JOIN shenzhen_people_filtered spf ON spf.PHA_qui = suf.PHA_qui -- demographic
JOIN shenzhen_people_phoneprice_10monthavg_level sppl ON sppl.PHA_qui = saup.PHA_qui -- phone price level
WHERE so.createdtime = 20190501 -- original other APP
AND saup.date = 20210501
AND spf.date = 20210501
GROUP BY saup.date, so.lcode, sppl.phoneprice_level


-- 20211101
SELECT
    saup.date,
    so.lcode,
    sppl.phoneprice_level,
    COUNT(*) as original_other_user_num20211101
FROM shenzhen_app_use_people_10month saup  -- APP use
JOIN shenzhen_otherapp_createtime so ON saup.lcode = so.lcode  -- original other APP 
JOIN shenzhen_app_use_filtered suf ON suf.PHA_qui = saup.PHA_qui -- population
JOIN shenzhen_people_filtered spf ON spf.PHA_qui = suf.PHA_qui -- demographic
JOIN shenzhen_people_phoneprice_10monthavg_level sppl ON sppl.PHA_qui = saup.PHA_qui -- phone price level
WHERE so.createdtime = 20190501 -- original other APP
AND saup.date = 20211101
AND spf.date = 20211101
GROUP BY saup.date, so.lcode, sppl.phoneprice_level


-- 20220501
SELECT
    saup.date,
    so.lcode,
    sppl.phoneprice_level,
    COUNT(*) as original_other_user_num20220501
FROM shenzhen_app_use_people_10month saup  -- APP use
JOIN shenzhen_otherapp_createtime so ON saup.lcode = so.lcode  -- original other APP 
JOIN shenzhen_app_use_filtered suf ON suf.PHA_qui = saup.PHA_qui -- population
JOIN shenzhen_people_filtered spf ON spf.PHA_qui = suf.PHA_qui -- demographic
JOIN shenzhen_people_phoneprice_10monthavg_level sppl ON sppl.PHA_qui = saup.PHA_qui -- phone price level
WHERE so.createdtime = 20190501 -- original other APP
AND saup.date = 20220501
AND spf.date = 20220501
GROUP BY saup.date, so.lcode, sppl.phoneprice_level


-- 20221101
SELECT
    saup.date,
    so.lcode,
    sppl.phoneprice_level,
    COUNT(*) as original_other_user_num20221101
FROM shenzhen_app_use_people_10month saup  -- APP use
JOIN shenzhen_otherapp_createtime so ON saup.lcode = so.lcode  -- original other APP 
JOIN shenzhen_app_use_filtered suf ON suf.PHA_qui = saup.PHA_qui -- population
JOIN shenzhen_people_filtered spf ON spf.PHA_qui = suf.PHA_qui -- demographic
JOIN shenzhen_people_phoneprice_10monthavg_level sppl ON sppl.PHA_qui = saup.PHA_qui -- phone price level
WHERE so.createdtime = 20190501 -- original other APP
AND saup.date = 20221101
AND spf.date = 20221101
GROUP BY saup.date, so.lcode, sppl.phoneprice_level


-- 20230501
SELECT
    saup.date,
    so.lcode,
    sppl.phoneprice_level,
    COUNT(*) as original_other_user_num20230501
FROM shenzhen_app_use_people_10month saup  -- APP use
JOIN shenzhen_otherapp_createtime so ON saup.lcode = so.lcode  -- original other APP 
JOIN shenzhen_app_use_filtered suf ON suf.PHA_qui = saup.PHA_qui -- population
JOIN shenzhen_people_filtered spf ON spf.PHA_qui = suf.PHA_qui -- demographic
JOIN shenzhen_people_phoneprice_10monthavg_level sppl ON sppl.PHA_qui = saup.PHA_qui -- phone price level
WHERE so.createdtime = 20190501 -- original other APP
AND saup.date = 20230501
AND spf.date = 20230501
GROUP BY saup.date, so.lcode, sppl.phoneprice_level


-- 20231101
SELECT
    saup.date,
    so.lcode,
    sppl.phoneprice_level,
    COUNT(*) as original_other_user_num20231101
FROM shenzhen_app_use_people_10month saup  -- APP use
JOIN shenzhen_otherapp_createtime so ON saup.lcode = so.lcode  -- original other APP 
JOIN shenzhen_app_use_filtered suf ON suf.PHA_qui = saup.PHA_qui -- population
JOIN shenzhen_people_filtered spf ON spf.PHA_qui = suf.PHA_qui -- demographic
JOIN shenzhen_people_phoneprice_10monthavg_level sppl ON sppl.PHA_qui = saup.PHA_qui -- phone price level
WHERE so.createdtime = 20190501 -- original other APP
AND saup.date = 20231101
AND spf.date = 20231101
GROUP BY saup.date, so.lcode, sppl.phoneprice_level


















-- original PHA 
DROP TABLE IF EXISTS shenzhen_20190501_original_PHA;
CREATE TABLE shenzhen_20190501_original_PHA AS
SELECT pha AS lcode
FROM newlycreatedPHA
WHERE createdate = 20190501



-- original PHA age
-- 20190501
SELECT
    saup.date,
    so.lcode,
    spf.age,
    COUNT(*) as original_PHA_user_num20190501
FROM shenzhen_app_use_people_10month saup  -- APP use
JOIN shenzhen_20190501_original_PHA sa on sa.lcode = saup.lcode -- original PHA
JOIN shenzhen_app_use_filtered suf ON suf.PHA_qui = saup.PHA_qui -- population
JOIN shenzhen_people_filtered spf ON spf.PHA_qui = suf.PHA_qui -- demographic
AND saup.date = 20190501
AND spf.date = 20190501 -- demographics
GROUP BY saup.date, so.lcode, spf.age


-- 20191101
SELECT
    saup.date,
    so.lcode,
    spf.age,
    COUNT(*) as original_PHA_user_num20191101
FROM shenzhen_app_use_people_10month saup  -- APP use
JOIN shenzhen_20190501_original_PHA sa on sa.lcode = saup.lcode -- original PHA
JOIN shenzhen_app_use_filtered suf ON suf.PHA_qui = saup.PHA_qui -- population
JOIN shenzhen_people_filtered spf ON spf.PHA_qui = suf.PHA_qui -- demographic
AND saup.date = 20191101
AND spf.date = 20191101 -- demographics
GROUP BY saup.date, so.lcode, spf.age


-- 20200501
SELECT
    saup.date,
    so.lcode,
    spf.age,
    COUNT(*) as original_PHA_user_num20200501
FROM shenzhen_app_use_people_10month saup  -- APP use
JOIN shenzhen_20190501_original_PHA sa on sa.lcode = saup.lcode -- original PHA
JOIN shenzhen_app_use_filtered suf ON suf.PHA_qui = saup.PHA_qui -- population
JOIN shenzhen_people_filtered spf ON spf.PHA_qui = suf.PHA_qui -- demographic
AND saup.date = 20200501
AND spf.date = 20200501 -- demographics
GROUP BY saup.date, so.lcode, spf.age


-- 20201101
SELECT
    saup.date,
    so.lcode,
    spf.age,
    COUNT(*) as original_PHA_user_num20201101
FROM shenzhen_app_use_people_10month saup  -- APP use
JOIN shenzhen_20190501_original_PHA sa on sa.lcode = saup.lcode -- original PHA
JOIN shenzhen_app_use_filtered suf ON suf.PHA_qui = saup.PHA_qui -- population
JOIN shenzhen_people_filtered spf ON spf.PHA_qui = suf.PHA_qui -- demographic
AND saup.date = 20201101
AND spf.date = 20201101 -- demographics
GROUP BY saup.date, so.lcode, spf.age


-- 20210501
SELECT
    saup.date,
    so.lcode,
    spf.age,
    COUNT(*) as original_PHA_user_num20210501
FROM shenzhen_app_use_people_10month saup  -- APP use
JOIN shenzhen_20190501_original_PHA sa on sa.lcode = saup.lcode -- original PHA
JOIN shenzhen_app_use_filtered suf ON suf.PHA_qui = saup.PHA_qui -- population
JOIN shenzhen_people_filtered spf ON spf.PHA_qui = suf.PHA_qui -- demographic
AND saup.date = 20210501
AND spf.date = 20210501 -- demographics
GROUP BY saup.date, so.lcode, spf.age


-- 20211101
SELECT
    saup.date,
    so.lcode,
    spf.age,
    COUNT(*) as original_PHA_user_num20211101
FROM shenzhen_app_use_people_10month saup  -- APP use
JOIN shenzhen_20190501_original_PHA sa on sa.lcode = saup.lcode -- original PHA
JOIN shenzhen_app_use_filtered suf ON suf.PHA_qui = saup.PHA_qui -- population
JOIN shenzhen_people_filtered spf ON spf.PHA_qui = suf.PHA_qui -- demographic
AND saup.date = 20211101
AND spf.date = 20211101 -- demographics
GROUP BY saup.date, so.lcode, spf.age


-- 20220501
SELECT
    saup.date,
    so.lcode,
    spf.age,
    COUNT(*) as original_PHA_user_num20220501
FROM shenzhen_app_use_people_10month saup  -- APP use
JOIN shenzhen_20190501_original_PHA sa on sa.lcode = saup.lcode -- original PHA
JOIN shenzhen_app_use_filtered suf ON suf.PHA_qui = saup.PHA_qui -- population
JOIN shenzhen_people_filtered spf ON spf.PHA_qui = suf.PHA_qui -- demographic
AND saup.date = 20220501
AND spf.date = 20220501 -- demographics
GROUP BY saup.date, so.lcode, spf.age


-- 20221101
SELECT
    saup.date,
    so.lcode,
    spf.age,
    COUNT(*) as original_PHA_user_num20221101
FROM shenzhen_app_use_people_10month saup  -- APP use
JOIN shenzhen_20190501_original_PHA sa on sa.lcode = saup.lcode -- original PHA
JOIN shenzhen_app_use_filtered suf ON suf.PHA_qui = saup.PHA_qui -- population
JOIN shenzhen_people_filtered spf ON spf.PHA_qui = suf.PHA_qui -- demographic
AND saup.date = 20221101
AND spf.date = 20221101 -- demographics
GROUP BY saup.date, so.lcode, spf.age


-- 20230501
SELECT
    saup.date,
    so.lcode,
    spf.age,
    COUNT(*) as original_PHA_user_num20230501
FROM shenzhen_app_use_people_10month saup  -- APP use
JOIN shenzhen_20190501_original_PHA sa on sa.lcode = saup.lcode -- original PHA
JOIN shenzhen_app_use_filtered suf ON suf.PHA_qui = saup.PHA_qui -- population
JOIN shenzhen_people_filtered spf ON spf.PHA_qui = suf.PHA_qui -- demographic
AND saup.date = 20230501
AND spf.date = 20230501 -- demographics
GROUP BY saup.date, so.lcode, spf.age


-- 20231101
SELECT
    saup.date,
    so.lcode,
    spf.age,
    COUNT(*) as original_PHA_user_num20231101
FROM shenzhen_app_use_people_10month saup  -- APP use
JOIN shenzhen_20190501_original_PHA sa on sa.lcode = saup.lcode -- original PHA
JOIN shenzhen_app_use_filtered suf ON suf.PHA_qui = saup.PHA_qui -- population
JOIN shenzhen_people_filtered spf ON spf.PHA_qui = suf.PHA_qui -- demographic
AND saup.date = 20231101
AND spf.date = 20231101 -- demographics
GROUP BY saup.date, so.lcode, spf.age







-- original PHA gender
-- 20190501
SELECT
    saup.date,
    so.lcode,
    spf.gender,
    COUNT(*) as original_PHA_user_num20190501
FROM shenzhen_app_use_people_10month saup  -- APP use
JOIN shenzhen_20190501_original_PHA sa on sa.lcode = saup.lcode -- original PHA
JOIN shenzhen_app_use_filtered suf ON suf.PHA_qui = saup.PHA_qui -- population
JOIN shenzhen_people_filtered spf ON spf.PHA_qui = suf.PHA_qui -- demographic
AND saup.date = 20190501
AND spf.date = 20190501 -- demographics
GROUP BY saup.date, so.lcode, spf.gender


-- 20191101
SELECT
    saup.date,
    so.lcode,
    spf.gender,
    COUNT(*) as original_PHA_user_num20191101
FROM shenzhen_app_use_people_10month saup  -- APP use
JOIN shenzhen_20190501_original_PHA sa on sa.lcode = saup.lcode -- original PHA
JOIN shenzhen_app_use_filtered suf ON suf.PHA_qui = saup.PHA_qui -- population
JOIN shenzhen_people_filtered spf ON spf.PHA_qui = suf.PHA_qui -- demographic
AND saup.date = 20191101
AND spf.date = 20191101 -- demographics
GROUP BY saup.date, so.lcode, spf.gender


-- 20200501
SELECT
    saup.date,
    so.lcode,
    spf.gender,
    COUNT(*) as original_PHA_user_num20200501
FROM shenzhen_app_use_people_10month saup  -- APP use
JOIN shenzhen_20190501_original_PHA sa on sa.lcode = saup.lcode -- original PHA
JOIN shenzhen_app_use_filtered suf ON suf.PHA_qui = saup.PHA_qui -- population
JOIN shenzhen_people_filtered spf ON spf.PHA_qui = suf.PHA_qui -- demographic
AND saup.date = 20200501
AND spf.date = 20200501 -- demographics
GROUP BY saup.date, so.lcode, spf.gender


-- 20201101
SELECT
    saup.date,
    so.lcode,
    spf.gender,
    COUNT(*) as original_PHA_user_num20201101
FROM shenzhen_app_use_people_10month saup  -- APP use
JOIN shenzhen_20190501_original_PHA sa on sa.lcode = saup.lcode -- original PHA
JOIN shenzhen_app_use_filtered suf ON suf.PHA_qui = saup.PHA_qui -- population
JOIN shenzhen_people_filtered spf ON spf.PHA_qui = suf.PHA_qui -- demographic
AND saup.date = 20201101
AND spf.date = 20201101 -- demographics
GROUP BY saup.date, so.lcode, spf.gender


-- 20210501
SELECT
    saup.date,
    so.lcode,
    spf.gender,
    COUNT(*) as original_PHA_user_num20210501
FROM shenzhen_app_use_people_10month saup  -- APP use
JOIN shenzhen_20190501_original_PHA sa on sa.lcode = saup.lcode -- original PHA
JOIN shenzhen_app_use_filtered suf ON suf.PHA_qui = saup.PHA_qui -- population
JOIN shenzhen_people_filtered spf ON spf.PHA_qui = suf.PHA_qui -- demographic
AND saup.date = 20210501
AND spf.date = 20210501 -- demographics
GROUP BY saup.date, so.lcode, spf.gender


-- 20211101
SELECT
    saup.date,
    so.lcode,
    spf.gender,
    COUNT(*) as original_PHA_user_num20211101
FROM shenzhen_app_use_people_10month saup  -- APP use
JOIN shenzhen_20190501_original_PHA sa on sa.lcode = saup.lcode -- original PHA
JOIN shenzhen_app_use_filtered suf ON suf.PHA_qui = saup.PHA_qui -- population
JOIN shenzhen_people_filtered spf ON spf.PHA_qui = suf.PHA_qui -- demographic
AND saup.date = 20211101
AND spf.date = 20211101 -- demographics
GROUP BY saup.date, so.lcode, spf.gender


-- 20220501
SELECT
    saup.date,
    so.lcode,
    spf.gender,
    COUNT(*) as original_PHA_user_num20220501
FROM shenzhen_app_use_people_10month saup  -- APP use
JOIN shenzhen_20190501_original_PHA sa on sa.lcode = saup.lcode -- original PHA
JOIN shenzhen_app_use_filtered suf ON suf.PHA_qui = saup.PHA_qui -- population
JOIN shenzhen_people_filtered spf ON spf.PHA_qui = suf.PHA_qui -- demographic
AND saup.date = 20220501
AND spf.date = 20220501 -- demographics
GROUP BY saup.date, so.lcode, spf.gender


-- 20221101
SELECT
    saup.date,
    so.lcode,
    spf.gender,
    COUNT(*) as original_PHA_user_num20221101
FROM shenzhen_app_use_people_10month saup  -- APP use
JOIN shenzhen_20190501_original_PHA sa on sa.lcode = saup.lcode -- original PHA
JOIN shenzhen_app_use_filtered suf ON suf.PHA_qui = saup.PHA_qui -- population
JOIN shenzhen_people_filtered spf ON spf.PHA_qui = suf.PHA_qui -- demographic
AND saup.date = 20221101
AND spf.date = 20221101 -- demographics
GROUP BY saup.date, so.lcode, spf.gender


-- 20230501
SELECT
    saup.date,
    so.lcode,
    spf.gender,
    COUNT(*) as original_PHA_user_num20230501
FROM shenzhen_app_use_people_10month saup  -- APP use
JOIN shenzhen_20190501_original_PHA sa on sa.lcode = saup.lcode -- original PHA
JOIN shenzhen_app_use_filtered suf ON suf.PHA_qui = saup.PHA_qui -- population
JOIN shenzhen_people_filtered spf ON spf.PHA_qui = suf.PHA_qui -- demographic
AND saup.date = 20230501
AND spf.date = 20230501 -- demographics
GROUP BY saup.date, so.lcode, spf.gender


-- 20231101
SELECT
    saup.date,
    so.lcode,
    spf.gender,
    COUNT(*) as original_PHA_user_num20231101
FROM shenzhen_app_use_people_10month saup  -- APP use
JOIN shenzhen_20190501_original_PHA sa on sa.lcode = saup.lcode -- original PHA
JOIN shenzhen_app_use_filtered suf ON suf.PHA_qui = saup.PHA_qui -- population
JOIN shenzhen_people_filtered spf ON spf.PHA_qui = suf.PHA_qui -- demographic
AND saup.date = 20231101
AND spf.date = 20231101 -- demographics
GROUP BY saup.date, so.lcode, spf.gender







-- original PHA income
-- 20190501
SELECT
    saup.date,
    so.lcode,
    sppl.phoneprice_level,
    COUNT(*) as original_PHA_user_num20190501
FROM shenzhen_app_use_people_10month saup  -- APP use
JOIN shenzhen_20190501_original_PHA sa on sa.lcode = saup.lcode -- original PHA
JOIN shenzhen_app_use_filtered suf ON suf.PHA_qui = saup.PHA_qui -- population
JOIN shenzhen_people_filtered spf ON spf.PHA_qui = suf.PHA_qui -- demographic
JOIN shenzhen_people_phoneprice_10monthavg_level sppl ON sppl.PHA_qui = saup.PHA_qui -- phone price level
AND saup.date = 20190501
AND spf.date = 20190501 -- demographics
GROUP BY saup.date, so.lcode, sppl.phoneprice_level


-- 20191101
SELECT
    saup.date,
    so.lcode,
    sppl.phoneprice_level,
    COUNT(*) as original_PHA_user_num20191101
FROM shenzhen_app_use_people_10month saup  -- APP use
JOIN shenzhen_20190501_original_PHA sa on sa.lcode = saup.lcode -- original PHA
JOIN shenzhen_app_use_filtered suf ON suf.PHA_qui = saup.PHA_qui -- population
JOIN shenzhen_people_filtered spf ON spf.PHA_qui = suf.PHA_qui -- demographic
JOIN shenzhen_people_phoneprice_10monthavg_level sppl ON sppl.PHA_qui = saup.PHA_qui -- phone price level
AND saup.date = 20191101
AND spf.date = 20191101 -- demographics
GROUP BY saup.date, so.lcode, sppl.phoneprice_level


-- 20200501
SELECT
    saup.date,
    so.lcode,
    sppl.phoneprice_level,
    COUNT(*) as original_PHA_user_num20200501
FROM shenzhen_app_use_people_10month saup  -- APP use
JOIN shenzhen_20190501_original_PHA sa on sa.lcode = saup.lcode -- original PHA
JOIN shenzhen_app_use_filtered suf ON suf.PHA_qui = saup.PHA_qui -- population
JOIN shenzhen_people_filtered spf ON spf.PHA_qui = suf.PHA_qui -- demographic
JOIN shenzhen_people_phoneprice_10monthavg_level sppl ON sppl.PHA_qui = saup.PHA_qui -- phone price level
AND saup.date = 20200501
AND spf.date = 20200501 -- demographics
GROUP BY saup.date, so.lcode, sppl.phoneprice_level


-- 20201101
SELECT
    saup.date,
    so.lcode,
    sppl.phoneprice_level,
    COUNT(*) as original_PHA_user_num20201101
FROM shenzhen_app_use_people_10month saup  -- APP use
JOIN shenzhen_20190501_original_PHA sa on sa.lcode = saup.lcode -- original PHA
JOIN shenzhen_app_use_filtered suf ON suf.PHA_qui = saup.PHA_qui -- population
JOIN shenzhen_people_filtered spf ON spf.PHA_qui = suf.PHA_qui -- demographic
JOIN shenzhen_people_phoneprice_10monthavg_level sppl ON sppl.PHA_qui = saup.PHA_qui -- phone price level
AND saup.date = 20201101
AND spf.date = 20201101 -- demographics
GROUP BY saup.date, so.lcode, sppl.phoneprice_level


-- 20210501
SELECT
    saup.date,
    so.lcode,
    sppl.phoneprice_level,
    COUNT(*) as original_PHA_user_num20210501
FROM shenzhen_app_use_people_10month saup  -- APP use
JOIN shenzhen_20190501_original_PHA sa on sa.lcode = saup.lcode -- original PHA
JOIN shenzhen_app_use_filtered suf ON suf.PHA_qui = saup.PHA_qui -- population
JOIN shenzhen_people_filtered spf ON spf.PHA_qui = suf.PHA_qui -- demographic
JOIN shenzhen_people_phoneprice_10monthavg_level sppl ON sppl.PHA_qui = saup.PHA_qui -- phone price level
AND saup.date = 20210501
AND spf.date = 20210501 -- demographics
GROUP BY saup.date, so.lcode, sppl.phoneprice_level


-- 20211101
SELECT
    saup.date,
    so.lcode,
    sppl.phoneprice_level,
    COUNT(*) as original_PHA_user_num20211101
FROM shenzhen_app_use_people_10month saup  -- APP use
JOIN shenzhen_20190501_original_PHA sa on sa.lcode = saup.lcode -- original PHA
JOIN shenzhen_app_use_filtered suf ON suf.PHA_qui = saup.PHA_qui -- population
JOIN shenzhen_people_filtered spf ON spf.PHA_qui = suf.PHA_qui -- demographic
JOIN shenzhen_people_phoneprice_10monthavg_level sppl ON sppl.PHA_qui = saup.PHA_qui -- phone price level
AND saup.date = 20211101
AND spf.date = 20211101 -- demographics
GROUP BY saup.date, so.lcode, sppl.phoneprice_level


-- 20220501
SELECT
    saup.date,
    so.lcode,
    sppl.phoneprice_level,
    COUNT(*) as original_PHA_user_num20220501
FROM shenzhen_app_use_people_10month saup  -- APP use
JOIN shenzhen_20190501_original_PHA sa on sa.lcode = saup.lcode -- original PHA
JOIN shenzhen_app_use_filtered suf ON suf.PHA_qui = saup.PHA_qui -- population
JOIN shenzhen_people_filtered spf ON spf.PHA_qui = suf.PHA_qui -- demographic
JOIN shenzhen_people_phoneprice_10monthavg_level sppl ON sppl.PHA_qui = saup.PHA_qui -- phone price level
AND saup.date = 20220501
AND spf.date = 20220501 -- demographics
GROUP BY saup.date, so.lcode, sppl.phoneprice_level


-- 20221101
SELECT
    saup.date,
    so.lcode,
    sppl.phoneprice_level,
    COUNT(*) as original_PHA_user_num20221101
FROM shenzhen_app_use_people_10month saup  -- APP use
JOIN shenzhen_20190501_original_PHA sa on sa.lcode = saup.lcode -- original PHA
JOIN shenzhen_app_use_filtered suf ON suf.PHA_qui = saup.PHA_qui -- population
JOIN shenzhen_people_filtered spf ON spf.PHA_qui = suf.PHA_qui -- demographic
JOIN shenzhen_people_phoneprice_10monthavg_level sppl ON sppl.PHA_qui = saup.PHA_qui -- phone price level
AND saup.date = 20221101
AND spf.date = 20221101 -- demographics
GROUP BY saup.date, so.lcode, sppl.phoneprice_level


-- 20230501
SELECT
    saup.date,
    so.lcode,
    sppl.phoneprice_level,
    COUNT(*) as original_PHA_user_num20230501
FROM shenzhen_app_use_people_10month saup  -- APP use
JOIN shenzhen_20190501_original_PHA sa on sa.lcode = saup.lcode -- original PHA
JOIN shenzhen_app_use_filtered suf ON suf.PHA_qui = saup.PHA_qui -- population
JOIN shenzhen_people_filtered spf ON spf.PHA_qui = suf.PHA_qui -- demographic
JOIN shenzhen_people_phoneprice_10monthavg_level sppl ON sppl.PHA_qui = saup.PHA_qui -- phone price level
AND saup.date = 20230501
AND spf.date = 20230501 -- demographics
GROUP BY saup.date, so.lcode, sppl.phoneprice_level


-- 20231101
SELECT
    saup.date,
    so.lcode,
    sppl.phoneprice_level,
    COUNT(*) as original_PHA_user_num20231101
FROM shenzhen_app_use_people_10month saup  -- APP use
JOIN shenzhen_20190501_original_PHA sa on sa.lcode = saup.lcode -- original PHA
JOIN shenzhen_app_use_filtered suf ON suf.PHA_qui = saup.PHA_qui -- population
JOIN shenzhen_people_filtered spf ON spf.PHA_qui = suf.PHA_qui -- demographic
JOIN shenzhen_people_phoneprice_10monthavg_level sppl ON sppl.PHA_qui = saup.PHA_qui -- phone price level
AND saup.date = 20231101
AND spf.date = 20231101 -- demographics
GROUP BY saup.date, so.lcode, sppl.phoneprice_level





-- SI 6

-- 各时间点PHA list及使用人数（看不出使用次数）
SELECT date, lcode, num
FROM shenzhen_app_list sal 
JOIN PHA_APPlist_distinct pd ON pd.PHA_APP = sal.lcode
