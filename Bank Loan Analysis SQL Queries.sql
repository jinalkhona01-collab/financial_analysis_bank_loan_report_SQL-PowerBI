SELECT* FROM bank_loan_data

--KPI’s:
--1.Total Loan Applications
SELECT COUNT(id) AS total_loan_applications FROM bank_loan_data;

--2.MTD Loan Applications
SELECT COUNT(id) AS mtd_total_loan_applications FROM bank_loan_data
WHERE EXTRACT(MONTH FROM issue_date) = 12 AND EXTRACT(YEAR FROM issue_date) = 2021;

--3.PMTD Loan Applications
SELECT COUNT(id) AS pmtd_total_loan_applications FROM bank_loan_data
WHERE EXTRACT(MONTH FROM issue_date) = 11 AND EXTRACT(YEAR FROM issue_date) = 2021;

--4Month-over-Month (MoM) loan applications (i.e., the percentage change from one month to the next)
WITH
mtd AS (
    SELECT COUNT(id) AS total
    FROM bank_loan_data
    WHERE EXTRACT(MONTH FROM issue_date) = 12
      AND EXTRACT(YEAR FROM issue_date) = 2021
),
pmtd AS (
    SELECT COUNT(id) AS total
    FROM bank_loan_data
    WHERE EXTRACT(MONTH FROM issue_date) = 11
      AND EXTRACT(YEAR FROM issue_date) = 2021
)
SELECT
    mtd.total AS MTD_total_loan_applications,
    pmtd.total AS PMTD_total_loan_applications,
    ROUND(
      CASE 
        WHEN pmtd.total = 0 THEN NULL -- or 0, or your logic for no previous month
        ELSE ((mtd.total::numeric - pmtd.total::numeric) / pmtd.total::numeric) * 100
      END, 2
    ) AS MoM_Percentage_Change
FROM mtd, pmtd;

--5.Total Funded Amount
SELECT SUM(loan_amount) AS Total_Funded_Amount FROM bank_loan_data

--6.Month-over-Month (MoM) funded amount (i.e., the percentage change from one month to the next)
WITH
mtd AS (
    SELECT SUM(loan_amount) AS total
    FROM bank_loan_data
    WHERE EXTRACT(MONTH FROM issue_date) = 12
      AND EXTRACT(YEAR FROM issue_date) = 2021
),
pmtd AS (
    SELECT SUM(loan_amount) AS total
    FROM bank_loan_data
    WHERE EXTRACT(MONTH FROM issue_date) = 11
      AND EXTRACT(YEAR FROM issue_date) = 2021
)

SELECT
    mtd.total AS MTD_total_funded_amount,
    pmtd.total AS PMTD_total_funded_amount,
    ROUND(
      CASE 
        WHEN pmtd.total = 0 THEN NULL -- or 0, or your logic for no previous month
        ELSE ((mtd.total::numeric - pmtd.total::numeric) / pmtd.total::numeric) * 100
      END, 2
    ) AS MoM_Percentage_Change
FROM mtd, pmtd;

--7.Total Amount Received
SELECT SUM(total_payment) AS Total_Amount_Collected FROM bank_loan_data

--8.Month-over-Month (MoM) amount received (i.e., the percentage change from one month to the next)
WITH
mtd AS (
    SELECT SUM(total_payment) AS total
    FROM bank_loan_data
    WHERE EXTRACT(MONTH FROM issue_date) = 12
      AND EXTRACT(YEAR FROM issue_date) = 2021
),
pmtd AS (
    SELECT SUM(total_payment) AS total
    FROM bank_loan_data
    WHERE EXTRACT(MONTH FROM issue_date) = 11
      AND EXTRACT(YEAR FROM issue_date) = 2021
)

SELECT
    mtd.total AS MTD_Total_Amount_Collected,
    pmtd.total AS PMTD_Total_Amount_Collected,
    ROUND(
      CASE 
        WHEN pmtd.total = 0 THEN NULL -- or 0, or your logic for no previous month
        ELSE ((mtd.total::numeric - pmtd.total::numeric) / pmtd.total::numeric) * 100
      END, 2
    ) AS MoM_Percentage_Change
FROM mtd, pmtd;

--9.Average Interest Rate
SELECT AVG(int_rate)*100 AS Avg_Interest_Rate FROM bank_loan_data;

--10.MoM (%) Change in Average Interest Rate
WITH
mtd AS (
    SELECT AVG(int_rate) AS Average
    FROM bank_loan_data
    WHERE EXTRACT(MONTH FROM issue_date) = 12
      AND EXTRACT(YEAR FROM issue_date) = 2021
),
pmtd AS (
    SELECT AVG(int_rate) AS Average
    FROM bank_loan_data
    WHERE EXTRACT(MONTH FROM issue_date) = 11
      AND EXTRACT(YEAR FROM issue_date) = 2021
)

SELECT
    mtd.Average AS MTD_Avg_Int_Rate,
    pmtd.Average AS PMTD_Avg_Int_Rate,
    ROUND(
      CASE 
        WHEN pmtd.Average = 0 THEN NULL -- or 0, or your logic for no previous month
        ELSE ((mtd.Average::numeric - pmtd.Average::numeric) / pmtd.Average::numeric) * 100
      END, 2
    ) AS MoM_Percentage_Change
