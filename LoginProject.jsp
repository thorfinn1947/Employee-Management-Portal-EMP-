<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Login Page</title>
  <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet"/>
  <script type="module" src="https://unpkg.com/ionicons@5.5.2/dist/ionicons/ionicons.esm.js"></script>
  <script nomodule src="https://unpkg.com/ionicons@5.5.2/dist/ionicons/ionicons.js"></script>
  <style>
    * {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
      font-family: 'Poppins', sans-serif;
    }

    body {
      background: #111;
      color: #fff;
      display: flex;
      justify-content: center;
      align-items: center;
      height: 100vh;
    }

    .login-box {
      background: #1e1e1e;
      padding: 40px;
      border-radius: 15px;
      width: 350px;
      box-shadow: 0 0 15px rgba(0, 0, 0, 0.6);
      animation: fadeIn 1.8s ease-in-out;
    }

    .login-box h2 {
      text-align: center;
      margin-bottom: 30px;
      font-size: 2em;
    }

    .input-box {
      position: relative;
      margin-bottom: 30px;
    }

    .input-box input {
      width: 100%;
      padding: 10px 10px 10px 10px;
      background: transparent;
      border: none;
      border-bottom: 2px solid #fff;
      color: #fff;
      font-size: 1em;
    }

    .input-box label {
      position: absolute;
      top: 50%;
      left: 10px;
      transform: translateY(-50%);
      pointer-events: none;
      transition: 0.3s;
      color: #aaa;
    }

    .input-box input:focus ~ label,
    .input-box input:valid ~ label {
      top: -10px;
      font-size: 0.8em;
      color: #0ef;
    }

    .input-box .icon {
      position: absolute;
      right: 10px;
      top: 50%;
      transform: translateY(-50%);
      color: #aaa;
    }

    button {
      width: 100%;
      padding: 10px;
      border: none;
      border-radius: 25px;
      background: #0ef;
      color: #111;
      font-weight: bold;
      cursor: pointer;
      transition: 0.3s;
    }

    button:hover {
      background: #09c;
    }

    .register-link {
      text-align: center;
      margin-top: 20px;
    }

    .register-link a {
      color: #0ef;
      text-decoration: none;
      font-weight: 600;
    }

    .register-link a:hover {
      text-decoration: underline;
    }

    .message {
      margin-bottom: 15px;
      text-align: center;
      color: #f44336; /* red for errors */
      font-weight: 500;
    }

    @keyframes fadeIn {
      from { opacity: 0; transform: translateY(20px); }
      to { opacity: 1; transform: translateY(0); }
    }
  </style>
</head>
<body>
  <div class="login-box">
    <form action="LoginServlet" method="post">
      <h2>Login</h2>

      <div class="input-box">
        <input type="text" name="username" value="<%= request.getParameter("username") != null ? request.getParameter("username") : "" %>" required />
        <label>UserName</label>
      </div>

      <div class="input-box">
        <input type="password" name="password" required />
        <label>Password</label>
      </div>
<% 
        String error = (String) request.getAttribute("errorMessage");
        if (error != null) { 
      %> 
        <div class="message"><%= error %></div>
      <% } %>
      <button type="submit">Login</button>

      <div class="register-link">
        <p>Don't have an account? <a href="addEmployee.jsp">Register</a></p>
      </div>
    </form>
  </div>
</body>
</html>
