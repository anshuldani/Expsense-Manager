# 💰 Expense Manager Dashboard

An **interactive, SQL-driven budgeting app** built with **Python** and **Streamlit**.  
The Expense Manager Dashboard helps you **track, analyze, and optimize your spending** with real-time data visualization and expense management.

🔗 **Demo Video:** [Watch on Loom](https://www.loom.com/share/7c9451878339429491e6561db40033d9?sid=31c6ebb0-6242-4d8f-b4c6-0ba85c8bd260)

---

## 🔎 Overview
The Expense Manager Dashboard is a **web-based application** built with **Streamlit** and **MySQL**. It provides tools for users and administrators to:
- View registered users
- Analyse individual and category-wise expenses
- Add new expenses to the database
- Visualise data interactively with charts

---

## ✨ Features
- **🏠 Home Page** → Overview of the app and About section  
- **👥 View Users** → Table of registered users (UserID, Name, Email, Location)  
- **📊 Get User Expenses** → View all expenses for a specific user via stored procedure  
- **📂 Category Expenses** → Visualize expenses per category with charts + tables  
- **➕ Add Expense** → Insert new expense entries into the database  

---

## 🛠️ Prerequisites
- **Python 3.8+**
- **MySQL Server** (running locally or remotely)
- Database: `ExpenseManager_Final`

Python dependencies:
```bash
pip install streamlit mysql-connector-python
````

---

## ⚙️ Setup and Installation

### 1️⃣ Set Up the Database

Run the following SQL commands in MySQL:

```sql
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
```

### 2️⃣ Update Database Connection

In `app.py`, update the MySQL credentials in the connection function:

```python
connection = mysql.connector.connect(
    host="localhost",
    port="3306",
    user="root",
    password="your-password",
    database="ExpenseManager_Final"
)
```

---

## ▶️ Running the Application

Start the Streamlit server:

```bash
streamlit run app.py
```

---

## 📘 Usage Guide

### 🏠 Home Page

* Overview of the app + About Us section

### 👥 View Users

* Displays all registered users in a table
* Columns: `UserID`, `Name`, `Email`, `Location`

### 📊 Get User Expenses

* Select a user by `UserID`
* Displays all expenses using **GetUserExpenses** stored procedure

### 📂 Category Expenses

* Bar chart of total expenses by category
* Table with category-wise breakdown

### ➕ Add Expense

* Input: `UserID`, `CategoryID`, `Amount`, `Description`
* Inserts a new expense entry into the database

---

## 🛠️ Troubleshooting

* **Error Connecting to Database** → Check MySQL credentials and ensure DB schema exists
* **Streamlit Not Found** → Install with `pip install streamlit`
* **Port Already in Use** → Run on another port:

  ```bash
  streamlit run app.py --server.port=8502
  ```

---

## 👨‍💻 Contributors

* **Anshul Dani**
