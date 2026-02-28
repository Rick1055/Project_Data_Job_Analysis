WITH remote_job_skill AS(
    SELECT
        skill_id,
        COUNT(*) AS skill_count
    FROM
        skills_job_dim AS job_skill
    INNER JOIN job_postings_fact AS job_postings ON job_postings.job_id = job_skill.skill_id
    WHERE
        job_postings.job_work_from_home = True 
        AND job_title_short = 'Data Analyst'
    GROUP BY
        skill_id
)

SELECT
    skills.skill_id,
    skills.skills AS skill_name,
    remote_job_skill.skill_count
FROM
    remote_job_skill
INNER JOIN skills_dim AS skills ON skills.skill_id = remote_job_skill.skill_id
ORDER BY
    skill_count DESC
LIMIT 5;