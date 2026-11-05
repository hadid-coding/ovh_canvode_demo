-- Canvode generated macros

{% macro generate_schema_name(custom_schema_name, node) -%}
    {%- set default_schema = target.schema -%}
    {%- if custom_schema_name is none -%}
        {{ default_schema }}
    {%- else -%}
        {{ custom_schema_name | trim }}
    {%- endif -%}
{%- endmacro %}


{# Deduplicate keeping the latest record per key set #}
{% macro deduplicate(relation, partition_by, order_by="updated_at desc") %}
    select * from (
        select *,
            row_number() over (
                partition by {{ partition_by }}
                order by {{ order_by }}
            ) as _row_num
        from {{ relation }}
    ) _deduped
    where _row_num = 1
{% endmacro %}
