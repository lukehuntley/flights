select
    *
from {{ source('raw_flights', 'raw_flights') }}
limit 10