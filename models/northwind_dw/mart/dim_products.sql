{{ config(materialized='table') }}

with
    staging as (
        select 
            product.product_id	
            , product.product_name
            , product.supplier_id	
            , product.category_id	
            , product.quantity_per_unit
            , product.unit_price	
            , product.units_in_stock	
            , product.units_on_order	
            , product.reorder_level
            , product.discontinued
        from {{ ref('stg_products') }} product
)
    , staging2 as (
        select
            supplier.supplier_id	
            , supplier.company_name
            , supplier.contact_name
            , supplier.contact_title
            , supplier.address
            , supplier.city
            , supplier.region	
            , supplier.postal_code
            , supplier.country
            , supplier.phone
            , supplier.fax
            , supplier.homepage	
        from {{ ref('stg_suppliers') }} supplier
)
    , transformed as (
        select
            row_number() over (order by product_id) as product_sk --auto incremental surrogate key, cria uma chave nova baseada em cada id
                , product_id	
                , product_name
                , category_id	
                , quantity_per_unit
                , unit_price	
                , units_in_stock	
                , units_on_order	
                , reorder_level
                , discontinued
                , staging.supplier_id	
        from staging
        left join staging2 staging2 on staging.supplier_id = staging2.supplier_id
)

select * from transformed