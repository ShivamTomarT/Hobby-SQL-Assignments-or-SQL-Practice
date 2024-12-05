/********************************************************************************************************************

                                                  Assignment- 1

*********************************************************************************************************************/

select * from orders
--1- write a sql to get all the orders where customers name has "a" as second character and "d" as fourth character 

select * from Orders
where customer_name like '_a_d%'


--2- write a sql to get all the orders placed in the month of dec 2020.

select * from Orders
where month(order_date) =12 and year(order_date)=2020

select * from Orders
where datename(mm,order_date)='December' and DATENAME(YYYY,order_date)=2020

select * from Orders
where datename(mm,order_date)='December' and DATENAME(YYYY,order_date)=2020

----3- write a query to get all the orders where ship_mode is neither in 'Standard Class' nor in 'First Class' and ship_date is after nov 2020.

select * from Orders
where ship_mode not in ('Standard Class','First Class') and ship_date > '2020-11-30'

--4- write a query to get all the orders where customer name neither start with "A" and nor ends with "n".

select * from Orders
where customer_name not like 'a%n'


--5- write a query to get all the orders where profit is negative.

select * from Orders
where profit <0

--6- write a query to get all the orders where either quantity is less than 3 or profit is 0.
select * from Orders
where quantity <3 or profit =0

--7- your manager handles the sales for South region and he wants you to create a report of all the orders in his region where some discount is provided to the customers.
select * from Orders
where region='south' and discount >0

--8- write a query to find top 5 orders with highest sales in furniture category.
select top 5 * from Orders
where category= 'furniture'
order by sales desc

--9- write a query to find all the records in technology and furniture category for the orders placed in the year 2020 only.
select * from Orders
where category in ('technology', 'furniture') and year(order_date)=2020


select * from Orders
where category in ('technology', 'furniture') and datepart(yyyy,order_date)=2020

--10-write a query to find all the orders where order date is in year 2020 but ship date is in 2021.

select * from Orders
where datepart(YYYY,order_date) =2020 
and  year(ship_date)=2021


/********************************************************************************************************************

                                                  Assignment- 2

*********************************************************************************************************************/
--1- write a update statement to update city as null for order ids :  CA-2020-161389 , US-2021-156909

update Orders
set city =' '
where order_id in ('CA-2020-161389' , 'US-2021-156909')

--2- write a query to find orders where city is null (2 rows)

select * from Orders
where city =' '


--3- write a query to get total profit, first order date and latest order date for each category.

select category,max (order_date) as first_order_date ,min(order_date) as lated_order_date,sum(profit) as total_profit from Orders
group by category


--4- write a query to find sub-categories where average profit is more than the half of the max profit in that sub-category.
select sub_category
from orders
group by sub_category
having avg(profit) > max(profit)/2



--5-write a query to find students who have got same marks in Physics and Chemistry.
--Solution 1:-
select STUDENT_ID,MARKS,count(1) as total from EXAMS_TABLE_DAY_4
where SUBJECT in ('Physics','Chemistry')
group by STUDENT_ID,MARKS
having count(1) =2

--Solution 2:-
with cte as (
select STUDENT_ID,MARKS from EXAMS_TABLE_DAY_4
where SUBJECT in ('physics','chemistry')
group by STUDENT_ID,MARKS
having count(MARKS)=2
)
select mt.* from cte as st inner join EXAMS_TABLE_DAY_4 as mt
on st.STUDENT_ID=mt.STUDENT_ID and st.MARKS =mt.MARKS


--6- write a query to find total number of products in each category.

select category,count(distinct product_id) as no_of_product from Orders
group by category


--7- write a query to find top 5 sub categories in west region by total quantity sold.
select top 5 sub_category,sum(quantity) as total_qty_sold from Orders
where region='west'
group by sub_category
order by total_qty_sold desc


---8- write a query to find total sales for each region and ship mode combination for orders in year 2020.

select region,ship_mode ,sum(sales) as total_sales from Orders
where datepart(YYYY,order_date)=2020 
group by region ,ship_mode



/********************************************************************************************************************

                                                  Assignment- 3

*********************************************************************************************************************/

--1- write a query to get region wise count of return orders.

select region,count(distinct mt.[Order Id]) as returned_order from Orders as st inner join Returns_ as mt 
on st.order_id=mt.[Order Id]
group by region


--2- write a query to get category wise sales of orders that were not returned.

select category,round(sum(sales),2) as total from Orders as st left join Returns_ as mt 
on mt.[Order Id]=st.order_id
where mt .[Order Id] is null
group by category

--3- write a query to print dep name and average salary of employees in that dep .

select * from employee
select * from dept

--Solution 1:-
select isnull(mt.dep_name,'?') as Dept_Name,avg(st.salary) as average_salary from employee as st left join dept as mt 
on st.dept_id=mt.dep_id
group  by mt.dep_name;

--Solution 2:-

