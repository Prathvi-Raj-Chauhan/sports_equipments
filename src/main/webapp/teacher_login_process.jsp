<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.*, javax.servlet.http.*" %>

<%
    String mobileNo = request.getParameter("mobile_no");
    String password = request.getParameter("password");

    String url = "jdbc:mysql://localhost:3306/sem";
    String user = "root";
    String dbPassword = "admin";

    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        con = DriverManager.getConnection(url, user, dbPassword);

        String sql = "SELECT * FROM teachers WHERE mobile_no = ? AND password = ?";
        ps = con.prepareStatement(sql);
        ps.setString(1, mobileNo);
        ps.setString(2, password);

        rs = ps.executeQuery();

        if(rs.next()) {
            // Use built-in session object
            session.setAttribute("teacher_id", rs.getInt("id"));
            session.setAttribute("teacher_name", rs.getString("name"));

            response.sendRedirect("teacher_dashboard.jsp");
        } else {
            response.sendRedirect("teacherLogin.jsp?error=1");
        }

    } catch(Exception e) {
        e.printStackTrace();
        response.sendRedirect("teacher_login.jsp?error=1");
    } finally {
        try { if(rs != null) rs.close(); } catch(Exception e){}
        try { if(ps != null) ps.close(); } catch(Exception e){}
        try { if(con != null) con.close(); } catch(Exception e){}
    }
%>
