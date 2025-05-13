-- Football Match exercise
 
/*
The FootballMatch table shows the EPL matches played in 2024/25 season as of 16th March 2025
 
Important Columns
Date - Match Date (dd/mm/yy)
Time - Time of match kick off
HomeTeam- Home Team
AwayTeam - Away Team
FTHG -Full Time Home Team Goals
FTAG - Full Time Away Team Goals
FTR - Full Time Result (H=Home Win, D=Draw, A=Away Win)
 
Full details at https://zomalex.co.uk/datasets/football_match_dataset.html
*/
 
SELECT
    fm.Date
    , fm.HomeTeam
    , fm.AwayTeam
    , fm.FTHG
    , fm.FTAG
    , fm.FTR
FROM
    FootballMatch fm;
 
/*
How many games have been played?.  
- In total
- By each team
- By Month
*/
 
-- How many goals have been scored in total

/* 
How many matches played
Select COUNT(*) as Number_of_Matches
from FootballMatch 
*/

--how many games played in Sep Oct Nov

SELECT
    DATENAME(YEAR, fm.[Date]) AS Year_Name,
    DATENAME(MONTH, fm.[Date]) AS MONTH_Name,
    MONTH(fm.DATE) AS Month_Number,
    COUNT(*) AS Number_of_Matches
FROM
    FootballMatch fm
GROUP BY 
    MONTH(fm.DATE), 
    DATENAME(Month, fm.[Date]), 
    DATENAME(YEAR, fm.[Date])
order by 
    Year_Name DESC, 
    Month_Number DESC --can you alias in order by

Select MONTH('2025-05-13') as MONTH
select DATEPART(Month, '2025-05-13') as MONTH
select DATENAME(Month, '2025-05-13') as MONTH;

--how many goals in total

Select

SUM(fm.FTAG) + SUM(fm.FTHG) as Total_Goals

From FootballMatch fm;

--ok

SELECT
    fm.HomeTeam as Team,
    sum(fm.FTHG) as Goals
FROM
    FootballMatch fm
GROUP BY 
    fm.HomeTeam

 UNION

 SELECT
    fm.AwayTeam as Team,
    sum(fm.FTAG) as Goala
FROM
    FootballMatch fm
GROUP BY 
    fm.AwayTeam


--As CTE

;
WITH
    CTE
    AS
    (
                    SELECT
                fm.HomeTeam AS Team,
                sum(fm.FTHG) AS TotalGoals
            FROM
                FootballMatch fm
            GROUP BY 
    fm.HomeTeam

        UNION ALL

            SELECT
                fm.AwayTeam,
                sum(fm.FTAG)
            FROM
                FootballMatch fm
            GROUP BY 
    fm.AwayTeam
    )
SELECT CTE.Team, sum(CTE.TotalGoals)AS Total_Goals
FROM CTE
GROUP BY 
CTE.Team

ORDER BY
CTE.Team;

--new
/* DROP TABLE IF EXISTS #LeagueTable;

SELECT
    fm.HomeTeam,
    sum(fm.FTHG) AS Goals
INTO#LeagueTable
FROM
    FootballMatch fm
GROUP BY 
    fm.HomeTeam

 UNION ALL

SELECT
    fm.AwayTeam,
    sum(fm.FTAG)

FROM
    FootballMatch fm
GROUP BY 
    fm.AwayTeam

Select t.HomeTeam As Team, SUM(T.Goals) as Total_Goals
from #LeagueTable t
group by t.HomeTeam
order by t.HomeTeam;
Fix the error
*/ 

DROP TABLE IF EXISTS #LeagueTable;
 
SELECT
    fm.HomeTeam as Team
    , SUM(fm.FTHG) AS GF
INTO #LeagueTable
FROM
    FootballMatch fm
group by fm.HomeTeam
UNION ALL
SELECT
    fm.AwayTeam
    , SUM(fm.FTAG)
FROM
    FootballMatch fm
group by fm.AwayTeam  
 
SELECT * FROM #LeagueTable;
 
SELECT t.Team As Team,
    SUM(T.GF) as GF
FROM #LeagueTable t
    group by t.Team
    order by t.Team

--Select * from #LeagueTable

DROP TABLE IF EXISTS #LeagueTable;
 
SELECT
    fm.HomeTeam as Team
    , SUM(fm.FTHG) AS GF
    , '???' as GA
INTO #LeagueTable
FROM
    FootballMatch fm
