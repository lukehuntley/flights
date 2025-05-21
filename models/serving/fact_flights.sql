{{
    config(
        materialized='table'
    )
}}

select 
    transactionid,
    flightdate,
    {{ dbt_utils.generate_surrogate_key(['airlinecode']) }} AS airline_key,
    {{ dbt_utils.generate_surrogate_key(['tailnum']) }} AS aircraft_key,
    flightnum,
    {{ dbt_utils.generate_surrogate_key(['originairportcode']) }} AS origin_airport_key,
    {{ dbt_utils.generate_surrogate_key(['destairportcode']) }} AS destination_airport_key,
    crsdeptime,
    deptime,
    depdelay,
    taxiout,
    wheelsoff,
    wheelson,
    taxiin,
    crsarrtime,
    arrtime,
    arrdelay,
    crselapsedtime,
    actualelapsedtime,
    cancelled,
    diverted,
    distance,
    case
        when try_cast(replace(distance, ' miles', '') as integer) <= 100 THEN '0-100 miles'
        else CONCAT(
            ceil(try_cast(replace(distance, ' miles', '') as integer) / 100) * 100 - 99,
            '-',
            ceil(try_cast(replace(distance, ' miles', '') as integer) / 100) * 100,
            ' miles'
        )
    end as distancegroup,
    case
        when depdelay > 15 THEN 1
        else 0
    end as depdelaygt15,
    -- case
    --     when deptime IS NULL OR arrtime IS NULL OR actualelapsedtime IS NULL THEN 0
    --     WHEN DATEADD(MINUTE, actualelapsedtime, departure_timestamp) > departure_timestamp THEN 1
    --     else 0
    -- end as nextdayarr,
    case
        when deptime IS NULL OR arrtime IS NULL OR actualelapsedtime IS NULL THEN 0
        WHEN to_date(arrival_timestamp) > to_date(departure_timestamp) THEN 1
        else 0
    end as nextdayarr,
    -- departure_timestamp,
    -- arrival_timestamp
from {{ ref('stg_flights') }}

