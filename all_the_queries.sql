-- DELIVERABLE 5 SQL FILE
CREATE DATABASE ExpenseManager_Final;
USE ExpenseManager_Final;

CREATE TABLE User (
    UserID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(100),
    Email VARCHAR(100),
    Password VARCHAR(100),
    Age INT,
    Gender VARCHAR(10),
    Location VARCHAR(100),
    TotalExpenses DECIMAL(10, 2) DEFAULT 0
);

CREATE TABLE Category (
    CategoryID INT PRIMARY KEY AUTO_INCREMENT,
    CategoryName VARCHAR(50),
    Description VARCHAR(255)
);

CREATE TABLE Expense (
    ExpenseID INT PRIMARY KEY AUTO_INCREMENT,
    UserID INT,
    CategoryID INT,
    Amount DECIMAL(10, 2),
    ExpenseDate DATETIME,
    Description VARCHAR(255),
    FOREIGN KEY (UserID) REFERENCES User(UserID),
    FOREIGN KEY (CategoryID) REFERENCES Category(CategoryID)
);

CREATE TABLE PaymentMethod (
    PaymentMethodID INT PRIMARY KEY AUTO_INCREMENT,
    MethodName VARCHAR(50),
    MethodType VARCHAR(50)
);

CREATE TABLE Transaction (
    TransactionID INT PRIMARY KEY AUTO_INCREMENT,
    UserID INT,
    ExpenseID INT,
    PaymentMethodID INT,
    TransactionDate DATETIME,
    FOREIGN KEY (UserID) REFERENCES User(UserID),
    FOREIGN KEY (ExpenseID) REFERENCES Expense(ExpenseID),
    FOREIGN KEY (PaymentMethodID) REFERENCES PaymentMethod(PaymentMethodID)
);

