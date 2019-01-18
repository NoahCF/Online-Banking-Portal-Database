
/*
This is SQL code for creating a bank database
on a MYSQL Server
*/

CREATE DATABASE IF NOT EXISTS `bank_db` DEFAULT CHARACTER SET utf8mb4;
USE bank_db;

CREATE TABLE `bank_db`.`ESTABLISHMENT` (
	establishment_id INT UNSIGNED NOT NULL,
	establishment_type ENUM('head office','branch') NOT NULL DEFAULT 'branch',
	establishment_location VARCHAR(255),
	establishment_phone VARCHAR(255),
	establishment_fax VARCHAR(255),
	establishment_open_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP(),
	establishment_head_position_id INT UNSIGNED,
	PRIMARY KEY(establishment_id)
);

CREATE TABLE `bank_db`.`POSITION` (
	position_id INT UNSIGNED NOT NULL,
	position_rank ENUM('clerk','manager','general manager','president') NOT NULL DEFAULT 'clerk',
	position_name VARCHAR(255) NOT NULL,
	position_monthly_salary DECIMAL(13,2) NOT NULL,
	position_establishment_id INT UNSIGNED DEFAULT NULL,
	PRIMARY KEY(position_id),
	FOREIGN KEY(position_establishment_id) REFERENCES establishment(establishment_id) ON DELETE SET NULL
);

ALTER TABLE `bank_db`.`ESTABLISHMENT` ADD FOREIGN KEY(establishment_head_position_id) REFERENCES `bank_db`.`POSITION` (position_id) ON DELETE SET NULL;

CREATE TABLE `bank_db`.`EMPLOYEE` (
	employee_id INT UNSIGNED NOT NULL,
	employee_position_id INT UNSIGNED NOT NULL,
	employee_name VARCHAR(255) NOT NULL,
	employee_address VARCHAR(255),
	employee_start_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP(),
	employee_email VARCHAR(255),
	employee_phone VARCHAR(255),
	PRIMARY KEY(employee_id),
	FOREIGN KEY(employee_position_id) REFERENCES position (position_id) ON DELETE NO ACTION
);

CREATE TABLE `bank_db`.`SERVICE` (
	service_id INT UNSIGNED NOT NULL,
	service_name VARCHAR(255) NOT NULL,
	service_type ENUM('banking','investment','insurance','credit') NOT NULL,
	service_level ENUM('personal','business','corporate'),
	service_monthly_fee DECIMAL(13,2) NOT NULL DEFAULT 0.00,
	service_credit_limit DECIMAL(13,2) NOT NULL DEFAULT 0.00,
	service_transaction_limit INT UNSIGNED NOT NULL DEFAULT 0,
	service_interest DECIMAL(5,2) NOT NULL DEFAULT 0.00, -- eg. 21.99 (%)
	service_description VARCHAR(255),
	service_general_manager_position_id INT UNSIGNED DEFAULT NULL,
	PRIMARY KEY(service_id),
	FOREIGN KEY(service_general_manager_position_id) REFERENCES position (position_id) ON DELETE SET NULL
);


CREATE TABLE `bank_db`.`CLIENT` (
	client_card_number BIGINT UNSIGNED NOT NULL,
	client_client_password VARCHAR(255) NOT NULL,
	client_name VARCHAR(255) NOT NULL,
	client_dob DATE NOT NULL,
	client_joining_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP(),
	client_address VARCHAR(255),
	client_email VARCHAR(255),
	client_phone VARCHAR(255),
	PRIMARY KEY(client_card_number)
);


CREATE TABLE `bank_db`.`ACCOUNT` (
	account_number INT UNSIGNED NOT NULL,
	account_balance DECIMAL(13,2) NOT NULL DEFAULT 0.00,
	account_service_id INT UNSIGNED NOT NULL,
	account_establishment_id INT UNSIGNED NOT NULL,
	account_client_card_number BIGINT UNSIGNED NOT NULL,
	PRIMARY KEY(account_number),
	FOREIGN KEY(account_service_id) REFERENCES service(service_id) ON DELETE NO ACTION,
	FOREIGN KEY(account_establishment_id) REFERENCES establishment(establishment_id) ON DELETE NO ACTION,
	FOREIGN KEY(account_client_card_number) REFERENCES client(client_card_number) ON DELETE NO ACTION
);


CREATE TABLE `bank_db`.`TRANSACTION` (
	transaction_account_number INT UNSIGNED NOT NULL,
	transaction_id BIGINT UNSIGNED NOT NULL,
	transaction_description VARCHAR(255),
	transaction_amount DECIMAL(13,2) NOT NULL,
	transaction_destination_id BIGINT UNSIGNED NOT NULL,
	transaction_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP(),
	PRIMARY KEY(transaction_account_number, transaction_id),
	FOREIGN KEY(transaction_account_number) REFERENCES account(account_number) ON DELETE CASCADE
);

CREATE TABLE `bank_db`.`EVENT` (
	event_employee_id INT UNSIGNED NOT NULL,
	event_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP(),
	event_activity ENUM('work','leave','sick'),
	PRIMARY KEY(event_employee_id, event_date),
	FOREIGN KEY(event_employee_id) REFERENCES employee(employee_id) ON DELETE CASCADE
);

