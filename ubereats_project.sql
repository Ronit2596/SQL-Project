create database ubereats_db;
use  ubereats_db;

select *
from ubereats;

select *
from countrytable;

/*Top-Rated Restaurants:
Retrieve the top-rated restaurants in each country*/

WITH TopRestaurants AS (
    SELECT
		CountryCode,
        RestaurantID,
        City,
        Rating,
        ROW_NUMBER() OVER (PARTITION BY CountryCode ORDER BY Rating DESC) AS rn
    FROM
		ubereats
)
SELECT *
FROM
      TopRestaurants tr
JOIN
     countrytable c using(CountryCode)
WHERE
    tr.rn = 1;
    
/*Identify the top three most popular cuisines across all countries.*/

SELECT Cuisines,COUNT(*) AS mostpopular
FROM ubereats
GROUP BY Cuisines
ORDER BY mostpopular DESC
LIMIT 3;

 /*Find the top cities that offer online delivery in each country.*/
 
 select CountryCode,City,count(Has_Online_delivery)as OnlineDelivery
 from ubereats
 where Has_Online_delivery ='Yes'
 group by CountryCode,City
 order by OnlineDelivery desc;
 
/*Analyze the relationship between the average 
cost for two and the rating of restaurants.*/

 select RestaurantID,avg(Average_Cost_for_two)as avgcost,Rating
 from ubereats
 group by Rating,RestaurantID
 order by Rating desc;

 /*Determine the average number of votes for restaurants in each country by
 descending order.*/
 select CountryCode,avg(Votes)as avgvotes
 from ubereats
 group by CountryCode
 order by avgvotes desc;
 
/*Find the top-rated restaurant in each price range.*/

with Topratedresturent as(
select *,
row_number()over(partition by Price_range order by Rating desc)as rnk
from ubereats)
select * from Topratedresturent
where rnk=1;





