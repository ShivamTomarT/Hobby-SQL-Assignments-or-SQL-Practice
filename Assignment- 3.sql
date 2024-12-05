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