SELECT * FROM bank_loan_data;

--KPI calculations--
--DASHBOARD 1 --
--1. Total Loan Application--
SELECT COUNT(id) AS total_loan_applications FROM bank_loan_data;

    -- MTD Loan Applications--
SELECT COUNT(id) AS MTD_total_loan_applications
FROM bank_loan_data
WHERE EXTRACT(MONTH FROM issue_date) = 12 
AND
EXTRACT(YEAR FROM issue_date )=2021;

  -- PMTD Loan Applications--
SELECT COUNT(id) AS PMTD_total_loan_applications
FROM bank_loan_data
WHERE EXTRACT(MONTH FROM issue_date ) = 11 
AND
EXTRACT(YEAR FROM issue_date )=2021;




--2.Total Funded amount--
SELECT SUM(loan_amount) AS total_funded_amount FROM bank_loan_data;

SELECT SUM(loan_amount) AS MTD_total_funded_amount
FROM bank_loan_data
WHERE EXTRACT(MONTH FROM TO_DATE(issue_date , 'DD-MM-YYYY')) = 12 
AND
EXTRACT(YEAR FROM TO_DATE(issue_date , 'DD-MM-YYYY'))=2021;

SELECT SUM(loan_amount) AS PMTD_total_funded_amount
FROM bank_loan_data
WHERE EXTRACT(MONTH FROM TO_DATE(issue_date , 'DD-MM-YYYY')) = 11 
AND
EXTRACT(YEAR FROM TO_DATE(issue_date , 'DD-MM-YYYY'))=2021;


--3.Total amount recieved--

SELECT SUM(total_payment) AS total_amount_recieved FROM bank_loan_data;

SELECT SUM(total_payment) AS total_amount_recieved 
FROM bank_loan_data
WHERE EXTRACT(MONTH FROM TO_DATE(issue_date , 'DD-MM-YYYY')) = 12 
AND
EXTRACT(YEAR FROM TO_DATE(issue_date , 'DD-MM-YYYY'))=2021;

SELECT SUM(total_payment) AS total_amount_recieved 
FROM bank_loan_data
WHERE EXTRACT(MONTH FROM TO_DATE(issue_date , 'DD-MM-YYYY')) = 11 
AND
EXTRACT(YEAR FROM TO_DATE(issue_date , 'DD-MM-YYYY'))=2021;



--4.Average interest rate

SELECT ROUND(AVG(int_rate)*100,2) AS avg_interest_rate FROM bank_loan_data;

SELECT ROUND(AVG(int_rate)*100,2) AS MTD_avg_interest_rate 
FROM bank_loan_data
WHERE EXTRACT(MONTH FROM TO_DATE(issue_date , 'DD-MM-YYYY')) = 12 
AND
EXTRACT(YEAR FROM TO_DATE(issue_date , 'DD-MM-YYYY'))=2021;

SELECT ROUND(AVG(int_rate)*100,2) AS PMTD_avg_interest_rate 
FROM bank_loan_data
WHERE EXTRACT(MONTH FROM TO_DATE(issue_date , 'DD-MM-YYYY')) = 11 
AND
EXTRACT(YEAR FROM TO_DATE(issue_date , 'DD-MM-YYYY'))=2021;


--5. Average debt to income DTI ratio--

SELECT ROUND(AVG(dti)*100,2) AS avg_dti FROM bank_loan_data;

SELECT ROUND(AVG(dti)*100,2) AS mtd_avg_dti 
FROM bank_loan_data
WHERE EXTRACT(MONTH FROM TO_DATE(issue_date , 'DD-MM-YYYY')) = 12 
AND
EXTRACT(YEAR FROM TO_DATE(issue_date , 'DD-MM-YYYY'))=2021;

SELECT ROUND(AVG(dti)*100,2) AS pmtd_avg_dti 
FROM bank_loan_data
WHERE EXTRACT(MONTH FROM TO_DATE(issue_date , 'DD-MM-YYYY')) = 11 
AND
EXTRACT(YEAR FROM TO_DATE(issue_date , 'DD-MM-YYYY'))=2021;


--Good loan and bad loan--

SELECT 
     (COUNT(CASE WHEN loan_status = 'Fully Paid' OR loan_status = 'Current' THEN id END)*100)
	 /
	 COUNT(id) AS good_loan_percentage

FROM bank_loan_data;


