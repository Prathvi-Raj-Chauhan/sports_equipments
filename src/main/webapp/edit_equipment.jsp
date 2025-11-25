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

    if("POST".equalsIgnoreCase(request.getMethod())){
        String name = request.getParameter("name");
        String qty = request.getParameter("quantity");
        try{
            String url="jdbc:mysql://localhost:3306/sem";
            String dbUser="root";
            String dbPass="admin";
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn=DriverManager.getConnection(url,dbUser,dbPass);
            PreparedStatement ps=conn.prepareStatement("UPDATE equipments SET name=?, quantity=? WHERE equipment_id=?");
            ps.setString(1,name);
            ps.setInt(2,Integer.parseInt(qty));
            ps.setInt(3,Integer.parseInt(id));
            ps.executeUpdate();
            conn.close();
            response.sendRedirect("manage_equipment.jsp?success=Equipment updated");
            return;
        }catch(Exception e){
            response.sendRedirect("manage_equipment.jsp?error=Unable to update");
            return;
        }
    }

    String currentName="";
    int currentQty=0;
    try{
        String url="jdbc:mysql://localhost:3306/sem";
        String dbUser="root";
        String dbPass="admin";
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn=DriverManager.getConnection(url,dbUser,dbPass);
        PreparedStatement ps=conn.prepareStatement("SELECT name, quantity FROM equipments WHERE equipment_id=?");
        ps.setInt(1,Integer.parseInt(id));
        ResultSet rs=ps.executeQuery();
        if(rs.next()){
            currentName=rs.getString("name");
            currentQty=rs.getInt("quantity");
        }else{
            conn.close();
            response.sendRedirect("manage_equipment.jsp?error=Not found");
            return;
        }
        conn.close();
    }catch(Exception e){
        response.sendRedirect("manage_equipment.jsp?error=Error loading equipment");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Edit Equipment</title>
    <style>
        body{font-family:'Inter',sans-serif;background:#0a1929;color:#fff;display:flex;align-items:center;justify-content:center;height:100vh;margin:0;}
        .card{width:380px;padding:32px;background:rgba(255,255,255,0.06);border-radius:20px;}
        label{display:block;margin-bottom:6px;color:rgba(255,255,255,0.7);}
        input{width:100%;padding:12px 14px;margin-bottom:20px;border-radius:10px;border:1px solid rgba(255,255,255,0.2);background:rgba(255,255,255,0.05);color:#fff;}
        button{width:100%;padding:12px;border:none;border-radius:10px;background:linear-gradient(135deg,#00b4ff,#007bff);color:#fff;font-weight:600;cursor:pointer;}
        a{display:block;text-align:center;margin-top:16px;color:#7dd9ff;text-decoration:none;}
    </style>
</head>
<body>
    <div class="card">
        <h2>Edit Equipment</h2>
        <form method="post">
            <label>Equipment Name</label>
            <input type="text" name="name" value="<%=currentName%>" required>
            <label>Quantity</label>
            <input type="number" name="quantity" value="<%=currentQty%>" min="0" required>
            <button type="submit">Update</button>
        </form>
        <a href="manage_equipment.jsp">Back to list</a>
    </div>
</body>
</html>

