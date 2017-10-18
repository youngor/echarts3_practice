SELECT car_age_segment as '车龄',  sum(quantity) as '数量'
 FROM ding_xiang_v2 
where year = 2017 
and (`quarter` like '%2%' or `quarter` like '%二%')
and initial_city = target_city
and series like '%凯越%'  
GROUP BY car_age_segment
order by cast(car_age_segment as unsigned)