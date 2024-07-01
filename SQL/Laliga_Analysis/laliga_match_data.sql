
-- creating a new database 
CREATE DATABASE laliga_data;

select * from laliga_match_data;
 
 
 -- CLEANING
 
 -- 1. Creating a staging table to work on 
 
 Create table laliga_match_data_staging like laliga_match_data;
 
 insert laliga_match_data_staging 
 select * from laliga_match_data;
 
 select * from laliga_match_data_staging;
 
 -- Checking if there is anty duplicates 
 
 with duplicate_cte as (
 select * , 
 row_number () over (partition by `date`, team , opponent ) as row_num 
 from laliga_match_data_staging
 ) 
  
 select * from duplicate_cte where row_num > 1;      -- returned 0 
 
 select * from laliga_match_data_staging;
 
 -- Renaming columns 
 
 Alter  table laliga_match_data_staging
 rename column `date` to match_date;
 
 Alter  table laliga_match_data_staging
 rename column  poss to  possession;
 
  Alter  table laliga_match_data_staging
 rename column  sh  to  shot;
 
  Alter  table laliga_match_data_staging
 rename column  sot  to  shot_on_target;
 
   Alter  table laliga_match_data_staging
 rename column  dist  to  distance_covered;
 
 Alter  table laliga_match_data_staging
 rename column  fk  to  freekick;
 
  Alter  table laliga_match_data_staging
 rename column  pk  to  penalty_kick;
 
 
 -- ANALYSIS -- 
 
 select * from laliga_match_data_staging;
 
-- 1. most wins for a team  across three season (2023/2022/2021)

select season, team, most_wins from (
(select season, team , most_wins , 
ROW_NUMBER() over (PARTITION BY season  order by most_wins desc) as row_num from 
		(select season , team , count(result ) as most_wins
		from laliga_match_data_staging
		where result = 'W'
		group by season, team) as  subquery1)
        ) as subquery2 
where row_num <=3
order by season desc, most_wins desc;






-- 2. Average possession  per season 
select season , team , avg(possession) as average_possession
from laliga_match_data_staging
group by season, team 
order by season desc , average_possession desc;

-- 3. most shot vs most shot on target 

select  season, team ,avg(shot) as avg_shot_attempted, avg(shot_on_target) as avg_shot_on_target from 
laliga_match_data_staging 
group by season, team 
order by season desc ,  avg_shot_attempted desc;


-- 4. top 10 games with most attendance

select season , team , opponent,  round(avg(attendance), 0) as avg_attendance
from laliga_match_data_staging 
group by season , team, opponent  
order by avg_attendance desc
limit 10;


-- 5. best  / worse home  records 

select team ,  season,  count(result) as best_home_record 
from laliga_match_data_staging
where venue = 'home' and (result  = 'W' OR result = 'D')
group by season , team 
order by season desc , best_home_record desc;

-- 6. best / worse away records 

select team ,  season,  count(result) as best_away_record 
from laliga_match_data_staging
where venue = 'away' and (result  = 'W' OR result = 'D')
group by season , team 
order by season desc , best_away_record desc;


-- 7.  Which  team is perfoming better overall ? 

-- We are gonna compare this with the following metrics 
		-- goal scored 
        -- goal conceded 
		-- xg  -  means how many chances your team is getting to score a goal 
        -- xga  - means how many chances your opponent is getting to score a goal against your team 
    
    --   Idea behind this is 
     --  if avg of goal scored is greater than the average of xg( chance created ) and 
      -- if avg of goal conceded is less than average of xga(chanced conceded) then we can 
      -- that they are overpoforming  
      
      
With perfomance_cte as (
select season , team ,  round(avg(goal_for), 2) as avg_goal_scored, round(avg(goal_against) , 2) as avg_goal_conceded, 
     round(avg(xg), 2)  as avg_chance_created ,  round(avg(xga), 2) as avg_chance_conceded  
     from laliga_match_data_staging
     group by season , team  
     )
     
     
        
select season , team ,  avg_chance_created,  avg_goal_scored,  avg_chance_conceded  ,avg_goal_conceded,
     Case 
      When  avg_goal_scored > avg_chance_created && avg_goal_conceded < avg_chance_conceded Then 'Yes'
      Else 'No' 
      End as OverPerforming 
from perfomance_cte 
group by season , team  
order by season desc ,avg_chance_created desc; 


-- 8. Most goal scored vs conceded across seasons 

select season, team , sum(goal_for) as goals_scored, sum(goal_against) as goal_conceded, (sum(goal_for) - sum(goal_against)) as goal_difference 
    from laliga_match_data_staging 
    group by season , team 
    order by season desc , goal_difference desc ;





 
 
 
 
 
 
 
 
 

