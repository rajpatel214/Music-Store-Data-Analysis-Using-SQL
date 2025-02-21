# Music-Store-Data-Analysis-Using-SQL

## Overview
This project contains multiple SQL queries that analyze a music database. The queries extract insights from various tables, including albums, artists, customers, employees, invoices, and tracks.

## Steps Followed in Analysis
1. **Understanding Data Structure**
   - Explored tables like album, artist, customer, employee, invoice,track, etc.
   - Identified relationships between tables (e.g., invoice and customer via customer_id).

2. **Writing Queries to Extract Insights**
   - Used **aggregate functions** (SUM, COUNT, AVG) to derive meaningful statistics.
   - Used **JOINs** to combine relevant tables for analysis.
   - Applied **CTEs (Common Table Expressions)** and **subqueries** for advanced filtering.
   - Implemented **ORDER BY** and **LIMIT** to get top results.
   - Used **window functions (ROW_NUMBER, MAX, etc.)** for ranking-based queries.

## Insights Obtained from Queries

### 1. Identifying Senior-most Employee
- Sorted employees based on job title hierarchy.
- Found the highest-ranking employee using ORDER BY levels DESC LIMIT 1.

### 2. Country with Most Invoices
- Grouped invoices by billing_country.
- Counted occurrences and identified the country with the highest invoices.

### 3. Top 3 Invoice Values
- Ordered invoices by total and retrieved the top 3 highest values.

### 4. Total Invoice Amount by City
- Summed invoice amounts (total) for each billing_city.
- Ordered results to find the cities generating the most revenue.

### 5. Customer Who Spent the Most
- Joined customer and invoice tables.
- Used SUM(total) grouped by customer and ordered to find the top spender.

### 6. Rock Music Listeners
- Found customers who purchased Rock music.
- Sorted by email for easy reference.

### 7. Top 10 Rock Artists
- Counted track_id for artists producing Rock music.
- Used LIMIT 10 to get the most prolific Rock musicians.

### 8. Songs Longer than Average Length
- Calculated the average milliseconds.
- Retrieved tracks with length greater than the average.

### 9. Spending by Customer on Artists
- Used CTE to find the artist with the highest revenue.
- Identified which customers contributed the most to this artist.

### 10. Most Popular Genre per Country
- Used ROW_NUMBER() to find the most purchased genre in each country.
- Alternative approach used a CTE to get max purchases per country.

### 11. Highest Spending Customer per Country
- Found the top customer in each country based on spending.
- Used **recursive CTEs** and **window functions** for ranking customers.

## SQL Techniques Used
- **CTEs (Common Table Expressions)** for temporary result storage.
- **JOINs** for merging data from multiple tables.
- **Aggregations (SUM, COUNT, AVG, MAX)** for insights.
- **Window Functions (ROW_NUMBER, RANK)** for ranking and partitioning data.
- **ORDER BY & LIMIT** for sorting and filtering top results.
- **Subqueries** for nested calculations.

## Conclusion
This project effectively analyzes key business metrics of a music database, showcasing SQL proficiency in handling complex queries and optimizing data retrieval.


