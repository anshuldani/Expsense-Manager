#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Fri Oct 25 12:07:17 2024
@author: anshuldani
"""

import mysql.connector
from mysql.connector import Error, ProgrammingError

# Function to establish a connection to the MySQL database
def create_connection():
    try:
        # Define connection parameters and attempt to connect to the database
        connection = mysql.connector.connect(
            host='localhost',
            port='3306',
            user='root',
            password='Anshuldani@k77',
            database='ExpenseManager'
        )
        return connection
    except Error as e:
        # Print any connection error
        print(f"Error: '{e}' occurred")
        return None

# Function to create a new user in the database
def create_user(connection):
    try:
        # Prompt user for input to create a new user entry
        name = input("Enter Name: ")
        email = input("Enter Email: ")
        
        # Validate email format
        if '@' not in email:
            print("Error: Invalid email format. Please ensure it contains '@'.")
            return
        
        password = input("Enter Password: ")
        
        # Validate age input
        try:
            age = int(input("Enter Age: "))
        except ValueError:
            print("Error: Age must be a numeric value.")
            return
        
        # Validate gender input
        gender = input("Enter Gender (Male/Female): ").strip().lower()
        if gender not in ['male', 'female']:
            print("Error: Invalid gender. Please enter 'Male' or 'Female'.")
            return
        
        location = input("Enter Location: ")

        # SQL query to insert a new user record
        query = """
        INSERT INTO User (Name, Email, Password, Age, Gender, Location)
        VALUES (%s, %s, %s, %s, %s, %s)
        """
        cursor = connection.cursor()
        cursor.execute(query, (name, email, password, age, gender, location))
        connection.commit()
        print("User created successfully.")
    except (ValueError, ProgrammingError) as e:
        print(f"Error: {e}. Please ensure your input is correct.")
    except Error as e:
        print(f"Database error: {e}")

# Function to fetch and display all users
def read_users(connection):
    try:
        # SQL query to select all users
        query = "SELECT * FROM User"
        cursor = connection.cursor()
        cursor.execute(query)
        users = cursor.fetchall()
        
        # Display all users in the database
        print("User List:")
        for user in users:
            print(user)
    except Error as e:
        print(f"Database error: {e}")

# Function to update a user's location in the database
def update_user_location(connection):
    try:
        # Prompt user to enter the ID and the new location
        user_id = int(input("Enter UserID: "))
        new_location = input("Enter New Location: ")
        
        # SQL query to update the user's location
        query = "UPDATE User SET Location = %s WHERE UserID = %s"
        cursor = connection.cursor()
        cursor.execute(query, (new_location, user_id))
        connection.commit()
        print("User location updated.")
    except ValueError:
        print("Invalid input for UserID. Please enter a numeric value.")
    except Error as e:
        print(f"Database error: {e}")

# Function to delete a user from the database
def delete_user(connection):
    try:
        # Prompt user to enter the ID of the user to delete
        user_id = int(input("Enter UserID: "))
        query = "DELETE FROM User WHERE UserID = %s"
        cursor = connection.cursor()
        cursor.execute(query, (user_id,))
        connection.commit()
        print("User deleted.")
    except ValueError:
        print("Invalid input for UserID. Please enter a numeric value.")
    except Error as e:
        print(f"Database error: {e}")

# Function to retrieve expenses for a specific user using a stored procedure
def get_user_expenses(connection):
    try:
        # Prompt user to enter the ID of the user whose expenses they want to fetch
        user_id = int(input("Enter UserID to fetch expenses: "))
        query = "CALL GetUserExpenses(%s)"
        cursor = connection.cursor()
        cursor.execute(query, (user_id,))
        expenses = cursor.fetchall()
        
        # Display all expenses for the given user
        print("Expenses for UserID:", user_id)
        for expense in expenses:
            expense_id = expense[0]
            user_id = expense[1]
            category_id = expense[2]
            amount = float(expense[3])  # Convert Decimal to float for readability
            expense_date = expense[4].strftime("%Y-%m-%d %H:%M:%S")  # Format datetime
            description = expense[5]
            print(f"ExpenseID: {expense_id}, UserID: {user_id}, CategoryID: {category_id}, Amount: ${amount:.2f}, Date: {expense_date}, Description: {description}")
    except ValueError:
        print("Invalid input for UserID. Please enter a numeric value.")
    except Error as e:
        print(f"Database error: {e}")

# OLAP Query: Function to display total expenses grouped by user and category
def total_expenses_by_user_and_category(connection):
    try:
        # SQL query to aggregate expenses by user and category
        query = """
        SELECT User.Name, Category.CategoryName, SUM(Expense.Amount) AS TotalAmount
        FROM Expense
        JOIN User ON Expense.UserID = User.UserID
        JOIN Category ON Expense.CategoryID = Category.CategoryID
        GROUP BY User.Name, Category.CategoryName
        ORDER BY User.Name, Category.CategoryName
        """
        cursor = connection.cursor()
        cursor.execute(query)
        results = cursor.fetchall()
        
        # Display total expenses grouped by user and category
        print("Total Expenses by User and Category:")
        for row in results:
            print(f"User: {row[0]}, Category: {row[1]}, Total Amount: ${row[2]:.2f}")
    except Error as e:
        print(f"Database error: {e}")

# OLAP Query 1: Function to display total expenses by category
def total_expenses_per_category(connection):
    try:
        # SQL query to aggregate expenses by category
        query = """
        SELECT Category.CategoryName, SUM(Expense.Amount) AS TotalAmount
        FROM Expense
        JOIN Category ON Expense.CategoryID = Category.CategoryID
        GROUP BY Category.CategoryName
        ORDER BY TotalAmount DESC
        """
        cursor = connection.cursor()
        cursor.execute(query)
        results = cursor.fetchall()
        
        # Display total expenses per category
        print("Total Expenses per Category:")
        for row in results:
            print(f"Category: {row[0]}, Total Amount: ${row[1]:.2f}")
    except Error as e:
        print(f"Database error: {e}")

# OLAP Query 2: Function to display monthly expenses per user
def monthly_expenses_per_user(connection):
    try:
        # SQL query to aggregate expenses by user and month
        query = """
        SELECT User.Name, MONTH(Expense.ExpenseDate) AS ExpenseMonth, SUM(Expense.Amount) AS TotalAmount
        FROM Expense
        JOIN User ON Expense.UserID = User.UserID
        GROUP BY User.Name, ExpenseMonth
        ORDER BY User.Name, ExpenseMonth
        """
        cursor = connection.cursor()
        cursor.execute(query)
        results = cursor.fetchall()
        
        # Display monthly expenses per user
        print("Monthly Expenses per User:")
        for row in results:
            print(f"User: {row[0]}, Month: {row[1]}, Total Amount: ${row[2]:.2f}")
    except Error as e:
        print(f"Database error: {e}")

# OLAP Query 3: Function to display average expenses by payment method
def average_expense_per_payment_method(connection):
    try:
        # SQL query to calculate average expenses by payment method
        query = """
        SELECT PaymentMethod.MethodName, AVG(Expense.Amount) AS AverageAmount
        FROM Transaction
        JOIN Expense ON Transaction.ExpenseID = Expense.ExpenseID
        JOIN PaymentMethod ON Transaction.PaymentMethodID = PaymentMethod.PaymentMethodID
        GROUP BY PaymentMethod.MethodName
        ORDER BY AverageAmount DESC
        """
        cursor = connection.cursor()
        cursor.execute(query)
        results = cursor.fetchall()
        
        # Display average expenses per payment method
        print("Average Expense per Payment Method:")
        for row in results:
            print(f"Payment Method: {row[0]}, Average Amount: ${row[1]:.2f}")
    except Error as e:
        print(f"Database error: {e}")

# Main function to display the menu and process user choices
def main():
    # Establish connection to the database
    connection = create_connection()
    if connection is None:
        print("Failed to connect to the database.")
        return
    
    # Menu loop for user interaction
    while True:
        print("\nExpense Manager CLI")
        print("1. Create User")
        print("2. View Users")
        print("3. Update User Location")
        print("4. Delete User")
        print("5. Get User Expenses")
        print("6. Total Expenses by User and Category")
        print("7. Total Expenses per Category (OLAP)")
        print("8. Monthly Expenses per User (OLAP)")
        print("9. Average Expense per Payment Method (OLAP)")
        print("10. Exit")
        
        # Take user input for menu choice
        choice = input("Enter your choice: ")
        
        # Execute the selected action
        if choice == '1':
            create_user(connection)
        elif choice == '2':
            read_users(connection)
        elif choice == '3':
            update_user_location(connection)
        elif choice == '4':
            delete_user(connection)
        elif choice == '5':
            get_user_expenses(connection)
        elif choice == '6':
            total_expenses_by_user_and_category(connection)  # Updated function
        elif choice == '7':
            total_expenses_per_category(connection)
        elif choice == '8':
            monthly_expenses_per_user(connection)
        elif choice == '9':
            average_expense_per_payment_method(connection)
        elif choice == '10':
            # Close the database connection before exiting
            if connection.is_connected():
                connection.close()
                print("Connection closed.")
            break
        else:
            print("Invalid choice, please try again.")

# Run the main function if the script is executed directly
if __name__ == "__main__":
    main()
