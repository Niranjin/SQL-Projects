
--1.Query showing Customers (just their full names, customer ID and country) who are not in the US.---
SELECT c.FirstName as "First Name", c.LastName as "Last Name", c.CustomerId as "Customer ID", c.Country as "Country"
  FROM Customer c 
 WHERE c.Country != "USA";
 
 
---2.query only showing the Customers from Brazil.---
SELECT c.FirstName as "First Name", c.LastName as "Last Name", c.CustomerId as "Customer ID", c.Country as "Country"
  From Customer c
 WHERE c.Country = "Brazil";
 
 
---3.Which sales agent made the most in sales in 2017?---
SELECT e.first_name || ' ' || e.last_name as employee_name,
       ROUND(SUM(i.total), 2) as total_sales
FROM employee e
JOIN customer c ON e.employee_id = c.support_rep_id
JOIN invoice i ON c.customer_id = i.customer_id
WHERE strftime('%Y', i.invoice_date) = '2017'
GROUP BY e.first_name, e.last_name
ORDER BY total_sales DESC
LIMIT 1;


---4.Which sales agent made the most in sales over all---
SELECT e.first_name || ' ' || e.last_name AS employee_name,
       ROUND(SUM(i.total), 2) AS total_sales 
  FROM employee e 
  JOIN customer c ON e.employee_id = c.support_rep_id 
  JOIN invoice i ON c.customer_id = i.customer_id 
 GROUP BY e.first_name, e.last_name 
 ORDER BY total_sales DESC 
 LIMIT 1;
 
 
---5.Provide a query that shows the most purchased track of 2013.---
SELECT t.name AS track_name, COUNT(i.invoice_id) AS total_purchases 
 FROM track t 
 JOIN invoice_line il ON t.track_id = il.track_id 
 JOIN invoice i ON il.invoice_id = i.invoice_id 
WHERE strftime('%Y', i.invoice_date) = '2017' 
GROUP BY t.name 
ORDER BY total_purchases DESC;


---6.query that, for each invoice, returns all the columns in the invoice table, plus the first name of the employee who handled that invoice---
SELECT i.*, e.first_name
  FROM invoice i
  JOIN customer c ON i.customer_id = c.customer_id
  JOIN employee e ON e.employee_id = c.support_rep_id;
  
  
---7.A query that displays the names of all reports and their managers---
SELECT e1.first_name || ' ' || e1.last_name AS report, 
        e2.first_name || ' ' || e2.last_name AS manager
FROM employee AS e1
JOIN employee AS e2 ON e1.reports_to = e2.employee_id;


---8.Provide a list of all songs in track and the number of times each track appeared in purchases during 2020.---
SELECT t.track_id, t.name,
       COUNT(i.invoice_id) AS no_of_purchases
  FROM track AS t
  LEFT JOIN invoice_line AS il
    ON t.track_id = il.track_id
  LEFT JOIN invoice AS i
    ON il.invoice_id = i.invoice_id AND invoice_date LIKE '2020%'
 GROUP BY t.track_id, t.name;
 
 
---9.Write a query that displays one invoice per row along with the running total---
 SELECT i1.invoice_id, i1.invoice_date, i1.total, ROUND(SUM(i2.total), 2) AS running_total
  FROM invoice AS i1
  JOIN invoice AS i2
    ON i1.invoice_id >= i2.invoice_id AND i1.invoice_date >= i2.invoice_date
 GROUP BY i1.invoice_id, i1.invoice_date, i1.total;
 
 
---10.Identify the top 3 customers who spent the most money overall in the last quarter of 2017.
 -- Calculate the start date and end date of the last quarter of 2017
WITH LastQuarter AS (
    SELECT 
        DATE('2021-10-01') AS start_date,
        DATE('2021-12-31') AS end_date
)

-- 11.Retrieve sales data for the last quarter of 2021 and calculate total spending for each customer
SELECT c.customer_id, c.first_name || ' ' || c.last_name AS customer_name,ROUND(SUM(i.total), 2) AS total_spending
  FROM LastQuarter lq
  JOIN invoice i ON i.invoice_date BETWEEN lq.start_date AND lq.end_date
  JOIN customer c ON i.customer_id = c.customer_id
 GROUP BY c.customer_id, customer_name
 ORDER BY total_spending DESC
 LIMIT 3;
 
 
---12.Identify the top 5 best-selling products and their total sales revenue---
WITH total_revenue AS (
    SELECT 
        t.track_id,
        ROUND(SUM(il.unit_price * il.quantity), 2) AS total_sales
    FROM 
        invoice_line il 
    JOIN 
        track t ON t.track_id = il.track_id 
    GROUP BY 
        t.track_id
)
SELECT t.name, tr.total_sales 
  FROM total_revenue tr 
  JOIN track t ON tr.track_id = t.track_id
 ORDER BY tr.total_sales DESC
LIMIT 5;

