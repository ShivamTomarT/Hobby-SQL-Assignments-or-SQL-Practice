
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