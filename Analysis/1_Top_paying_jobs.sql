/*
What are the Top paying Data Analyst Jobs?
*/

SELECT
    job_id,
    job_title_short as job_title,
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date,
    cd.name as company_name
from job_postings_fact as jp
LEFT JOIN company_dim AS cd ON jp.company_id = cd.company_id
where 
    job_title_short LIKE '%Data%Analyst%' AND
    job_location = 'Anywhere' AND
    salary_year_avg IS NOT NULL
    ORDER BY salary_year_avg DESC
    LIMIT 10;
