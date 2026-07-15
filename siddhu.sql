
CREATE DATABASE pizzahut;

USE pizzahut;

create table orders(
order_id int not null,
order_date date not null,
order_time time not null,
primary key(order_id));

create table order_details(
order_details_id int not null,
order_id int not null,
pizza_id text not null,
quantity int not null,
primary key(order_details_id));

CREATE TABLE pizza_types (
    pizza_type_id VARCHAR(50) NOT NULL,
    name VARCHAR(100) NOT NULL,
    category VARCHAR(50) NOT NULL,
    ingredients TEXT NOT NULL,
    PRIMARY KEY (pizza_type_id)
);
INSERT INTO pizza_types (pizza_type_id, name, category, ingredients) VALUES
('bbq_ckn','The Barbecue Chicken Pizza','Chicken','Barbecued Chicken, Red Peppers, Green Peppers, Tomatoes, Red Onions, Barbecue Sauce'),
('cali_ckn','The California Chicken Pizza','Chicken','Chicken, Artichoke, Spinach, Garlic, Jalapeno Peppers, Fontina Cheese, Gouda Cheese'),
('ckn_alfredo','The Chicken Alfredo Pizza','Chicken','Chicken, Red Onions, Red Peppers, Mushrooms, Asiago Cheese, Alfredo Sauce'),
('ckn_pesto','The Chicken Pesto Pizza','Chicken','Chicken, Tomatoes, Red Peppers, Spinach, Garlic, Pesto Sauce'),
('southw_ckn','The Southwest Chicken Pizza','Chicken','Chicken, Tomatoes, Red Peppers, Red Onions, Jalapeno Peppers, Corn, Cilantro, Chipotle Sauce'),
('thai_ckn','The Thai Chicken Pizza','Chicken','Chicken, Pineapple, Tomatoes, Red Peppers, Thai Sweet Chilli Sauce'),
('big_meat','The Big Meat Pizza','Classic','Bacon, Pepperoni, Italian Sausage, Chorizo Sausage'),
('classic_dlx','The Classic Deluxe Pizza','Classic','Pepperoni, Mushrooms, Red Onions, Red Peppers, Bacon'),
('hawaiian','The Hawaiian Pizza','Classic','Sliced Ham, Pineapple, Mozzarella Cheese'),
('ital_cpcllo','The Italian Capocollo Pizza','Classic','Capocollo, Red Peppers, Tomatoes, Goat Cheese, Garlic, Oregano'),
('napolitana','The Napolitana Pizza','Classic','Tomatoes, Anchovies, Green Olives, Red Onions, Garlic'),
('pep_msh_pep','The Pepperoni, Mushroom, and Peppers Pizza','Classic','Pepperoni, Mushrooms, Green Peppers'),
('pepperoni','The Pepperoni Pizza','Classic','Mozzarella Cheese, Pepperoni'),
('the_greek','The Greek Pizza','Classic','Kalamata Olives, Feta Cheese, Tomatoes, Garlic, Beef Chuck Roast, Red Onions'),
('brie_carre','The Brie Carre Pizza','Supreme','Brie Carre Cheese, Prosciutto, Caramelized Onions, Pears, Thyme, Garlic'),
('calabrese','The Calabrese Pizza','Supreme','Nduja Salami, Pancetta, Tomatoes, Red Onions, Friggitello Peppers, Garlic'),
('ital_supr','The Italian Supreme Pizza','Supreme','Calabrese Salami, Capocollo, Tomatoes, Red Onions, Green Olives, Garlic'),
('peppr_salami','The Pepper Salami Pizza','Supreme','Genoa Salami, Capocollo, Pepperoni, Tomatoes, Asiago Cheese, Garlic'),
('prsc_argla','The Prosciutto and Arugula Pizza','Supreme','Prosciutto di San Daniele, Arugula, Mozzarella Cheese'),
('sicilian','The Sicilian Pizza','Supreme','Coarse Sicilian Salami, Tomatoes, Green Olives, Luganega Sausage, Onions, Garlic'),
('soppressata','The Soppressata Pizza','Supreme','Soppressata Salami, Fontina Cheese, Mozzarella Cheese, Mushrooms, Garlic'),
('spicy_ital','The Spicy Italian Pizza','Supreme','Capocollo, Tomatoes, Goat Cheese, Artichokes, Peperoncini verdi, Garlic'),
('spinach_supr','The Spinach Supreme Pizza','Supreme','Spinach, Red Onions, Pepperoni, Tomatoes, Artichokes, Kalamata Olives, Garlic, Asiago Cheese'),
('five_cheese','The Five Cheese Pizza','Veggie','Mozzarella Cheese, Provolone Cheese, Smoked Gouda Cheese, Romano Cheese, Blue Cheese, Garlic'),
('four_cheese','The Four Cheese Pizza','Veggie','Ricotta Cheese, Gorgonzola Piccante Cheese, Mozzarella Cheese, Parmigiano Reggiano Cheese, Garlic'),
('green_garden','The Green Garden Pizza','Veggie','Spinach, Mushrooms, Tomatoes, Green Olives, Feta Cheese'),
('ital_veggie','The Italian Vegetables Pizza','Veggie','Eggplant, Artichokes, Tomatoes, Zucchini, Red Peppers, Garlic, Pesto Sauce'),
('mediterraneo','The Mediterranean Pizza','Veggie','Spinach, Artichokes, Kalamata Olives, Sun-dried Tomatoes, Feta Cheese, Plum Tomatoes, Red Onions'),
('mexicana','The Mexicana Pizza','Veggie','Tomatoes, Red Peppers, Jalapeno Peppers, Red Onions, Cilantro, Corn, Chipotle Sauce, Garlic'),
('spin_pesto','The Spinach Pesto Pizza','Veggie','Spinach, Artichokes, Tomatoes, Sun-dried Tomatoes, Garlic, Pesto Sauce'),
('spinach_fet','The Spinach and Feta Pizza','Veggie','Spinach, Mushrooms, Red Onions, Feta Cheese, Garlic'),
('veggie_veg','The Vegetables + Vegetables Pizza','Veggie','Mushrooms, Tomatoes, Red Peppers, Green Peppers, Red Onions, Zucchini, Spinach, Garlic');





