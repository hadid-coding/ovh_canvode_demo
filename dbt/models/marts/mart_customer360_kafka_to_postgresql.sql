{{
    config(
        materialized='incremental',
        tags=['mart', 'production', 'canvode'],
        alias='fact_customer_monthly',
        schema='gold',
        unique_key=['customer_id', 'revenue_month', 'currency'],
        partition_by={"field": "revenue_month", "data_type": "date"},
        on_schema_change='append_new_columns'
    )
}}

{# Mart model for customer360_kafka_to_postgresql. Owner: data-team. SLA: 15 min. #}

{% if is_incremental() %}
    -- Incremental merge is handled by unique_key; no watermark filter is
    -- added here because mart grains may not retain the source watermark.
{% endif %}

with transformed as (
    select *
    from {{ ref('int_customer360_kafka_to_postgresql') }}
)

select
    coalesce(customer_id, -1) as customer_id,
    coalesce(revenue_month, date '1900-01-01') as revenue_month,
    coalesce(currency, '__missing__') as currency,
    customer_segment,
    country_code,
    monthly_revenue,
    purchase_count,
    last_event_timestamp
from transformed
