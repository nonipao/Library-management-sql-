select * from issued_status
order by member_id
-- Task 1. Create a New Book Record
--"978-1-60129-456-2', 'To Kill a Mockingbird', 'Classic', 6.00, 'yes', 'Harper Lee', 'J.B. Lippincott & Co.')"

 insert into books 
	 ( isbn , book_title, category, rental_price, status, author, publisher)
	 values ('978-1-60129-456-2', 'To Kill a Mockingbird', 'Classic', 6.00, 'yes', 'Harper Lee', 'J.B. Lippincott & Co.');

--Task 2: Update an Existing Member's Address

update members
set member_address = 'b85_balgi'
where member_id = 'C103';

--Task 3: Delete a Record from the Issued Status Table -- Objective: Delete the record with issued_id = 'IS121' from the issued_status table.

delete from issued_status
where issued_id = 'IS121'

--Task 4: Retrieve All Books Issued by a Specific Employee -- Objective: Select all books issued by the employee with emp_id = 'E101'.

select * from issued_status
where issued_emp_id = 'E101'

--Task 5: List Members Who Have Issued More Than One Book -- Objective: Use GROUP BY to find members who have issued more than one book.
select issued_emp_id,
	   count(*) total_count
from  issued_status
group by 1
having count(*) > 1
order by total_count desc

--CTAS (Create Table As Select) questions

--Task 6: Create Summary Tables: Used CTAS to generate new tables based on query results - each book and total book_issued_cnt
select * from books;;
select * from issued_status;
CREATE TABLE BOOK_ISSUED_CNTS AS
SELECT
	B.ISBN,
	B.BOOK_TITLE,
	COUNT(IST.ISSUED_ID) AS ISSUE_COUNT
FROM
	ISSUED_STATUS AS IST
	FULL JOIN BOOKS AS B 
	ON IST.ISSUED_BOOK_ISBN = B.ISBN
GROUP BY
	B.ISBN,
	B.BOOK_TITLE;

drop table  book_issued_cnts

/*Task 7. Retrieve All Books in a Specific Category:*/
SELECT
	*
FROM
	BOOKS
WHERE
	CATEGORY = 'Classic'

--Task 8: Find Total Rental Income by Category:
SELECT 
    b.category,
    SUM(b.rental_price) total_rental_price,
    COUNT(*)
FROM 
issued_status as ist
left JOIN
books as b
ON b.isbn = ist.issued_book_isbn
GROUP BY 1

-- task 9: List Members Who Registered in the Last 180 Days:

SELECT * FROM members
WHERE reg_date >= CURRENT_DATE - INTERVAL '180 days';

--Task 10: List Employees with Their Branch Manager's Name and their branch details
select * from branch
select 
	e.emp_id,
	e.emp_name,
	e.branch_id,
	e.position,
	b.*, e2.emp_id
	
from employe as e
 join branch as b 
on e.branch_id = b.branch_id
join employe as e2
on e2.emp_id = b.manager_id

--Task 11. Create a Table of Books with Rental Price Above a Certain Threshold

create table expensive_books as 
select * from books
where rental_price >7.00;


select * from expensive_books
order by rental_price desc

--Task 12: Retrieve the List of Books Not Yet Returned
select * from return_status
select * from issued_status

SELECT * FROM issued_status as ist
LEFT JOIN
return_status as rs
ON rs.issued_id = ist.issued_id
WHERE rs.return_id IS NULL;

/* Task 13: Identify Members with Overdue Books
Write a query to identify members who have overdue books 
(assume a 30-day return period). Display the member's_id, member's name, book title, issue date, and days overdue.*/

select * from members 
select * from books

SELECT 
    ist.issued_member_id,
    m.member_name,
    bk.book_title,
    ist.issued_date,
    -- rs.return_date,
    CURRENT_DATE - ist.issued_date as over_dues_days
FROM issued_status as ist
JOIN 
members as m
    ON m.member_id = ist.issued_member_id
JOIN 
books as bk
ON bk.isbn = ist.issued_book_isbn
LEFT JOIN 
return_status as rs
ON rs.issued_id = ist.issued_id
WHERE 
    rs.return_date IS NULL
    AND
    (CURRENT_DATE - ist.issued_date) > 30
ORDER BY 1




