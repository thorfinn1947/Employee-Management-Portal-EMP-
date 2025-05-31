<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.nit.DBSERVLET.Employee" %>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <title>Employee Search</title>
  <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet"/>
  <style>
    * {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
      font-family: 'Poppins', sans-serif;
    }
    body {
      background: green;
      color: #fff;
      padding: 30px;
      animation: fadeIn 1.8s ease-in-out;
    }
    h2 {
      text-align: center;
      margin-bottom: 20px;
      font-style: oblique;
      font-weight: 500;
    }
    .search-form, .results {
      background: #1e1e1e;
      padding: 20px;
      border-radius: 10px;
      margin-bottom: 30px;
    }
    .form-group {
      margin-bottom: 15px;
    }
    label {
      display: block;
      margin-bottom: 5px;
    }
    input, select {
      width: 100%;
      padding: 8px;
      background: #333;
      border: none;
      color: #fff;
      border-radius: 5px;
    }
    button {
      padding: 10px 20px;
      background: #0ef;
      color: #000;
      border: none;
      border-radius: 20px;
      cursor: pointer;
      font-weight: bold;
    }
    table {
      width: 100%;
      border-collapse: collapse;
      margin-top: 15px;
    }
    th, td {
      padding: 10px;
      text-align: left;
      border-bottom: 1px solid #444;
    }
    th {
      background: #222;
    }
    .actions select {
      padding: 5px;
      background: #0ef;
      color: #000;
      border-radius: 5px;
    }
    .checkbox {
      text-align: center;
    }
    @keyframes fadeIn {
      from { opacity: 0; transform: translateY(20px); }
      to { opacity: 1; transform: translateY(0); }
    }
  </style>
  <script>
    function handleAction(select, empId) {
      const action = select.value;
      if (!action) return;

      if (action === 'delete') {
        if (!confirm(`Are you sure you want to delete employee ${empId}?`)) {
          select.value = "";
          return;
        }
      }

      window.location.href = `${action.charAt(0).toUpperCase() + action.slice(1)}EmployeeServlet?empId=${empId}`;
      select.value = "";
    }

    function toggleAll(masterCheckbox) {
      const checkboxes = document.querySelectorAll("tbody input[type='checkbox']");
      checkboxes.forEach(cb => cb.checked = masterCheckbox.checked);
    }
  </script>
</head>
<body>

  <form id="searchForm" method="get" action="SearchEmployeeServlet" class="search-form">
    <h2>Employee Search</h2>

    <div class="form-group">
      <label>Employee ID</label>
      <input type="text" name="empId" value="<%= request.getParameter("empId") != null ? request.getParameter("empId") : "" %>"/>
    </div>

    <div class="form-group">
      <label>First Name</label>
      <input type="text" name="firstName" value="<%= request.getParameter("firstName") != null ? request.getParameter("firstName") : "" %>"/>
    </div>

    <div class="form-group">
      <label>Last Name</label>
      <input type="text" name="lastName" value="<%= request.getParameter("lastName") != null ? request.getParameter("lastName") : "" %>"/>
    </div>

    <div class="form-group">
      <label>Login ID</label>
      <input type="text" name="loginId" value="<%= request.getParameter("loginId") != null ? request.getParameter("loginId") : "" %>"/>
    </div>

    <div class="form-group">
      <label>Date of Birth</label>
      <input type="text" name="dobFrom" placeholder="01-Jan-1980" value="<%= request.getParameter("dobFrom") != null ? request.getParameter("dobFrom") : "" %>"/>
    </div>

    <div class="form-group">
      <label>Department</label>
      <select name="department">
        <option value="" <%= (request.getParameter("department") == null || request.getParameter("department").isEmpty()) ? "selected" : "" %>>-- All Departments --</option>
        <option value="Engineering" <%= "Engineering".equals(request.getParameter("department")) ? "selected" : "" %>>Engineering</option>
        <option value="Support" <%= "Support".equals(request.getParameter("department")) ? "selected" : "" %>>Support</option>
        <option value="HR" <%= "HR".equals(request.getParameter("department")) ? "selected" : "" %>>HR</option>
        <option value="Finance" <%= "Finance".equals(request.getParameter("department")) ? "selected" : "" %>>Finance</option>
      </select>
    </div>

    <button type="submit">Search</button>
  </form>

  <div class="results">
    <%
      List<Employee> results = (List<Employee>) request.getAttribute("searchResults");
      if (results != null && !results.isEmpty()) {
    %>
      <p style="text-align:center;"><%= results.size() %> result(s) found.</p>
    <%
      }
    %>

    <table>
      <thead>
        <tr>
          <th class="checkbox"><input type="checkbox" onclick="toggleAll(this)"/></th>
          <th>Employee ID</th>
          <th>First Name</th>
          <th>Last Name</th>
          <th>Login ID</th>
          <th>DOB</th>
          <th>Department</th>
          <th>Salary</th>
          <th>Actions</th>
        </tr>
      </thead>
      <tbody>
        <%
          if (results != null && !results.isEmpty()) {
              for (Employee emp : results) {
        %>
        <tr>
          <td class="checkbox"><input type="checkbox" /></td>
          <td><a href="ViewEmployeeServlet?empId=<%= emp.getEmpId() %>"><%= emp.getEmpId() %></a></td>
          <td><%= emp.getFirstName() %></td>
          <td><%= emp.getLastName() %></td>
          <td><%= emp.getLoginId() %></td>
          <td><%= emp.getDob() %></td>
          <td><%= emp.getDepartment() %></td>
          <td><%= emp.getSalary() %></td>
          <td class="actions">
            <select onchange="handleAction(this, '<%= emp.getEmpId() %>')">
              <option value="">-- Select --</option>
              <option value="view">View</option>
              <option value="edit">Edit</option>
              <option value="delete">Delete</option>
              <option value="history">History</option>
            </select>
          </td>
        </tr>
        <%
              }
          } else if (request.getParameterMap().size() > 0) {
        %>
        <tr>
          <td colspan="9" style="text-align:center;">No results found</td>
        </tr>
        <%
          }
        %>
      </tbody>
    </table>
  </div>

  <%
    Integer currentPage = (Integer) request.getAttribute("currentPage");
    Integer totalPages = (Integer) request.getAttribute("totalPages");
    if (currentPage != null && totalPages != null && totalPages > 1) {
  %>
  <div style="text-align:center; margin-top: 20px;">
    <% for (int i = 1; i <= totalPages; i++) { %>
      <a href="SearchEmployeeServlet?page=<%= i %>" style="margin: 0 5px; font-weight:<%= i == currentPage ? "bold" : "normal" %>; color: #0ef;">
        <%= i %>
      </a>
    <% } %>
  </div>
  <% } %>

</body>
</html>
