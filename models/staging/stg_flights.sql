

{{
    config(
        materialized='table',
    )
}}

with cte_a as (
    select
        transactionid,  
        flightdate,        
        airlinecode,  
        trim(split_part(airlinename, ':', 1)) as airlinename, 
        tailnum,  
        flightnum,  
        originairportcode,  
        trim(split_part(origairportname, ':', 2)) as origairportname,  
        origincityname,  
        originstate, 
        originstatename,  
        destairportcode,  
        trim(split_part(destairportname, ':', 2)) as destairportname,  
        destcityname,  
        deststate,  
        deststatename,
        case
            when crsdeptime = 2400 then '0000'
            else lpad(crsdeptime, 4, '0') 
        end as crsdeptime,
        case
            when deptime = 2400 then '0000'
            else lpad(deptime, 4, '0') 
        end as deptime,  
        depdelay,  
        taxiout,
        case
            when wheelsoff = 2400 then '0000'
            else lpad(wheelsoff, 4, '0') 
        end as wheelsoff, 
        case
            when wheelson = 2400 then '0000'
            else lpad(wheelson, 4, '0') 
        end as wheelson,  
        taxiin,
        case
            when crsarrtime = 2400 then '0000'
            else lpad(crsarrtime, 4, '0') 
        end as crsarrtime,
        case
            when arrtime = 2400 then '0000'
            else lpad(arrtime, 4, '0') 
        end as arrtime, 
        arrdelay,  
        crselapsedtime,  
        actualelapsedtime,  
        cancelled,  
        diverted,  
        distance,
        -- cast(replace(distance, ' miles', '') as integer) as distance,
        -- to_timestamp(
        --     concat(
        --         to_char(to_date(to_char(flightdate), 'YYYYMMDD'), 'YYYYMMDD'),
        --         ' ',
        --         lpad(deptime, 4, '0')
        --     ),
        --     'YYYYMMDD HH24MI'
        --     ) AS departure_timestamp
        case 
            when deptime = 2400 then 
                to_timestamp(
                    concat(
                        TO_CHAR(TO_DATE(TO_CHAR(flightdate), 'YYYYMMDD'), 'YYYYMMDD'),
                        ' 0000'
                    ),
                    'YYYYMMDD HH24MI'
                )
            else
                to_timestamp(
                    concat(
                        TO_CHAR(TO_DATE(TO_CHAR(flightdate), 'YYYYMMDD'), 'YYYYMMDD'), 
                        ' ', 
                        lpad(deptime, 4, '0')
                    ),
                    'YYYYMMDD HH24MI'
                )
        end as departure_timestamp,
    from {{ source('raw_flights', 'raw_flights') }}
)
select
    cte_a.*,
    DATEADD(MINUTE, cte_a.actualelapsedtime, cte_a.departure_timestamp) as arrival_timestamp
from cte_a
-- limit 100



