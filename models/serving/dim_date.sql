{{
    config(
        materialized='table'
    )
}}

{% set get_start_date_query %}
    select min(to_char(TO_DATE(TO_CHAR(flightdate),'YYYYMMDD'),'YYYY-MM-DD')) from {{ ref('stg_flights') }}
{% endset %}
{%- set start_date = dbt_utils.get_single_value(get_start_date_query) -%}

{% set get_end_date_query %}
    select max(to_char(TO_DATE(TO_CHAR(flightdate),'YYYYMMDD'),'YYYY-MM-DD')) from {{ ref('stg_flights') }}
{% endset %}
{%- set end_date = dbt_utils.get_single_value(get_end_date_query) -%}

{{ dbt_date.get_date_dimension(start_date,end_date) }}