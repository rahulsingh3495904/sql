        
													    /*Superstore*/

CREATE SCHEMA superstore;


USE superstore;

/*                                                    Understand the Data                                                                  */

/*Question 1*/
/*Describe the data in hand in your own words.*/

	/*1. cust_dimen: Details of all the customers
		
        Customer_Name (TEXT): Name of the customer
        Province (TEXT): Province of the customer
        Region (TEXT): Region of the customer
        Customer_Segment (TEXT): Segment of the customer
        Cust_id (TEXT): Unique Customer ID
	
    2. market_fact: Details of every order item sold
		
        Ord_id (TEXT): Order ID
        Prod_id (TEXT): Prod ID
        Ship_id (TEXT): Shipment ID
        Cust_id (TEXT): Customer ID
        Sales (DOUBLE): Sales from the Item sold
        Discount (DOUBLE): Discount on the Item sold
        Order_Quantity (INT): Order Quantity of the Item sold
        Profit (DOUBLE): Profit from the Item sold
        Shipping_Cost (DOUBLE): Shipping Cost of the Item sold
        Product_Base_Margin (DOUBLE): Product Base Margin on the Item sold
        
    3. orders_dimen: Details of every order placed
		
        Order_ID (INT): Order ID
        Order_Date (TEXT): Order Date
        Order_Priority (TEXT): Priority of the Order
        Ord_id (TEXT): Unique Order ID
	
    4. prod_dimen: Details of product category and sub category
		
        Product_Category (TEXT): Product Category
        Product_Sub_Category (TEXT): Product Sub Category
        Prod_id (TEXT): Unique Product ID
	
    5. shipping_dimen: Details of shipping of orders
		
        Order_ID (INT): Order ID
        Ship_Mode (TEXT): Shipping Mode
        Ship_Date (TEXT): Shipping Date
        Ship_id (TEXT): Unique Shipment ID*/


/*Question 2*/
/*Identify and list the Primary Keys and Foreign Keys for this dataset*/

/*1. cust_dimen
		Primary Key: Cust_id
        Foreign Key: NA
	
    2. market_fact
		Primary Key: NA
        Foreign Key: Ord_id, Prod_id, Ship_id, Cust_id
	
    3. orders_dimen
		Primary Key: Ord_id
        Foreign Key: NA
	
    4. prod_dimen
		Primary Key: Prod_id, Product_Sub_Category
        Foreign Key: NA
	
    5. shipping_dimen
		Primary Key: Ship_id
        Foreign Key: NA*/


/*                                                          Basic & Advanced Analysis                                                       */

/*Question 1*/
/*Write a query to display the Customer_Name and Customer Segment using alias name “Customer Name", "Customer Segment" from table Cust_dimen.*/

SELECT 
    Customer_Name AS 'Customer Name',
    Customer_Segment AS 'Customer Segment'
FROM
    cust_dimen;



/*Question 2*/
/*2. Write a query to find all the details of the customer from the table cust_dimen order by desc.*/

SELECT 
    *
FROM
    cust_dimen
ORDER BY Customer_Name DESC;

/*Question 3*/
/*3. Write a query to get the Order ID, Order date from table orders_dimen where ‘Order Priority’ is high.*/

SELECT 
    Order_ID, Order_Date
FROM
    orders_dimen
WHERE
    Order_Priority = 'high';

/*Question 4*/
/*4. Find the total and the average sales (display total_sales and avg_sales)*/

SELECT 
    AVG(sales) AS avg_sales, SUM(sales) AS total_sales
FROM
    market_fact;


/*Question 5*/
/*5. Write a query to get the maximum and minimum sales from maket_fact table.*/

SELECT 
    MAX(Sales) AS Maximum_Sales, MIN(Sales) AS Minimum_Sales
FROM
    market_fact;



/*Question 6*/
/*6. Display the number of customers in each region in decreasing order of no_of_customers. The result should contain columns Region, no_of_customers.*/

SELECT 
    region, COUNT(*) AS no_of_customers
FROM
    cust_dimen
GROUP BY region
ORDER BY no_of_customers DESC;



/*Question 7*/
/*7. Find the region having maximum customers (display the region name and max(no_of_customers)*/

SELECT 
    region, COUNT(*) AS no_of_customers
FROM
    cust_dimen
GROUP BY region
ORDER BY no_of_customers DESC
LIMIT 1;




/*Question 8*/
/*8. Find all the customers from Atlantic region who have ever purchased ‘TABLES’ and the number of tables purchased (display the customer name, no_of_tables purchased)*/

 
SELECT 
    c.customer_name, COUNT(*) AS no_of_tables_purchased
FROM
    market_fact AS m
        INNER JOIN
    cust_dimen AS c ON m.cust_id = c.cust_id
    inner join 
    prod_dimen AS p ON m.prod_id=p.prod_id
