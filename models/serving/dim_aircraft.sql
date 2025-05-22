{{
    config(
        materialized='table'
    )
}}

with cte_a as (
    select
        distinct tailnum
    from {{ ref('stg_flights') }}
    where tailnum is not null
)
select 
    {{ dbt_utils.generate_surrogate_key(['tailnum']) }} AS aircraft_key,
    tailnum
from cte_a
order by tailnum asc