CREATE TABLE `bank_db`.`PAYROLL` (
	payroll_employee_id INT UNSIGNED NOT NULL,
	payroll_period varchar(45) NOT NULL DEFAULT "1 MONTH", /*range of time, start and finish separated by a dash*/
	payroll_salary DECIMAL(13,2) NOT NULL DEFAULT 0.00,
	payroll_deduction DECIMAL(13,2) NOT NULL DEFAULT 0.00,
	PRIMARY KEY(payroll_employee_id, payroll_period),
	FOREIGN KEY(payroll_employee_id) REFERENCES employee(employee_id) ON DELETE CASCADE
);


/* Populating the database ----------------------------------------------------------------------------------------------*/

/*establishment insertion*/
INSERT INTO BANK_DB.ESTABLISHMENT values (1, 'head office', "Montreal", "1-800-123-4567",  "1-800-234-5678", '1995-01-01 14:00:00', NULL);
INSERT INTO BANK_DB.ESTABLISHMENT values (2, 'branch', "Ontario", "1-800-345-6789" , "1-800-456-7890", '1996-01-01 14:00:0', NULL);

/*position insertion*/
INSERT INTO BANK_DB.POSITION values (1, 'president', "Bank president", 75000.00, 1), (2, 'manager', "Bank manager", 10000.00, 1), (3, 'clerk', "Senior clerk", 4500.00, 1);
INSERT INTO BANK_DB.POSITION values (4, 'general manager', "Investment manager", 9200.00, 1), (5, 'general manager', "Insurance manager", 8500.00, 1), (6, 'general manager', "Credit manager", 10000.00, 1), (7, 'general manager', "Banking manager", 7800.00, 1);
INSERT INTO BANK_DB.POSITION values (8, 'manager', "Branch manager", 7200.00, 2), (9, 'clerk', "Clerk", 3200.00, 2);

/*Set the head of the establishments based on positions*/
UPDATE BANK_DB.ESTABLISHMENT SET establishment_head_position_id=1 WHERE establishment_id=1;
UPDATE BANK_DB.ESTABLISHMENT SET establishment_head_position_id=2 where establishment_id=2;

/*Employee insertion*/
INSERT INTO BANK_DB.EMPLOYEE values (1, 1, "John Doe", "3922 St Catherine", '1994-01-01 14:00:00', "doe@gmail.com", "450-921-2932");
INSERT INTO BANK_DB.EMPLOYEE values (2, 2, "Jack Jill", "3994 St Catherine", '1995-01-01 14:00:00', "jack@gmail.com", "450-932-2934");
INSERT INTO BANK_DB.EMPLOYEE values (3, 3, "Ali Baba", "3995 St Catherine", '1995-01-01 14:00:00', "ali@gmail.com", "450-932-2944");
INSERT INTO BANK_DB.EMPLOYEE values (4, 4, "Ali Bud", "3995 St Catherine", '1995-01-01 14:00:00', "ali@gmail.com", "450-934-2934");
INSERT INTO BANK_DB.EMPLOYEE values (5, 5, "Vicky Bud", "3998 St Catherine", '1995-01-01 14:00:00', "vicky@gmail.com", "450-122-2934");
INSERT INTO BANK_DB.EMPLOYEE values (6, 6, "Jose Aldo", "4002 St Catherine", '1995-01-01 14:00:00', "jose@gmail.com", "450-932-2134");
INSERT INTO BANK_DB.EMPLOYEE values (7, 7, "Jimeny Cracket", "4932 Maisonneuve", '1995-01-01 14:00:00', "Jimeny@gmail.com", "450-932-4944");
INSERT INTO BANK_DB.EMPLOYEE values (8, 8, "Zak Efon", "4943 West", '1996-01-01 14:00:0', "Zak@gmail.com", "450-932-4934");
INSERT INTO BANK_DB.EMPLOYEE values (9, 9, "Bart Sompsin", "4192 West", '1996-01-01 14:00:0', "Bart@gmail.com", "450-111-4934");

/*service insertion*/
INSERT INTO BANK_DB.SERVICE values (1, "Long term Investment", 'investment', 'personal', 10.00, 0.00, 0.00, 0.00, "Cannot withdraw money for 12 months", 4);
INSERT INTO BANK_DB.SERVICE values (2, "Company insurance", 'insurance', 'business', 1500.00, 0.00, 0.00, 30.00, "Property insurance", 5);
INSERT INTO BANK_DB.SERVICE values (3, "Corporate Credit", 'credit', 'Corporate', 20.00, 5000.00, 1000, 15.00, "Credit for corporation", 6);
INSERT INTO BANK_DB.SERVICE values (4, "Limited", 'banking', 'personal', 75.00, 2400.00, 50, 19.99, "Limited transactions", 7);

/*client insertion*/
INSERT INTO BANK_DB.CLIENT values (1000000000000000, "comp353", "Jackie Chung", '1997-04-03', '2005-12-31 23:59:59', "3955 St Catherine, Montreal, Qc", "jackie@gmail.com", "450-928-2932");

/*account insertion*/
INSERT INTO BANK_DB.ACCOUNT values (1, 5000.90, 4, 1, 1000000000000000);

/*transaction insertion*/
INSERT INTO BANK_DB.TRANSACTION values (1, 1, "bill payment", 150.00, 2, '2010-06-12 14:59:59');

/*event insertion*/
INSERT INTO BANK_DB.EVENT values (2, '2011-01-12 14:59:59', 'sick');

/*payroll insertion*/
INSERT INTO BANK_DB.PAYROLL values ( 1, "2011-01-01 - 2011-02-01", 75000.00, 9123.00);

