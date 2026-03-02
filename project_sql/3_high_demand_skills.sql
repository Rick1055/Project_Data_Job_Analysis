/*
Question: What are the most in-demand skills for data analysts
- Join job postings to inner join table similar to the previous query 
- Identify the top 5 in-demand skills for a data analyst.
- Focus on all job postings.
- Why? Retrieves the top 5 skills with the highest demand in the job market,
    providing insights into the most valuable skills for job seekers.
*/

WITH job_select AS (
    SELECT 
        job_skills.skill_id,
        COUNT(job_postings.job_id) AS job_count
    FROM
        job_postings_fact AS job_postings
    INNER JOIN skills_job_dim AS job_skills ON job_skills.job_id = job_postings.job_id
    WHERE
        job_title_short = 'Data Analyst' -- change as per your requirements
    GROUP BY
        job_skills.skill_id
)

SELECT
    job_select.skill_id,
    skills.skills AS skill_name,  
    job_select.job_count
FROM
    skills_dim AS skills
RIGHT JOIN job_select ON skills.skill_id = job_select.skill_id
ORDER BY
    job_count DESC
LIMIT 5;
 
