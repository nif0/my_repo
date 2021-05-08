connect to demo 


select * from boarding_passes bp
select * from ticket_flights tf 
select * from tickets t 
select * from seats
select * from bookings b2 
select * from flights f2 
select * from pg_catalog.pg_stat_all_tables psat 
select * from airports a 
select * from aircrafts a 
select count(1) from aircrafts a2
select sum(amount) from ticket_flights tf 
select count(amount) from ticket_flights tf 
select avg(amount) from ticket_flights tf2 
select max(amount) from ticket_flights tf3 
select min(amount) from ticket_flights tf4 

select * from aircrafts a, aircrafts_data ad where a.aircraft_code = ad.aircraft_code
--join'ы
select * from aircrafts a3 
left join 
aircrafts_data ad 
on a3.aircraft_code = ad.aircraft_code 

select * from aircrafts a3 
right join 
aircrafts_data ad 
on a3.aircraft_code = ad.aircraft_code 

--каждый с каждым
select * from aircrafts a3 
cross join 
aircrafts_data ad 

select * from aircrafts a3 
inner join 
aircrafts_data ad 
on a3.aircraft_code = ad.aircraft_code 

select * from aircrafts a3 
full join 
aircrafts_data ad 
on a3.aircraft_code = ad.aircraft_code 

select * from aircrafts a3 
left join 
aircrafts_data ad 
on a3.aircraft_code = ad.aircraft_code 

select * from aircrafts a3 
 left join 
aircrafts_data ad 
on a3.aircraft_code = ad.aircraft_code --using a3.aircraft_code, ad.aircraft_code 

select a2.airport_name, count(f.flight_id) from flights f, airports a2 where a2.airport_code = f.departure_airport 
group by (a2.airport_name) having count(f.flight_id) > 400

select 

select * from boarding_passes bp
select * from aircrafts a2 --самолёты
select * from aircrafts_data ad 
select * from airports a3 
select * from ticket_flights tf 
select * from tickets t 
select * from seats
select * from bookings b2 
select * from flights f2 
select * from routes r 
select * from flights_v fv 
select * from pg_catalog.pg_stat_all_tables psat 
select * from airports a 
select * from flight_and_passenger
create table flight_and_passenger as
select t1.flight_id ,t1.passenger_id from flight_and_passenger t2 join flight_and_passenger t1 
on t2.flight_id = t1.flight_id-- and t2.passenger_id = t1.passenger_id
order by t1.flight_id
create index flightidx on flight_and_passenger using hash (flight_id) --using hash
order by t1.flight_id 

select distinct flight_id from flight_and_passenger