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

        PreparedStatement check = conn.prepareStatement("SELECT quantity FROM equipments WHERE name=?");
        check.setString(1, equipmentName);
        ResultSet crs = check.executeQuery();

        if(crs.next() && crs.getInt("quantity") > 0){
            PreparedStatement update = conn.prepareStatement("UPDATE issued SET status='approved' WHERE issue_id=?");
            update.setInt(1, Integer.parseInt(issueId));
            update.executeUpdate();

            PreparedStatement reduce = conn.prepareStatement("UPDATE equipments SET quantity=quantity-1 WHERE name=?");
            reduce.setString(1, equipmentName);
            reduce.executeUpdate();

            conn.close();
            response.sendRedirect("teacher_dashboard.jsp?success=Request approved");
        }else{
            conn.close();
            response.sendRedirect("teacher_dashboard.jsp?error=No stock available");
        }
    }catch(Exception e){
        response.sendRedirect("teacher_dashboard.jsp?error=Unable to approve");
    }
%>

