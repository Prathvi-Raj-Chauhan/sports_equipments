<%@ page import="java.sql.*" %>

<%
    String name  = request.getParameter("name");
    String email = request.getParameter("email");
    String pass  = request.getParameter("password");

    String url    = "jdbc:mysql://localhost:3306/sportsdb";
    String dbUser = "root";
    String dbPass = "@Rajput9405";

// Check if already exists
    String checkQuery = "SELECT id FROM students WHERE email=?";
    String insertQuery = "INSERT INTO students(name,email,password) VALUES(?,?,?)";

    try {
    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection conn = DriverManager.getConnection(url, dbUser, dbPass);

    PreparedStatement check = conn.prepareStatement(checkQuery);
    check.setString(1, email);
    ResultSet rs = check.executeQuery();

    if(rs.next()){
    response.sendRedirect("register.jsp?error=1");
    } else {
    PreparedStatement insert = conn.prepareStatement(insertQuery);
    insert.setString(1, name);
    insert.setString(2, email);
    insert.setString(3, pass);
    insert.executeUpdate();

    // Redirect directly to login page after successful registration
    response.sendRedirect("login.jsp?registered=1");
    }

    conn.close();

    } catch(Exception e){
    out.println("<h3 style='color:red;'>Error: " + e.getMessage() + "</h3>");
    }


%>
