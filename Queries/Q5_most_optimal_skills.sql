-- What are the most optimal skills? (TOP 25)
--  Optimal: High demand and high paying
WITH JOB_TO_SKILL AS
	(SELECT SKILLS_JOB_DIM.SKILL_ID,
			SKILLS,
			JOB_ID
		FROM SKILLS_JOB_DIM
		INNER JOIN SKILLS_DIM ON SKILLS_JOB_DIM.SKILL_ID = SKILLS_DIM.SKILL_ID
  )
  
SELECT
	SKILLS,
	ROUND(AVG(salary_year_avg), 0) AS average_salary,
    COUNT(JOB_POSTINGS_FACT.job_id) AS demand
FROM JOB_TO_SKILL
INNER JOIN JOB_POSTINGS_FACT ON JOB_TO_SKILL.JOB_ID = JOB_POSTINGS_FACT.JOB_ID
WHERE salary_year_avg IS NOT NULL
--    AND JOB_TITLE_SHORT = 'Data Analyst' AND job_work_from_home = TRUE 
GROUP BY
	SKILL_ID, SKILLS
ORDER BY
	demand DESC, average_salary 
LIMIT 25

-- Results: 

/*
[
  {
    "skills": "sql",
    "average_salary": "124935",
    "demand": "12974"
  },
  {
    "skills": "python",
    "average_salary": "132440",
    "demand": "12883"
  },
  {
    "skills": "r",
    "average_salary": "127115",
    "demand": "5088"
  },
  {
    "skills": "aws",
    "average_salary": "136481",
    "demand": "4952"
  },
  {
    "skills": "tableau",
    "average_salary": "116796",
    "demand": "4830"
  },
  {
    "skills": "spark",
    "average_salary": "141734",
    "demand": "4025"
  },
  {
    "skills": "excel",
    "average_salary": "99751",
    "demand": "3835"
  },
  {
    "skills": "azure",
    "average_salary": "130433",
    "demand": "3480"
  },
  {
    "skills": "java",
    "average_salary": "136210",
    "demand": "2760"
  },
  {
    "skills": "power bi",
    "average_salary": "106738",
    "demand": "2589"
  },
  {
    "skills": "snowflake",
    "average_salary": "137960",
    "demand": "2458"
  },
  {
    "skills": "hadoop",
    "average_salary": "138574",
    "demand": "2272"
  },
  {
    "skills": "scala",
    "average_salary": "145120",
    "demand": "1912"
  },
  {
    "skills": "nosql",
    "average_salary": "137039",
    "demand": "1686"
  },
  {
    "skills": "kafka",
    "average_salary": "144754",
    "demand": "1642"
  },
  {
    "skills": "sas",
    "average_salary": "112788",
    "demand": "1563"
  },
  {
    "skills": "sas",
    "average_salary": "112788",
    "demand": "1563"
  },
  {
    "skills": "databricks",
    "average_salary": "131525",
    "demand": "1521"
  },
  {
    "skills": "redshift",
    "average_salary": "140792",
    "demand": "1520"
  },
  {
    "skills": "airflow",
    "average_salary": "142386",
    "demand": "1506"
  },
  {
    "skills": "go",
    "average_salary": "131689",
    "demand": "1394"
  },
  {
    "skills": "git",
    "average_salary": "128316",
    "demand": "1358"
  },
  {
    "skills": "oracle",
    "average_salary": "115125",
    "demand": "1357"
  },
  {
    "skills": "sql server",
    "average_salary": "112487",
    "demand": "1321"
  },
  {
    "skills": "gcp",
    "average_salary": "131738",
    "demand": "1252"
  }
]
*/