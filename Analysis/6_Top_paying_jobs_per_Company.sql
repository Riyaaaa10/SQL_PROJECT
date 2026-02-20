/*
Highest paying Data Analyst jobs per company
*/

WITH ranked_jobs AS (
    SELECT
        jp.job_id,
        jp.job_title,
        jp.job_location,
        jp.job_schedule_type,
        jp.salary_year_avg,
        jp.job_posted_date,
        cd.name AS company_name,
        
ROW_NUMBER() OVER (
            ORDER BY jp.salary_year_avg DESC
        ) AS salary_rank

FROM job_postings_fact jp
LEFT JOIN company_dim cd 
        ON jp.company_id = cd.company_id

WHERE 
        jp.job_title_short like '%Data%Analyst%'
        AND jp.job_location = 'Anywhere'
        AND jp.salary_year_avg IS NOT NULL
)

SELECT *
FROM ranked_jobs
WHERE salary_rank <= 10;