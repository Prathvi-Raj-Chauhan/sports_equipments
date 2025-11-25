<%@ page import="java.sql.*" %>
<%@ page session="true" %>
<%
    if(session.getAttribute("teacher_id") == null){
        response.sendRedirect("teacherLogin.jsp");
        return;
    }

    String issueId = request.getParameter("issue_id");
    String equipmentName = request.getParameter("equipment_name");

    if(issueId == null || equipmentName == null){
        response.sendRedirect("teacher_dashboard.jsp?error=Invalid request");
        return;
    }

    try{
        String url="jdbc:mysql://localhost:3306/sem";
        String dbUser="root";
        String dbPass="admin";
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn=DriverManager.getConnection(url,dbUser,dbPass);

        PreparedStatement update = conn.prepareStatement("UPDATE issued SET status='returned' WHERE issue_id=?");
        update.setInt(1, Integer.parseInt(issueId));
        update.executeUpdate();

        PreparedStatement addBack = conn.prepareStatement("UPDATE equipments SET quantity=quantity+1 WHERE name=?");
        addBack.setString(1, equipmentName);
        addBack.executeUpdate();

        conn.close();
        response.sendRedirect("teacher_dashboard.jsp?success=Equipment marked returned");
    }catch(Exception e){
        response.sendRedirect("teacher_dashboard.jsp?error=Unable to mark returned");
    }
%>