-- 1.Retrieve the total number of orders placed.

select count(order_id) as total_orders from orders;

-- 2.Calculate the total revenue generated from pizza sales.

SELECT 
    ROUND(SUM(order_details.quantity * pizzas.price),
            2) AS total_sales
FROM
    order_details
        JOIN
    pizzas ON pizzas.pizza_id = order_details.pizza_id;
    
   -- 3. Identify the highest-priced pizza.
SELECT 
    pizza_types.name, pizzas.price
FROM
    pizza_types
        JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
ORDER BY pizzas.price DESC
LIMIT 1;
    
-- 4.Identify the most common pizza size ordered.

SELECT 
    pizzas.size,
    COUNT(order_details.order_details_id) AS order_count
FROM
    pizzas
        JOIN
    order_details ON pizzas.pizza_id = order_details.pizza_id
GROUP BY pizzas.size
ORDER BY order_count DESC;
 
 -- 5.List the top 5 most ordered pizza types along with their quantities.
 
SELECT 
    pizza_types.name,
    SUM(order_details.quantity) AS total_quantity
FROM
    pizza_types
        JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
        JOIN
    order_details ON order_details.pizza_id = pizzas.pizza_id
GROUP BY pizza_types.name
ORDER BY total_quantity DESC
LIMIT 5;
 
 -- 6.Join the necessary tables to find the 
-- total quantity of each pizza category ordered.

SELECT 
    pizza_types.category,
    SUM(order_details.quantity) AS total_quantity
FROM
    pizza_types
        JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
        JOIN
    order_details ON order_details.pizza_id = pizzas.pizza_id
GROUP BY pizza_types.category
ORDER BY total_quantity DESC;

-- 7.Determine the distribution of orders by hour of the day.
SELECT 
    HOUR(order_time) AS hour,
    COUNT(order_id) AS order_count
FROM
    orders
GROUP BY hour(order_time);

-- 8.Join relevant tables to find the category-wise distribution of pizzas.

select category, count(name) from pizza_types
group by category;


-- 9.Group the orders by date and calculate the average 
-- number of pizzas ordered per day.


SELECT 
    orders.order_date,
    AVG(order_details.quantity) AS average_pizzas_ordered
FROM
    orders
        JOIN
    order_details ON orders.order_id = order_details.order_id
GROUP BY orders.order_date;



-- 10.Determine the top 3 most ordered pizza types based on revenue.

SELECT 
    pizza_types.name,
    SUM(order_details.quantity * pizzas.price) AS revenue
FROM
    pizza_types
        JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
        JOIN
    order_details ON pizzas.pizza_id = order_details.pizza_id
GROUP BY pizza_types.name
ORDER BY revenue DESC
LIMIT 3;

-- 11.Calculate the percentage contribution of each pizza type to total revenue.
use pizzahut;

SELECT 
    pizza_types.name,
    SUM(order_details.quantity * pizzas.price) AS revenue,
    ROUND(
        (SUM(order_details.quantity * pizzas.price) / 
        (SELECT SUM(order_details.quantity * pizzas.price)
         FROM order_details
         JOIN pizzas 
         ON order_details.pizza_id = pizzas.pizza_id)) * 100, 2
    ) AS revenue_percentage
FROM
    pizza_types
        JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
        JOIN
    order_details ON order_details.pizza_id = pizzas.pizza_id
GROUP BY pizza_types.name
ORDER BY revenue_percentage DESC;

-- 12.Analyze the cumulative revenue generated over time.

SELECT 
    orders.order_date,
    SUM(order_details.quantity * pizzas.price) AS daily_revenue,
    SUM(SUM(order_details.quantity * pizzas.price)) 
    OVER(ORDER BY orders.order_date) AS cumulative_revenue
FROM
    orders
        JOIN
    order_details ON orders.order_id = order_details.order_id
        JOIN
    pizzas ON order_details.pizza_id = pizzas.pizza_id
GROUP BY orders.order_date
ORDER BY orders.order_date;

-- 13. Determine the top 3 most ordered pizza types based on revenue for each pizza category.

SELECT *
FROM
(
    SELECT 
        pizza_types.category,
        pizza_types.name,
        SUM(order_details.quantity * pizzas.price) AS revenue,
        RANK() OVER(
            PARTITION BY pizza_types.category 
            ORDER BY SUM(order_details.quantity * pizzas.price) DESC
        ) AS pizza_rank
    FROM
        pizza_types
            JOIN
        pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
            JOIN
        order_details ON pizzas.pizza_id = order_details.pizza_id
    GROUP BY 
        pizza_types.category,
        pizza_types.name
) AS ranked_pizzas
WHERE pizza_rank <= 3;










 
 
 
