create database if not exists salesdatawalmart;
use salesdatawalmart;
show tables;
select * from walmartsalesdata;
alter table walmartsalesdata
change column Date Date date;
alter table walmartsalesdata
change column Time Time time;
-- TIME OF DAY --
select time,
(case
 when 'time' between '00:00:00' and '12:00:00' then 'Morning'
 when 'time' between '12:00:00' and '16:00:00' then 'Afternoon'
 else 'Evening'
 end
)as time_of_date
from walmartsalesdata;
alter table walmartsalesdata add column time_of_date varchar(20);
update walmartsalesdata
set time_of_date =(
case
 when 'time' between '00:00:00' and '12:00:00' then 'Morning'
 when 'time' between '12:00:00' and '16:00:00' then 'Afternoon'
 else 'Evening'
 end);
 --  Product --
-- DAY NAME--
select Date,
( dayname(Date))as Day_name
 from walmartsalesdata;
 alter table walmartsalesdata add column Day_name varchar(14);
 update walmartsalesdata
 set Day_name = dayname(Date);
 -- Month Name --
 select Date,
 (monthname(Date)) as Month_name from walmartsalesdata;
 alter table walmartsalesdata add column Month_name varchar(14);
  update walmartsalesdata
 set Month_name = monthname(Date);
-- Generic Questions --
 -- Unique City --
 select city,count(distinct city)as No_of_city from walmartsalesdata
 group by city;
 -- Branch in Each City --
 select city,count(Branch)as No_of_Branch FROM walmartsalesdata
 group by city;
 -- Product Questions -- 
 -- 1. How many unique product lines does the data have?
 select Product_line,count(distinct Product_line) from walmartsalesdata
 group by Product_line;#6
 -- 2. What is most common payment method?
 select Payment,count(Payment) from walmartsalesdata
 group by Payment;#E-Wallet:345
 -- 3. What is most selling Product Line?
 select Product_line,sum(Quantity)as Most_selling_Product from walmartsalesdata
 group by Product_line
 order by Most_selling_Product desc;#Electronic accessories:971
 -- 4. What is total Revenue by Month?
 select Month_name,round(sum(Total),0)as Revenue from walmartsalesdata
 group by Month_name
 order by Revenue desc;#January:116292
 -- 5. What month had the largest COGS?
  select Month_name,round(sum(cogs),0)as COGS from walmartsalesdata
 group by Month_name
 order by COGS desc;#January:110754
 -- 6. What Product line had the largest Revenue?
 select Product_line,round(sum(Total),0)as Revenue from walmartsalesdata
 group by Product_line
 order by Revenue desc;#Food and beverages:56145
 -- 7. What is the city with largest Revene?
 select city,round(sum(Total),0)as Revenue from walmartsalesdata
 group by city
 order by Revenue desc;#Naypyitaw:110569
 -- 8. Which Product line had the largest VAT?
 alter table walmartsalesdata
 rename column `Tax5%` to `VAT`;
 select Product_line,round(sum(VAT),0)as VAT from walmartsalesdata
 group by Product_line
 order by VAT desc;#Food and beverages:2674
 -- 9. Fetch the product line with good and bad avg sales by adding a coloumn?
 select Product_line,round(avg(VAT),0) as avg_vat from walmartsalesdata
 group by Product_line
 order by avg_vat desc;
 -- 10. What is avg rating of each Product Line?
 select Product_line,round(avg(Rating),1) as avg_rating  from walmartsalesdata
 group by Product_line
 order by avg_rating desc;
 --  END ---
 
