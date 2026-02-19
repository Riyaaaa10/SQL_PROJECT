/*
 Top 5 In demand skills for job Data Analyst with remote opportunities 
*/


SELECT
    skills,
    COUNT(job_postings_fact.job_id) AS total_demand
FROM 
    job_postings_fact
INNER JOIN 
    skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN 
    skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE 
    job_title_short like '%Data%Analyst%' AND job_work_from_home = TRUE
GROUP BY 
    skills
ORDER BY 
    total_demand DESC
LIMIT 5