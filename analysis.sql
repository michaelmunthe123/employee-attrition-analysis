-- overall
SELECT COUNT(*) AS n,
 SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END) AS exits,
 100.0*SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END)/COUNT(*) AS rate_pct
 FROM employees;

-- department
SELECT Department, COUNT(*) AS n,
 SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END) AS exits,
 100.0*SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END)/COUNT(*) AS rate_pct
 FROM employees GROUP BY Department ORDER BY rate_pct DESC;

-- overtime_by_department
SELECT Department, OverTime, COUNT(*) AS n,
 SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END) AS exits,
 100.0*SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END)/COUNT(*) AS rate_pct
 FROM employees GROUP BY Department,OverTime ORDER BY Department,OverTime;

-- tenure
WITH bands AS (
 SELECT *, CASE WHEN YearsAtCompany<=2 THEN '0–2'
 WHEN YearsAtCompany<=5 THEN '3–5' WHEN YearsAtCompany<=10 THEN '6–10'
 ELSE '11+' END AS TenureBand FROM employees)
 SELECT TenureBand,COUNT(*) AS n,
 SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END) AS exits,
 100.0*SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END)/COUNT(*) AS rate_pct
 FROM bands GROUP BY TenureBand ORDER BY rate_pct DESC;