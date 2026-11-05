{{
    config(
        materialized='view',
        tags=['staging', 'canvode'],
        meta={'owner': 'data-team', 'pipeline': 'customer360_kafka_to_postgresql'}
    )
}}

with source as (
    select *
    from {{ source('kafka_customer_events', 'customer_events') }}
    where event_timestamp > cast('{{ var("run_date", "1900-01-01") }}' as timestamp)
      and (customer_id.notnull() and event_timestamp.notnull() and amount.notnull() and amount >= 0 and currency.notnull())
),

renamed_and_cast as (
    select
    cast(customer_id as int64) as customer_id,
    cast(event_timestamp as timestamp) as event_timestamp,
    to_hex(sha256(lower(trim(cast(email as string))))) as email_masked,  -- PII masked at staging
    to_hex(sha256(lower(trim(cast(phone as string))))) as phone_masked,  -- PII masked at staging
    cast(product_id as int64) as product_id,
    cast(amount as numeric) as amount,
    cast(currency as string) as currency,
    cast(event_type as string) as event_type
    from source
)

select * from renamed_and_cast
