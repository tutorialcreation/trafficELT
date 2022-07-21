select * from endpoints_trafficinfo
/* we see that all column names are of type double precision(float) apart from track_id,id and text*/
select column_name, data_type from   information_schema.columns where  table_name = 'endpoints_trafficinfo' order  by ordinal_position
/* we see that we have 704 records with positive time, and that the
motorcycle is the one with the greatest average speed in the traffic*/
select * from endpoints_trafficinfo where time > 0 order by avg_speed desc
/* we see that the vehicle that traveled that traveled the longest distance in traffic
is the car*/
select * from endpoints_trafficinfo where time> 0 order by traveled_ddesc

select * from endpoints_trafficinfo where typelike 'a%'
select * from endpoints_trafficinfo where typelike '%i'
/* we notice that we have 349 records with character 'ar' that is cars,*/
select * from endpoints_trafficinfo where typelike '%ar%'

select * from endpoints_trafficinfo where typelike 'C%';

select * from endpoints_trafficinfo where upper(type) like 'C%'
select * from endpoints_trafficinfo where typeilike 'C%'

/* added code to check whether there is any type that has empty string and
we found none, all type entries contain data*/
select type,coalesce(type,'no type') from endpoints_trafficinfo order by 1
/* added new type column with prefilled data */
select coalesce(type,'No type') as type from endpoints_trafficinfo order by 1;
select coalesce(type,'No type') as Type from endpoints_trafficinfo order by 1;
select coalesce(type,'No type') as "Type" from endpoints_trafficinfo order by 1;

/* checking distinctness of the data */
-- not distinct - 6
select distinct coalesce(type,'No type') as type from endpoints_trafficinfo order by 1;
-- not distinct - 742
select distinct coalesce(traveled_d,0) as travel_distance from endpoints_trafficinfo order by 1;
-- distinct - 761
select distinct coalesce(avg_speed,0) as average_speed from endpoints_trafficinfo order by 1;
-- not distinct - 265
select distinct coalesce(lat,0) as latitude from endpoints_trafficinfo order by 1;
-- not distinct - 339
select distinct coalesce(lon,0) as longitude from endpoints_trafficinfo order by 1;
-- not distinct - 736
select distinct coalesce(speed,0) as speed from endpoints_trafficinfo order by 1;
-- not distinct - 637
select distinct coalesce(lon_acc,0) as long_acc from endpoints_trafficinfo order by 1;
-- not distinct - 640
select distinct coalesce(lat_acc,0) as lat_acc from endpoints_trafficinfo order by 1;
-- not distinct - 610
select distinct coalesce(time,0) as time from endpoints_trafficinfo order by 1;


/* limits and offsets */
select * from endpoints_trafficinfo order by id limit 1;
select * from endpoints_trafficinfo order by id limit 2;
select * from endpoints_trafficinfo order by id offset 10 limit 10;

-- creating copy tables
create table new_endpoints_trafficinfo as select * from endpoints_trafficinfo limit 0;

-- in and not in types
select * from endpoints_trafficinfo where id=10 or id=11;
select * from endpoints_trafficinfo where id in (10,11);
select * from endpoints_trafficinfo where not (id=10 or id=11);
select * from endpoints_trafficinfo where id not in (10,11);

/*
Add another table for outsourcing the location
*/
select id,traveled_d,avg_speed,speed,lat,lon,location_id from endpoints_trafficinfo;
-- check for places where traffic was in hellas
select id,traveled_d,avg_speed,speed,lat,lon,location_id from endpoints_trafficinfo where location_id in (select id from endpoints_location where place ='Hellas');
-- check for places where traffic was not in hellas - None
select id,traveled_d,avg_speed,speed,lat,lon,location_id from endpoints_trafficinfo where location_id not in (select id from endpoints_location where place ='Hellas');
-- check if subqueries exists
select id,traveled_d,avg_speed,speed,lat,lon,location_id from endpoints_trafficinfo where exists (select 1 from endpoints_location where place ='Hellas' and location_id=id);
-- check if subqueries do not exist
select id,traveled_d,avg_speed,speed,lat,lon,location_id from endpoints_trafficinfo where not exists (select 1 from endpoints_location where place ='Hellas' and location_id=id);


/*
JOINS
*/

select c.id,c.landmarks,p.id,p.location_id,p.type from endpoints_location c,endpoints_trafficinfo p;
select c.pk,c.title,p.pk,p.category,p.title from categories c CROSS JOIN posts p;
select c.pk,c.title,p.pk,p.category,p.title from categories c,posts p where c.pk=p.category;
select c.pk,c.title,p.pk,p.category,p.title from categories c inner join posts p on c.pk=p.category;
select distinct p.pk,p.title,p.content,p.author,p.category from categories c inner join posts p on c.pk=p.category where c.title='orange';
select c.*,p.category,p.title from categories c left join posts p on c.pk=p.category;
select c.*,p.category from categories c left join posts p on p.category=c.pk;
select c.* from categories c left join posts p on p.category=c.pk where p.category is null;
select c.*,p.category,p.title from posts p right join categories c on c.pk=p.category;
select jpt.*,t.*,p.title from j_posts_tags jpt inner join tags t on jpt.tag_pk=t.pk inner join posts p on jpt.post_pk = p.pk;
select jpt.*,t.*,p.title from j_posts_tags jpt full outer join tags t on jpt.tag_pk=t.pk full outer join posts p on jpt.post_pk = p.pk;
select jpt.*,t.*,p.title from j_posts_tags jpt cross join tags t cross join posts p ;
select distinct p1.title,p1.author,p1.category from posts p1 where p1.author=1;
select distinct p2.title,p2.author,p2.category from posts p2 where p2.author=2;
select distinct p2.title,p2.author,p2.category from posts p1,posts p2 where p1.category=p2.category and p1.author<>p2.author and p1.author=1 and p2.author=2;
select distinct p2.title,p2.author,p2.category from posts p1 inner join posts p2 on ( p1.category=p2.category and p1.author<>p2.author) where p1.author=1 and p2.author=2;
select category,count(*) from posts group by category;
select category,count(*) from posts group by 1;
select category,count(*) from posts group by category having count(*) > 2;
select category,count(*) from posts group by 1 having count(*) > 2;
select category,count(*) as category_count from posts group by category;
select category,count(*) as category_count from posts group by category having category_count > 2;
select title from categories union select tag from tags order by title;
select title from categories union all select tag from tags order by title;
select title from categories except select tag from tags order by 1;
select title from categories intersect select tag from tags order by 1;
