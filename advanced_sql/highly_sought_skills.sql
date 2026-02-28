WITH skill_count AS(
    SELECT
        skill_id,
        COUNT(job_id) AS skill_frequency
    FROM 
        skills_job_dim AS skill_req
    GROUP BY
        skill_id)
SELECT
   skills_dim.skills,
   skill_count.skill_frequency
FROM
    skills_dim 
LEFT JOIN skill_count ON skill_count.skill_id = skills_dim.skill_id 
ORDER BY
    skill_count.skill_frequency DESC
LIMIT 5;