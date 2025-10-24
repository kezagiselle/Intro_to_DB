import mysql.connector

try:
    # Try connecting to MySQL Server
    mydb = mysql.connector.connect(
        host="localhost",
        user="root",              # 👈 replace with your MySQL username
        password="Gisele12345@"   # 👈 replace with your MySQL password
    )

    if mydb.is_connected():
        mycursor = mydb.cursor()

        # Create database if not exists
        mycursor.execute("CREATE DATABASE IF NOT EXISTS alx_book_store")
        print("Database 'alx_book_store' created successfully!")

except mysql.connector.Error as e:
    print("❌ Error while connecting to MySQL:", e)

finally:
    # Always close the connection
    if 'mydb' in locals() and mydb.is_connected():
        mycursor.close()
        mydb.close()
        print("MySQL connection closed.")
