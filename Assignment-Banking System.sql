-- tasks 1 
create database HMBank;
use HMBank;

create table Customers(
customer_id int Primary Key auto_increment,
first_name varchar(10) not null,
last_name varchar(10),
DOB date not null,
email varchar(50) not null unique,
phone_number bigint not null unique,
address varchar(100) not null
);

create table Accounts(
account_id int Primary Key auto_increment,
customer_id int not null unique,
account_type varchar(15) not null 
CHECK (account_type IN ('savings', 'current', 'zero_balance')),
balance decimal(10,2) default 0.00,
foreign key (customer_id) references Customers(customer_id)
on delete cascade on update cascade
);

create table Transactions(
transaction_id int primary key auto_increment,
account_id int not null,
transaction_type varchar(10) check (transaction_type in ('deposit', 'withdrawal', 'transfer')),
amount decimal(10,2) default 0.0,
transaction_date date,
Foreign Key (account_id) references Accounts(account_id)
on delete cascade on update cascade
);

-- customers table data insertion

insert into customers (first_name, last_name, DOB, email, phone_number, address) values
('John', 'Doe', '1990-05-15', 'john.doe@example.com', 9876543210, 'Chennai'),
('Jane', 'Smith', '1985-03-20', 'jane.smith@example.com', 9123456780, 'Bangalore'),
('Alice', 'Johnson', '1992-07-08', 'alice.johnson@example.com', 9871234560, 'Mumbai'),
('Bob', 'Brown', '1988-01-12', 'bob.brown@example.com', 7890123456, 'Delhi'),
('Eve', 'Davis', '1993-10-02', 'eve.davis@example.com', 7896541230, 'Chennai'),
('Charlie', 'Clark', '1993-10-02', 'charlie.clark@example.com', 7901123456, 'Kolkata'),
('David', 'Lee', '1987-09-30', 'david.lee@example.com', 9988776655, 'Mumbai'),
('John', 'Doe', '1990-05-15', 'john.duplicate@example.com', 9876543310, 'Hyderabad'),
('Grace', 'Kim', '1993-10-02', 'grace.kim@example.com', 7000123456, 'Pune'),
('Henry', 'Wong', '1994-12-22', 'henry.wong@example.com', 9090909090, 'Delhi'),
('Ivy', 'Young', '1989-11-11', 'ivy.young@example.com', 8080808080, 'Bangalore'),
('Jack', 'Miller', '1990-01-01', 'jack.miller@example.com', 6060606060, 'Chennai'),
('Karen', 'Wilson', '1993-05-23', 'karen.wilson@example.com', 5050505050, 'Mumbai'),
('Leo', 'Thomas', '1988-08-08', 'leo.thomas@example.com', 4040404040, 'Kolkata'),
('Maya', 'Scott', '1992-03-03', 'maya.scott@example.com', 3030303030, 'Bangalore');

-- accounts table data insertion

insert into accounts (customer_id, account_type, balance) values
(1, 'savings', 10000),
(2, 'current', 15000),
(3, 'zero_balance', 0),
(4, 'savings', 43000),
(5, 'current', 50000),
(6, 'savings', 10000),
(7, 'current', 25000),
(8, 'savings', 20000),
(9, 'zero_balance', 0),
(10, 'savings', 10000),
(11, 'current', 5000),
(12, 'savings', 10000),
(13, 'current', 15000),
(14, 'zero_balance', 0),
(15, 'savings', 50000);

-- transactions table data insertion

