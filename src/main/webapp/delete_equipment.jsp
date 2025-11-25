<%@ page import="java.sql.*" %>
<%@ page session="true" %>
<%
    if(session.getAttribute("teacher_id") == null){
        response.sendRedirect("teacherLogin.jsp");
        return;
    }
    String id = request.getParameter("id");
    if(id == null){
        response.sendRedirect("manage_equipment.jsp?error=Invalid equipment");
        return;
    }
    try{
        String url="jdbc:mysql://localhost:3306/sem";
        String dbUser="root";
        String dbPass="admin";
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn=DriverManager.getConnection(url,dbUser,dbPass);
        PreparedStatement ps=conn.prepareStatement("DELETE FROM equipments WHERE equipment_id=?");
        ps.setInt(1,Integer.parseInt(id));
        ps.executeUpdate();
        conn.close();
        response.sendRedirect("manage_equipment.jsp?success=Equipment deleted");
    }catch(Exception e){
        response.sendRedirect("manage_equipment.jsp?error=Unable to delete");
    }
%>

