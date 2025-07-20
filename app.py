import streamlit as st
import mysql.connector
from mysql.connector import Error

# Function to create a database connection
def create_connection():
    try:
        connection = mysql.connector.connect(
            host="localhost",  # Change to your database host
            port="3306",
            user="root",        # Replace with your MySQL username
            password="Anshuldani@k77",# Replace with your MySQL password
            database="ExpenseManager_Final" # Replace with your database name
        )
        return connection
    except Error as e:
        st.error(f"Error connecting to the database: {e}")
        return None

# Fetch users from the database
def fetch_users():
    try:
        connection = create_connection()
        if connection:
            cursor = connection.cursor(dictionary=True)
            cursor.execute("SELECT UserID as id, Name as name, Email as email, Location as location FROM User;")
            users = cursor.fetchall()
            connection.close()
            return users
    except Error as e:
        st.error(f"Error fetching users: {e}")
        return []

# Fetch user expenses from the database
def fetch_user_expenses(user_id):
    try:
        connection = create_connection()
        if connection:
            cursor = connection.cursor()
            cursor.execute("CALL GetUserExpenses(%s);", (user_id,))
            expenses = cursor.fetchall()
            connection.close()
            return expenses
    except Error as e:
        st.error(f"Error fetching user expenses: {e}")
        return []

# Fetch category-wise expenses from the database
def fetch_category_expenses():
    try:
        connection = create_connection()
        if connection:
            cursor = connection.cursor()
            cursor.execute("""
                SELECT c.CategoryName, SUM(e.Amount) AS Total
                FROM Expense e
                JOIN Category c ON e.CategoryID = c.CategoryID
                GROUP BY c.CategoryName;
            """)
            category_expenses = cursor.fetchall()
            connection.close()
            return category_expenses
    except Error as e:
        st.error(f"Error fetching category expenses: {e}")
        return []

# Add a new expense to the database
def add_expense(user_id, category_id, amount, description):
    try:
        connection = create_connection()
        if connection:
            cursor = connection.cursor()
            cursor.execute("""
                INSERT INTO Expense (UserID, CategoryID, Amount, ExpenseDate, Description)
                VALUES (%s, %s, %s, NOW(), %s);
            """, (user_id, category_id, amount, description))
            connection.commit()
            connection.close()
            st.success("Expense added successfully!")
    except Error as e:
        st.error(f"Error adding expense: {e}")

# Streamlit app starts here
st.set_page_config(page_title="Expense Manager Dashboard", layout="wide")
st.title("Expense Manager Dashboard")

# Sidebar menu
menu = st.sidebar.radio(
    "Navigate",
    ["Home", "View Users", "Get User Expenses", "Category Expenses", "Add Expense"]
)

# Home Page
if menu == "Home":
    #st.image("https://via.placeholder.com/800x200.png?text=Expense+Manager", use_container_width=True)
    st.subheader("Welcome to the Expense Manager Dashboard!")
    st.write("Explore features like viewing users, managing expenses, and analyzing spending trends.")
    if st.button("About Us"):
        st.info("This dashboard helps manage and visualize expenses efficiently.")

# View Users
elif menu == "View Users":
    st.subheader("Users in the Database")
    users = fetch_users()
    if users:
        st.table(users)
    else:
        st.warning("No users found in the database.")

# Get User Expenses
elif menu == "Get User Expenses":
    st.subheader("View User Expenses")
    users = fetch_users()
    user_id = st.selectbox("Select User", [user["id"] for user in users])
    if st.button("Get Expenses"):
        expenses = fetch_user_expenses(user_id)
        if expenses:
            st.write(f"Expenses for User ID {user_id}:")
            for expense in expenses:
                st.write(f"{expense[0]}: ${expense[1]:.2f}")
        else:
            st.warning("No expenses found for this user.")

# Category Expenses
elif menu == "Category Expenses":
    st.subheader("Total Expenses by Category")
    category_expenses = fetch_category_expenses()
    if category_expenses:
        st.bar_chart(
            {category[0]: category[1] for category in category_expenses}
        )
        st.write("**Detailed Breakdown**")
        st.table(category_expenses)
    else:
        st.warning("No category expenses found.")

# Add Expense
elif menu == "Add Expense":
    st.subheader("Add a New Expense")
    users = fetch_users()
    user_id = st.selectbox("Select User", [user["id"] for user in users])
    category_id = st.number_input("Enter Category ID", min_value=1, step=1)
    amount = st.number_input("Expense Amount", min_value=0.0, step=0.1)
    description = st.text_input("Expense Description")
    if st.button("Add Expense"):
        add_expense(user_id, category_id, amount, description)

# Footer
st.sidebar.markdown("---")
st.sidebar.markdown("**Expense Manager v1.0**")
st.sidebar.markdown("© 2024, DBO GROUP 11")
