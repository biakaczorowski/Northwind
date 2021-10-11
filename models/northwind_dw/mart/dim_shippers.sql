{{ config(materialized='table') }}

with
    staging as (
        select * 
        from {{ ref('stg_shippers') }}
)
    , transformed as (
        select
            row_number() over (order by shipper_id) as shipper_sk --auto incremental surrogate key, cria uma chave nova baseada em cada id
            , shipper_id	
            , company_name
            , phone
        from staging
)

select * from transformed