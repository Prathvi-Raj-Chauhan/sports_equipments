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
    <title>Students | Sports Portal</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        body{font-family:'Inter',sans-serif;background:#071322;color:#fff;margin:0;}
        .layout{display:flex;min-height:100vh;}
        .sidebar{width:260px;background:rgba(255,255,255,0.05);padding:34px 22px;}
        .sidebar h2{margin:0 0 4px;}
        .sidebar p{color:rgba(255,255,255,0.6);}
        .nav a{display:block;padding:10px 14px;margin-bottom:10px;border-radius:10px;text-decoration:none;color:rgba(255,255,255,0.7);}
        .nav a.active{background:rgba(0,170,255,0.25);color:#66e3ff;}
        .content{flex:1;padding:40px;}
        table{width:100%;border-collapse:collapse;background:rgba(255,255,255,0.04);border-radius:18px;overflow:hidden;}
        th,td{padding:16px 24px;}
        th{text-transform:uppercase;letter-spacing:0.6px;font-size:13px;color:rgba(255,255,255,0.55);border-bottom:1px solid rgba(255,255,255,0.08);}
        tr+tr td{border-top:1px solid rgba(255,255,255,0.05);}
        .badge{padding:6px 12px;border-radius:999px;border:1px solid rgba(255,255,255,0.2);font-weight:600;}
    </style>
</head>
<body>
<div class="layout">
    <aside class="sidebar">
        <h2>Coach Panel</h2>
        <p><%=teacherName%></p>
        <div class="nav">
            <a href="teacher_dashboard.jsp">Dashboard</a>
            <a href="manage_equipment.jsp">Manage Equipment</a>
            <a href="view_all_issued.jsp">All Issued Items</a>
            <a href="view_students.jsp" class="active">View Students</a>
            <a class="nav" href="teacher_logout.jsp">Logout</a>
        </div>
        
    </aside>
    <main class="content">
        <h1>Students</h1>
        <table>
            <thead>
                <tr>
                    <th>Roll Number</th>
                    <th>Name</th>
                    <th>Total Requests</th>
                    <th>Active Borrows</th>
                </tr>
            </thead>
            <tbody>
                <%
                    try{
                        String url="jdbc:mysql://localhost:3306/sem";
                        String dbUser="root";
                        String dbPass="admin";
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        Connection conn=DriverManager.getConnection(url,dbUser,dbPass);
                        Statement stmt=conn.createStatement();
                        ResultSet rs=stmt.executeQuery(
                            "SELECT s.roll_no,s.name," +
                            "(SELECT COUNT(*) FROM issued i WHERE i.student_roll=s.roll_no) AS total_requests," +
                            "(SELECT COUNT(*) FROM issued i WHERE i.student_roll=s.roll_no AND status='approved') AS active_requests " +
                            "FROM students s ORDER BY s.roll_no");
                        boolean any=false;
                        while(rs.next()){ any=true;
                %>
                <tr>
                    <td><%=rs.getString("roll_no")%></td>
                    <td><%=rs.getString("name")%></td>
                    <td><span class="badge"><%=rs.getInt("total_requests")%></span></td>
                    <td><span class="badge"><%=rs.getInt("active_requests")%></span></td>
                </tr>
                <% } if(!any){ %>
                <tr><td colspan="4" style="text-align:center;padding:32px 0;color:rgba(255,255,255,0.6);">No students found.</td></tr>
                <% } conn.close(); }catch(Exception e){ %>
                <tr><td colspan="4" style="text-align:center;padding:32px 0;color:#ff8a9a;">Error loading students.</td></tr>
                <% } %>
            </tbody>
        </table>
    </main>
</div>
</body>
</html>

