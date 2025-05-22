{{
    config(
        materialized='table'
    )
}}

with cte_a as (
    select        
        distinct airlinecode,
        airlinename
    from {{ ref('stg_flights') }}
    where airlinecode is not null
)
select 
    {{ dbt_utils.generate_surrogate_key(['airlinecode']) }} AS airline_key,
    airlinecode,
    airlinename
from cte_a