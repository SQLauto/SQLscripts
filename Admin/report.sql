-- to find the users ID from the database.
select * from wslogdb70 ..users
where user_login_name like '%fer%'

-- find the total logging of that particular user
select b.name, b.category_name ,a.record_number,a.Date_time,a.full_url,a.Category 
from dbo.log_details a with(nolock) left join wslogdb70.dbo.v_risk_class b on a.category = b.category_id
where user_id = '3080' 
 order by 4 desc



-- find the hits  on the records 
select * from dbo.summary with(nolock)
where User_id = '3080'
order by  2 desc


select * from wslogdb70..wc_security_url with (nolock)