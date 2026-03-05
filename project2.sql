-- library management system project 
-- creating branch table 

drop table if exists branch;
create table branch
	(
		branch_id	varchar(10) primary key ,
		manager_id varchar(10),
		branch_address varchar(55),
		contact_no varchar(10)
	);

-- creating employes tables 
drop table if exists employe;
create table employe (
	emp_id varchar (25) primary key,
	emp_name varchar (25),	
	position  varchar (25),
	salary int ,
	branch_id  varchar (25)
	)


-- creating books table 
drop table if exists books;
create table books (
isbn  varchar (20) primary key,
book_title varchar (70),
category varchar (25),
rental_price float,
status  varchar (15),
author varchar (35),
publisher varchar (55)
)





-- creating members table
drop table if exists members;
create table members 
	( member_id varchar (10) primary key,
	member_name varchar (25),
	member_address	varchar (75),
	reg_date date 
	)

-- creating issued_status table 
create table issued_status 
(
	issued_id varchar (20) primary key,
	issued_member_id varchar (20),
	issued_book_name varchar (70),
	issued_date date,
	issued_book_isbn varchar (25),
	issued_emp_id varchar (25)
);

-- creating return_status table
create table return_status

( 
	return_id varchar (25) primary key, 
	issued_id varchar (25),
	return_book_name varchar (75),
	return_date	date,
	return_book_isbn varchar (25)
	
	);
	










