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
        replace(tailnum,'@','') AS tailnum, 
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
        -- case
        --     when crsdeptime = 2400 then '0000'
        --     else lpad(crsdeptime, 4, '0') 
        -- end as crsdeptime,
         case
            when crsdeptime = 2400 then to_time('000000', 'HH24MISS')
            else to_time(rpad(lpad(crsdeptime, 4, '0'), 6, '0'), 'HH24MISS')
        end as crsdeptime,
        -- case
        --     when deptime = 2400 then '0000'
        --     else lpad(deptime, 4, '0') 
        -- end as deptime,
        case
            when deptime = 2400 then to_time('000000', 'HH24MISS')
            else to_time(rpad(lpad(deptime, 4, '0'), 6, '0'), 'HH24MISS')
        end as deptime,
        depdelay,  
        taxiout,
        -- case
        --     when wheelsoff = 2400 then '0000'
        --     else lpad(wheelsoff, 4, '0') 
        -- end as wheelsoff,
        case
            when wheelsoff = 2400 then to_time('000000', 'HH24MISS')
            else to_time(rpad(lpad(wheelsoff, 4, '0'), 6, '0'), 'HH24MISS')
        end as wheelsoff,
        -- case
        --     when wheelson = 2400 then '0000'
        --     else lpad(wheelson, 4, '0') 
        -- end as wheelson,
        case
            when wheelson = 2400 then to_time('000000', 'HH24MISS')
            else to_time(rpad(lpad(wheelson, 4, '0'), 6, '0'), 'HH24MISS')
        end as wheelson,
        taxiin,
        -- case
        --     when crsarrtime = 2400 then '0000'
        --     else lpad(crsarrtime, 4, '0') 
        -- end as crsarrtime,
        case
            when crsarrtime = 2400 then to_time('000000', 'HH24MISS')
            else to_time(rpad(lpad(crsarrtime, 4, '0'), 6, '0'), 'HH24MISS')
        end as crsarrtime,
        -- case
        --     when arrtime = 2400 then '0000'
        --     else lpad(arrtime, 4, '0') 
        -- end as arrtime,
        case
            when arrtime = 2400 then to_time('000000', 'HH24MISS')
            else to_time(rpad(lpad(arrtime, 4, '0'), 6, '0'), 'HH24MISS')
        end as arrtime,
        arrdelay,  
        crselapsedtime,  
        actualelapsedtime,  
        cancelled,  
        diverted,  
        distance,
        -- cast(replace(distance, ' miles', '') as integer) as distance,
    from {{ source('raw_flights', 'raw_flights') }}
)
select 
    * 
from cte_a
order by cte_a.transactionid