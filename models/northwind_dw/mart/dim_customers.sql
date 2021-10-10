{{ config(materialized='table') }}

with
    staging as (
        select * 
        from {{ ref('stg_customers') }}
)
    , transformed as (
        select
            row_number() over (order by customer_id) as customer_sk --auto incremental surrogate key, cria uma chave nova baseada em cada id
            , customer_id
            , country
            , city
            , fax
            , postal_code
            , address
            , region
            , contact_name
            , phone
            , company_name
            , contact_title
        from staging
)

select * from transformed