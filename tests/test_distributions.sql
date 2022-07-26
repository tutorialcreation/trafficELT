with test_distributions as(
    with speed_distribution as (
        select speed,count(*) from endpoints_trafficinfo group by speed
    ),
    
)

select * from test_distributions