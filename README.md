# Parks-and-Recreation-End-to-End-SQL-Data-Analysis-Database-Engineering
This repository contains a structured SQL script that performs an extensive analysis of a "Parks and Recreation" organizational database. The project progresses from foundational data retrieval to complex database automation, demonstrating a mastery of MySQL for business intelligence and data engineering.
Technical Features & SQL Concepts

Advanced Data Analysis
Window Functions: Implemented PARTITION BY and ORDER BY within windows to create Rolling Totals and identify performance tiers using ROW_NUMBER(), RANK(), and DENSE_RANK().

Subqueries & CTEs: Utilized Common Table Expressions (CTEs) and nested subqueries to perform multi-level aggregations and improve code readability.

Complex Joins: Performed Inner, Left, Right, and Self-Joins to connect demographics, salary data, and departmental hierarchies.

Database Engineering & Automation
Stored Procedures: Developed parameterized procedures to automate repetitive tasks, such as filtering high-salary employees.

Triggers: Engineered an AFTER INSERT trigger to maintain data integrity across tables, automatically syncing employee demographics when new salary records are created.

Events: Scheduled automated database maintenance using EVENTS to manage record retention (e.g., auto-deleting retired employee records)

Data Transformation & Logic
Case Statements: Built custom logic for age-bracketing and automated calculation of tiered salary increases and performance bonuses.

String Manipulation: Cleaned and formatted raw text data using SUBSTRING, REPLACE, CONCAT, and TRIM.

Temporary Tables: Leveraged TEMPORARY TABLE for intermediate data processing and improving query performance on large datasets.

Business Insights Generated
Calculated average salaries by department and occupation to identify budget outliers.

Mapped employee demographics against job satisfaction and pay scales.

Built a "rolling total" of company expenditure on salaries per gender/department.
