-- What are the top skills based on salary? (TOP 25)
WITH JOB_TO_SKILL AS
	(SELECT SKILLS_JOB_DIM.SKILL_ID,
			SKILLS,
			JOB_ID
		FROM SKILLS_JOB_DIM
		INNER JOIN SKILLS_DIM ON SKILLS_JOB_DIM.SKILL_ID = SKILLS_DIM.SKILL_ID
  )
  
SELECT
	SKILLS,
	ROUND(AVG(salary_year_avg), 0) AS average_salary
FROM JOB_TO_SKILL
INNER JOIN JOB_POSTINGS_FACT ON JOB_TO_SKILL.JOB_ID = JOB_POSTINGS_FACT.JOB_ID
WHERE salary_year_avg IS NOT NULL
--    AND JOB_TITLE_SHORT = 'Data Analyst' AND job_work_from_home = TRUE 
GROUP BY
	SKILL_ID, SKILLS
ORDER BY
	average_salary DESC
LIMIT 25

-- Results: 

/*
[
  {
    "skills": "debian",
    "average_salary": "196500"
  },
  {
    "skills": "ringcentral",
    "average_salary": "182500"
  },
  {
    "skills": "mongo",
    "average_salary": "170715"
  },
  {
    "skills": "lua",
    "average_salary": "170500"
  },
  {
    "skills": "dplyr",
    "average_salary": "160667"
  },
  {
    "skills": "haskell",
    "average_salary": "155758"
  },
  {
    "skills": "asp.net core",
    "average_salary": "155000"
  },
  {
    "skills": "node",
    "average_salary": "154408"
  },
  {
    "skills": "cassandra",
    "average_salary": "154124"
  },
  {
    "skills": "solidity",
    "average_salary": "153640"
  },
  {
    "skills": "watson",
    "average_salary": "152844"
  },
  {
    "skills": "codecommit",
    "average_salary": "152289"
  },
  {
    "skills": "rshiny",
    "average_salary": "151611"
  },
  {
    "skills": "hugging face",
    "average_salary": "148648"
  },
  {
    "skills": "neo4j",
    "average_salary": "147708"
  },
  {
    "skills": "gatsby",
    "average_salary": "147500"
  },
  {
    "skills": "scala",
    "average_salary": "145120"
  },
  {
    "skills": "mlr",
    "average_salary": "145000"
  },
  {
    "skills": "kafka",
    "average_salary": "144754"
  },
  {
    "skills": "pytorch",
    "average_salary": "144470"
  },
  {
    "skills": "couchdb",
    "average_salary": "144167"
  },
  {
    "skills": "mxnet",
    "average_salary": "143695"
  },
  {
    "skills": "theano",
    "average_salary": "143404"
  },
  {
    "skills": "shell",
    "average_salary": "143370"
  },
  {
    "skills": "golang",
    "average_salary": "143139"
  }
]
*/