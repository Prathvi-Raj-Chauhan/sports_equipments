<%@ page import="java.sql.*"%>
<%
    String rollNo = request.getParameter("roll_no");
    String pass  = request.getParameter("password");

    String url      = "jdbc:mysql://localhost:3306/sem";
    String dbUser   = "root";
    String dbPass   = "admin";

    String query = "SELECT roll_no, name FROM students WHERE roll_no=? AND password=?";

    try {
    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection conn = DriverManager.getConnection(url, dbUser, dbPass);

    PreparedStatement pstmt = conn.prepareStatement(query);
    pstmt.setString(1, rollNo);
    pstmt.setString(2, pass);

    ResultSet res = pstmt.executeQuery();

    if (res.next()) {
    // Store session data
    session.setAttribute("student_roll", res.getInt("roll_no"));
    session.setAttribute("username", res.getString("name"));

    response.sendRedirect("studentDashboard.jsp");
    } else {
    // Redirect back to login with message
     out.println("ERROR IN LOGGING IN");
    }

    res.close();
    pstmt.close();
    conn.close();

    } catch (Exception e) {
    out.println("Error: " + e.getMessage());
    }


%>
