{{
    config(
        materialized='ephemeral',
        tags=['intermediate', 'canvode']
    )
}}

-- Pass-through: no intermediate transforms. Data flows staging → mart.

with staged as (
    select * from {{ ref('stg_customer360_kafka_to_postgresql') }}
)

select * from staged