INSERT INTO User (UserID, Name, Email, Password, Age, Gender, Location)
VALUES ('John Doe', 'john@example.com', 'pass123', 30, 'Male', 'New York'),
('Jane Smith', 'jane@example.com', 'pass456', 28, 'Female', 'Chicago'),
('Alice Johnson', 'alice@example.com', 'pass789', 35, 'Female', 'Los Angeles'),
('Robert Brown', 'robert@example.com', 'passabc', 40, 'Male', 'Miami'),
('Emily Davis', 'emily@example.com', 'passdef', 25, 'Female', 'Boston'),
('Michael Lee', 'michael@example.com', 'passghi', 32, 'Male', 'San Francisco'),
('Jessica Wilson', 'jessica@example.com', 'passjkl', 29, 'Female', 'Seattle'),
('David Garcia', 'david@example.com', 'passmno', 27, 'Male', 'Houston'),
('Sarah Martinez', 'sarah@example.com', 'passpqr', 33, 'Female', 'Phoenix'),
('James Anderson', 'james@example.com', 'passstu', 31, 'Male', 'Denver'),
('Linda Harris', 'linda@example.com', 'passvwx', 38, 'Female', 'Las Vegas'),
('Paul Clark', 'paul@example.com', 'passyz', 36, 'Male', 'Atlanta'),
('Olivia King', 'olivia@example.com', 'pass1234', 26, 'Female', 'Dallas'),
('Henry Scott', 'henry@example.com', 'pass5678', 34, 'Male', 'Portland'),
('Mia Moore', 'mia@example.com', 'pass91011', 29, 'Female', 'Philadelphia'),
('Chris Young', 'chris@example.com', 'pass1314', 37, 'Male', 'San Diego'),
('Sophia White', 'sophia@example.com', 'pass1516', 30, 'Female', 'Austin'),
('Ethan Taylor', 'ethan@example.com', 'pass1718', 24, 'Male', 'Nashville'),
('Amelia Adams', 'amelia@example.com', 'pass1920', 28, 'Female', 'Kansas City'),
('Liam Hill', 'liam@example.com', 'pass2122', 35, 'Male', 'Charlotte'),
('Chloe Baker', 'chloe@example.com', 'pass2324', 26, 'Female', 'San Jose'),
('Benjamin Collins', 'benjamin@example.com', 'pass2526', 39, 'Male', 'Indianapolis'),
('Zoe Nelson', 'zoe@example.com', 'pass2728', 27, 'Female', 'Orlando'),
('Daniel Perez', 'daniel@example.com', 'pass2930', 33, 'Male', 'Salt Lake City'),
('Lily Rivera', 'lily@example.com', 'pass3132', 29, 'Female', 'Columbus'),
('Matthew Bennett', 'matthew@example.com', 'pass3334', 36, 'Male', 'Charlotte'),
('Victoria Hughes', 'victoria@example.com', 'pass3536', 25, 'Female', 'Baltimore'),
('Alexander Cox', 'alexander@example.com', 'pass3738', 34, 'Male', 'Oklahoma City'),
('Samantha Perry', 'samantha@example.com', 'pass3940', 31, 'Female', 'Sacramento'),
('Lucas Cooper', 'lucas@example.com', 'pass4142', 30, 'Male', 'Milwaukee'),
('Natalie Torres', 'natalie@example.com', 'pass4344', 28, 'Female', 'Memphis'),
('Andrew Long', 'andrew@example.com', 'pass4546', 37, 'Male', 'Cleveland'),
('Grace Foster', 'grace@example.com', 'pass4748', 32, 'Female', 'Virginia Beach'),
('Joseph Ward', 'joseph@example.com', 'pass4950', 35, 'Male', 'Albuquerque'),
('Harper Brooks', 'harper@example.com', 'pass5152', 27, 'Female', 'Louisville'),
('Ryan Bell', 'ryan@example.com', 'pass5354', 33, 'Male', 'Omaha'),
('Ellie Sanders', 'ellie@example.com', 'pass5556', 29, 'Female', 'Tucson'),
('Nathan Myers', 'nathan@example.com', 'pass5758', 40, 'Male', 'Fresno'),
('Hannah Reed', 'hannah@example.com', 'pass5960', 24, 'Female', 'Mesa'),
('Elijah Patterson', 'elijah@example.com', 'pass6162', 26, 'Male', 'Raleigh'),
('Ava Turner', 'ava@example.com', 'pass6364', 28, 'Female', 'Omaha'),
('Dylan Phillips', 'dylan@example.com', 'pass6566', 31, 'Male', 'Colorado Springs'),
('Abigail Parker', 'abigail@example.com', 'pass6768', 34, 'Female', 'Wichita'),
('Jackson Murphy', 'jackson@example.com', 'pass6970', 29, 'Male', 'Tulsa'),
('Emily Green', 'emily.green@example.com', 'pass7172', 36, 'Female', 'Minneapolis'),
('Owen Nelson', 'owen@example.com', 'pass7374', 32, 'Male', 'Arlington'),
('Lillian Carter', 'lillian@example.com', 'pass7576', 27, 'Female', 'New Orleans'),
('Sebastian Mitchell', 'sebastian@example.com', 'pass7778', 33, 'Male', 'San Antonio'),
('Ella Bailey', 'ella@example.com', 'pass7980', 25, 'Female', 'Fort Worth');

INSERT INTO Category (CategoryName, Description)
VALUES ('Food', 'Expenses related to food'),
       ('Transportation', 'Travel expenses'),
       ('Entertainment', 'Leisure activities'),
       ('Health', 'Medical and health-related expenses'),
       ('Education', 'Expenses for learning and education'),
       ('Housing', 'Costs related to accommodation and rent'),
       ('Utilities', 'Bills for electricity, water, and gas'),
       ('Clothing', 'Spending on apparel and accessories'),
       ('Personal Care', 'Costs for grooming and hygiene'),
       ('Gifts', 'Expenses for presents and donations'),
       ('Travel', 'Costs incurred during trips and vacations'),
       ('Savings', 'Money set aside for future use'),
       ('Insurance', 'Premiums paid for insurance policies'),
       ('Pets', 'Expenses for pet care and supplies'),
       ('Subscriptions', 'Recurring costs for digital services'),
       ('Technology', 'Spending on gadgets and electronics'),
       ('Miscellaneous', 'General expenses that do not fit other categories');
ALTER TABLE Expense AUTO_INCREMENT = 1;

