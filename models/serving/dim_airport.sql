{{
    config(
        materialized='table'
    )
}}

with cte_a as (
    select        
        distinct originairportcode,
        origairportname,
        origincityname,
        originstate,
        originstatename
    from {{ ref('stg_flights') }}
),
    cte_b as (
    select 
        distinct destairportcode,
        destairportname,
        destcityname,
        deststate,
        deststatename
    from {{ ref('stg_flights') }}
),
    cte_c as (
    select
        originairportcode as airportcode,
        origairportname as airportname,
        origincityname as cityname,
        originstate as statecode,
        originstatename as statename
    from cte_a
    union
    select
        destairportcode as airportcode,
        destairportname as airportname,
        destcityname as cityname,
        deststate as statecode,
        deststatename as statename
    from cte_b
),
    cte_d as (
    select 
        distinct airportcode,
        airportname,
        cityname,
        statecode,
        statename
    from cte_c
    where airportcode is not null
)
select 
    {{ dbt_utils.generate_surrogate_key(['airportcode']) }} AS airport_key,
    airportcode,
    airportname,
    cityname,
    statecode,
    statename
from cte_d