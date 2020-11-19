use house_price_regression;
select * from regression_data_clean;

#change the conditions name to condit as it gives problems

# some of the ids are duplicates. check if the rows are duplicates too so you can remove them

#Use the alter table command to drop the column date from the database, as we would not use it in the analysis with SQL. 
ALTER TABLE regression_data_clean DROP COLUMN date; 

#Select all the data from the table to verify if the command worked. Limit your returned results to 10.
SELECT*FROM regression_data_clean 
LIMIT 10;

#Use sql query to find how many rows of data you have.
SELECT COUNT(*) FROM regression_data_clean; 
#RESULT: 21597

#What are the unique values in the column bedrooms?
SELECT DISTINCT bedrooms from regression_data_clean; 
#RESULT:(1,2,3,4,5,6,7,8,9,10,11,33)

#What are the unique values in the column bathrooms?
SELECT DISTINCT bathrooms from regression_data_clean;

#What are the unique values in the column bathrooms?
SELECT DISTINCT bathrooms from regression_data_clean;

#What are the unique values in the column floors?
SELECT DISTINCT floors from regression_data_clean;
#RESULT: 1,2,3,4

#What are the unique values in the condition grade?
SELECT DISTINCT condition FROM regression_data_clean;

#What are the unique values in the column grade?
SELECT DISTINCT grade FROM regression_data_clean;
#result 3,4,5,6,7,8,9,10,11,12,13

#Arrange the data in a decreasing order by the price of the house. 
#Return only the IDs of the top 10 most expensive houses in your data.
SELECT id from regression_data_clean
ORDER BY price DESC LIMIT 10;

#What is the average price of all the properties in your data?
SELECT avg(price) from regression_data_clean;
#RESULT: '540296.5735'

#What is the average price of the houses grouped by bedrooms? 
#The returned result should have only two columns, bedrooms and Average of the prices. 
#Use an alias to change the name of the second column.
select bedrooms, avg(price) as avg_price
from regression_data_clean
group by bedrooms; 

#What is the average sqft_living of the houses grouped by bedrooms? 
#The returned result should have only two columns, bedrooms and Average of the sqft_living. 
#Use an alias to change the name of the second column.
select bedrooms, avg(sqft_living) as avg_sqftliving
from regression_data_clean
group by bedrooms; 

#What is the average price of the houses with a waterfront and without a waterfront? 
#The returned result should have only two columns, waterfront and Average of the prices. 
#Use an alias to change the name of the second column.
select waterfront, avg(price) as avg_price
from regression_data_clean
group by waterfront; 

#Is there any correlation between the columns condition and grade? 
#You can analyse this by grouping the data by one of the variables and then 
#aggregating the results of the other column. 
#Visually check if there is a positive correlation or negative correlation or no correlation between the variables.

select grade, avg(condit) as avg_condition
from regression_data_clean
group by grade
order by grade; 

select avg(grade), condit as avg_condition
from regression_data_clean
group by condit
order by condit; 

#One of the customers is only interested in the following houses:
#Number of bedrooms either 3 or 4
#Bathrooms more than 3
#One Floor
#No waterfront
#Condition should be 3 at least
#Grade should be 5 at least
#Price less than 300000
#For the rest of the things, they are not too concerned. Write a simple query to find what are the options available for them?

SELECT bedrooms, bathrooms, floors, waterfront, grade, price 
FROM regression_data_clean
WHERE bedrooms = 3 OR bedrooms = 4 AND bathrooms > 3
AND floors = 1
AND waterfront = 0
AND condit >= 3
AND grade >= 5
AND price < 300000
order by price; 

#Your manager wants to find out the list of properties whose prices are twice more than the 
#average of all the properties in the database. 
#Write a query to show them the list of such properties. You might need to use a sub query for this problem.
SELECT id, price from regression_data_clean 
WHERE price >= 2*(
SELECT avg(price) from regression_data_clean
); 

#Since this is something that the senior management is regularly interested in, create a view of the same query.
create view avg_price as 
SELECT id, price from regression_data_clean 
WHERE price >= 2*(
SELECT avg(price) from regression_data_clean); 

#Most customers are interested in properties with three or four bedrooms. 
#What is the difference in average prices of the properties with three and four bedrooms?

create view three_price as SELECT avg(price) as price_three from regression_data_clean WHERE bedrooms = 3;
create view four_price as SELECT avg(price) as price_four from regression_data_clean WHERE bedrooms = 4;

#SELECT price_three from three_price, SELECT price_four from four_price,  (price_four - price_three) as price_diff;

SELECT price_three , price_four,(price_four - price_three) as price_diff
FROM three_price JOIN
four_price;

#What are the different locations where properties are available in your database? (distinct zip codes)
SELECT distinct zipcode from regression_data_clean;

#Show the list of all the properties that were renovated.
select id from regression_data_clean 
where yr_renovated > 0;

#Provide the details of the property that is the 11th most expensive property in your database.
SELECT * from regression_data_clean order by price desc limit 10,1; 