INSERT INTO Expense (UserID, CategoryID, Amount, ExpenseDate, Description)
VALUES (1, 1, 50.00, '2024-09-15 10:00:00', 'Lunch at restaurant'),
       (2, 2, 20.00, '2024-09-16 12:00:00', 'Bus fare'),
       (3, 1, 100.00, '2024-09-17 14:00:00', 'Grocery shopping'),
       (4, 3, 30.00, '2024-09-18 18:00:00', 'Movie tickets'),
       (5, 4, 200.00, '2024-09-19 09:00:00', 'Doctor visit'),
       (6, 5, 500.00, '2024-09-20 11:00:00', 'Course enrollment fee'),
       (7, 6, 1500.00, '2024-09-21 08:00:00', 'Rent payment'),
       (8, 7, 100.00, '2024-09-22 07:00:00', 'Electricity bill'),
       (9, 8, 75.00, '2024-09-23 15:00:00', 'Clothing purchase'),
       (10, 9, 30.00, '2024-09-24 16:00:00', 'Haircut'),
       (11, 10, 40.00, '2024-09-25 17:00:00', 'Gift for friend'),
       (12, 11, 1200.00, '2024-09-26 06:00:00', 'Airplane tickets'),
       (13, 12, 300.00, '2024-09-27 13:00:00', 'Savings deposit'),
       (14, 13, 150.00, '2024-09-28 14:30:00', 'Health insurance premium'),
       (15, 14, 60.00, '2024-09-29 19:00:00', 'Pet food purchase'),
       (16, 15, 10.00, '2024-09-30 09:30:00', 'Music streaming subscription'),
       (17, 16, 250.00, '2024-10-01 12:00:00', 'New smartphone purchase'),
       (18, 1, 65.00, '2024-10-02 13:00:00', 'Dinner at diner'),
       (19, 7, 90.00, '2024-10-03 10:00:00', 'Gas bill payment'),
       (20, 2, 15.00, '2024-10-04 09:00:00', 'Taxi ride'),
       (21, 3, 40.00, '2024-10-05 19:00:00', 'Concert ticket'),
       (22, 4, 300.00, '2024-10-06 08:00:00', 'Dental check-up'),
       (23, 8, 120.00, '2024-10-07 11:00:00', 'Winter jacket purchase'), 
       (24, 9, 20.00, '2024-10-08 15:00:00', 'Manicure service'),
       (25, 10, 50.00, '2024-10-09 16:00:00', 'Wedding gift'),
       (26, 11, 800.00, '2024-10-10 07:00:00', 'Road trip expenses'),
       (27, 13, 200.00, '2024-10-11 14:00:00', 'Car insurance renewal'),
       (28, 12, 400.00, '2024-10-12 12:00:00', 'Emergency fund'),
       (29, 6, 1200.00, '2024-10-13 18:00:00', 'Monthly rent'),
       (30, 5, 350.00, '2024-10-14 17:00:00', 'Online course subscription'),
       (31, 16, 100.00, '2024-10-15 09:00:00', 'Wireless headphones purchase'),
       (32, 1, 20.00, '2024-10-16 10:00:00', 'Breakfast at cafe'),
       (33, 14, 45.00, '2024-10-17 12:00:00', 'Pet grooming'),
       (34, 15, 8.00, '2024-10-18 13:00:00', 'Online magazine subscription'),
       (35, 16, 500.00, '2024-10-19 18:00:00', 'Laptop upgrade'),
       (36, 4, 250.00, '2024-10-20 08:30:00', 'Vision test and glasses'),
       (37, 3, 60.00, '2024-10-21 20:00:00', 'Theater play'),
       (38, 7, 150.00, '2024-10-22 07:00:00', 'Water bill'),
       (39, 8, 85.00, '2024-10-23 14:30:00', 'Shoes purchase'),
       (40, 10, 25.00, '2024-10-24 09:00:00', 'Charity donation'),
       (41, 13, 180.00, '2024-10-25 16:00:00', 'Life insurance premium'),
       (42, 12, 250.00, '2024-10-26 12:30:00', 'Investment in stocks'),
       (43, 14, 70.00, '2024-10-27 10:00:00', 'Pet boarding fees'),
       (44, 9, 40.00, '2024-10-28 15:00:00', 'Facial treatment'),
       (45, 1, 30.00, '2024-10-29 08:00:00', 'Lunch at work cafeteria'),
       (46, 5, 600.00, '2024-10-30 14:00:00', 'Professional certification'),
       (47, 15, 15.00, '2024-10-31 11:00:00', 'Movie streaming subscription'),
       (48, 2, 50.00, '2024-11-01 18:00:00', 'Monthly metro pass'),
       (49, 6, 1400.00, '2024-11-02 08:00:00', 'Rent payment');


