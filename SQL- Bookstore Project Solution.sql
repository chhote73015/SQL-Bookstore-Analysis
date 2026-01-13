--Create Database
CREATE DATABASE OnlineBookstore;


-- Switch to the datase
\c OnlineBookstore;


-- Create Tables
DROP TABLE IF EXISTS Books;
CREATE TABLE Books (
       Book_ID SERIAL PRIMARY KEY,
	   Title VARCHAR(100),
	   Author VARCHAR(100),
	   Genre VARCHAR(50),
	   Published_Year INT,
	   Price NUMERIC(10,2),
	   Stock INT
);
 SELECT * FROM Books;



DROP TABLE IF EXISTS customers;
CREATE TABLE Customers(
        Customer_ID SERIAL PRIMARY KEY,
		Name VARCHAR(100),
		Email VARCHAR(100),
		Phone VARCHAR(15),
		City VARCHAR(50),
		Country VARCHAR(150)
);

SELECT * FROM customers;


DROP TABLE IF EXISTS orders;
CREATE TABLE Orders(
     Order_ID SERIAL PRIMARY KEY,
	 Customer_ID INT REFERENCES Customers(Customer_ID),
	 Book_ID INT REFERENCES Books(Book_ID),
	 Order_Date DATE,
	 Quantity INT,
	 Total_Amount NUMERIC(10,2)
);

SELECT * FROM orders;


SELECT * FROM Books;
SELECT * FROM customers;
SELECT * FROM orders;



-- 1) Retrieve all the books in the "Fiction" genre:

SELECT * FROM Books
WHERE Genre='Fiction';

-- 2) Find books published after thr year 1950;

SELECT * FROM Books
WHERE published_year>1950;


-- 3) List all customers from the Canada:



-- 4) Show orders placed in November 2023:

SELECT * FROM orders
WHERE order_date BETWEEN '2023-11-01' AND '2023-11-30';

-- 5) Retrieve the total stock of books available:

SELECT SUM(stock) AS Total_Stock
From Books;

-- 6) Find details of the most expensive books:

SELECT * FROM books 
ORDER BY Price
DESC LIMIT 1;


-- 7) Show all customers who ordered mpre than 1 quality of a book:

 SELECT * FROM orders
 where quantity>1;
 

-- 8) Retrieve all orders where the total amount exceeds $20:

SELECT * FROM orders
 where total_amount>20;

-- 9) List all genres available in the books table:

SELECT DISTINCT genre FROM books;

-- 10) Find the book with the lowest stock:

SELECT * FROM books
ORDER BY stock LIMIT 1 ;


-- 11) Calculate the total revenue generated from all orders:

SELECT SUM(total_amount) AS Total_Revenue
FROM orders;


SELECT * FROM Books;
SELECT * FROM customers;
SELECT * FROM orders;


-- Advance Questions:

--1) Retrieve the total number of books sold for each genre:

  SELECT b.genre, SUM(o.quantity) AS Total_book_sold
  FROM Orders o
  JOIN Books b ON O.book_id=b.book_id
  GROUP BY b.genre;

-- 2) Find the average price of books in the "fantasy" genre:

SELECT AVG(price) AS Price_sum
FROM books
WHERE genre='Fantasy';


SELECT * FROM Books;
SELECT * FROM customers;
SELECT * FROM orders;


-- 3) List customers who have placed at least 2 orders:

SELECT customer_id, COUNT(Order_id) AS ORDER_COUNT
FROM orders
GROUP BY customer_id
HAVING COUNT(Order_id) >=2;

-- 4) Find the most frequently ordered book:

SELECT Book_id, COUNT(order_id) AS ORDER_COUNT
FROM orders
GROUP BY Book_id
ORDER BY ORDER_COUNT DESC LIMIT 1;

-- 5) Show the top 3 most expensive book of 'Fantasy' Genre :

SELECT * FROM Books
WHERE Genre='Fantasy'
ORDER BY price DESC LIMIT 3;

-- 6) Retrieve the total quantity of books sold by each author:

SELECT b.author, SUM(o.quantity) AS Total_Books_Sold
FROM orders o
JOIN books b ON o.book_id=b.book_id
GROUP BY b.Author;

-- 7) List and city where customers who spent over $30 are located:

SELECT  DISTINCT c.city, total_amount
FROM orders o
JOIN customers c ON o.customer_id=c.customer_id
WHERE o.total_amount >30;

-- 8) Find the customer who spent the most on orders:

SELECT c.customer_id, c.name, SUM(o.total_amount) AS Total_Spent
FROM orders o
JOIN customers c ON o.customer_id=c.customer_id
GROUP BY c.customer_id, c.name
ORDER BY Total_Spent DESC LIMIT 1;


-- 9)  Calculate the stock remaining after fulfulling all orders:

SELECT b.book_id, b.title, b.stock, COALESCE(SUM(o.quantity),0) AS Order_quantity,
      b.stock- COALESCE (SUM(O.quantity),0) AS Remaining_Quantity
FROM books b
LEFT JOIN orders o ON b.book_id=o.book_id
GROUP BY b.book_id ORDER BY b.book_id ASC;






