with source_data as (
    select
        employee_id
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
        ,  photo		
        , notes	
        , reports_to
        , photo_path
    from {{ source('erpnorthwind20211010','public_employees') }}
)

select * from source_data