insert into transactions (account_id, transaction_type, amount, transaction_date) values
(1, 'deposit', 5000, '2025-06-01'),
(2, 'withdrawal', 2000, '2025-06-01'),
(4, 'deposit', 10000, '2025-06-01'),  
(6, 'deposit', 3000, '2025-06-05'),
(7, 'withdrawal', 1500, '2025-06-05'),
(8, 'deposit', 5000, '2025-06-05'),    
(10, 'withdrawal', 1000, '2025-06-10'),
(11, 'deposit', 5000, '2025-06-10'),
(12, 'deposit', 2000, '2025-06-15'),
(13, 'withdrawal', 3000, '2025-06-15'), 
(15, 'deposit', 3000, '2025-06-15'),    
(1, 'withdrawal', 1000, '2025-06-20'),
(2, 'deposit', 2000, '2025-06-20'),
(4, 'withdrawal', 5000, '2025-06-20'),
(6, 'deposit', 5000, '2025-06-25');


-- Tasks 2: Select, Where, Between, AND, LIKE

-- 1.Write a SQL query to retrieve the name, account type and email of all customers.

select concat(first_name,' ',last_name) 'customer name', account_type, email
from Customers, Accounts
where customers.customer_id = accounts.customer_id;

-- 2.Write a SQL query to list all transaction corresponding customer.

select first_name, last_name, transaction_type, amount, transaction_date
from customers, accounts, transactions
where customers.customer_id = accounts.customer_id
and accounts.account_id = transactions.account_id;


-- 3.Write a SQL query to increase the balance of a specific account 
-- by a certain amount.

update accounts
set balance = balance + 5000
where account_id = 3;


-- 4.Write a SQL query to Combine first and last names of customers as a full_name

select concat(first_name, ' ', last_name) as full_name
from customers;


-- 5.Write a SQL query to remove accounts with a balance of zero where the account
-- type is savings

set sql_safe_updates = 0;
delete from accounts
where balance = 0 and account_type = 'savings';

select * from accounts;


-- 6.Write a SQL query to Find customers living in a specific city.

select concat(first_name,' ',last_name) as CustomerName
from customers
where address like '%Chennai%';

-- 7.Write a SQL query to Get the account balance for a specific account.

select customer_id,balance
from accounts
where account_id = 1;

-- 8.Write a SQL query to List all current accounts with a balance greater than $1,000.

select * from accounts
where account_type = 'current' and balance > 1000;

-- 9.Write a SQL query to Retrieve all transactions for a specific account.

select * from transactions
where account_id = 7;

-- 10.Write a SQL query to Calculate the interest accrued on savings accounts
-- based on a given interest rate.

select account_id, balance, balance * 0.04 as interest
from accounts
where account_type = 'savings';

-- 11.Write a SQL query to Identify accounts where the balance is less than a specified
-- overdraft limit.

select account_id, balance
from accounts
where balance < 500;

-- 12.Write a SQL query to Find customers not living in a specific city

select concat(first_name,' ',last_name) as Customer_name
from customers
where address not like '%Mumbai%';

-- Tasks 3: Aggregate functions, Having, Order By, GroupBy and Joins

-- 1.Write a SQL query to Find the average account balance for all customers. 

select customer_id, avg(balance) as avg_balance
from accounts
group by customer_id;

-- 2.Write a SQL query to Retrieve the top 10 highest account balances.

select account_id, balance
from accounts
order by 2 desc
limit 10;

-- 3.Write a SQL query to Calculate Total Deposits for All Customers in specific date.

select sum(amount) as total_deposits
from transactions
where transaction_type = 'deposit' and transaction_date = '2025-06-01';

-- 4.Write a SQL query to Find the Oldest and Newest Customers.

  select
  (select concat(first_name, ' ', last_name) from customers
  where dob = (select min(dob) from customers)) as old_customer,
  (select concat(first_name, ' ', last_name) from customers
  where dob = (select max(dob) from customers)) as new_customer;

-- 5.Write a SQL query to Retrieve transaction details along with the account type

select t.transaction_id, t.transaction_type, t.amount, t.transaction_date,
accounts.account_type from transactions t
join accounts using(account_id);

-- 6. Write a SQL query to Get a list of customers along with their account details.

select c.customer_id, c.first_name, c.last_name,accounts.account_id,
accounts.account_type, accounts.balance from customers c
join accounts using(customer_id);

