

CREATE TABLE bank_loan_data(
    id BIGINT PRIMARY KEY,
    address_state VARCHAR(10),
    application_type VARCHAR(20),
    emp_length VARCHAR(20),
    emp_title VARCHAR(100),
    grade CHAR(1),
    home_ownership VARCHAR(20),
    issue_date TEXT,
    last_credit_pull_date TEXT,
    last_payment_date TEXT,
    loan_status VARCHAR(50),
    next_payment_date TEXT,
    member_id BIGINT,
    purpose VARCHAR(50),
    sub_grade VARCHAR(5),
    term VARCHAR(20),
    verification_status VARCHAR(30),
    annual_income NUMERIC(12,2),
    dti NUMERIC(6,2),
    installment NUMERIC(10,2),
    int_rate NUMERIC(6,4),
    loan_amount NUMERIC(12,2),
    total_acc INT,
    total_payment NUMERIC(12,2)
);
SELECT issue_date FROM bank_loan_data LIMIT 10;

ALTER TABLE bank_loan_data
ALTER COLUMN issue_date TYPE DATE
USING TO_DATE(issue_date, 'DD-MM-YYYY');