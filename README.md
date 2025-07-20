README: Expense Manager Dashboard

This README provides detailed information on setting up, running, and using the Expense Manager Dashboard, a Streamlit application for managing and visualizing user expenses.


Table of Contents:
1. Overview
2. Features
3. Prerequisites
4. Setup and Installation
5. Database Schema
6. Running the Application
7. Usage Guide
8. Troubleshooting
9. Contributors


Overview:
The Expense Manager Dashboard is a web-based application built with Streamlit and MySQL. It provides users and administrators with tools to:
* View registered users.
* View individual user expenses.
* Analyze category-wise expenses.
* Add new expenses to the database.



Features:
1. Home Page: Introduction to the application and its purpose.
2. View Users: Displays a table of all users in the database.
3. Get User Expenses: View all expenses for a selected user.
4. Category Expenses: Analyze total expenses by category with visualizations.
5. Add Expense: Add a new expense entry to the database.


Prerequisites:
* Python 3.8+ installed on your machine.
* MySQL Server installed and running.
* A database named `ExpenseManager_Final` with the correct schema.



Setup and Installation:



1. Install Dependencies

Install the required Python libraries:
* Streamlit
* MySQLConnector

2. Set Up the Database

Ensure your MySQL server is running and execute the following SQL commands to create the necessary schema

sql
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

3. Update the Database Connection
Modify the `create_connection` function in the script to match your MySQL credentials:
python -
connection = mysql.connector.connect(
    host="localhost",  
    port="3306",
    user="root",        
    password="your-password", 
    database="ExpenseManager_Final" 
)


4. Running the Application:
Run the Streamlit app with the following command:

streamlit run app.py

This will launch a local web server. To use the application, open the URL (usually `http://localhost:8501`) in your browser.




Usage Guide:

1. Home Page
* Provides an overview of the app's purpose and a link to an About Us section.

2. View Users
* Displays a table of all users registered in the database.
* Columns include UserID, Name, Email, and Location.

3. Get User Expenses
* Allows selecting a user by ID and displays all associated expenses.
* The data is fetched using the `GetUserExpenses` stored procedure.

4. Category Expenses
* Displays a bar chart summarizing total expenses by category.
* Provides a detailed breakdown in a table format.

5. Add Expense
* Enables adding a new expense entry.
* Inputs include User ID, Category ID, Expense Amount, and Description.


Troubleshooting:
1. Error Connecting to the Database
* Verify your MySQL credentials and ensure the database server is running.
* Ensure the database `ExpenseManager_Final` exists and matches the schema provided.

2. Streamlit Not Found 
   Ensure Streamlit is installed by running:
     
     pip install streamlit
     

3. Port Already in Use
    Run the app on a different port:
     
     streamlit run app.py --server.port=8502
     


LOOM VIDEO LINK : https://www.loom.com/share/7c9451878339429491e6561db40033d9?sid=31c6ebb0-6242-4d8f-b4c6-0ba85c8bd260

Contributor:
Anshul Dani