-- 7. Write a SQL query to Retrieve transaction details along with customer
-- information for a specific account

select t.transaction_id, t.transaction_type, t.amount, t.transaction_date,
c.customer_id, c.first_name, c.last_name
from transactions t
join accounts a using(account_id)
join customers c using(customer_id)
where t.account_id = 6; 

-- 8. Write a SQL query to Identify customers who have more than one account.

select customer_id, count(account_id) as account_count
from accounts
group by customer_id
having count(account_id) > 1;

-- 9. Write a SQL query to Calculate the difference in transaction amounts
-- between deposits and withdrawals.

select 
(select sum(amount) from transactions where transaction_type = 'deposit') -
(select sum(amount) from transactions where transaction_type = 'withdrawal') 
as difference;


-- 10. Write a SQL query to Calculate the average daily balance for each 
-- account over a specified period

select account_id, avg(balance) as avg_daily_balance
from accounts
where account_id in(
select  account_id from transactions 
where transaction_date between '2025-06-01' and '2025-06-05')
group by account_id;

-- 11. Calculate the total balance for each account type

select account_type, sum(balance) as total_balance
from accounts
group by account_type;


-- 12. Identify accounts with the highest number of transactions order
-- by descending order.

select account_id, count(transaction_id) as transaction_count
from transactions
group by account_id
order by 2 desc;

-- 13. List customers with high aggregate account balances, 
-- along with their account types.

select c.customer_id, c.first_name, c.last_name, a.account_type, 
sum(a.balance) as total_balance
from customers c
join accounts a using(customer_id)
group by 1, 4
having sum(a.balance) > 10000; 

-- 14. Identify and list duplicate transactions based 
-- on transaction amount, date, and account.

select account_id, amount, transaction_date, count(*) as dup_count
from transactions
group by account_id, amount, transaction_date
having count(*) > 1;

-- Tasks 4: Subquery and its type

-- 1. Retrieve the customer(s) with the highest account balance.

select customer_id,concat(first_name,' ', last_name ) as customer_name
from customers 
where customer_id in (
select customer_id 
from accounts 
where balance = (select max(balance) from accounts)
);

-- 2. Calculate the average account balance for customers who have more than one account

select avg(balance) as avg_balance
from ( select customer_id, avg(balance) as balance, 
count(*) as acc_count
from accounts
group by customer_id
having count(*) > 1
) as multi_acc_customers;


-- 3. Retrieve accounts with transactions whose amounts exceed the average 
-- transaction amount.

select * from transactions
where amount > (select avg(amount) from transactions);

-- 4. Identify customers who have no recorded transactions.

select concat(first_name,' ',last_name) as customer_name from customers
where customer_id in (
select customer_id from accounts
where account_id not in (
select account_id from transactions)
);

  
-- 5. Calculate the total balance of accounts with no recorded transactions.

select sum(balance) as total_balance
from accounts
where account_id not in (
select account_id from transactions
);

-- 6. Retrieve transactions for accounts with the lowest balance.

select * from transactions
where account_id in (
select account_id from accounts 
where balance = (select min(balance) from accounts)
);

-- 7. Identify customers who have accounts of multiple types.

select customer_id 
from accounts 
group by customer_id 
having count(distinct account_type) > 1;

-- 8. Calculate the percentage of each account type out of the total number of accounts.

select account_type,
count(*) as total,
(count(*) * 100.0) / (select count(*) from accounts) as percentage
from accounts
group by account_type;

-- 9. Retrieve all transactions for a customer with a given customer_id.

select * from transactions
where account_id in (
select account_id from accounts where customer_id = 7 
);

-- 10. Calculate the total balance for each account type, including a 
-- subquery within the SELECT clause

select account_type,
sum(balance) as total_balance,
(select sum(balance) from accounts) as overall_total
from accounts
group by account_type;





