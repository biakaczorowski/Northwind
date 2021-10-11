with source_data as (
    select
        order_id
        , product_id	
        , unit_price	
        , quantity
        , discount
    from {{ source('erpnorthwind20211010','public_order_details') }}
)

select * from source_data