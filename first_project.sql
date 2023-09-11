use school_proj;

#First check 
select * 
from schools;

#Notices the empty value in percent_tested. Updates table to use the null value instead
Update schools
set percent_tested = null
where percent_tested = 0;

#Check to see updated table
select * 
from schools;

#Checking the proportion of missing values in the column in relation to the entire table
SELECT COUNT(*) - COUNT(PERCENT_TESTED) AS NUM_TESTED_MISSING, COUNT(*) AS NUM_SCHOOLS
FROM SCHOOLS;

#About 5 % missing values - Neither good or bad, but something to keep in mind

# Question: Count the number of unique building_code values
SELECT COUNT(DISTINCT BUILDING_CODE) AS NUM_SCHOOL_BUILDINGS
FROM SCHOOLS;

#About 62 % are unique values 

#Question: Find all schools with an average math score of at least 80% of the possible 800.
SELECT SCHOOL_NAME, AVERAGE_MATH
FROM SCHOOLS
WHERE AVERAGE_MATH >= 640
ORDER BY AVERAGE_MATH DESC;

#10 returned rows with an average math score of at least 640

#Question: Find the single lowest score for reading
SELECT MIN(AVERAGE_READING) AS LOWEST_READING
FROM SCHOOLS;

#The rating is 38 % out of the available points

#Question: Find the school with the highest average writing score.
SELECT SCHOOL_NAME, MAX(AVERAGE_WRITING) AS MAX_WRITING
FROM SCHOOLS
GROUP BY SCHOOL_NAME
ORDER BY MAX_WRITING DESC
LIMIT 1;

#Top score of 693 out of 800 possible points

#Question: Let's look at scores across reading, writing, and math to find the top 10 performing schools 
SELECT SCHOOL_NAME, SUM(AVERAGE_MATH + AVERAGE_READING + AVERAGE_WRITING) AS AVERAGE_SAT
FROM SCHOOLS
GROUP BY SCHOOL_NAME
ORDER BY AVERAGE_SAT DESC
LIMIT 10;

#4 schools with a score above 2000

#Question: Build a query that calculates the number of schools and the average SAT score per borough
SELECT BOROUGH, COUNT(*) AS NUM_SCHOOLS, 
ROUND(SUM(AVERAGE_MATH + AVERAGE_READING + AVERAGE_WRITING) / COUNT(*)) AS AVERAGE_BOROUGH_SAT
FROM SCHOOLS
GROUP BY BOROUGH
ORDER BY AVERAGE_BOROUGH_SAT DESC;

#Staten Island with 10 schools are the top scorer across the board.

#QUESTION: Let's focus on Brooklyn. We wish to find the top five schools for math performance.
SELECT SCHOOL_NAME, AVERAGE_MATH
FROM SCHOOLS
WHERE BOROUGH = 'Brooklyn'
GROUP BY SCHOOL_NAME, AVERAGE_MATH
ORDER BY AVERAGE_MATH DESC
LIMIT 5;
