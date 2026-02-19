/* 
What skills are required for the Top paying Data Analyst Jobs?
*/

WITH top_paying_skill AS (
    SELECT
        job_id,
        job_title_short as job_title,
        salary_year_avg,
        cd.name as company_name
    from job_postings_fact as jp
    LEFT JOIN company_dim AS cd ON jp.company_id = cd.company_id
    where 
        job_title_short LIKE '%Data%Analyst%' AND
        job_location = 'Anywhere' AND
        salary_year_avg IS NOT NULL
    ORDER BY 
        salary_year_avg DESC
    LIMIT 10
)
SELECT
    top_paying_skill.*, skills
from top_paying_skill 
INNER JOIN skills_job_dim ON top_paying_skill.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY salary_year_avg DESC