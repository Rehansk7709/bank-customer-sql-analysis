


create database xyz
create table customers (
    customerid int primary key,
    customername varchar(50) not null,
    pincode varchar(10),
    city varchar(30),
    accounttype varchar(20),
    accountno int unique
);


create table accounts (
    accountno int primary key,
    customerid int not null,
    balance decimal(15,2),
    opendate date,
    foreign key (customerid) references customers(customerid)
);

create table transactions (
    transactionid int primary key,
    accountno int not null,
    transactiontype varchar(20),
    amount decimal(15,2),
    transactiondate date,
    foreign key (accountno) references accounts(accountno)
);

create table loans (
    loanid int primary key,
    customerid int not null,
    loanamount decimal(15,2),
    loandate date,
    loantype varchar(30),
    foreign key (customerid) references customers(customerid)
);


select * from sys.tables ;
insert into customers (customerid, customername, pincode, city, accounttype, accountno) values
(1, 'rahul sharma', '411045', 'pune', 'savings', 1001),
(2, 'rohit mehta', '400056', 'mumbai', 'savings', 1002),
(3, 'priya verma', '122001', 'gurgaon', 'current', 1003),
(4, 'neha singh', '560001', 'bangalore', 'savings', 1004),
(5, 'rajesh kumar', '600001', 'chennai', 'savings', 1005),
(6, 'pooja patel', '380001', 'ahmedabad', 'savings', 1006),
(7, 'rakesh gupta', '700001', 'kolkata', 'savings', 1007),
(8, 'meena joshi', '110001', 'delhi', 'savings', 1008),
(9, 'rajiv nair', '682001', 'kochi', 'savings', 1009),
(10, 'ajay verma', '302001', 'jaipur', 'savings', 1010);

insert into accounts (accountno, customerid, balance, opendate) values
(1001, 1, 100000, '2020-01-01'),
(1002, 2, 200000, '2020-02-01'),
(1003, 3, 300000, '2020-03-01'),
(1004, 4, 400000, '2020-04-01'),
(1005, 5, 500000, '2020-05-01'),
(1006, 6, 600000, '2020-06-01'),
(1007, 7, 700000, '2020-07-01'),
(1008, 8, 800000, '2020-08-01'),
(1009, 9, 900000, '2020-09-01'),
(1010, 10, 1000000, '2020-10-01');


insert into transactions (transactionid, accountno, transactiontype, amount, transactiondate) values
(1, 1001, 'withdraw', 5000, '2020-01-05'),
(2, 1002, 'deposit', 10000, '2020-02-10'),
(3, 1003, 'withdraw', 2000, '2020-03-15'),
(4, 1004, 'deposit', 15000, '2020-04-20'),
(5, 1005, 'withdraw', 3000, '2020-05-25'),
(6, 1006, 'deposit', 20000, '2020-06-30'),
(7, 1007, 'withdraw', 4000, '2020-07-05'),
(8, 1008, 'deposit', 25000, '2020-08-10'),
(9, 1009, 'withdraw', 5000, '2020-09-15'),
(10, 1010, 'deposit', 30000, '2020-10-20');


insert into loans (loanid, customerid, loanamount, loandate, loantype) values
(1, 1, 200000, '2020-01-10', 'personal loan'),
(2, 2, 300000, '2020-02-15', 'home loan'),
(3, 3, 400000, '2020-03-20', 'car loan'),
(4, 4, 500000, '2020-04-25', 'education loan'),
(5, 5, 600000, '2020-05-30', 'personal loan'),
(6, 6, 700000, '2020-06-05', 'home loan'),
(7, 7, 800000, '2020-07-10', 'car loan'),
(8, 8, 900000, '2020-08-15', 'education loan'),
(9, 9, 1000000, '2020-09-20', 'personal loan'),
(10, 10, 1100000, '2020-10-25', 'car loan');

select *  from  customers;
select * from  accounts;
select * from loans;
select * from transactions;


 

select  a.accountno ,a.balance,c.customername  
from customers c inner join accounts a
on  c.customerid = a.customerid;


SELECT c.customername, a.accountno, a.balance  
from accounts a inner join customers c
on c.customerid = a.customerid;







