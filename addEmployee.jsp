<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<title>Add Employee</title>
<style>
  body {
    font-family: Arial, sans-serif;
    background: red;
    color: #eee;
    display: flex;
    justify-content: center;
    align-items: center;
    min-height: 100vh;
    margin: 0;
  }
  h2{
 margin-left: 180px;
  }
  form {
    background: #333;
    padding: 20px;
    border-radius: 8px;
    box-shadow:0 0 18px rgba(0,0,0,6);
    width: 600px;
     animation: fadeIn 1.8s ease-in-out;
  }
  label {
    display: block;
    margin-top: 12px;
  }
  input, select, textarea {
    width: 100%;
    padding: 6px;
    margin-top: 4px;
    border-radius: 4px;
    border: none;
    background: #444;
    color: #eee;
  }
  input[readonly] {
    background: #555;
  }
  button {
    margin-top: 20px;
    width: 100%;
    padding: 10px;
    border: none;
    border-radius: 5px;
    background: #0ef;
    font-weight: bold;
    cursor: pointer;
  }
  .error {
    color: #f55;
    margin-top: 10px;
  }
  .message {
    margin-top: 10px;
    text-align: center;
  }
   @keyframes fadeIn {
      from { opacity: 0; transform: translateY(20px); }
      to { opacity: 1; transform: translateY(0); }
    }
  
</style>
<script>
  function generateEmpId() {
    const letters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    let id = "";
    for(let i=0; i<5; i++) {
      id += letters.charAt(Math.floor(Math.random() * letters.length));
    }
    id += Math.floor(Math.random() * 10);
    return id;
  }

  function generateLoginId() {
    const firstName = document.getElementById('firstName').value.trim().toLowerCase();
    const lastName = document.getElementById('lastName').value.trim().toLowerCase();
    if(firstName && lastName) {
      const randomNum = Math.floor(100 + Math.random() * 900);
      return firstName.charAt(0) + lastName + randomNum;
    }
    return "";
  }

  function validateAge() {
    const dobInput = document.getElementById('dob');
    const dob = new Date(dobInput.value);
    if (!dobInput.value) return false;

    const today = new Date();
    let age = today.getFullYear() - dob.getFullYear();
    const m = today.getMonth() - dob.getMonth();
    if(m < 0 || (m === 0 && today.getDate() < dob.getDate())) {
      age--;
    }
    return age >= 18;
  }

  function onFormSubmit(event) {
    if(!validateAge()) {
      event.preventDefault();
      document.getElementById('ageError').textContent = "Employee must be at least 18 years old.";
      return false;
    } else {
      document.getElementById('ageError').textContent = "";
    }

    const password = document.getElementById('password').value;
    const confirmPassword = document.getElementById('confirmPassword').value;

    if (password !== confirmPassword) {
      event.preventDefault();
      document.getElementById('passwordError').textContent = "Passwords do not match.";
      return false;
    } else {
      document.getElementById('passwordError').textContent = "";
    }
  }

  window.onload = function() {
    document.getElementById('empId').value = generateEmpId();

    const updateLoginId = () => {
      document.getElementById('loginId').value = generateLoginId();
    };
    document.getElementById('firstName').addEventListener('input', updateLoginId);
    document.getElementById('lastName').addEventListener('input', updateLoginId);

    updateLoginId();
    document.getElementById('employeeForm').addEventListener('submit', onFormSubmit);
  };
</script>
</head>
<body>

<form id="employeeForm" method="post" enctype="multipart/form-data" action="${pageContext.request.contextPath}/AddEmployeeServlet">
  <h2>Register Employee</h2>

  <label for="empId">Employee ID</label>
  <input type="text" id="empId" name="empId" readonly />

  <label for="firstName">First Name</label>
  <input type="text" id="firstName" name="firstName" required />

  <label for="middleName">Middle Name</label>
  <input type="text" id="middleName" name="middleName" />

  <label for="lastName">Last Name</label>
  <input type="text" id="lastName" name="lastName" required />

  <label for="dob">Date of Birth</label>
  <input type="date" id="dob" name="dob" required />
  <div id="ageError" class="error"></div>

  <label for="department">Department</label>
  <select id="department" name="department" required>
    <option value="">--Select Department--</option>
    <option value="Engineering">Engineering</option>
    <option value="Support">Support</option>
    <option value="HR">HR</option>
    <option value="Finance">Finance</option>
  </select>

  <label for="loginId">Login ID</label>
  <input type="text" id="loginId" name="loginId" readonly />

  <label for="password">Password</label>
  <input type="password" id="password" name="password" required />

  <label for="confirmPassword">Confirm Password</label>
  <input type="password" id="confirmPassword" name="confirmPassword" required />
  <div id="passwordError" class="error"></div>

  <label for="salary">Salary</label>
  <input type="number" id="salary" name="salary" step="0.01" required />

  <label for="permanentAddress">Permanent Address</label>
  <textarea id="permanentAddress" name="permanentAddress" rows="2" required></textarea>

  <label for="currentAddress">Current Address</label>
  <textarea id="currentAddress" name="currentAddress" rows="2" required></textarea>

  <label for="idProof">ID Proof (PDF, 10KB – 1MB)</label>
  <input type="file" id="idProof" name="idProof" accept=".pdf" required />

  <button type="submit">Submit</button>
</form>

</body>
</html>