INSERT INTO PaymentMethod (MethodName, MethodType)
VALUES ('Credit Card', 'Card'),
    ('Cash', 'Cash'),
    ('Bank Transfer', 'Electronic'),
    ('Debit Card', 'Card'),
    ('PayPal', 'Electronic'),
    ('Google Pay', 'Electronic'),
    ('Apple Pay', 'Electronic'),
    ('Cheque', 'Paper'),
    ('Cryptocurrency', 'Digital'),
    ('Mobile Banking', 'Electronic'),
    ('Prepaid Card', 'Card'),
    ('Gift Card', 'Card'),
    ('Direct Debit', 'Electronic'),
    ('Wire Transfer', 'Electronic'),
    ('Money Order', 'Paper'),
    ('Venmo', 'Electronic'),
    ('Amazon Pay', 'Electronic');
INSERT INTO Transaction (UserID, ExpenseID, PaymentMethodID, TransactionDate)
VALUES 
    (1, 1, 1, '2024-09-15 10:30:00'),
    (2, 2, 2, '2024-09-16 12:15:00'),
    (3, 3, 3, '2024-09-17 14:20:00'),
    (4, 4, 4, '2024-09-18 09:00:00'),
    (5, 5, 5, '2024-09-19 11:30:00'),
    (6, 6, 6, '2024-09-20 13:45:00'),
    (7, 7, 7, '2024-09-21 15:00:00'),
    (8, 8, 8, '2024-09-22 17:10:00'),
    (9, 9, 9, '2024-09-23 18:30:00'),
    (10, 10, 10, '2024-09-24 20:00:00'),
    (11, 11, 11, '2024-09-25 21:30:00'),
    (12, 12, 12, '2024-09-26 08:00:00'),
    (13, 13, 13, '2024-09-27 10:15:00'),
    (14, 14, 14, '2024-09-28 12:40:00'),
    (15, 15, 15, '2024-09-29 14:00:00'),
    (16, 16, 16, '2024-09-30 16:20:00'),
    (17, 17, 17, '2024-10-01 18:45:00'),
    (18, 18, 11, '2024-10-02 08:30:00'),
    (19, 19, 1, '2024-10-03 10:15:00'),
    (20, 20, 2, '2024-10-04 12:45:00'),
    (21, 21, 3, '2024-10-05 14:10:00'),
    (22, 22, 4, '2024-10-06 16:25:00'),
    (23, 23, 5, '2024-10-07 18:40:00'),
    (24, 24, 6, '2024-10-08 20:50:00'),
    (25, 25, 7, '2024-10-09 22:00:00'),
    (26, 26, 8, '2024-10-10 08:15:00'),
    (27, 27, 9, '2024-10-11 09:30:00'),
    (28, 28, 10, '2024-10-12 11:45:00'),
    (29, 29, 11, '2024-10-13 14:00:00'),
    (30, 30, 12, '2024-10-14 16:20:00'),
    (31, 31, 13, '2024-10-15 18:45:00'),
    (32, 32, 14, '2024-10-16 20:10:00'),
    (33, 33, 15, '2024-10-17 22:30:00'),
    (34, 34, 16, '2024-10-18 09:00:00'),
    (35, 35, 17, '2024-10-19 11:15:00'),
    (36, 36, 12, '2024-10-20 13:30:00'),
    (37, 37, 1, '2024-10-21 15:45:00'),
    (38, 38, 2, '2024-10-22 17:00:00'),
    (39, 39, 3, '2024-10-23 19:15:00'),
    (40, 40, 4, '2024-10-24 21:30:00'),
    (41, 41, 5, '2024-10-25 08:00:00'),
    (42, 42, 6, '2024-10-26 10:15:00'),
    (43, 43, 7, '2024-10-27 12:45:00'),
    (44, 44, 8, '2024-10-28 14:10:00'),
    (45, 45, 9, '2024-10-29 16:25:00'),
    (46, 46, 10, '2024-10-30 18:40:00'),
    (47, 47, 11, '2024-10-31 20:50:00'),
    (48, 48, 12, '2024-11-01 22:00:00'),
    (49, 49, 13, '2024-11-02 08:15:00');

