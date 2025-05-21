{{
    config(
        materialized='view'
    )
}}

select 
    f.transactionid,    
    distancegroup,
    depdelaygt15,
    nextdayarr,
    airline.airlinename,
    origin_airport.airportname as origairportname,
    destination_airport.airportname as destairportname,
    -- Additoinal columns worth including    
    -- f.flightdate,
    dt.date_day as flightdate,
    aircraft.tailnum,
    f.flightnum,
    origin_airport.cityname as origincityname,
    origin_airport.statename as originstatename,   
    destination_airport.cityname as destcityname,  
    destination_airport.statename as deststatename,
    f.depdelay,
    f.taxiout,
    f.taxiin,
    f.arrdelay,
    f.crselapsedtime,  
    f.actualelapsedtime,  
    f.cancelled,  
    f.diverted,  
    f.distance  
from {{ ref('fact_flights') }} f
join dim_airline as airline
    on airline.airline_key = f.airline_key
join dim_airport origin_airport
    on origin_airport.airport_key = f.origin_airport_key
join dim_airport destination_airport
    on destination_airport.airport_key = f.destination_airport_key
join dim_aircraft as aircraft
    on aircraft.aircraft_key = f.aircraft_key
join dim_date as dt
    on dt.date_key = f.flightdate


 
      


        
        

