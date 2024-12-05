
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

