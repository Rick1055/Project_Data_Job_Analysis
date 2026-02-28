SELECT
    company_id,
    name AS company_name
FROM    
    company_dim AS company
WHERE company_id IN(
    SELECT
        company_id
    FROM
        job_postings_fact AS job_postings
    WHERE
        job_no_degree_mention = true
)
ORDER BY
        company_id