-- Views
CREATE VIEW UserExpenseDetails AS
SELECT User.Name, Expense.Amount, Category.CategoryName, Expense.ExpenseDate, Expense.Description
FROM Expense
JOIN User ON Expense.UserID = User.UserID
JOIN Category ON Expense.CategoryID = Category.CategoryID;

-- 3. Triggers, Stored Procedures and Functions

DELIMITER $$

CREATE TRIGGER after_expense_insert
AFTER INSERT ON Expense
FOR EACH ROW
BEGIN
   UPDATE User
   SET TotalExpenses = TotalExpenses + NEW.Amount
   WHERE UserID = NEW.UserID;
END $$

DELIMITER ;

DELIMITER $$

CREATE PROCEDURE GetUserExpenses(IN in_UserID INT)
BEGIN
    SELECT * FROM Expense WHERE UserID = in_UserID;
END$$

DELIMITER ;

DELIMITER $$

CREATE FUNCTION CalculateMonthlyExpenses(in_UserID INT, in_Month INT)
RETURNS DECIMAL(10, 2)
DETERMINISTIC
BEGIN
    DECLARE Total DECIMAL(10, 2) DEFAULT 0;
    
    SELECT SUM(Amount) INTO Total
    FROM Expense
    WHERE UserID = in_UserID AND MONTH(Date) = in_Month;
    
    RETURN Total;
END$$

DELIMITER ;

-- SQL QUERIES
-- 1 People who are from New York
SELECT Name, Location FROM User WHERE Location = 'New York';
-- 2 Find the category with the most expenses
SELECT c.CategoryName, SUM(e.Amount) AS TotalSpending
FROM Expense e
JOIN Category c ON e.CategoryID = c.CategoryID
GROUP BY c.CategoryName
ORDER BY TotalSpending DESC
LIMIT 1;
-- 3 Transactions from a particular payment method
SELECT * FROM Transaction WHERE PaymentMethodID = 2;
-- 4 Amount spent in each category
SELECT c.CategoryName, SUM(e.Amount) AS TotalAmountSpent
FROM Expense e
JOIN Category c ON e.CategoryID = c.CategoryID
GROUP BY c.CategoryName;
-- 5 Most expensive expense for each user 
SELECT e.UserID, MAX(e.Amount) AS MaxExpense
FROM Expense e
GROUP BY e.UserID;
-- 6 Number of transactions for each payment method
SELECT pm.MethodName, COUNT(t.TransactionID) AS TransactionCount
FROM PaymentMethod pm
JOIN Transaction t ON pm.PaymentMethodID = t.PaymentMethodID
GROUP BY pm.MethodName;
-- 7 Average expense for each category
SELECT c.CategoryName, AVG(e.Amount) AS AverageExpense
FROM Expense e
JOIN Category c ON e.CategoryID = c.CategoryID
GROUP BY c.CategoryName;
-- 8 Most recent expense for each user
SELECT e.UserID, e.Amount, e.ExpenseDate
FROM Expense e
WHERE e.ExpenseDate = (
    SELECT MAX(ExpenseDate) 
    FROM Expense 
    WHERE UserID = e.UserID
);
-- 9 Total spending for each month
SELECT YEAR(e.ExpenseDate) AS Year, MONTH(e.ExpenseDate) AS Month, SUM(e.Amount) AS TotalSpending
FROM Expense e
GROUP BY YEAR(e.ExpenseDate), MONTH(e.ExpenseDate)
ORDER BY Year DESC, Month DESC;
-- 10 Users who have spent on more than 2 categories
SELECT u.Name
FROM User u
JOIN Expense e ON u.UserID = e.UserID
GROUP BY u.UserID
HAVING COUNT(DISTINCT e.CategoryID) > 2;
-- 11 User who spent on a specific category
SELECT UserID, u.Name, u.Location 
FROM User u
WHERE u.UserID IN (
    SELECT e.UserID 
    FROM Expense e 
    WHERE e.CategoryID = (
        SELECT CategoryID FROM Category WHERE CategoryName = 'Travel'
    )
);
-- 12 Users with above average spending
SELECT Name, TotalExpenses 
FROM User
WHERE TotalExpenses > (
    SELECT AVG(TotalExpenses) 
    FROM User
);
-- 13 Total spending per user
WITH UserExpenses AS (
    SELECT e.UserID, SUM(e.Amount) AS TotalSpending
    FROM Expense e
    GROUP BY e.UserID
)
SELECT u.Name, u.Location, ue.TotalSpending
FROM User u
JOIN UserExpenses ue ON u.UserID = ue.UserID
ORDER BY ue.TotalSpending DESC;
-- 14 Most popular payment method
SELECT pm.MethodName, COUNT(t.PaymentMethodID) AS UsageCount
FROM PaymentMethod pm
JOIN Transaction t ON pm.PaymentMethodID = t.PaymentMethodID
GROUP BY pm.MethodName
ORDER BY UsageCount DESC
LIMIT 1;
-- 15 Cumulative spending for each category
SELECT 
    c.CategoryName,
    SUM(e.Amount) AS TotalSpending,
    SUM(SUM(e.Amount)) OVER (ORDER BY SUM(e.Amount) DESC) AS CumulativeSpending
