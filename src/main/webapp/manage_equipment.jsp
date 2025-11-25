<%@ page import="java.sql.*" %>
<%@ page session="true" %>
<%
    if(session.getAttribute("teacher_id") == null){
        response.sendRedirect("teacherLogin.jsp");
        return;
    }
    String teacherName = (String) session.getAttribute("teacher_name");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Equipment | Sports Portal</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Inter', sans-serif;
            background: #0a1929;
            color: #fff;
            margin: 0;
        }
        .layout { display: flex; min-height: 100vh; }
        .sidebar { width: 260px; background: rgba(255,255,255,0.06); padding: 32px 20px; }
        .sidebar h2 { margin-bottom: 4px; }
        .sidebar p { color: rgba(255,255,255,0.6); }
        .nav a {
            display: block;
            padding: 10px 14px;
            border-radius: 10px;
            text-decoration: none;
            color: rgba(255,255,255,0.8);
            margin-top: 8px;
        }
        .nav a.active { background: rgba(0,170,255,0.25); color: #0fe; }
        .content { flex: 1; padding: 40px; }
        .actions { display: flex; justify-content: space-between; align-items: center; }
        .btn { padding: 10px 18px; border: none; border-radius: 10px; cursor: pointer; font-weight: 600; }
        .btn-primary { background: linear-gradient(135deg,#00b4ff,#007bff); color: #fff; }
        table { width: 100%; border-collapse: collapse; margin-top: 24px; background: rgba(255,255,255,0.04); border-radius: 18px; overflow: hidden; }
        th, td { padding: 16px 20px; }
        th { text-transform: uppercase; letter-spacing: 0.5px; font-size: 13px; color: rgba(255,255,255,0.6); }
        tr + tr td { border-top: 1px solid rgba(255,255,255,0.08); }
        .link-btn { color: #3ad5ff; text-decoration: none; font-weight: 600; margin-right: 12px; }
        .link-btn.danger { color: #ff7b7b; }
    </style>
</head>
<body>
<div class="layout">
    <aside class="sidebar">
        <h2>Coach Panel</h2>
        <p><%=teacherName%></p>
        <div class="nav">
            <a href="teacher_dashboard.jsp">Dashboard</a>
            <a href="manage_equipment.jsp" class="active">Manage Equipment</a>
            <a href="view_all_issued.jsp">All Issued Items</a>
            <a href="view_students.jsp">View Students</a>
            <a class="nav" href="teacher_logout.jsp">Logout</a>
        </div>

    </aside>
    <main class="content">
        <div class="actions">
            <h1>Equipment Inventory</h1>
            <a class="btn btn-primary" href="add_equipment.jsp">+ Add Equipment</a>
        </div>
        <%
            try{
                String url="jdbc:mysql://localhost:3306/sem";
                String dbUser="root";
                String dbPass="admin";
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection conn=DriverManager.getConnection(url,dbUser,dbPass);
                Statement stmt=conn.createStatement();
                ResultSet rs=stmt.executeQuery("SELECT equipment_id,name,quantity FROM equipments ORDER BY name");
        %>
        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Name</th>
                    <th>Quantity</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <%
                    boolean any=false;
                    while(rs.next()){ any=true;
                %>
                <tr>
                    <td>#<%=rs.getInt("equipment_id")%></td>
                    <td><%=rs.getString("name")%></td>
                    <td><%=rs.getInt("quantity")%></td>
                    <td>
                        <a class="link-btn" href="edit_equipment.jsp?id=<%=rs.getInt("equipment_id")%>">Edit</a>
                        <a class="link-btn danger" href="delete_equipment.jsp?id=<%=rs.getInt("equipment_id")%>" onclick="return confirm('Delete this equipment?')">Delete</a>
                    </td>
                </tr>
                <% } if(!any){ %>
                <tr><td colspan="4" style="text-align:center; color: rgba(255,255,255,0.6); padding: 30px 0;">No equipment yet.</td></tr>
                <% } conn.close(); }catch(Exception e){ %>
                <tr><td colspan="4" style="text-align:center; color:#ff8b9a;">Error loading equipment.</td></tr>
                <% } %>
            </tbody>
        </table>
    </main>
</div>
</body>
</html>

