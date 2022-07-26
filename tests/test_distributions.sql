with test_distributions as(
    with speed_distribution as (
        select speed,count(*) from endpoints_trafficinfo group by speed
    ),
    time_distribution as(
        select time,count(*) from endpoints_trafficinfo group by time
    )
    
)

select * from test_distributions