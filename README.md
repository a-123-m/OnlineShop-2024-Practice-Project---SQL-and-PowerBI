# OnlineShop-2024 Practice Project- SQL and PowerBI
An end-to-end Online Shop 2024 analytics project using PostgreSQL and Power BI, covering data cleaning, SQL joins, BI views, dimensional modeling, DAX KPIs, DirectQuery and interactive dashboard development. 

## 📌 Project Overview

This project is a hands-on **SQL + Power BI analytics project** built using the **Online Shop 2024 dataset** from Kaggle.
The main objective of this project was to understand an end-to-end analytics workflow using **PostgreSQL as the database layer** and **Power BI as the visualization and reporting layer**.
The project covers database creation, data loading, data cleaning, relational data modeling, SQL analysis, creation of BI views, Power BI connectivity using DirectQuery, dimensional modeling, DAX calculations and dashboard development in PowerBI by importing data from PostgreSQL.

## 🎯 Project Objectives

* Practice working with relational data using PostgreSQL
* Understand primary keys and foreign key relationships
* Import and validate data in PostgreSQL
* Perform data cleaning and preprocessing using SQL
* Join multiple relational tables for analysis
* Create fact and dimensional tables for analysis
* Create analytical/BI views
* Apply SQL concepts for business analysis
* Connect PostgreSQL with Power BI using DirectQuery
* Create a Date table in PowerBI and apply time-intelligence concepts
* Build a dimensional model for Power BI
* Develop KPIs and business metrics using DAX
* Build an interactive Power BI dashboard

## 🗂️ Dataset

**Dataset:** Online Shop 2024  
**Source:** Kaggle <a href="https://www.kaggle.com/datasets/marthadimgba/online-shop-2024"> Click here to access dataset </a>

The dataset contains multiple related tables representing different aspects of an online shopping business, including:
* Customers
* Orders
* Order Items
* Products
* Suppliers
* Payments
* Shipments
* Reviews

These tables were loaded into PostgreSQL and connected using relational keys.

## 🏗️ Project Workflow

The project followed the following end-to-end workflow:

```text
Download Kaggle Dataset
      ↓
Create PostgreSQL Database
      ↓
Create Tables
      ↓
Set up Primary & Foreign Keys for tables
      ↓
Import Data
      ↓
Data Validation
      ↓
Data Cleaning & Preprocessing
      ↓
SQL Joins & Transformations
      ↓
Creation of BI Views for analysis
      ↓
Answering important 5 KPI metrics & Business Questions
      ↓
Import data into Power BI using DirectQuery Mode
      ↓
Dimensional Modeling
      ↓
Creation of Date table, DAX Measures & KPIs
      ↓
Dashboard Development
      ↓
Business Insights
```

## 📊 Data Model
The project uses a **Galaxy Schema (Fact Constellation)** in Power BI, with multiple fact tables sharing common dimension tables.

<img width="1565" height="685" alt="image" src="https://github.com/user-attachments/assets/28cdd05b-89f2-4b96-a02f-923176b1d0ab" />

### Model Structure
**Fact Tables**
- Fact Sales
- Fact Payment
- Fact Shipment
- Fact Review

**Dimension Tables**
- Dim Customer
- Dim Product
- Dim Supplier
- Date

The model uses **one-to-many relationships** between dimension and fact tables, with the dimension tables acting as filtering tables for analysis.

## 📊 Dashboard Preview
<img width="1265" height="701" alt="onlineshop2024_pic" src="https://github.com/user-attachments/assets/aa0cca27-3942-46f9-8bfd-07d2dd04ab4f" />

### Dashboard Components

- Total Sales
- Total Orders
- Total Quantity
- Average Order Value
- Average Customer Rating
- Monthly Sales Trend
- Shipment Status Distribution
- Sales by Category
- State & City Sales Performance
- YoY Sales Growth
- YoY Orders Growth
  
### Interactive Filters
Users can dynamically analyze the dashboard using:
* Category
* Product
* Year
* Day
* City
* Supplier

## 🔑Key KPI's
<img width="1252" height="261" alt="image" src="https://github.com/user-attachments/assets/53078f8d-6d8b-4fc9-8a50-5ee33b5b2959" />
KPI : Total sales, Total orders, Average Order Value(AOV), Total quantity sold, Average Customer rating
<h4>Total sales</h4>
<img width="540" height="157" alt="image" src="https://github.com/user-attachments/assets/0809e161-c285-4f7c-b09b-b325a885b8bc" />
<h4>Total orders</h4>
<img width="542" height="155" alt="image" src="https://github.com/user-attachments/assets/40b6e791-086a-4c0b-9dc2-8eb36c5c17ed" />
<h4>Average Order Value(AOV)</h4>
<img width="565" height="157" alt="image" src="https://github.com/user-attachments/assets/af611709-fe6a-4f2b-addd-65aebac0d19a" />
<h4>Total quantity sold</h4>
<img width="567" height="161" alt="image" src="https://github.com/user-attachments/assets/e870c60b-055a-4e20-b652-7e5d7cd6d91c" />
<h4>Average Customer rating</h4>
<img width="737" height="161" alt="image" src="https://github.com/user-attachments/assets/df5be781-6868-4995-87af-90e4c57f6cda" />

