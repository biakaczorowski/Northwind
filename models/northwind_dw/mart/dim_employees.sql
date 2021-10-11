{{ config(materialized='table') }}

with
    staging as (
        select * 
        from {{ ref('stg_employees') }}
)
    , transformed as (
        select
            row_number() over (order by employee_id) as employee_sk --auto incremental surrogate key, cria uma chave nova baseada em cada id
                , employee_id
                , last_name	
                , first_name		
                , title		
                , title_of_courtesy	
                , birth_date		
                , hire_date	
                , address	
                , city	
                , region		
                , postal_code	
                , country		
                , home_phone	
                , extension
                , photo		
                , notes	
                , reports_to
                , photo_path
        from staging
)

select * from transformed