group by fm.HomeTeam
UNION ALL
SELECT
    fm.AwayTeam
    , SUM(fm.FTAG)
    ,'???'
FROM
    FootballMatch fm
group by fm.AwayTeam  
 
SELECT * FROM #LeagueTable;
 
SELECT t.Team As Team,
    SUM(T.GF) as GF
FROM #LeagueTable t
    group by t.Team
    order by t.Team;
 
--GA (Goal Against)

DROP TABLE IF EXISTS #LeagueTable;
 
SELECT
    fm.HomeTeam as Team
    , SUM(fm.FTHG) AS GF
    , SUM(FTAG) as GA
    --, '???' as GA
INTO #LeagueTable
FROM
    FootballMatch fm
group by fm.HomeTeam
UNION ALL
SELECT
    fm.AwayTeam
    , SUM(fm.FTHG) as GF
    ,SUM(FTAG) as GA
FROM
    FootballMatch fm
group by fm.AwayTeam  
 
--SELECT * FROM #LeagueTable;
 
SELECT t.Team As Team,
    SUM(T.GF) as GF,
    SUM(T.GA) as GA
FROM #LeagueTable t
    group by t.Team
    order by t.Team;
 
-- from Imran

DROP TABLE IF EXISTS #LeagueTable;
 
SELECT
    fm.HomeTeam AS Team
    ,SUM(fm.FTHG) AS GF
    ,SUM(fm.FTAG) AS GA
INTO #LeagueTable
    FROM FootballMatch fm
    GROUP BY fm.HomeTeam
UNION ALL
SELECT
        fm.AwayTeam    
        ,SUM(fm.FTAG)
        ,SUM(fm.FTHG)
FROM  FootballMatch fm
GROUP BY fm.AwayTeam;
 
SELECT
    t.Team AS Team
    ,SUM(T.GF) AS GF    
    ,SUM(T.GA) AS GA
FROM
    #LeagueTable t
GROUP BY t.Team
ORDER BY t.Team;

--number of games played

DROP TABLE IF EXISTS #LeagueTable;
 
SELECT
    1 as Played
    ,fm.HomeTeam AS Team
    ,SUM(fm.FTHG) AS GF
    ,SUM(fm.FTAG) AS GA
INTO #LeagueTable
    FROM FootballMatch fm
    GROUP BY fm.HomeTeam
UNION ALL
SELECT
        1 as Played
        ,fm.AwayTeam    
        ,SUM(fm.FTAG)
        ,SUM(fm.FTHG)
FROM  FootballMatch fm
GROUP BY fm.AwayTeam;
 
SELECT
    t.Team AS Team
    ,sum(Played) as Played
    ,SUM(T.GF) AS GF    
    ,SUM(T.GA) AS GA
FROM
    #LeagueTable t
GROUP BY t.Team
ORDER BY t.Team;
 
--again trying

DROP TABLE IF EXISTS #LeagueTable;
 
SELECT
    fm.HomeTeam as Team
    ,count(*) as Played
    ,SUM(fm.FTHG) AS GF
    ,SUM(fm.FTAG) AS GA
INTO #LeagueTable
    FROM FootballMatch fm
    GROUP BY fm.HomeTeam
UNION ALL
SELECT
        fm.AwayTeam 
        ,count(*) as Played   
        ,SUM(fm.FTAG)
        ,SUM(fm.FTHG)
FROM  FootballMatch fm
GROUP BY fm.AwayTeam;
 
SELECT
    t.Team AS Team
    ,sum(t.Played) as Played
    ,SUM(t.GF) AS GF    
    ,SUM(t.GA) AS GA
FROM
    #LeagueTable t
GROUP BY t.Team
ORDER BY t.Team;
 

 --corrected

 DROP TABLE IF EXISTS #LeagueTable;
 
SELECT
    fm.HomeTeam AS Team
    ,COUNT(*) as Played
    ,SUM(fm.FTHG) AS GF
    ,SUM(fm.FTAG) AS GA
INTO #LeagueTable
    FROM FootballMatch fm
    GROUP BY fm.HomeTeam
UNION ALL --need to be same number columns in both tables
SELECT
        fm.AwayTeam    
        ,COUNT(*) as Played
        ,SUM(fm.FTAG)
        ,SUM(fm.FTHG)
FROM  FootballMatch fm
GROUP BY fm.AwayTeam;
 
SELECT
    t.Team AS Team
    ,SUM(t.Played) AS Played
    ,SUM(T.GF) AS GF    
    ,SUM(T.GA) AS GA
