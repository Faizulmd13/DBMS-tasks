import tkinter as tk
import mysql.connector

# Create a database connection
connection = mysql.connector.connect(
    host="localhost",
    user="root",
    password="",
    database="user_contacts"
)
cursor = connection.cursor()

# Create a table to store contacts
cursor.execute("""
CREATE TABLE IF NOT EXISTS user_details (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE,
    phone VARCHAR(255) NOT NULL
)
""")
connection.commit()

# Function to add a new contact
def add_contact():
    name = name_entry.get()
    email = email_entry.get()
    phone = phone_entry.get()
    cursor.execute("""
        INSERT INTO user_details (name, email, phone)
        VALUES (%s, %s, %s)
    """, (name, email, phone))
    connection.commit()
    clear_entries()
    show_contacts()

# Function to delete a contact
def delete_contact():
    selected_contact = contact_listbox.get(tk.ACTIVE)
    contact_id = selected_contact.split(".")[0]
    cursor.execute("DELETE FROM user_details WHERE id=%s", (contact_id,))
    connection.commit()
    show_contacts()

# Function to update a contact
def update_contact():
    selected_contact = contact_listbox.get(tk.ACTIVE)
    contact_id = selected_contact.split(".")[0]
    name = name_entry.get()
    email = email_entry.get()
    phone = phone_entry.get()
    cursor.execute("""
        UPDATE user_details
        SET name=%s, email=%s, phone=%s
        WHERE id=%s
    """, (name, email, phone, contact_id))
    connection.commit()
    clear_entries()
    show_contacts()

# Function to show contacts
def show_contacts():
    cursor.execute("SELECT * FROM user_details")
    contacts = cursor.fetchall()
    contact_listbox.delete(0, tk.END)
    for contact in contacts:
        contact_listbox.insert(tk.END, f"{contact[0]}. {contact[1]}")

# Function to fill entries with selected contact details
def fill_entries(event):
    selected_contact = contact_listbox.get(tk.ACTIVE)
    contact_id = selected_contact.split(".")[0]
    cursor.execute("SELECT * FROM user_details WHERE id=%s", (contact_id,))
    contact = cursor.fetchone()
    clear_entries()
    name_entry.insert(tk.END, contact[1])
    email_entry.insert(tk.END, contact[2])
    phone_entry.insert(tk.END, contact[3])

# Function to clear input fields
def clear_entries():
    name_entry.delete(0, tk.END)
    email_entry.delete(0, tk.END)
    phone_entry.delete(0, tk.END)

# GUI Setup
root = tk.Tk()
root.title("Contact Management System")

# Input fields
tk.Label(root, text="Name:").pack()
name_entry = tk.Entry(root)
name_entry.pack()

tk.Label(root, text="Email:").pack()
email_entry = tk.Entry(root)
email_entry.pack()

tk.Label(root, text="Phone:").pack()
phone_entry = tk.Entry(root)
phone_entry.pack()

# Buttons
tk.Button(root, text="Add Contact", command=add_contact).pack()
tk.Button(root, text="Update Contact", command=update_contact).pack()
tk.Button(root, text="Delete Contact", command=delete_contact).pack()

# Contact list
contact_listbox = tk.Listbox(root)
contact_listbox.pack()
contact_listbox.bind("<<ListboxSelect>>", fill_entries)

# Initial population of contact list
show_contacts()

# Start GUI loop
root.mainloop()

# Close the database connection after GUI closes
connection.close()

