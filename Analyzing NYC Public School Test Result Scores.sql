-- Dataset: Datacamp SQL Project Intermediate
-- Queried using: MySQL Workbench, postgreSQL

-- CASE 1
-- Select all columns from the database
-- Display only the first ten rows
select * from schools
limit 10;

-- CASE 2
-- Count rows with percent_tested missing and total number of schools
select
    count(*) - count(percent_tested) as num_tested_missing,
    count(*) as num_schools
from schools;

-- CASE 3
-- Count the number of unique building_code values
select count(distinct(building_code)) as num_school_buildings
from schools;

-- CASE 4
-- Select school and average_math
-- Filter for average_math 640 or higher
-- Display from largest to smallest average_math
select 
    school_name,
    average_math
from schools
where average_math > 640
order by average_math desc;

-- CASE 5
-- Find lowest average_reading
select min(average_reading) as lowest_reading from schools;

-- CASE 6
-- Find the top score for average_writing
-- Group the results by school
-- Sort by max_writing in descending order
-- Reduce output to one school
select
    school_name,
    max(average_writing) as max_writing
from schools
group by school_name
order by max_writing desc
limit 1;

-- CASE 7
-- Calculate average_sat
-- Group by school_name
-- Sort by average_sat in descending order
-- Display the top ten results
select 
    school_name,
    sum(average_math+average_reading+average_writing) as average_sat
from schools
group by school_name
order by average_sat desc
limit 10;

-- CASE 8
-- Select borough and a count of all schools, aliased as num_schools
-- Calculate the sum of average_math, average_reading, and average_writing, divided by a count of all schools, aliased as average_borough_sat
-- Organize results by borough
-- Display by average_borough_sat in descending order
select
    borough,
    count(*) as num_schools,
    sum(average_math+average_reading+average_writing)/count(school_name) as average_borough_sat
from schools
group by borough
order by average_borough_sat desc;

-- CASE 9
-- Select school and average_math
-- Filter for schools in Brooklyn
-- Aggregate on school_name
-- Display results from highest average_math and restrict output to five rows
select 
    school_name,
    average_math
from schools
where borough = 'Brooklyn'
group by school_name
order by average_math desc
limit 5;
