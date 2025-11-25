<%@ page import="java.sql.*"%>
<%
    String email = request.getParameter("email");
    String pass  = request.getParameter("password");

    String url      = "jdbc:mysql://localhost:3306/sportsdb";
    String dbUser   = "root";
    String dbPass   = "@Rajput9405";

    String query = "SELECT id, name FROM students WHERE email=? AND password=?";

    try {
    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection conn = DriverManager.getConnection(url, dbUser, dbPass);

    PreparedStatement pstmt = conn.prepareStatement(query);
    pstmt.setString(1, email);
    pstmt.setString(2, pass);

    ResultSet res = pstmt.executeQuery();

    if (res.next()) {
    // Store session data
    session.setAttribute("student_id", res.getInt("id"));
    session.setAttribute("username", res.getString("name"));

    response.sendRedirect("studentDashboard.jsp");
    } else {
    // Redirect back to login with message
    response.sendRedirect("login.jsp?error=1");
    }

    res.close();
    pstmt.close();
    conn.close();

    } catch (Exception e) {
    out.println("Error: " + e.getMessage());
    }


%>
