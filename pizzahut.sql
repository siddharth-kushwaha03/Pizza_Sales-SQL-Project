-- 11.Calculate the percentage contribution of each pizza type to total revenue.

SELECT 
    pizza_types.category,
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
GROUP BY pizza_types.category
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


-- 13. Determine the top 3 most ordered pizza types 
-- based on revenue for each pizza category.

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