## Business questions
1. Which product generated the highest sales?
2. Which category generated the highest sales?
3. Which are the top 5 products by revenue?
4. Which customers are the top 10 customers by spending?
5. What is the monthly sales trend?
6. Which month generated the highest sales?
7. What is the average rating for each product along with total reviews?
8. Which products have an average rating above 4?
9. What is the payment success rate for each payment method?
10. What is the average delivery time for each carrier?
11. Rank products by revenue within each category
12. What percentage of total sales does each category contribute?
13. Which customers have spent more than the average customer spending?
14. What are the top 3 customers by revenue in each city?
15. What is the month-over-month sales growth?

## Insights
<ol>
<li>4K Monitor generated the highest total sales of Rs. 10,28,666.50</li>
<img width="557" height="160" alt="image" src="https://github.com/user-attachments/assets/3c95b532-640d-419a-9525-db37482d8325" />
<li>Among all the categories, Electronics generated the highest total sales of Rs. 1,52,47,167.14</li>
<img width="563" height="163" alt="image" src="https://github.com/user-attachments/assets/7011f4cd-6749-4d51-a475-e71050121468" />
<li>4K Monitor, Microphone, Standing Desk, Kitchen Blender and Air Purifier are the top 5 products by revenue</li>
<img width="612" height="287" alt="image" src="https://github.com/user-attachments/assets/4e26c2fb-4065-4598-a20f-d68f0791d519" />
<li>John Williams, James Natallie, John Philip, John Gonzalez, Mary Douglas, James Samuel, James Thomas, Mary Wayne, James Roger and Mary Lopez are the top 10 customers by spending</li>
<img width="640" height="441" alt="image" src="https://github.com/user-attachments/assets/e584ae7f-071b-42c6-96c8-c0a7cd25a17d" />
<li>The monthly sales remained fairly stable throughout the month, ranging from approximately 3.17M to 3.77M.</li>
<img width="715" height="502" alt="image" src="https://github.com/user-attachments/assets/66310e0b-44c1-48a3-9525-4470eb06f3b3" />
<li>October recorded the highest sales at 3.77M, making it the strongest-performing month.</li>
<img width="537" height="163" alt="image" src="https://github.com/user-attachments/assets/0d07f36e-59fe-4b17-84b8-7a7a84e30635" />
<li>The average rating and the total number of reviews left for each product is shown below</li> 
<img width="710" height="752" alt="image" src="https://github.com/user-attachments/assets/47f14d8f-9713-4e07-95ce-63bd13c7f754" />
<li> The following products have an average rating above 4</li> 
<img width="633" height="312" alt="image" src="https://github.com/user-attachments/assets/2720c7ac-a7aa-4444-ac99-d0ed709fd877" />
<li>Payment success rate for the payment method "Credit Card" is 80%</li> 
<img width="753" height="163" alt="image" src="https://github.com/user-attachments/assets/2bda7142-42f3-4cd2-a120-794a16ee5330" />
<li>The average delivery time taken for each carrier is shown below</li> 
<img width="697" height="226" alt="image" src="https://github.com/user-attachments/assets/f436a39f-12b8-41ef-a81e-9155f6350c11" />
<li>Products ranked by revenue within each category</li> 
<img width="897" height="787" alt="image" src="https://github.com/user-attachments/assets/c71646b4-2dc2-4958-9c30-22a725d6eeaa" />
<li>Electronics is the strongest-performing category, generating 35.88% of total revenue (15.25M). Home & Kitchen follows with 26.32% (11.18M), while Accessories contributes 23.14% (9.83M). Furniture is the weakest category at 14.66% (6.23M).</li> 
<img width="627" height="251" alt="image" src="https://github.com/user-attachments/assets/b5b2cf7c-d41a-42cc-97b1-cfe12c330c59" />
<li>The following customers have spent more than the average customer spending</li> 
<img width="682" height="786" alt="image" src="https://github.com/user-attachments/assets/8d0adf73-1e49-401d-96fa-c83662ffba66" />
<li>The top 3 customers by revenue in each city is as shown below</li> 
<img width="702" height="506" alt="image" src="https://github.com/user-attachments/assets/1d559758-3a0f-4925-a050-f6d19fdd228c" />
<li>Month over Month sales growth</li> 
<img width="661" height="497" alt="image" src="https://github.com/user-attachments/assets/d7061120-4076-4820-b0fb-2b510f350727" />
</ol>

> 📌 **Note:** Refer to the **SQL** folder for the complete queries used throughout this project, including table creation, data cleaning, joins, BI views, KPI calculations and business analysis.

If you found this project helpful, consider giving it a ⭐ on GitHub!
Thank you❤️

<div>
  <h2>Connect with Me</h2>
<a href="mailto:aiswarya2000mohan@gmail.com">
  <img src="https://img.shields.io/badge/-Gmail-red?style=for-the-badge&logo=gmail&logoColor=white" alt="Gmail">
</a>
<a href="https://www.linkedin.com/in/aiswarya-mohan-950948221/">
  <img src="https://img.shields.io/badge/-LinkedIn-blue?style=for-the-badge&logo=linkedin&logoColor=white" alt="LinkedIn">
</a>
</div>
