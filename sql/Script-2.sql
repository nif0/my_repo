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
--join'�
select * from aircrafts a3 
left join 
aircrafts_data ad 
on a3.aircraft_code = ad.aircraft_code 
using (aircraft_code)

select * from aircrafts a3 
right join 
aircrafts_data ad 
on a3.aircraft_code = ad.aircraft_code 
--using (aircraft_code)

select * from aircrafts a3 
full join 
aircrafts_data ad 
using (aircraft_code) 


--������ � ������
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
 
commit;
ALTER TABLE bookings.flight_and_passenger4 add CONSTRAINT flight_and_passenger4_passenger_passenger_id_fkey foreign key(passenger_passenger_id)   references tickets(passenger_id) on update cascade on delete set null;
ALTER TABLE bookings.flight_and_passenger4 add CONSTRAINT flight_and_passenger4_ticket_ticket_no_fkey foreign key(ticket_ticket_no)   references tickets(ticket_no) on update cascade on delete set null;
--alter table flight_and_passenger4 drop constraint flight_and_passenger4_ticket_ticket_no_fkey

select cast('12/03/2001' as date) 
select cast('0100' as integer)
select cast('0100' as text)
create table binary_t (value integer) ;

insert into binary_t(value) values(0);
select * from binary_t
commit;
select case value when 0 then '0' when 1 then '1' when 2 then '2' else null end from binary_t

select value from binary_t bt where (select value from binary_t where value = 5) = 5
select value from binary_t bt where exists (select value from binary_t where value is null) 
select value from binary_t bt where not exists (select value from binary_t where value is null) 
select value from binary_t bt where not exists (select value from binary_t where value is null) and true
select value from binary_t bt where not exists (select value from binary_t where value is null) and false

select value from binary_t bt where 8 < any (select value from binary_t )
select value from binary_t bt where 4 = some (select value from binary_t )
select value from binary_t bt where 4 = all (select value from binary_t where value = 4)
explain  select value from binary_t bt where 4 = all (select value from binary_t where value = 9)