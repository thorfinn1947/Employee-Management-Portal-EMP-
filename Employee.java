package com.nit.DBSERVLET;

public class Employee {
    private String empId;
    private String firstName;
    private String lastName;
    private String loginId;
    private String dob; // Use String for simplicity, ideally Date
    private String department;
    private double salary;

    // Constructor
    public Employee(String empId, String firstName, String lastName, String loginId, String password, String dob, String department, double salary) {
        this.empId = empId;
        this.firstName = firstName;
        this.lastName = lastName;
        this.loginId = loginId;
        this.dob = dob;
        this.department = department;
        this.salary = salary;
    }

    // Getters and Setters

    public String getEmpId() { return empId; }
    public void setEmpId(String empId) { this.empId = empId; }

    public String getFirstName() { return firstName; }
    public void setFirstName(String firstName) { this.firstName = firstName; }

    public String getLastName() { return lastName; }
    public void setLastName(String lastName) { this.lastName = lastName; }

    public String getLoginId() { return loginId; }
    public void setLoginId(String loginId) { this.loginId = loginId; }



    public String getDob() { return dob; }
    public void setDob(String dob) { this.dob = dob; }

    public String getDepartment() { return department; }
    public void setDepartment(String department) { this.department = department; }

    public double getSalary() { return salary; }
    public void setSalary(double salary) { this.salary = salary; }
}
