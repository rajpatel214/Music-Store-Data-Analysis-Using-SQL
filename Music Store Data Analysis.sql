

select * from album a 

select * from album2 a 

select * from artist a 

select * from customer c 

select * from employee e 

select * from genre g 

select * from invoice i 

select * from invoice_line il 

select * from media_type mt 

select * from playlist p 

select * from playlist_track pt 

select * from track t 


# q=1 who is the senior most employees based on job title ?


select * from employee e 
order by levels desc limit 1

# qustion 2 which country has the most invoices?

select count(*) num_invoices, billing_country from invoice i group by billing_country

#qustion3 what are 3 tops values of total invoices

select * from invoice i order by total desc limit 3

# qustion 4 which city has total invoice 

select * from invoice i 

select sum(total) as sum_total_invoices,billing_city from invoice i group by billing_city order by sum_total_invoices desc 

# qustion 5 Customer who has spend more

select sum(i.total) as total,c.customer_id,c.first_name,c.last_name from customer c join invoice i on c.customer_id = i.customer_id 
group by c.customer_id,c.first_name,c.last_name  order by total desc limit 1

#Q6: Write query to return the email, first name, last name, & Genre of all Rock Music listeners. 
# Return your list ordered alphabetically by email starting with A.

select distinct c.email,c.first_name,c.last_name from customer c join invoice i on c.customer_id = i.customer_id join invoice_line il 
on i.invoice_id = il.invoice_line_id 
where il.track_id in (select t.track_id from track t join genre g on t.genre_id = g.genre_id where g.name like "%Rock%")
order  by c.email

# qustion 7 Let's invite the artists who have written the most rock music in our dataset. 
#Write a query that returns the Artist name and total track count of the top 10 rock bands.

select * from genre 


SELECT artist.artist_id, artist.name,COUNT(artist.artist_id) AS number_of_songs
FROM track
JOIN album ON album.album_id = track.album_id
JOIN artist ON artist.artist_id = album.artist_id
JOIN genre ON genre.genre_id = track.genre_id
WHERE genre.name LIKE 'Rock'
GROUP BY artist.artist_id,artist.name
ORDER BY number_of_songs DESC
LIMIT 10;



# qustion 8 Return all the track names that have a song length longer than the average song length. 
#Return the Name and Milliseconds for each track. Order by the song length with the longest songs listed first


select name ,milliseconds from track t where milliseconds > (select avg(milliseconds) from track t )
order by milliseconds desc 

#quston 8 : Find how much amount spent by each customer on artists? Write a query to return customer name, artist name and total spent 


select * from album a 

select * from artist a 

select * from customer c 

select * from invoice_line il 

with cte as (
select a2.name,a2.artist_id,sum(il.unit_price*il.quantity) as total from album a join artist a2 on a.artist_id = a2.artist_id 
join track t on a.album_id = t.album_id 
join invoice_line il on il.track_id = t.track_id 
group by 1,2
order by total desc 
limit 1
)
select c.first_name,c.last_name,a2.name,sum(il.unit_price*il.quantity) as total1 from album a join artist a2 on a.artist_id = a2.artist_id 
join track t on a.album_id = t.album_id 
join invoice_line il on il.track_id = t.track_id join invoice i on i.invoice_id = il.invoice_line_id 
join customer c on c.customer_id = i.customer_id join cte c1 on a.artist_id =c1.artist_id
group by 1,2,3
order by total1 desc 


select * from album a join artist a2 on a.artist_id = a2.artist_id 
join track t on a.album_id = t.album_id 
join invoice_line il on il.track_id = t.track_id 


select * from customer c 

customer c join invoice i on c.customer_id = i.customer_id join

select * from invoice i 

select * from invoice_line il 

select * from genre g 


#Qustion 10

with cte as (
select count(il.quantity)as purchase , c.country,g.name,g.genre_id ,
row_number() over(partition by  c.country  order by count(il.quantity) desc) as new_col
from invoice i join customer c on i.customer_id = c.customer_id 
join invoice_line il on il.invoice_id = i.invoice_id 
join track t on il.track_id = t.track_id 
join genre g on t.genre_id = g.genre_id
group by c.country,g.name ,g.genre_id 
order by  c.country asc ,1 desc 
)
select * from cte where new_col<=1


with cte1 as (
		select count(*) as purchse ,c.country,g.name ,g.genre_id from invoice i join customer c on i.customer_id = c.customer_id 
		join invoice_line il on il.invoice_id = i.invoice_id 
		join track t on il.track_id = t.track_id 
		join genre g on t.genre_id = g.genre_id
		group by c.country,g.name ,g.genre_id 
		order by c.country asc , g.genre_id desc 
),
cte as (
select max(purchse) as max_purchse,country from cte1 group by country)
select cte1.* from cte1 join cte on cte1.country = cte.country
where cte1.purchse= cte.max_purchse



/* Q9: Write a query that determines the customer that has spent the most on music for each country. 
Write a query that returns the country along with the top customer and how much they spent. 
For countries where the top amount spent is shared, provide all customers who spent this amount.*/

WITH RECURSIVE 
	customter_with_country AS (
		SELECT customer.customer_id,first_name,last_name,billing_country,SUM(total) AS total_spending
		FROM invoice
		JOIN customer ON customer.customer_id = invoice.customer_id
		GROUP BY 1,2,3,4
		ORDER BY 2,3 DESC),
	country_max_spending AS(
		SELECT billing_country,MAX(total_spending) AS max_spending
		FROM customter_with_country
		GROUP BY billing_country)
SELECT cc.billing_country, cc.total_spending, cc.first_name, cc.last_name, cc.customer_id
FROM customter_with_country cc
JOIN country_max_spending ms
ON cc.billing_country = ms.billing_country
WHERE cc.total_spending = ms.max_spending
ORDER BY 1;


WITH Customter_with_country AS (
		SELECT customer.customer_id,first_name,last_name,billing_country,SUM(total) AS total_spending,
	    ROW_NUMBER() OVER(PARTITION BY billing_country ORDER BY SUM(total) DESC) AS RowNo 
		FROM invoice
		JOIN customer ON customer.customer_id = invoice.customer_id
		GROUP BY 1,2,3,4
		ORDER BY 4 ASC,5 DESC)
SELECT * FROM Customter_with_country WHERE RowNo <= 1
