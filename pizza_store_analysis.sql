use pizza_store;
show tables;
select * from order_details;
select * from orders;
select * from pizzas;
select count(*) from orders;
select count( * ) from order_details;
select * from order_details;
select * from orders;
select * from order_details;
select * from pizzas;

select pizza_types.name,pizza_types.category,pizzas.size,order_details.quantity,(order_details.quantity * pizzas.price) as revenue 
from pizza_types 
join pizzas 
on pizzas.pizza_type_id = pizza_types.pizza_type_id 
join order_details
on order_details.pizza_id = pizzas.pizza_id; 
select count(order_id ) as total_orders_placed from orders;
select round(sum(order_details.quantity * pizzas.price ),2) from order_details
join pizzas 
on order_details.pizza_id = pizzas.pizza_id;
select round(sum(order_details.quantity * pizzas.price),2) 
from order_Details 
join pizzas
on order_details.pizza_id = pizzas.pizza_id; 
select pizza_types.name,max(pizzas.price) as max_price from pizza_types
join pizzas 
on pizzas.pizza_type_id = pizza_types.pizza_type_id
group by pizza_types.name order by max_price desc limit 1;
select pizza_types.name,max(pizzas.price) as highest_price from pizza_types
join pizzas
on pizza_types.pizza_type_id = pizzas.pizza_type_id 
group by pizza_types.name order by highest_price desc limit 1;



