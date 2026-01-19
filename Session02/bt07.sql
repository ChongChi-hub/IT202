CREATE TABLE Partner (
    partner_id VARCHAR(20) PRIMARY KEY,
    partner_name VARCHAR(100) NOT NULL,
    description VARCHAR(255)
);

CREATE TABLE Customer (
    customer_id VARCHAR(20) PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    identity_card VARCHAR(20) NOT NULL,
    phone_number VARCHAR(15) NOT NULL,
    email VARCHAR(100),
    UNIQUE (identity_card),
    UNIQUE (phone_number)
);

CREATE TABLE Account (
    account_number VARCHAR(20) PRIMARY KEY,
    customer_id VARCHAR(20) NOT NULL,
    balance DECIMAL(15, 2) DEFAULT 0,
    created_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    CHECK (balance >= 0),
    FOREIGN KEY (customer_id) REFERENCES Customer(customer_id)
);

CREATE TABLE TuitionBill (
    bill_code VARCHAR(50) PRIMARY KEY,
    partner_id VARCHAR(20) NOT NULL,
    student_code VARCHAR(50) NOT NULL,
    student_name VARCHAR(100),
    amount DECIMAL(15, 2) NOT NULL,
    due_date DATETIME,
    status VARCHAR(20) DEFAULT 'Pending',
    CHECK (amount > 0),
    FOREIGN KEY (partner_id) REFERENCES Partner(partner_id)
);

CREATE TABLE Transaction (
    transaction_id VARCHAR(50) PRIMARY KEY,
    account_number VARCHAR(20) NOT NULL,
    bill_code VARCHAR(50) NOT NULL,
    amount DECIMAL(15, 2) NOT NULL,
    transaction_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    description VARCHAR(255),
    CHECK (amount > 0),
    UNIQUE (bill_code),
    FOREIGN KEY (account_number) REFERENCES Account(account_number),
    FOREIGN KEY (bill_code) REFERENCES TuitionBill(bill_code)
);