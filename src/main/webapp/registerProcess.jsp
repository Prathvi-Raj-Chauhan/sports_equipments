<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.*, javax.servlet.http.*" %>

<%
    // 1. Get form data
    String name  = request.getParameter("name");
    String rollNo = request.getParameter("rollNo");
    String pass  = request.getParameter("password");

    // 2. Database credentials
    String url    = "jdbc:mysql://localhost:3306/sem";
    String dbUser = "root";
    String dbPass = "admin";

    // 3. SQL Queries
    String checkQuery  = "SELECT name FROM students WHERE roll_no = ?";
    String insertQuery = "INSERT INTO students(name, roll_no, password) VALUES (?, ?, ?)";

    Connection conn = null;
    PreparedStatement check = null;
    PreparedStatement insert = null;
    ResultSet rs = null;

    try {
        // 4. Load MySQL Driver
        Class.forName("com.mysql.cj.jdbc.Driver");

        // 5. Connect to DB
        conn = DriverManager.getConnection(url, dbUser, dbPass);

        // 6. Check if email already exists
        check = conn.prepareStatement(checkQuery);
        check.setString(1, rollNo);
        rs = check.executeQuery();

        if (rs.next()) {
            // Email already used, redirect back with error
            response.sendRedirect("register.jsp?error=1");
        } else {
            // 7. Insert new teacher
            insert = conn.prepareStatement(insertQuery);
            insert.setString(1, name);
            insert.setString(2, rollNo);
            insert.setString(3, pass);
            insert.executeUpdate();

            // 8. Redirect to login page after successful register
            response.sendRedirect("index.jsp");
        }

    } catch (Exception e) {
        out.println("<h3 style='color:red;'>Error: " + e.getMessage() + "</h3>");
    } finally {
        try { if (rs != null) rs.close(); } catch (Exception e) {}
        try { if (check != null) check.close(); } catch (Exception e) {}
        try { if (insert != null) insert.close(); } catch (Exception e) {}
        try { if (conn != null) conn.close(); } catch (Exception e) {}
    }
%>
