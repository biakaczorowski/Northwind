with source_data as (
    select
        shipper_id	
        , company_name
        , phone
    from {{ source('erpnorthwind20211010','public_shippers') }}
)

select * from source_data
