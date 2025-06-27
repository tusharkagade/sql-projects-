use uddanous;
show tables;

select * from airline_delay;
-- 1. Total Flights by Airline
select carrier_name,sum(arr_flights) as total_flights from airline_delay 
group by carrier_name
order by total_flights desc;

-- 2. Delay Percentage by Airline
select carrier_name,
sum(arr_flights) as total_flights,
sum(arr_del15) as delayed_flights,
round(sum(arr_del15) / sum(arr_flights)*100,2) as delay_percentage 
from airline_delay
group by carrier_name
order by delay_percentage desc;

-- 3. Monthly Delay Trend
select year,month,sum(arr_del15) as total_delays from airline_delay
group by year,month
order by total_delays;

-- 4. Top 10 Airports by Delay Count
select airport_name, sum(arr_del15) as total_delays
from airline_delay
group by airport_name
order by total_delays desc
limit 10 ;

-- 5. Delay Reasons by Airline
select carrier_name,
       round(sum(carrier_delay),2) as carrier_delay,
       round(sum(weather_delay),2) as wether_delay,
       round(sum(nas_Delay),2) as nas_delay,
       round(sum(security_delay),2) as late_aircraft_delay
from airline_delay
group by carrier_name
order by late_aircraft_delay desc;

-- 6. Airlines with High Cancellation Rates

select carrier_name,
       sum(arr_cancelled) as total_cancelled,
       sum(arr_flights) as total_flights,
       round(sum(arr_cancelled) / sum(arr_flights)*100,2) as cancellation_rate
       from airline_delay
       group by carrier_name
       order by cancellation_rate desc;
       
-- 7. Airports with Late Aircraft Delay Issues
select airport_name, sum(late_aircraft_delay) as total_late_aircraft_delay
from airline_delay
group by airport_name
order by total_late_aircraft_delay desc;

-- 8. Average delay per airline
select carrier_name,round(avg(late_aircraft_delay),2) as average_aircraft_delay from airline_delay
group by carrier_name
order by average_aircraft_delay desc;





