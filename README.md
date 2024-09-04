# SQL-Pizza-Project

This SQL project analyzes data for a pizza store. The database consists of four primary tables. Each table plays a crucial role in storing different facets of the business operations, from individual orders to the types of pizzas offered. Below is a detailed description of each table and its columns:

1. order_details:
   - order_details_id: A unique identifier for each entry in the order details.
   - order_id: References the ID from the orders table, linking the order detail to a specific order.
   - pizza_id: References the ID from the pizzas table, identifying which pizza was ordered.
   - quantity: The number of pizzas ordered of the specified type.

2. pizzas:
   - pizza_id: A unique identifier for each type of pizza available.
   - pizza_type_id: Links to the pizza_types table, specifying the type of pizza.
   - size: The size of the pizza (e.g., small, medium, large).
   - price: The cost of the pizza.

3. orders:
   - order_id: A unique identifier for each order placed.
   - date: The date on which the order was placed.
   - time: The time at which the order was placed.

4. pizza_types:
   - pizza_type_id: A unique identifier for each type of pizza.
   - name: The name of the pizza type (e.g., Margherita, Pepperoni).
   - category: Categorizes the pizza (e.g., Vegetarian, Non-Vegetarian).
   - ingredients: Lists the ingredients used in the pizza.

Relevance to a Pizza Sales Store Manager:

A pizza sales store manager can utilize this SQL project to extract valuable insights and conduct detailed data analysis, facilitating informed decision-making and efficient management of the store's operations. Here are a few insight for a store manager to manage the store more efficiently:

1/ The total revenue generated from pizza sales.

2/ The highest-priced pizza.

3/ The most common pizza size ordered.

4/ The distribution of orders by hour of the day.

5/ The average number of pizzas ordered per day.

6/ The percentage contribution of each pizza type to total revenues.

7/ The cumulative revenue generated over time.

8/ The variation of revenue per day.

9/ The price range customer often choose.

- Sales Analysis: By querying the order_details and pizzas tables, managers can identify the best-selling pizzas, assess revenue from different pizza sizes, and evaluate pricing strategies.
- Inventory Management: Analyzing the pizza_types and their ingredients helps in managing inventory more efficiently, ensuring that ingredients are stocked according to demand and reducing waste.
- Customer Preferences: Through data gathered in the orders and pizzas tables, managers can track customer preferences over time, adjusting the menu to cater to popular choices and experimenting with new or seasonal offerings witth the popular price.
- Operational Efficiency: Date and time data from the orders table allow managers to assess peak and low hours to arrange shift for the staff appropriately, ensuring operational efficiency and customer satisfaction.
