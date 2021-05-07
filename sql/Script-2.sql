connect to demo
select * from aircrafts a 
select count(1) from aircrafts a2 

select * from aircrafts a, aircrafts_data ad where a.aircraft_code = ad.aircraft_code
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

