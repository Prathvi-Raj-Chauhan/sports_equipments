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
    <title>All Issued Items | Sports Portal</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        body { font-family:'Inter',sans-serif; background:#081526; color:#fff; margin:0; }
        .layout { display:flex; min-height:100vh; }
        .sidebar { width:260px; background:rgba(255,255,255,0.05); padding:34px 22px; }
        .sidebar h2 { margin:0 0 4px; }
        .sidebar p { color:rgba(255,255,255,0.6); margin-bottom:24px; }
        .nav a { display:block; padding:10px 14px; margin-bottom:10px; border-radius:10px; text-decoration:none; color:rgba(255,255,255,0.7); }
        .nav a.active { background:rgba(0,170,255,0.25); color:#66e3ff; }
        .content { flex:1; padding:40px; }
        table { width:100%; border-collapse:collapse; background:rgba(255,255,255,0.04); border-radius:18px; overflow:hidden; }
        th, td { padding:16px 22px; }
        th { text-transform:uppercase; letter-spacing:0.6px; font-size:13px; color:rgba(255,255,255,0.55); border-bottom:1px solid rgba(255,255,255,0.08); }
        tr + tr td { border-top:1px solid rgba(255,255,255,0.05); }
        .status-badge { padding:6px 12px; border-radius:999px; font-size:12px; font-weight:600; border:1px solid transparent; }
        .status-pending { background:rgba(255,193,7,0.15); color:#ffda7b; border-color:rgba(255,193,7,0.4); }
        .status-approved { background:rgba(34,197,94,0.15); color:#5ef5a3; border-color:rgba(34,197,94,0.35); }
        .status-rejected { background:rgba(239,68,68,0.15); color:#ff8f9b; border-color:rgba(239,68,68,0.35); }
        .status-returned { background:rgba(148,163,184,0.2); color:#dbe4ff; border-color:rgba(148,163,184,0.35); }
        .btn-return { padding:8px 16px; border:none; border-radius:10px; background:linear-gradient(135deg,#feb144,#ff9248); color:#1f1f1f; font-weight:600; cursor:pointer; }
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
            <a href="view_all_issued.jsp" class="active">All Issued Items</a>
            <a href="view_students.jsp">View Students</a>
            <a class="nav" href="teacher_logout.jsp">Logout</a>
        </div>

    </aside>
    <main class="content">
        <h1>All Issued Items</h1>
        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Student Roll</th>
                    <th>Equipment</th>
                    <th>Issue Date</th>
                    <th>Status</th>
                    <th>Action</th>
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
                        ResultSet rs=stmt.executeQuery("SELECT issue_id,student_roll,equipment_name,issue_date,status FROM issued ORDER BY issue_date DESC");
                        boolean any=false;
                        while(rs.next()){
                            any=true;
                            String status = rs.getString("status");
                %>
                <tr>
                    <td>#<%=rs.getInt("issue_id")%></td>
                    <td><%=rs.getString("student_roll")%></td>
                    <td><%=rs.getString("equipment_name")%></td>
                    <td><%=rs.getString("issue_date")%></td>
                    <td><span class="status-badge status-<%=status.toLowerCase()%>"><%=status%></span></td>
                    <td>
                        <% if("approved".equalsIgnoreCase(status)){ %>
                        <form action="mark_returned.jsp" method="post">
                            <input type="hidden" name="issue_id" value="<%=rs.getInt("issue_id")%>">
                            <input type="hidden" name="equipment_name" value="<%=rs.getString("equipment_name")%>">
                            <button class="btn-return" type="submit">Mark Returned</button>
                        </form>
                        <% } else { %>
                        -
                        <% } %>
                    </td>
                </tr>
                <% } if(!any){ %>
                <tr><td colspan="6" style="text-align:center; padding:32px 0; color:rgba(255,255,255,0.6);">No issued records yet.</td></tr>
                <% } conn.close(); }catch(Exception e){ %>
                <tr><td colspan="6" style="text-align:center; padding:32px 0; color:#ff8a9a;">Error loading issued items.</td></tr>
                <% } %>
            </tbody>
        </table>
    </main>
</div>
</body>
</html>