SELECT  top 3 c.customername, a.accountno, a.balance  
from accounts a inner join customers c
on c.customerid = a.customerid
order by a.balance desc;


select *  from  customers;
select * from loans;

select c.customername,l.loanamount,l.loantype 
from customers c inner join loans l
on c.customerid = l.customerid;

select * from transactions;

Select transactiontype, sum(amount)
as total_amount
from transactions
group by transactiontype;
--Display customer-wise total transaction amount using GROUP BY.
select * from transactions;
select * from customers;
select * from accounts;


select c.customername, sum(t.amount)
as total_transaction_amount
from customers c
inner join accounts a
on c.customerid = a.customerid
inner join transactions t
on a.accountno = t.accountno
group by c.customername;


---Find customers whose balances are greater than the average bank balance.


select c.customername, a.balance
from customers c
inner join accounts a
on c.customerid = a.customerid
where a.balance > (select avg(balance) from accounts);

--7. Show the highest transaction amount performed by each customer.


select c.customername, max(t.amount) as highest_transaction
from customers c
inner join accounts a
on c.customerid = a.customerid
inner join transactions t
on a.accountno = t.accountno
group by c.customername;





select c.customername
from customers c
left join loans l
on c.customerid = l.customerid
where l.customerid is null;



---Display all customers who have not taken any loans using LEFT JOIN.

select c.customername
from customers c
left join loans l
on c.customerid = l.customerid
where l.customerid is null;


 
insert into customers (customerid, customername, pincode, city, accounttype, accountno)
values (11, 'sneha deshmukh', '440001', 'nagpur', 'savings', 1011);

 

select c.customername
from customers c
left join loans l
on c.customerid = l.customerid
where l.customerid is null;


--9. Find the total number of transactions performed by each customer.
select c.customername, count(t.transactionid) as total_transactions
from customers c
inner join accounts a
on c.customerid = a.customerid
inner join transactions t
on a.accountno = t.accountno
group by c.customername;




----10. Rank customers based on their account balances using RANK() window function.

select c.customername, a.balance,
rank() over (order by a.balance desc) as balance_rank
from customers c
inner join accounts a
on c.customerid = a.customerid;



--11. Display dense ranking of customers according to balance using DENSE_RANK().


select c.customername, a.balance,
dense_rank() over (order by a.balance desc) 
as balance_dense_rank from customers c
inner join accounts a
on c.customerid = a.customerid;


--12. Show previous transaction amount using LAG() function.

select t.transactionid, t.accountno, 
t.transactiontype, t.amount,
lag(t.amount) over (order by t.transactiondate) 
as previous_transaction_amount
from transactions t;


---13. Show next transaction amount using LEAD() function.

select t.transactionid, t.accountno, 
t.transactiontype, t.amount,lead(t.amount) 
over (order by t.transactiondate) 
as next_transaction_amount
from transactions t;


--14. Calculate running total of transaction amounts using SUM() OVER().


select t.transactionid, t.accountno,
t.transactiontype, t.amount,sum(t.amount)
over (order by t.transactiondate) 
as running_total from transactions t;


 
 
--15. Find the second highest account balance using subquery or window function.

select max(balance) 
as second_highest_balance
from accounts
where balance < (select max(balance) 
from accounts);

--16. Find customers who performed more than 2 transactions.

select c.customername, count(t.transactionid) as total_transactions
from customers c
inner join accounts a
on c.customerid = a.customerid
inner join transactions t
on a.accountno = t.accountno
group by c.customername
having count(t.transactionid) > 2;



 
insert into transactions (transactionid, accountno, transactiontype, amount, transactiondate)
values (11, 1010, 'deposit', 15000, '2024-06-01'),
       (12, 1010, 'withdraw', 5000, '2024-06-02');
 
select c.customername, count(t.transactionid) as total_transactions
from customers c
inner join accounts a
on c.customerid = a.customerid
inner join transactions t
on a.accountno = t.accountno
group by c.customername
having count(t.transactionid) > 2;


--17. Display customer-wise minimum and maximum transaction amounts.

select c.customername,
min(t.amount) as min_transaction,
max(t.amount) as max_transaction
from customers c inner join accounts a
on c.customerid = a.customerid
inner join transactions t
on a.accountno = t.accountno
group by c.customername;