with cte as 
(
select dept_id,AVG(salary) as Average_Salary from employee
group by dept_id
)
select st.dept_id ,mt.dep_name,st.Average_Salary from cte as st inner join dept as mt 
on st.dept_id=mt.dep_id


--4- write a query to print dep names where none of the emplyees have same salary.


select * from employee

--Solution 1:-
select d.dep_name,count(e.emp_id),count(distinct e.salary)
from employee e
inner join dept d on e.dept_id=d.dep_id
group by d.dep_name
having count(e.emp_id)=count(distinct e.salary);

--Solution 2:-
with cte as 
(
select dept_id from employee
group by dept_id
having count(emp_id) = count(distinct salary)
)
select st.dept_id,mt.dep_name from cte as st inner join dept as mt 
on mt .dep_id =st.dept_id


--5- write a query to print sub categories where we have all 3 kinds of returns (others,bad quality,wrong items).

select sub_category,count(distinct mt.[Return Reason] ) as total from Orders as st inner join Returns_ as mt 
on mt.[Order Id]=st.order_id
group by sub_category
having count(distinct mt.[Return Reason] )=3


--6- write a query to find cities where not even a single order was returned.

select * from Orders as st left join Returns_ as mt 
on mt.[Order Id]=st.order_id
where mt.[Order Id] is null


--7- write a query to find top 3 subcategories by sales of returned orders in east region.

select top 3 sub_category,sum(sales) as total_sales from Orders as st inner join Returns_ as mt 
on mt .[Order Id]=st.order_id
where region='east' 
group by sub_category
order by total_sales desc


--8- write a query to print dep name for which there is no employee.

--Solution:1
select mt.dep_name from employee as st right join dept as mt 
on mt.dep_id=st.dept_id
where st.emp_id is null

--Soulution :2
select d.dep_id,d.dep_name
from dept d 
left join employee e on e.dept_id=d.dep_id
group by d.dep_id,d.dep_name
having count(e.emp_id)=0;


--9- write a query to print employees name for dep id is not avaiable in dept table.

--Solution:1
select st.emp_name from employee as st left join dept as mt 
on mt.dep_id=st.dept_id
where mt.dep_name is null

--Solution:2
with cte as 
(
select st.emp_name,mt.dep_id from employee as st left join dept as mt 
on mt.dep_id=st.dept_id
group by st.emp_name,mt.dep_id
having count(dep_id) =0
)
select emp_name from cte 

/********************************************************************************************************************

                                                  Assignment- 4

*********************************************************************************************************************/
/*
1- write a query to print emp name , their manager name and diffrence in their age (in days) 
    for employees whose year of birth is before their managers year of birth .
*/


select st.emp_name,mt.emp_name,datediff(dd,st.dob,mt.dob) as diff_in_age from employee as st inner join employee as mt 
on st.manager_id =mt.emp_id
where datepart(yy,st.dob) <datepart(yy,mt.dob)


/*
2- write a query to find subcategories who never had any return orders in the month of november (irrespective of years).
*/


select sub_category from Orders as st left join Returns_ as mt 
on mt.[Order Id]=st.order_id
where datepart(mm,order_date)=11
group by sub_category
having count(distinct [Return Reason])  =0


/*
3- orders table can have multiple rows for a particular order_id when customers buys more than 1 product in an order.
write a query to find order ids where there is only 1 product bought by the customer.
*/

select order_id,count(distinct product_id) as number_of_bought_product from Orders
group by order_id
having count(distinct product_id)=1


/*
4- write a query to print manager names along with the comma separated list(order by emp salary) of all employees directly reporting to him.
*/

select mt.emp_name as Manager,STRING_AGG(st.emp_name,',') as Employees from employee as st inner join employee as mt 
on st.manager_id=mt.emp_id
group by mt.emp_name


/*
5- write a query to get number of business days between order_date and ship_date (exclude weekends). 
Assume that all order date and ship date are on weekdays only
*/

select order_id,order_date,ship_date ,datediff(day,order_date,ship_date)-2*datediff(week,order_date,ship_date) as no_of_business_days
from orders


/*
6- write a query to print 3 columns : category, total_sales and (total sales of returned orders)
*/

select category,sum(sales) as total_sales ,
sum(case when mt.[Order Id] is not null then st.sales end) as [total sales of returned orders] 
from Orders as st left join Returns_ as mt 
on mt.[Order Id]=st.order_id
group by category


/*
7- write a query to print below 3 columns
category, total_sales_2019(sales in year 2019), total_sales_2020(sales in year 2020)
*/

select category,sum(case when datepart(yy,order_date)=2019 then sales end) as[sales in year 2019],
sum(case when datepart(yy,order_date)=2020 then sales end) as[sales in year 2020]
from Orders
group by category

/*
8- write a query print top 5 cities in west region by average no of days between order date and ship date.
*/

select top 5 city ,avg(datediff(day,order_date,ship_date) ) as avg_days from Orders
where region='west'
group by city
order by avg_days desc


