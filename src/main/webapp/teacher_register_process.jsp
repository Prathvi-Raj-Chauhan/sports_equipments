<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.*, javax.servlet.http.*" %>
<%
    // 1. Get form parameters
    String name = request.getParameter("name");
    String mobileNo = request.getParameter("mobile_no");
    String email = request.getParameter("email");
    String password = request.getParameter("password");

    // 2. Database connection info
    String url = "jdbc:mysql://localhost:3306/sem"; // replace with your DB
    String user = "root"; // DB username
    String dbPassword = "admin"; // DB password

    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    try {
        // 3. Load JDBC Driver
        Class.forName("com.mysql.cj.jdbc.Driver");
        con = DriverManager.getConnection(url, user, dbPassword);

        // 4. Check if mobile number already exists
        String checkSql = "SELECT * FROM teachers WHERE mobile_no = ?";
        ps = con.prepareStatement(checkSql);
        ps.setString(1, mobileNo);
        rs = ps.executeQuery();

        if(rs.next()) {
            // Mobile number exists, redirect back with error
            response.sendRedirect("teacher_register.jsp?error=1");
        } else {
            // 5. Insert new teacher into database
            String insertSql = "INSERT INTO teachers (name, mobile_no, email, password) VALUES (?, ?, ?, ?)";
            ps = con.prepareStatement(insertSql);
            ps.setString(1, name);
            ps.setString(2, mobileNo);
            ps.setString(3, email);
            ps.setString(4, password); // For security, consider hashing the password!

            int rows = ps.executeUpdate();

            if(rows > 0) {
                // Registration successful, redirect to login
                response.sendRedirect("teacherLogin.jsp");
            } else {
                response.sendRedirect("teacher_register.jsp?error=1");
            }
        }
    } catch(Exception e) {
        e.printStackTrace();
        response.sendRedirect("teacher_register.jsp?error=1");
    } finally {
        // Close resources
        try { if(rs != null) rs.close(); } catch(Exception e){}
        try { if(ps != null) ps.close(); } catch(Exception e){}
        try { if(con != null) con.close(); } catch(Exception e){}
    }
%>