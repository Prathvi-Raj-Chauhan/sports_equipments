<%@ page import="java.sql.*" %>
<%@ page session="true" %>
<%
    if(session.getAttribute("teacher_id") == null){
        response.sendRedirect("teacherLogin.jsp");
        return;
    }

    String issueId = request.getParameter("issue_id");
    if(issueId == null){
        response.sendRedirect("teacher_dashboard.jsp?error=Invalid request");
        return;
    }

    try{
        String url="jdbc:mysql://localhost:3306/sem";
        String dbUser="root";
        String dbPass="admin";
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn=DriverManager.getConnection(url,dbUser,dbPass);

        PreparedStatement ps = conn.prepareStatement("UPDATE issued SET status='rejected' WHERE issue_id=?");
        ps.setInt(1, Integer.parseInt(issueId));
        ps.executeUpdate();

        conn.close();
        response.sendRedirect("teacher_dashboard.jsp?success=Request rejected");
    }catch(Exception e){
        response.sendRedirect("teacher_dashboard.jsp?error=Unable to reject");
    }
%>

