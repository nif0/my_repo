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
select * from aircrafts a, aircrafts_data ad where a.aircraft_code = ad.aircraft_code and a.model like '300%'
select * from aircrafts a, aircrafts_data ad where a.aircraft_code = ad.aircraft_code and a.model like '%300%'
select * from aircrafts a, aircrafts_data ad where a.aircraft_code = ad.aircraft_code and a.model like '%7_7_300'
select * from aircrafts a, aircrafts_data ad where a.aircraft_code = ad.aircraft_code and a.model like '300%'
select * from aircrafts a, aircrafts_data ad where a.aircraft_code = ad.aircraft_code and a.model like '_____ ___-%3%__'

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

select '10','20'
select all value from binary_t where value between 2 and 4
update binary_t  set value = 1 where value = 10

create table sity (
sity_id integer primary key,
name varchar(200)
);
insert into sity(sity_id,name) values(1,'������');
insert into sity(sity_id,name) values(2,'������������');
insert into sity(sity_id,name) values(3,'�����������');
insert into sity(sity_id,name) values(4,'�����������');
insert into sity(sity_id,name) values(5,'������');
insert into sity(sity_id,name) values(6,'�������');
insert into sity(sity_id,name) values(7,'�����');
insert into sity(sity_id,name) values(8,'���-����');
insert into sity(sity_id,name) values(9,'�����');
commit;

select * from sity_countries sc left join sity s on sc.sity_sity_id = s.sity_id
select * from sity_countries sc full join sity s on sc.sity_sity_id = s.sity_id

select * from seats
select * from flights f2 
select * from tickets t 

select * from airports_data ad 
select * from aircrafts_data ad2 
select * from aircrafts a 

create view seats_aircrafts as 
select s.*,a.model,a.range from seats s,aircrafts a where s.aircraft_code = a.aircraft_code
drop seats_aircrafts;

create materialized view seats_aircrafts2 as
select s.*,a.model,a.range from seats s,aircrafts a where s.aircraft_code = a.aircraft_code
drop materialized view seats_aircrafts2

create view v_aircrafts_test as select * from aircrafts a 
select count(1) from v_aircrafts_test
insert into aircrafts (aircraft_code,model,range) values ('CR2','��������� CRJ-200',200) 
drop view v_aircrafts_test

create view v_aircrafts_test as 
select * from aircrafts_data ad 
select * from v_aircrafts_test
insert into v_aircrafts_test (aircraft_code,model,range) values (774,'{"en": "Boeing 777-300", "ru": "����� 777-300"}',12000)
update v_aircrafts_test set range = '13000' where aircraft_code = '774'
delete from v_aircrafts_test  where aircraft_code = '774'
alter table v_aircrafts_test add test_col char(100) default 'test'
alter view v_aircrafts_test add test_col char(100) default 'test'
drop view v_aircrafts_test2;

create view v_aircrafts_test2 as 
select * from aircrafts_data ad  where range < 7000 
with check option
insert into v_aircrafts_test2 (aircraft_code,model,range) VALUES ('S35','{"en": "Sukhoi Superjet-500", "ru": "����� ���������-100"}',11780)

create or replace view v_aircrafts_test2 as 
select * from aircrafts_data ad  where range < 7000 
delete from aircrafts_data where aircraft_code = 'S35'

create or replace view v_aircrafts_test2 as 
select ad.*,'test' as "t" from aircrafts_data ad  where range < 7000 with check option
select * from v_aircrafts_test2
insert into v_aircrafts_test2 (aircraft_code,model,range) VALUES ('S35','{"en": "Sukhoi Superjet-500", "ru": "����� ���������-100"}',6780)


create view v_aircrafts_test2 as 
select * from aircrafts_data ad  where range < 7000 
with check option
insert into v_aircrafts_test2 (aircraft_code,model,range) VALUES ('S35','{"en": "Sukhoi Superjet-500", "ru": "����� ���������-100"}',11780)


create view v_aircrafts_test_ord_aircode as 
select aircraft_code from aircrafts_data ad order by aircraft_code 
select * from v_aircrafts_test_ord_aircode
insert into v_aircrafts_test_ord_aircode (aircraft_code) values (123)


