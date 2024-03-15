---A query to count the tracks in the track table whose media type is MPEG---
SELECT COUNT(*) AS tracks_tally
  FROM track
 WHERE media_type_id IN (SELECT media_type_id
                           FROM media_type
                          WHERE name LIKE '%MPEG%');


---a query to return customer invoices where the first name (first_name) starts with the letter A---
SELECT *
  FROM invoice
 WHERE customer_id IN (SELECT customer_id
                         FROM customer
                         WHERE SUBSTRING(first_name, 1, 1) = 'A'
					   )
 
  
  ---a query to select the names (first_name and last_name) from the customer table where customer_id is not in the customer identifiers whose total purchase amount is less than a hundred dollars(using subquery concept).---
 SELECT first_name || ' ' || last_name AS customer_name
  FROM customer
 WHERE customer_id NOT IN (
						   SELECT customer_id
                             FROM invoice
                         GROUP BY customer_id
                           HAVING SUM(total) < 100
						  )
 
  
  --- a query to compute the average number of sales per billing city---
 SELECT AVG(billing_city_tally) AS billing_city_tally_avg
FROM   (
         SELECT billing_city, COUNT(*) AS billing_city_tally
           FROM invoice
          GROUP BY billing_city)

  
  ---a query to select customer name along with the average purchases they made---
SELECT c.first_name||' '||c.last_name,i.total_avg 
  FROM customer c 
  JOIN (   SELECT i.customer_id,AVG(i.total) AS total_avg 
             FROM invoice i
             GROUP BY customer_id
		) AS i 
    ON c.customer_id = i.customer_id

  
  ---query to select the country and the average number of sales per country per customer.---
SELECT ct.country, 
        i.invoice_tally / ct.customer_tally AS sale_avg_tally
   FROM (SELECT billing_country, COUNT(*) AS invoice_tally
           FROM invoice
          GROUP BY billing_country) AS i
   JOIN (SELECT country, COUNT(*) AS customer_tally
           FROM customer
          GROUP BY country) AS ct
     ON i.billing_country = ct.country
  ORDER BY sale_avg_tally DESC;


---query to find the average sale per customer using nested subquery---  
SELECT last_name, 
       first_name, 
       (SELECT AVG(total)
          FROM invoice i
         WHERE c.customer_id = i.customer_id) total_avg
  FROM customer c;
  

--- a query to display all invoices where the total purchase amount (total) is greater than the average purchase amount in the same country---
  SELECT *
  FROM invoice i1
 WHERE total > (SELECT AVG(total)
                  FROM invoice i2
                 WHERE i1.billing_country = i2.billing_country);


---a query to display all tracks that have never been sold---
SELECT * 
  FROM track t 
 WHERE NOT EXISTS (SELECT * 
                     FROM invoice_line il 
                    WHERE t.track_id = il.track_id);


---a query that uses nested subqueries to find employees by last_name and first_name involved in transactions where the customers total purchase amount is greater than one hundred dollars.---
SELECT last_name, first_name
  FROM employee
 WHERE employee_id IN (SELECT support_rep_id
                         FROM customer
                        WHERE customer_id IN (SELECT customer_id
                                                FROM invoice
                                            GROUP BY customer_id
                                              HAVING SUM(total) > 100));


---query to select the city and the average number of sales per city using CTE---
WITH
city_sales_table AS (
SELECT billing_city, COUNT(*) AS billing_city_tally
  FROM invoice
 GROUP BY billing_city
)
SELECT AVG(billing_city_tally) AS billing_country_tally_avg
  FROM city_sales_table;


---query to find the average sale per country per customer using CTE ---
WITH
country_invoice_total_table AS (
  SELECT billing_country, SUM(total) AS invoice_total
    FROM invoice
   GROUP BY billing_country
),
country_total_table AS (
  SELECT country, COUNT(*) AS customer_tally
    FROM customer
   GROUP BY country
)
  SELECT ct.country, 
         ROUND(i.invoice_total / ct.customer_tally, 2) AS sale_avg
    FROM country_invoice_total_table  AS i
    JOIN country_total_table AS ct
      ON i.billing_country = ct.country
   ORDER BY sale_avg DESC
   LIMIT 5;
