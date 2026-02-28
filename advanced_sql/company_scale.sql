WITH job_openings AS(
    SELECT 
        company_id,
        COUNT(job_id) AS num_of_jobs
    FROM
        job_postings_fact AS job_postings
    GROUP BY
        company_id
)
SELECT
    name AS company_name,
    job_openings.num_of_jobs AS job_count,
    CASE
        WHEN job_openings.num_of_jobs < 10 THEN 'Small Company'
        WHEN job_openings.num_of_jobs >= 10 THEN 'Medium Company'
        WHEN job_openings.num_of_jobs <= 50 THEN 'Medium Company'
        ELSE 'Large Company'
    END AS company_scale
FROM
    company_dim AS company
LEFT JOIN job_openings ON job_openings.company_id = company.company_id
