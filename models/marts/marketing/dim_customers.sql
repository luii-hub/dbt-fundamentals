with customers as (

    select * from {{ ref('stg_jaffle_shop__customers') }}

),

orders as (
    select * from {{ ref('fct_orders') }}
),

payments as (
    select * from {{ ref('stg_stripe__payments')}}
),


customer_orders as (

    select
        customer_id,

        min(order_date) as first_order_date,
        max(order_date) as most_recent_order_date,
        count(order_id) as number_of_orders

    from orders

    group by 1

),

lifetime_expenses as (

    SELECT 

        c.customer_id,
        SUM(p.amount) AS lifetime_expenses

    FROM payments p 

    JOIN orders o ON o.order_id = p.order_id
    JOIN customers c ON c.customer_id = o.customer_id 

    GROUP BY c.customer_id 
    ORDER BY lifetime_expenses DESC
    
),


final as (

    select
        customers.customer_id,
        customers.first_name,
        customers.last_name,
        customer_orders.first_order_date,
        customer_orders.most_recent_order_date,
        coalesce(customer_orders.number_of_orders, 0) as number_of_orders,
        coalesce(lifetime_expenses.lifetime_expenses, 0) as lifetime_expenses



    from customers

    left join customer_orders using (customer_id)
    left join lifetime_expenses using (customer_id)

)

select * from final
