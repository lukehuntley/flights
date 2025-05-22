{{
    config(
        materialized='view'
    )
}}

select 
        f.transactionid,    
        f.distancegroup,
        f.depdelaygt15,
        f.nextdayarr,
        airline.airlinename,
        origin_airport.airportname as origairportname,
        destination_airport.airportname as destairportname,
        -- Additional columns worth including    
        dt.date_day as flightdate,
        aircraft.tailnum,
        f.flightnum,
        origin_airport.cityname as origincityname,
        origin_airport.statename as originstatename,   
        destination_airport.cityname as destcityname,  
        destination_airport.statename as deststatename,
        f.deptime,  
        f.depdelay,
        f.taxiout,
        f.wheelsoff,
        f.wheelson,
        f.taxiin,
        f.arrdelay,
        f.arrtime,
        f.crselapsedtime,  
        f.actualelapsedtime,  
        f.cancelled,  
        f.diverted,  
        f.distance,
    from {{ ref('fact_flights') }} f
    left join dim_date as dt
        on dt.date_key = f.flightdate
    left join dim_airline as airline
        on airline.airline_key = f.airline_key
    left join dim_airport origin_airport
        on origin_airport.airport_key = f.origin_airport_key
    left join dim_airport destination_airport
        on destination_airport.airport_key = f.destination_airport_key
    left join dim_aircraft as aircraft
        on aircraft.aircraft_key = f.aircraft_key


 
      


        
        

