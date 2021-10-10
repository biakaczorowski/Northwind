{{ config(materialized='table') }}

--select * from {{ ref('stg_orders') }}

with
    customers as (
        select
            customer_sk
            , customer_id
        from {{ ref('dim_customers') }}
    )
, orders_with_sk as (
    select
        orders.order_id
        , customers.customer_id
        --, orders.employee_id
        , orders.order_date --posso trocar a ordem das colunas alterando a ordem que elas são escritas aqui
        , orders.ship_region
        , orders.shipped_date
        , orders.ship_country
        , orders.ship_name
        , orders.ship_postal_code
        , orders.ship_city as cidade --trocar o nome da coluna
        , orders.freight
        --, orders.ship_via as shipper_id
        , orders.ship_address
        , orders.required_date
    from {{ ref('stg_orders') }} orders --apelido para tabela
    left join customers customers on orders.customer_id = customers.customer_id
)

select * from orders_with_sk

--chamar as outras dims aqui