WHERE
    c.region = 'atlantic' 
    AND  p.product_sub_category = 'tables'
GROUP BY m.cust_id , c.customer_name;





/*Question 9*/
/*9. Find all the customers from Ontario province who own Small Business. (display the customer name, no of small business owners)*/

SELECT 
    Customer_Name, COUNT(*) AS 'no_of_small_business_owners'
FROM
    cust_dimen
WHERE
    province = 'Ontario'
        AND customer_segment = 'small business'
GROUP BY Customer_Name;



/*Question 10*/
/*10. Find the number and id of products sold in decreasing order of products sold (display product id, no_of_products sold)*/

SELECT 
    prod_id AS product_id, COUNT(*) AS no_of_products_sold
FROM
    market_fact
GROUP BY prod_id
ORDER BY no_of_products_sold DESC;



/*Question 11*/
/*11. Display product Id and product sub category whose produt category belongs to Furniture and Technlogy. The result should contain columns product id, product sub category.*/


SELECT 
    prod_id AS Product_id, product_sub_category
FROM
    prod_dimen
WHERE
    Product_Category = 'Furniture'
        OR Product_Category = 'Technology';


 select* from prod_dimen;




 
/*Question 12*/
/*12. Display the product categories in descending order of profits (display the product category wise profits i.e. product_category, profits)?*/

SELECT 
    p.product_category, SUM(m.profit) AS profits
FROM
    market_fact m
        INNER JOIN
    prod_dimen p ON m.prod_id = p.prod_id
GROUP BY p.product_category
ORDER BY profits DESC;





/*Question 13*/
/*13. Display the product category, product sub-category and the profit within each subcategory in three columns.*/

SELECT 
    p.product_category,
    p.product_sub_category,
    SUM(m.profit) AS profits
FROM
    market_fact m
        INNER JOIN
    prod_dimen p ON m.prod_id = p.prod_id
GROUP BY p.product_category , p.product_sub_category;




/*Question 14*/
/*14. Display the order date, order quantity and the sales for the order.*/

SELECT 
    o.Order_date, m.Order_Quantity, m.Sales
FROM
    orders_dimen AS o
        INNER JOIN
    market_fact AS m ON o.Ord_id = m.Ord_id
GROUP BY m.Order_Quantity , m.Sales;




/*Question 15*/
/*15. Display the names of the customers whose name contains the*
i) Second letter as ‘R’
ii) Fourth letter as ‘D’*/

SELECT 
    Customer_Name
FROM
    cust_dimen
WHERE
    Customer_Name LIKE '_R%'
    AND Customer_Name LIKE '___D%';


/*Question 16*/
/*16. Write a SQL query to  make a list with Cust_Id, Sales, Customer Name and their region where sales are between 1000 and 5000.*/

SELECT 
    c.Customer_name, c.Cust_id, c.Region, m.Sales
FROM
    Cust_dimen AS c
        INNER JOIN
    market_fact AS m ON c.Cust_id = m.Cust_id
WHERE
    m.Sales BETWEEN 1000 AND 5000;





/*Question 17*/
/*17. Write a SQL query to find the 3rd highest sales.*/

SELECT 
    sales
FROM
    market_fact
ORDER BY sales DESC 
LIMIT 2 , 1;


select * from market_fact;

/*by using subquery*/
SELECT sales  
FROM 
    (SELECT sales 
     FROM market_fact 
     ORDER BY sales DESC 
     LIMIT 3) AS Comp 
ORDER BY sales 
LIMIT 1;



/*Question 18*/
/*18. Where is the least profitable product subcategory shipped the most? For the least profitable product sub-category, display the region-wise no_of_shipments and the
profit made in each region in decreasing order of profits (i.e. region, no_of_shipments, profit_in_each_region)*/
/*→ Note: You can hardcode the name of the least profitable product subcategory*/


  SELECT 
    c.region,
    COUNT(DISTINCT s.ship_id) AS no_of_shipments,
    SUM(m.profit) AS profit_in_each_region
FROM
    market_fact m
        INNER JOIN
    cust_dimen c ON m.cust_id = c.cust_id
        INNER JOIN
    shipping_dimen s ON m.ship_id = s.ship_id
        INNER JOIN
    prod_dimen p ON m.prod_id = p.prod_id
WHERE
    p.product_sub_category IN (SELECT 
            p.product_sub_category
        FROM
            market_fact m
                INNER JOIN
            prod_dimen p ON m.prod_id = p.prod_id
        GROUP BY p.product_sub_category
        HAVING SUM(m.profit) <= ALL (SELECT 
                SUM(m.profit) AS profits
            FROM
                market_fact m
                    INNER JOIN
                prod_dimen p ON m.prod_id = p.prod_id
            GROUP BY p.product_sub_category))
GROUP BY c.region
ORDER BY profit_in_each_region DESC;