/*
9- write a query to print emp name, manager name and senior manager name (senior manager is manager's manager).
*/

select st.emp_name,mt.emp_name,rt.emp_name from employee as st 
inner join employee as mt on st.manager_id=mt.emp_id
inner join employee as rt on mt.manager_id=rt.emp_id


/********************************************************************************************************************

                                                  Assignment- 5

*********************************************************************************************************************/
/*
1- write a query to produce below output from icc_world_cup table.
team_name, no_of_matches_played , no_of_wins , no_of_losses
*/
select * from icc_world_cup;


--Solution 1:-
with all_team as
(
select Team_1 as  Team,Winner from icc_world_cup
union all
select Team_2 as Team,Winner from icc_world_cup
)
select Team,count(1) as no_of_matches_played,sum(case when Team=Winner then 1 else 0 end) as no_of_wins,
count(1)-sum(case when Team=Winner then 1 else 0 end) as no_of_losses
from all_team
group by Team;


--Solution 2:-
with all_teams as 
(select team_1 as team, case when team_1=winner then 1 else 0 end as win_flag from icc_world_cup
union all
select team_2 as team, case when team_2=winner then 1 else 0 end as win_flag from icc_world_cup)
select team,count(1) as total_matches_played , sum(win_flag) as matches_won,count(1)-sum(win_flag) as matches_lost
from all_teams
group by team


/*
2- write a query to print first name and last name of a customer using orders table(everything after first space can be considered as last name)
customer_name, first_name,last_name
*/


select customer_name , trim(SUBSTRING(customer_name,1,CHARINDEX(' ',customer_name))) as first_name
, SUBSTRING(customer_name,CHARINDEX(' ',customer_name)+1,len(customer_name)-CHARINDEX(' ',customer_name)+1) as second_name
from orders;



/*
3- write a query to print below output using drivers table. Profit rides are the no of rides where end location of a ride is 
same as start location of immediate next ride for a driver
id, total_rides , profit_rides
dri_1,5,1
dri_2,2,0
*/
select * from drivers


--Solution 1:-
select st.id,count(1) as total_rides, 
sum(case when mt.id is not null then 1 else 0 end) as profit_rides
from drivers as st left join drivers as mt
on st.end_loc=mt.start_loc and st.end_time=mt.start_time
group by st.id;

--Solution 2:-
with cte as 
(
select * ,
lead(start_loc,1) over(partition by id order by start_time asc) as next_start_location 
from drivers
)
select id, count(1) as total_rides
,sum(case when end_loc=next_start_location then 1 else 0 end ) as profit_rides from cte
group by id 


/*
4- write a query to print customer name and no of occurence of character 'n' in the customer name.
customer_name , count_of_occurence_of_n
*/
select customer_name , len(customer_name)-len(replace(lower(customer_name),'n','')) as count_of_occurence_of_n
from orders


/*

5-write a query to print below output from orders data. example output
hierarchy type,hierarchy name ,total_sales_in_west_region,total_sales_in_east_region
category , Technology, ,
category, Furniture, ,
category, Office Supplies, ,
sub_category, Art , ,
sub_category, Furnishings, ,
--and so on all the category ,subcategory and ship_mode hierarchies 
*/


select 
'category' as hierarchy_type,category as hierarchy_name
,sum(case when region='West' then sales end) as total_sales_in_west_region
,sum(case when region='East' then sales end) as total_sales_in_east_region
from orders
group by category
union all
select 
'sub_category',sub_category
,sum(case when region='West' then sales end) as total_sales_in_west_region
,sum(case when region='East' then sales end) as total_sales_in_east_region
from orders
group by sub_category
union all
select 
'ship_mode ',ship_mode 
,sum(case when region='West' then sales end) as total_sales_in_west_region
,sum(case when region='East' then sales end) as total_sales_in_east_region
from orders
group by ship_mode 

/*
6- the first 2 characters of order_id represents the country of order placed . write a query to print total no of orders placed in each country
(an order can have 2 rows in the data when more than 1 item was purchased in the order but it should be considered as 1 order)
*/

select left(order_id,2) as country, count(distinct order_id) as total_orders
from orders 
group by left(order_id,2)


/********************************************************************************************************************

                                                  Assignment- 6

*********************************************************************************************************************/

1.https://datalemur.com/questions/matching-skills

2.https://datalemur.com/questions/sql-page-with-no-likes

3.https://datalemur.com/questions/tesla-unfinished-parts

4.https://datalemur.com/questions/laptop-mobile-viewership

5.https://datalemur.com/questions/sql-average-post-hiatus-1

6.https://datalemur.com/questions/teams-power-users

7.https://datalemur.com/questions/completed-trades

8.https://datalemur.com/questions/sql-avg-review-ratings

9.https://datalemur.com/questions/click-through-rate

10.https://datalemur.com/questions/second-day-confirmation


