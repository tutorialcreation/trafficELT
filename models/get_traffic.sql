select * from endpoints_trafficinfo
/* we see that all column names are of type double precision(float) apart from track_id,id and text*/
select column_name, data_type from   information_schema.columns where  table_name = 'endpoints_trafficinfo' order  by ordinal_position
/* we see that we have 704 records with positive time, and that the
motorcycle is the one with the greatest average speed in the traffic*/
select * from endpoints_trafficinfo where " time" > 0 order by " avg_speed" desc
/* we see that the vehicle that traveled that traveled the longest distance in traffic
is the car*/
select * from endpoints_trafficinfo where " time" > 0 order by " traveled_d" desc

select * from endpoints_trafficinfo where " type" like 'a%'
select * from endpoints_trafficinfo where " type" like '%i'
/* we notice that we have 349 records with character 'ar' that is cars,*/
select * from endpoints_trafficinfo where " type" like '%ar%'

select * from endpoints_trafficinfo where " type" like 'C%';

select * from endpoints_trafficinfo where upper(" type") like 'C%'
select * from endpoints_trafficinfo where " type" ilike 'C%'

/* added code to check whether there is any type that has empty string and
we found none, all type entries contain data*/
select " type",coalesce(" type",'no type') from endpoints_trafficinfo order by 1
/* added new type column with prefilled data */
select coalesce(" type",'No description') as type from endpoints_trafficinfo order by 1;
select coalesce(description,'No description') as Description from endpoints_trafficinfo order by 1;
select coalesce(description,'No description') as "Description" from endpoints_trafficinfo order by 1;
select distinct coalesce(description,'No description') as description from endpoints_trafficinfo order by 1;
select * from endpoints_trafficinfo order by pk limit 1;
select * from endpoints_trafficinfo order by pk limit 2;
select * from endpoints_trafficinfo order by pk offset 1 limit 1;
create table new_endpoints_trafficinfo as select * from endpoints_trafficinfo limit 0;
select * from endpoints_trafficinfo where pk=10 or pk=11;
select * from endpoints_trafficinfo where pk in (10,11);
select * from endpoints_trafficinfo where not (pk=10 or pk=11);
select * from endpoints_trafficinfo where pk not in (10,11);
select pk,title,content,author,category from posts;
select pk,title,content,author,category from posts where category in (select pk from categories where title ='orange');
select pk,title,content,author,category from posts where category not in (select pk from categories where title ='orange');
select pk,title,content,author,category from posts where exists (select 1 from categories where title ='orange' and posts.category=pk);
select pk,title,content,author,category from posts where not exists (select 1 from categories where title ='orange' and posts.category=pk);
select c.pk,c.title,p.pk,p.category,p.title from categories c,posts p;
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