FROM mtd, pmtd;

--11.Avg DTI
SELECT AVG(dti)*100 AS Avg_DTI FROM bank_loan_data

--12.MoM (%) Change in Average DTI
WITH
mtd AS (
    SELECT AVG(dti) AS AvgDTI
    FROM bank_loan_data
    WHERE EXTRACT(MONTH FROM issue_date) = 12
      AND EXTRACT(YEAR FROM issue_date) = 2021
),
pmtd AS (
    SELECT AVG(dti) AS AvgDTI
    FROM bank_loan_data
    WHERE EXTRACT(MONTH FROM issue_date) = 11
      AND EXTRACT(YEAR FROM issue_date) = 2021
)

SELECT
    mtd.AvgDTI AS MTD_Avg_DTI,
    pmtd.AvgDTI AS PMTD_Avg_DTI,
    ROUND(
      CASE 
        WHEN pmtd.AvgDTI = 0 THEN NULL -- or 0, or your logic for no previous month
        ELSE ((mtd.AvgDTI::numeric - pmtd.AvgDTI::numeric) / pmtd.AvgDTI::numeric) * 100
      END, 2
    ) AS MoM_Percentage_Change
FROM mtd, pmtd;

--GOOD LOAN ISSUED
--1.Good Loan Percentage
SELECT (COUNT(CASE WHEN loan_status IN ('Fully Paid', 'Current') THEN id END)*100.0)/COUNT(id) AS Good_Loan_Percentage FROM bank_loan_data;

--2.Good Loan Applications
SELECT COUNT(id) AS Good_Loan_Applications FROM bank_loan_data
WHERE loan_status = 'Fully Paid' OR loan_status = 'Current'

--3.Good Loan Funded Amount
SELECT SUM(loan_amount) AS Good_Loan_Funded_amount FROM bank_loan_data
WHERE loan_status = 'Fully Paid' OR loan_status = 'Current'

--4.Good Loan Amount Received
SELECT SUM(total_payment) AS Good_Loan_amount_received FROM bank_loan_data
WHERE loan_status = 'Fully Paid' OR loan_status = 'Current'

--BAD LOAN ISSUED
--1.Bad Loan Percentage
SELECT
    (COUNT(CASE WHEN loan_status = 'Charged Off' THEN id END) * 100.0) / 
	COUNT(id) AS Bad_Loan_Percentage
FROM bank_loan_data

--2.Bad Loan Applications
SELECT COUNT(id) AS Bad_Loan_Applications FROM bank_loan_data
WHERE loan_status = 'Charged Off'

--3.Bad Loan Funded Amount
SELECT SUM(loan_amount) AS Bad_Loan_Funded_amount FROM bank_loan_data
WHERE loan_status = 'Charged Off'

--4.Bad Loan Amount Received
SELECT SUM(total_payment) AS Bad_Loan_amount_received FROM bank_loan_data
WHERE loan_status = 'Charged Off'

--1.LOAN STATUS
	SELECT
        loan_status,
        COUNT(id) AS Total_Loan_Applications,
        SUM(total_payment) AS Total_Amount_Received,
        SUM(loan_amount) AS Total_Funded_Amount,
        AVG(int_rate * 100) AS Interest_Rate,
        AVG(dti * 100) AS DTI
    FROM
        bank_loan_data
    GROUP BY
        loan_status
--2.
SELECT 
	loan_status, 
	SUM(total_payment) AS MTD_Total_Amount_Received, 
	SUM(loan_amount) AS MTD_Total_Funded_Amount 
FROM bank_loan_data
WHERE EXTRACT(MONTH FROM issue_date) = 12 AND EXTRACT(YEAR FROM issue_date) = 2021          GROUP BY loan_status

--BANK LOAN REPORT | OVERVIEW
--1. Monthly Trends by Issue Date
SELECT 
	EXTRACT(MONTH FROM issue_date) AS Month_Number, 
	TO_CHAR(issue_date, ‘Month’) AS Month_name, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Received_Amount
FROM bank_loan_data
GROUP BY EXTRACT(MONTH FROM issue_date), TO_CHAR(issue_date, ‘Month’)
ORDER BY EXTRACT(MONTH FROM issue_date)

--2. Regional Analysis by State 
SELECT 
	address_state AS State, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM bank_loan_data
GROUP BY address_state
ORDER BY address_state

--3. Loan Term Analysis 
SELECT 
	term, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM bank_loan_data
GROUP BY term
ORDER BY term

--4. Employee Length Analysis
SELECT 
	emp_length AS Employee_Length, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM bank_loan_data
GROUP BY emp_length
ORDER BY emp_length

--5. Loan Purpose Breakdown 
SELECT 
	purpose AS PURPOSE, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM bank_loan_data
GROUP BY purpose
ORDER BY purpose

--6. Home Ownership Analysis 
SELECT 
	home_ownership AS Home_Ownership, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM bank_loan_data
GROUP BY home_ownership
ORDER BY home_ownership

--END