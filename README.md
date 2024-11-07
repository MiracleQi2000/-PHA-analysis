# PHA-analysis

This repository contains the source **SQL CODE** using on Unicom database, self-defined **DATA** used for analysis, and **R CODE** for visualization that have been used in the Potential Harmdul APP (PHA) - Digital Inequality Analysis.
The database is the phone use record of the uesrs of wireless carrier China Unicom, including 10 time points: 2019-05, 2019-11, 2020-05, 2020-11, 2021-05, 2021-11, 2022-05, 2022-11, 2023-05, 2023-11.


**SQL CODE**

1-Define population
> Select people with unchange id, gender, and proper change of age;

> Match people who have residency records at all 10 time points in time and are all frequent users in Shenzhen;

> Match people who have APP use records at all 10 time points;

> Final population: 567,101
  
2-APP use

> Describe the distribution of the number of users per number of APPs (including PHAs and Other normal APPs) used at each time point

3-PHA use

> Describe the distribution of the number of users per number of PHAs used at each time point;

> Describe the average number of PHAs used by each age/gender/income group

4-PHA supply

> Extract active PHA list of each timep point;

> Extract demographics of new users of original PHA at each time point;

> Extract aggregate use traffic and time of each PHA and Other APP at each time point;

> Extract aggregate and average use traffic and time of each time point

5-Income

> Describe the distribution of the number of users and average APP usage of each phone brand and type at each time point;

6-Mechanism test-01

> Define Other APP list;

> Define 10 levels of personal income, using average phone price of 10 time points of one person as an index;

> Describe the distribution of the number of users of each PHA (original and newly created) at each time point

7-mechanism test-02

> X Panel error

8-mechanism test-03√

> Quantify the three dimensions

> Draw figures of the average user age/female proportion/income level at each time point of the original/newly created PHA/APP

9-mechanism test - top use

> Extract the user number of each PHA/APP for each age/gender/income group;

> Figure out the top 50 use of each group;

> Build relationship between group and PHA/APP category

10-mechanism test - phone system

> Distinguish phone system into ios and Android;

> Descirbe the distribution of the average PHA/APP usage of the two phone systems users at each time point;

> Describe the distribution of the number of users of each PHA/APP of each phone system at each time point 


**DATA**
Imported files (self-defined out of the database)

> PHA list (organized using data on the website of Ministry of Industry and Information Technology of the People's Republic of China, https://www.miit.gov.cn/)

> newlycreatedPHA (create time of each PHA)

> phone price (only includes phones that have users more than or equal to 50, with missing prices for a few indistinguishable phone brandd and types, organized by Professor WeiMing YE)
