# Employee-Management-Portal-EMP-
Robust Java EE web application for employee management featuring secure login, dynamic employee ID and login ID generation, DOB validation, PDF file uploads, and smart search with filters and remote pagination — built with JSP, Servlets, Oracle DB, and JavaScript.
This is a full-stack Java web application built using JSP/Servlets, Oracle Database, HTML/CSS/JavaScript, and JDBC. It provides complete functionality for user login, employee registration, employee search, and management features.

📌 Features
🔐 User Login
Login page with username and password.

Credentials validation against Oracle DB.

Redirects to employee search page upon successful login.

👨‍💼 Employee Addition
Auto-generated Employee ID with format EMPXX1.

Login ID: Automatically generated using the first letter of first name and full last name. If duplicate exists, a 3-digit random number is appended.

Fields:

First Name

Last Name

Middle Name

Date of Birth (with DD-MMM-YYYY format and date picker)

Department (Dropdown: Engineering, Support, HR, Finance)

Salary

Permanent Address

Current Address

ID Proof Upload (PDF only, 10KB–1MB size validation)

DOB Validation: Age must be greater than 18 years.

🔍 Employee Search
Search filters:

Employee ID

First Name

Last Name

Login ID

Date of Birth (Range)

Department

Search Results:

Grid with remote pagination

Selectable records for multi-delete

Columns: Employee ID, First Name, Last Name, Login ID, DOB, Department, Salary

View: Shows complete employee details

Edit: Allows modification of uploaded documents

Delete: Remove employee entry

History (if implemented): View historical changes for an employee