SELECT COUNT(id) AS good_loan_count
FROM bank_loan_data
WHERE loan_status = 'Fully Paid' OR loan_status = 'Current';

SELECT SUM(loan_amount) AS good_loan_funded_amount
FROM bank_loan_data
WHERE loan_status = 'Fully Paid' OR loan_status = 'Current';

SELECT SUM(total_payment) AS good_loan_recieved_amount
FROM bank_loan_data
WHERE loan_status = 'Fully Paid' OR loan_status = 'Current';


SELECT 
     (COUNT(CASE WHEN loan_status = 'Charged Off'  THEN id END)*100)
	 /
	 COUNT(id) AS bad_loan_percentage

FROM bank_loan_data;

SELECT COUNT(id) AS bad_loan_count
FROM bank_loan_data
WHERE loan_status = 'Charged Off';


SELECT SUM(loan_amount) AS bad_loan_funded_amount
FROM bank_loan_data
WHERE loan_status = 'Charged Off';

SELECT SUM(total_payment) AS bad_loan_recieved_amount
FROM bank_loan_data
WHERE loan_status = 'Charged Off' ;


--Loan status grid view--

SELECT loan_status , 
       COUNT(id) AS loan_count,
	   SUM(total_payment) AS total_amount_recieved,
	   SUM(loan_amount) AS total_funded_amount,
	   AVG(int_rate) AS interest_rate,
	   AVG(dti * 100) AS dti

FROM bank_loan_data
GROUP BY loan_status;

SELECT 
	loan_status, 
	SUM(total_payment) AS MTD_Total_Amount_Received, 
	SUM(loan_amount) AS MTD_Total_Funded_Amount 
FROM bank_loan_data
WHERE EXTRACT(MONTH FROM TO_DATE(issue_date , 'DD-MM-YYYY')) = 12 
AND
EXTRACT(YEAR FROM TO_DATE(issue_date , 'DD-MM-YYYY'))=2021
GROUP BY loan_status;

--DASHBOARD 2 : OVERVIEW --

 -- Monthly trends by issue date--

SELECT 
    EXTRACT(MONTH FROM TO_DATE(issue_date, 'DD-MM-YYYY')) as month,
    TRIM(TO_CHAR(TO_DATE(issue_date, 'DD-MM-YYYY'), 'Month')) AS month_name,
    COUNT(id) AS total_loan_applications,
    SUM(loan_amount) AS total_funded_amount,
    SUM(total_payment) AS total_received_amount
FROM bank_loan_data
GROUP BY 
    EXTRACT(MONTH FROM TO_DATE(issue_date, 'DD-MM-YYYY')),
    TRIM(TO_CHAR(TO_DATE(issue_date, 'DD-MM-YYYY'), 'Month'))
ORDER BY 
    EXTRACT(MONTH FROM TO_DATE(issue_date, 'DD-MM-YYYY'));

 -- Regional analysis by state--

 
SELECT 
    address_state ,
    COUNT(id) AS total_loan_applications,
    SUM(loan_amount) AS total_funded_amount,
    SUM(total_payment) AS total_received_amount
FROM bank_loan_data
GROUP BY 
    address_state
ORDER BY address_state;

--Loan term analysis--

SELECT 
    term ,
    COUNT(id) AS total_loan_applications,
    SUM(loan_amount) AS total_funded_amount,
    SUM(total_payment) AS total_received_amount
FROM bank_loan_data
GROUP BY 
    term;

--Employee length analysis--

SELECT 
    emp_length ,
    COUNT(id) AS total_loan_applications,
    SUM(loan_amount) AS total_funded_amount,
    SUM(total_payment) AS total_received_amount
FROM bank_loan_data
GROUP BY 
   emp_length
ORDER BY emp_length;


--Loan purpose breakdown--

SELECT 
    purpose ,
    COUNT(id) AS total_loan_applications,
    SUM(loan_amount) AS total_funded_amount,
    SUM(total_payment) AS total_received_amount
FROM bank_loan_data
GROUP BY 
    purpose;

--Home ownership analysis--

SELECT 
    home_ownership,
    COUNT(id) AS total_loan_applications,
    SUM(loan_amount) AS total_funded_amount,
    SUM(total_payment) AS total_received_amount
FROM bank_loan_data
GROUP BY 
    home_ownership;


--DASHBOARD 3 : DETAILS--

SELECT * FROM bank_loan_data;









    