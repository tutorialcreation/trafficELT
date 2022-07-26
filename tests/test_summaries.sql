with distance_summaries as(
    select type,max(traveled_d) from endpoints_trafficinfo group by type
),
speed_summaries as(
    select type,max(speed) from endpoints_trafficinfo group by type
)

select * from distance_summaries