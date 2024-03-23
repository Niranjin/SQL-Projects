# Project Database Overview

This document provides a concise overview of the database schema which is integral to the operational framework of our business project. The database is structured to comprehensively accommodate various facets of business operations including employee management, order tracking, financial transactions, and product inventory, ensuring a streamlined and efficient data management system.

## Table Descriptions

### Employees Table
The Employees table is pivotal for storing detailed information about the personnel within the organization. It encompasses fields such as Employee Number, Name, Contact Information, and Job Title. It also delineates organizational hierarchy through the 'Reports To' field and associates employees with specific office locations via the 'Office Code'. 

- **Key Relations**: 
  - `ReportsTo` references `EmployeeNumber` to establish reporting structures.
  - `OfficeCode` links to an external Offices table, connecting employees to their physical work location.

### Order Details Table
This table meticulously records the individual items within each customer order, detailing the product code, quantity, and pricing.

- **Key Relations**:
  - Connected to the Orders and Products tables through `OrderNumber` and `ProductCode` to enrich order details with comprehensive product and order meta-data.

### Orders Table
The Orders table captures the lifecycle of customer orders from inception to fulfillment, tracking key dates, order status, and customer comments.

- **Key Relations**: 
  - `CustomerNumber` serves as a foreign key, referencing the Customers table to identify the customer associated with each order.

### Payments Table
This table logs the payment transactions received from customers, detailing the payment method, date, and amount.

- **Key Relations**:
  - Linked to the Customers table by `CustomerNumber`, associating each payment transaction with a specific customer.

### Product Lines Table
The Product Lines table categorizes products into distinct lines, providing both textual and multimedia descriptions of each category.

### Products Table
Housing a detailed catalog of products, this table includes information on product specifications, inventory, and pricing.

- **Key Relations**:
  - Tied to the Product Lines table through the `ProductLine` field, correlating products with their respective categories for easy navigation and management.

## Summary
This structured and relational database schema forms the backbone of our project’s data management capabilities. It is meticulously designed to encapsulate critical business operations, ensuring data integrity and availability across various operational domains. An astute arrangement of primary and foreign keys facilitates the interconnection among tables, enabling complex queries and comprehensive data analyses that support informed decision-making and operational efficiency.


# Project Notebook:-
Please find the attached project containing various insights accompanied by visualizations. I utilized Matplotlib, a powerful visualization library, along with pandas for data manipulation as needed. You can <a href="https://drive.google.com/file/d/1AqU_R7-wjiU2OZE-ToEIm5lP8S9d91PX/view?usp=drive_link">click here</a> to view the notebook
