-- Creating the database
CREATE DATABASE insurancedb;

-- Using the database
USE insurancedb;

-- Creating tables
CREATE TABLE address_details
(
  address_id int primary key,
  h_no varchar(6),
  city varchar(50),
  addressline1 varchar(50),
  state varchar(50),
  pin varchar(50)
);

CREATE TABLE user_details
(
  user_id int primary key,
  firstname varchar(50),
  lastname varchar(50),
  email varchar(50),
  mobileno varchar(50),
  address_id int references address_details(address_id),
  dob date
);

CREATE TABLE ref_policy_types
(
  policy_type_code varchar(10) primary key,
  policy_type_name varchar(50)
);

CREATE TABLE policy_sub_types
(
  policy_type_id varchar(10) primary key,
  policy_type_code varchar(10) references ref_policy_types(policy_type_code),
  description varchar(50),
  yearsofpayements int,
  amount double,
  maturityperiod int,
  maturityamount double,
  validity int
);

CREATE TABLE user_policies
(
  policy_no varchar(20) primary key,
  user_id int references user_details(user_id),
  date_registered date,
  policy_type_id varchar(10) references policy_sub_types(policy_type_id)
);

CREATE TABLE policy_payments
(
  receipno int primary key,
  user_id int references user_details(user_id),
  policy_no varchar(20) references user_policies(policy_no),
  dateofpayment date,
  amount double,
  fine double
);

-- Inserting records
-- (Insert statements remain the same)

-- Performing queries
-- Problem#1:
--Write a query to display the policytypeid,policytypename,description of all the car’s policy details
SELECT p.policy_type_id, r.policy_type_name, p.description
FROM policy_sub_types p
JOIN ref_policy_types r ON p.policy_type_code = r.policy_type_code
WHERE r.policy_type_name ='car';

-- Problem#2:
--Write a query to display the policytypecode,no of polycies in each code with alias name NO_OF_POLICIES.
SELECT policy_type_code, COUNT(policy_type_code) AS no_of_policies
FROM policy_sub_types
GROUP BY policy_type_code;

-- Problem#3:
--Write a query to display the userid,firstname,lastname, email,mobileno who are residing in Chennai.
SELECT ud.user_id, ud.firstname, ud.lastname, ud.email, ud.mobileno
FROM user_details ud
JOIN address_details ad ON ud.address_id=ad.address_id
WHERE ad.city='hyderabad'
GROUP BY ud.user_id;