FROM Expense e
JOIN Category c ON e.CategoryID = c.CategoryID
GROUP BY c.CategoryName
ORDER BY TotalSpending DESC;
-- 16 Users and categories they have spent on
SELECT u.Name AS UserName, c.CategoryName, SUM(e.Amount) AS TotalCategorySpending
FROM User u
JOIN Expense e ON u.UserID = e.UserID
JOIN Category c ON e.CategoryID = c.CategoryID
GROUP BY u.Name, c.CategoryName
ORDER BY u.Name, TotalCategorySpending DESC;
-- 17 Monthly spending per user
SELECT 
    u.Name AS UserName, 
    DATE_FORMAT(e.ExpenseDate, '%Y-%m') AS Month, 
    SUM(e.Amount) AS MonthlySpending
FROM User u
JOIN Expense e ON u.UserID = e.UserID
GROUP BY u.Name, Month
ORDER BY u.Name, Month;
-- 18 Category spending as a percentage of total expenses
WITH CategorySpending AS (
    SELECT c.CategoryName, SUM(e.Amount) AS TotalCategorySpending
    FROM Expense e
    JOIN Category c ON e.CategoryID = c.CategoryID
    GROUP BY c.CategoryName
),
TotalSpending AS (
    SELECT SUM(TotalCategorySpending) AS GrandTotal
    FROM CategorySpending
)
SELECT cs.CategoryName, 
       cs.TotalCategorySpending, 
       ROUND((cs.TotalCategorySpending / ts.GrandTotal) * 100, 2) AS PercentageOfTotal
FROM CategorySpending cs, TotalSpending ts
ORDER BY PercentageOfTotal DESC;

-- 19 Payment method used most often by each user 
SELECT u.Name, pm.MethodName, COUNT(t.TransactionID) AS UsageCount
FROM Transaction t
JOIN PaymentMethod pm ON t.PaymentMethodID = pm.PaymentMethodID
JOIN User u ON t.UserID = u.UserID
GROUP BY u.UserID, pm.MethodName
HAVING COUNT(t.TransactionID) = (
    SELECT MAX(UsageCount)
    FROM (
        SELECT COUNT(t1.TransactionID) AS UsageCount
        FROM Transaction t1
        WHERE t1.UserID = u.UserID
        GROUP BY t1.PaymentMethodID
    ) AS SubQuery
)
ORDER BY u.Name;