FROM
    #LeagueTable t
GROUP BY t.Team
ORDER BY t.Team;

--case statement
 
 DROP TABLE IF EXISTS #LeagueTable;
 
SELECT
    fm.HomeTeam AS Team
    ,COUNT(*) as Played
    ,sum(case fm.FTR when 'H' then 1 Else 0 End) as Won
    ,SUM(fm.FTHG) AS GF
    ,SUM(fm.FTAG) AS GA
INTO #LeagueTable
    FROM FootballMatch fm
    GROUP BY fm.HomeTeam
UNION ALL --need to be same number columns in both tables
SELECT
        fm.AwayTeam 
        ,COUNT(*) as Played
        ,sum(case fm.FTR when 'A' then 1 else 0 end) as Won  
        ,SUM(fm.FTAG)
        ,SUM(fm.FTHG)
FROM  FootballMatch fm
GROUP BY fm.AwayTeam;
 
SELECT
    t.Team AS Team
    ,SUM(t.Played) AS Played
    ,SUM(t.won) as Won
    ,SUM(T.GF) AS GF    
    ,SUM(T.GA) AS GA
FROM
    #LeagueTable t
GROUP BY t.Team
ORDER BY t.Team;

--better way to use group by

DROP TABLE IF EXISTS #LeagueTable;
 
SELECT
    fm.HomeTeam AS Team
   -- ,COUNT(*) as Played
   -- ,sum(case fm.FTR when 'H' then 1 Else 0 End) as Won
    ,fm.FTHG AS GF
    ,fm.FTAG AS GA
INTO #LeagueTable
    FROM FootballMatch fm
    --GROUP BY fm.HomeTeam
UNION ALL --need to be same number columns in both tables
SELECT
        fm.AwayTeam 
        --,COUNT(*) as Played
       -- ,sum(case fm.FTR when 'A' then 1 else 0 end) as Won  
        ,fm.FTAG
        ,fm.FTHG
FROM  FootballMatch fm
--GROUP BY fm.AwayTeam;
 
SELECT
    t.Team AS Team
    --,SUM(t.Played) AS Played
    --,SUM(t.won) as Won
    ,count(*) AS Played
    ,SUM(T.GF) AS GF    
    ,SUM(T.GA) AS GA
FROM
    #LeagueTable t
GROUP BY t.Team
ORDER BY t.Team;

-- 1
DROP TABLE IF EXISTS #LeagueTable;
 
SELECT
    fm.HomeTeam AS Team
    ,case when fm.FTR = 'H' then 1 else 0 end as won
    ,fm.FTHG AS GF
    ,fm.FTAG AS GA
INTO #LeagueTable
    FROM FootballMatch fm
UNION ALL --need to be same number columns in both tables
SELECT
        fm.AwayTeam 
        ,case fm.FTR when 'A' then 1 else 0 end as Won  
        ,fm.FTAG
        ,fm.FTHG
FROM  FootballMatch fm
 
SELECT
    t.Team AS Team
    ,count(*) AS Played
    ,sum(t.won) as Won
    ,SUM(T.GF) AS GF    
    ,SUM(T.GA) AS GA
FROM
    #LeagueTable t
GROUP BY t.Team
ORDER BY t.Team;

--Simple version

DROP TABLE IF EXISTS #LeagueTable;

    SELECT
        fm.HomeTeam AS Team
    , CASE WHEN fm.FTR = 'H' THEN 1 ELSE 0 END AS Won
    , CASE WHEN fm.FTR = 'D' THEN 1 ELSE 0 END AS Drawn
    , fm.FTHG AS GF
    , fm.FTAG AS GA
    INTO #LeagueTable
    FROM FootballMatch fm
UNION ALL
    SELECT
        fm.AwayTeam
    , CASE WHEN fm.FTR = 'A' THEN 1 ELSE 0 END AS Won
    , CASE WHEN fm.FTR = 'D' THEN 1 ELSE 0 END AS Drawn
    , fm.FTAG
    , fm.FTHG
    FROM FootballMatch fm

SELECT *
FROM #LeagueTable;

SELECT
    t.Team AS Team
    , count(*) AS Played
    , SUM(t.Won) AS Won
    , SUM(t.Drawn) AS Drawn
    , SUM(T.GF) AS GF    
    , SUM(T.GA) AS GA
FROM
    #LeagueTable t
GROUP BY t.Team
ORDER BY t.Team;
 
--points calculation
