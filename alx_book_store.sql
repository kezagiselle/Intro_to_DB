import mysql.connector

-- //database connection setup

mydb = mysql.connector.connect(
  host="localhost",
  user="root",
  password="Gisele12345@",
)

mycursor = mydb.cursor()

-- create the database
mycursor.execute("CREATE DATABASE IF NOT EXISTS alx_book_store")    
mycursor.execute("USE alx_book_store")

-- create tables

mycursor.execute("""
CREATE TABLE IF NOT EXISTS Authors (
    author_id INT AUTO_INCREMENT PRIMARY KEY,
    author_name VARCHAR(100) NOT NULL
)
""")

mycursor.execute("""
CREATE TABLE IF NOT EXISTS Books (
    book_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(200) NOT NULL,
    author_id INT,
    price DOUBLE,
    publication_date DATE,
    FOREIGN KEY (author_id) REFERENCES Authors(author_id)
)
""")

mycursor.execute("""
CREATE TABLE IF NOT EXISTS Customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL UNIQUE
    address TEXT
)
""")

mycursor.execute("""
CREATE TABLE IF NOT EXISTS Order_Details (
    orderdetailid INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    book_id INT,
    quantity DOUBLE,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (book_id) REFERENCES Books(book_id
)
""")

print("All tables created successfully!")


# Insert authors
sql = "INSERT INTO Authors (author_name) VALUES (%s)"
authors = [("J.K. Rowling",), ("George R.R. Martin",), ("Chinua Achebe",)]
mycursor.executemany(sql, authors)
mydb.commit()
print(f"{mycursor.rowcount} author(s) inserted.")

# Insert books
sql = "INSERT INTO Books (title, author_id, price, publication_date) VALUES (%s, %s, %s, %s)"
books = [
    ("Harry Potter and the Philosopher's Stone", 1, 20.99, "1997-06-26"),
    ("A Game of Thrones", 2, 25.50, "1996-08-06"),
    ("Things Fall Apart", 3, 15.75, "1958-06-17"),
]
mycursor.executemany(sql, books)
mydb.commit()
print(f"{mycursor.rowcount} book(s) inserted.")

# Insert customers
sql = "INSERT INTO Customers (customer_name, email, address) VALUES (%s, %s, %s)"
customers = [
    ("Alice Johnson", "alice@example.com", "123 Main Street"),
    ("Bob Smith", "bob@example.com", "456 Oak Avenue")
]
mycursor.executemany(sql, customers)
mydb.commit()
print(f"{mycursor.rowcount} customer(s) inserted.")

# Insert orders
sql = "INSERT INTO Orders (customer_id, order_date) VALUES (%s, %s)"
orders = [(1, "2025-10-24"), (2, "2025-10-23")]
mycursor.executemany(sql, orders)
mydb.commit()
print(f"{mycursor.rowcount} order(s) inserted.")

# Insert order details
sql = "INSERT INTO Order_Details (order_id, book_id, quantity) VALUES (%s, %s, %s)"
order_details = [(1, 1, 2), (1, 3, 1), (2, 2, 1)]
mycursor.executemany(sql, order_details)
mydb.commit()
print(f"{mycursor.rowcount} order detail record(s) inserted.")

# -------------------------------
# Read data (example)
# -------------------------------
print("\n📚 All Books:")
mycursor.execute("""
SELECT Books.title, Authors.author_name, Books.price
FROM Books
JOIN Authors ON Books.author_id = Authors.author_id
""")
for row in mycursor.fetchall():
    print(row)

# -------------------------------
# Update a book price
# -------------------------------
sql = "UPDATE Books SET price = %s WHERE book_id = %s"
mycursor.execute(sql, (22.99, 1))
mydb.commit()
print(f"\n{mycursor.rowcount} book record(s) updated.")

# -------------------------------
# Delete a customer (example)
# -------------------------------
sql = "DELETE FROM Customers WHERE customer_id = %s"
mycursor.execute(sql, (2,))
mydb.commit()
print(f"{mycursor.rowcount} customer record(s) deleted.")

# -------------------------------
# Close connections
# -------------------------------
mycursor.close()
mydb.close()
print("\n✅ Database connection closed.")