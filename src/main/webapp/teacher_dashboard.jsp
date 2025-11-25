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
    <title>Teacher Dashboard | Sports Portal</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif;
            min-height: 100vh;
            background: linear-gradient(135deg, #0a1929 0%, #1a2332 50%, #0f1419 100%);
            color: #ffffff;
            overflow-x: hidden;
        }

        .bg-gradient {
            position: fixed;
            inset: 0;
            background:
                radial-gradient(circle at 15% 25%, rgba(0, 150, 255, 0.18) 0%, transparent 50%),
                radial-gradient(circle at 80% 70%, rgba(0, 200, 255, 0.12) 0%, transparent 50%);
            z-index: 0;
            pointer-events: none;
        }

        .layout {
            display: flex;
            min-height: 100vh;
            position: relative;
            z-index: 1;
        }

        .sidebar {
            width: 280px;
            background: rgba(255, 255, 255, 0.05);
            backdrop-filter: blur(20px);
            border-right: 1px solid rgba(255, 255, 255, 0.15);
            padding: 32px 0;
            display: flex;
            flex-direction: column;
        }

        .sidebar-header {
            padding: 0 24px 32px;
            border-bottom: 1px solid rgba(255, 255, 255, 0.1);
            margin-bottom: 24px;
        }

        .sidebar-header h2 {
            font-size: 20px;
            font-weight: 600;
            color: #ffffff;
            margin-bottom: 4px;
        }

        .sidebar-header p {
            font-size: 13px;
            color: rgba(255, 255, 255, 0.6);
        }

        .sidebar-nav {
            flex: 1;
            padding: 0 16px;
        }

        .sidebar-nav a {
            display: flex;
            align-items: center;
            color: rgba(255, 255, 255, 0.65);
            text-decoration: none;
            padding: 12px 16px;
            border-radius: 12px;
            margin-bottom: 6px;
            font-size: 15px;
            font-weight: 500;
            transition: all 0.3s ease;
        }

        .sidebar-nav a.active {
            background: rgba(0, 150, 255, 0.2);
            color: #00b4ff;
            border-left: 3px solid #00c4ff;
        }

        .sidebar-nav a:hover {
            background: rgba(255, 255, 255, 0.12);
            color: #ffffff;
        }

        .sidebar-footer {
            padding: 24px;
            border-top: 1px solid rgba(255, 255, 255, 0.1);
        }

        .sidebar-footer a {
            display: flex;
            align-items: center;
            justify-content: center;
            color: rgba(255, 255, 255, 0.75);
            text-decoration: none;
            padding: 10px 16px;
            border-radius: 10px;
            border: 1px solid rgba(255, 255, 255, 0.2);
            transition: all 0.3s ease;
        }

        .sidebar-footer a:hover {
            background: rgba(255, 255, 255, 0.1);
        }

        .main {
            flex: 1;
            padding: 40px;
        }

        .main-header h1 {
            font-size: 32px;
            font-weight: 700;
            color: #ffffff;
        }

        .main-header p {
            color: rgba(255, 255, 255, 0.65);
            margin-top: 6px;
        }

        .message {
            margin-top: 24px;
            padding: 14px 18px;
            border-radius: 12px;
            font-size: 14px;
            font-weight: 500;
        }

        .message.success {
            background: rgba(40, 167, 69, 0.15);
            border: 1px solid rgba(40, 167, 69, 0.35);
            color: #71f6a5;
        }

        .message.error {
            background: rgba(220, 53, 69, 0.15);
            border: 1px solid rgba(220, 53, 69, 0.35);
            color: #ff8b9a;
        }

        .cards {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
            gap: 20px;
            margin-top: 32px;
        }

        .card {
            background: rgba(255, 255, 255, 0.06);
            border: 1px solid rgba(255, 255, 255, 0.1);
            border-radius: 20px;
            padding: 24px;
            box-shadow: 0 15px 30px rgba(15, 30, 50, 0.35);
            position: relative;
        }

        .card h3 {
            color: rgba(255, 255, 255, 0.65);
            text-transform: uppercase;
            font-size: 13px;
            letter-spacing: 1px;
        }

        .card .value {
            font-size: 38px;
            font-weight: 700;
            margin-top: 12px;
            color: #fff;
        }

        .card .icon {
            position: absolute;
            top: 18px;
            right: 18px;
            font-size: 28px;
            opacity: 0.35;
        }

        .section {
            margin-top: 40px;
        }

        .section-header {
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-bottom: 18px;
        }

        .section-header h2 {
            font-size: 22px;
            color: #ffffff;
        }

        .table-wrapper {
            background: rgba(255, 255, 255, 0.05);
            border: 1px solid rgba(255, 255, 255, 0.08);
            border-radius: 20px;
            overflow: hidden;
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        thead {
            background: rgba(255, 255, 255, 0.04);
        }

        th, td {
            padding: 16px 24px;
            text-align: left;
            font-size: 14px;
        }

        th {
            text-transform: uppercase;
            letter-spacing: 0.6px;
            color: rgba(255, 255, 255, 0.55);
            border-bottom: 1px solid rgba(255, 255, 255, 0.06);
        }

        tr + tr td {
            border-top: 1px solid rgba(255, 255, 255, 0.04);
        }

        .status-badge {
            padding: 6px 12px;
            border-radius: 999px;
            font-size: 12px;
            font-weight: 600;
            text-transform: uppercase;
            border: 1px solid transparent;
        }

        .status-pending {
            background: rgba(255, 193, 7, 0.15);
            color: #fcd56d;
            border-color: rgba(255, 193, 7, 0.4);
        }

        .status-approved {
            background: rgba(40, 167, 69, 0.15);
            color: #7ef4aa;
            border-color: rgba(40, 167, 69, 0.35);
        }

        .status-rejected {
            background: rgba(220, 53, 69, 0.15);
            color: #ff8a9a;
            border-color: rgba(220, 53, 69, 0.35);
        }

        .status-returned {
            background: rgba(108, 117, 125, 0.15);
            color: #c6ccd1;
            border-color: rgba(108, 117, 125, 0.35);
        }

        .btn {
            border: none;
            border-radius: 10px;
            padding: 8px 16px;
            font-size: 13px;
            font-weight: 600;
            cursor: pointer;
            color: #fff;
        }

        .btn-approve {
            background: linear-gradient(135deg, #29d88f, #15b783);
            box-shadow: 0 8px 16px rgba(34, 197, 94, 0.3);
        }

        .btn-reject {
            background: linear-gradient(135deg, #f75050, #d72638);
            box-shadow: 0 8px 16px rgba(239, 68, 68, 0.3);
        }

        .btn-return {
            background: linear-gradient(135deg, #fbbb54, #ff8c42);
            color: #1c1c1c;
        }

        .actions {
            display: inline-flex;
            gap: 8px;
        }

        .empty-state {
            padding: 40px 20px;
            text-align: center;
            color: rgba(255, 255, 255, 0.6);
        }

        @media (max-width: 900px) {
            .layout {
                flex-direction: column;
            }
            .sidebar {
                position: static;
                width: 100%;
                height: auto;
                flex-direction: row;
                overflow-x: auto;
            }
            .main {
                margin-left: 0;
                padding: 24px;
            }
        }
    </style>
</head>
<body>
<div class="bg-gradient"></div>
<div class="layout">
    <aside class="sidebar">
        <div class="sidebar-header">
            <h2>Coach Panel</h2>
            <p><%=teacherName%></p>
        </div>
        <nav class="sidebar-nav">
            <a href="teacher_dashboard.jsp" class="active">Dashboard</a>
            <a href="manage_equipment.jsp">Manage Equipment</a>
            <a href="view_all_issued.jsp">All Issued Items</a>
            <a href="view_students.jsp">View Students</a>
            <a href="teacher_logout.jsp">Logout</a>
        </nav>

    </aside>

    <main class="main">
        <div class="main-header">
            <h1>Teacher Dashboard</h1>
            <p>Monitor requests, inventory and student borrowing activity.</p>
        </div>

        <% if(request.getParameter("success") != null){ %>
        <div class="message success"><%= request.getParameter("success") %></div>
        <% } %>
        <% if(request.getParameter("error") != null){ %>
        <div class="message error"><%= request.getParameter("error") %></div>
        <% } %>

        <div class="cards">
            <div class="card">

                <h3>Total Equipment</h3>
                <div class="value">
                    <%
                        try{
                            String url="jdbc:mysql://localhost:3306/sem";
                            String dbUser="root";
                            String dbPass="admin";
                            Class.forName("com.mysql.cj.jdbc.Driver");
                            Connection conn=DriverManager.getConnection(url,dbUser,dbPass);
                            Statement stmt=conn.createStatement();
                            ResultSet rs=stmt.executeQuery("SELECT COUNT(*) FROM equipments");
                            if(rs.next()) out.print(rs.getInt(1));
                            conn.close();
                        }catch(Exception e){ out.print("0"); }
                    %>
                </div>
            </div>
            <div class="card">
                <h3>Pending Requests</h3>
                <div class="value">
                    <%
                        try{
                            String url="jdbc:mysql://localhost:3306/sem";
                            String dbUser="root";
                            String dbPass="admin";
                            Class.forName("com.mysql.cj.jdbc.Driver");
                            Connection conn=DriverManager.getConnection(url,dbUser,dbPass);
                            Statement stmt=conn.createStatement();
                            ResultSet rs=stmt.executeQuery("SELECT COUNT(*) FROM issued WHERE status='pending'");
                            if(rs.next()) out.print(rs.getInt(1));
                            conn.close();
                        }catch(Exception e){ out.print("0"); }
                    %>
                </div>
            </div>
            <div class="card">
                <h3>Approved Items</h3>
                <div class="value">
                    <%
                        try{
                            String url="jdbc:mysql://localhost:3306/sem";
                            String dbUser="root";
                            String dbPass="admin";
                            Class.forName("com.mysql.cj.jdbc.Driver");
                            Connection conn=DriverManager.getConnection(url,dbUser,dbPass);
                            Statement stmt=conn.createStatement();
                            ResultSet rs=stmt.executeQuery("SELECT COUNT(*) FROM issued WHERE status='approved'");
                            if(rs.next()) out.print(rs.getInt(1));
                            conn.close();
                        }catch(Exception e){ out.print("0"); }
                    %>
                </div>
            </div>
            <div class="card">

                <h3>Total Issued</h3>
                <div class="value">
                    <%
                        try{
                            String url="jdbc:mysql://localhost:3306/sem";
                            String dbUser="root";
                            String dbPass="admin";
                            Class.forName("com.mysql.cj.jdbc.Driver");
                            Connection conn=DriverManager.getConnection(url,dbUser,dbPass);
                            Statement stmt=conn.createStatement();
                            ResultSet rs=stmt.executeQuery("SELECT COUNT(*) FROM issued");
                            if(rs.next()) out.print(rs.getInt(1));
                            conn.close();
                        }catch(Exception e){ out.print("0"); }
                    %>
                </div>
            </div>
        </div>

        <div class="section">
            <div class="section-header">
                <h2>Pending Borrow Requests</h2>
            </div>
            <div class="table-wrapper">
                <table>
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Student Roll</th>
                            <th>Equipment</th>
                            <th>Requested On</th>
                            <th>Status</th>
                            <th>Actions</th>
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
                                ResultSet rs=stmt.executeQuery("SELECT issue_id, student_roll, equipment_name, issue_date, status FROM issued WHERE status='pending' ORDER BY issue_date DESC");
                                boolean hasRows = false;
                                while(rs.next()){
                                    hasRows = true;
                        %>
                        <tr>
                            <td>#<%= rs.getInt("issue_id") %></td>
                            <td><%= rs.getString("student_roll") %></td>
                            <td><%= rs.getString("equipment_name") %></td>
                            <td><%= rs.getString("issue_date") %></td>
                            <td><span class="status-badge status-<%= rs.getString("status").toLowerCase() %>"><%= rs.getString("status") %></span></td>
                            <td>
                                <div class="actions">
                                    <form action="approve_request.jsp" method="post">
                                        <input type="hidden" name="issue_id" value="<%= rs.getInt("issue_id") %>">
                                        <input type="hidden" name="equipment_name" value="<%= rs.getString("equipment_name") %>">
                                        <button class="btn btn-approve" type="submit">Approve</button>
                                    </form>
                                    <form action="reject_request.jsp" method="post">
                                        <input type="hidden" name="issue_id" value="<%= rs.getInt("issue_id") %>">
                                        <button class="btn btn-reject" type="submit">Reject</button>
                                    </form>
                                </div>
                            </td>
                        </tr>
                        <%
                                }
                                if(!hasRows){
                        %>
                        <tr>
                            <td colspan="6">
                                <div class="empty-state">No pending requests right now.</div>
                            </td>
                        </tr>
                        <%
                                }
                                conn.close();
                            }catch(Exception e){
                        %>
                        <tr>
                            <td colspan="6"><div class="empty-state">Error loading requests.</div></td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
        </div>

        <div class="section">
            <div class="section-header">
                <h2>Recently Approved</h2>
            </div>
            <div class="table-wrapper">
                <table>
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Student Roll</th>
                            <th>Equipment</th>
                            <th>Issued On</th>
                            <th>Status</th>
                            <th>Actions</th>
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
                                ResultSet rs=stmt.executeQuery("SELECT issue_id, student_roll, equipment_name, issue_date, status FROM issued WHERE status='approved' ORDER BY issue_date DESC LIMIT 10");
                                boolean hasRows = false;
                                while(rs.next()){
                                    hasRows = true;
                        %>
                        <tr>
                            <td>#<%= rs.getInt("issue_id") %></td>
                            <td><%= rs.getString("student_roll") %></td>
                            <td><%= rs.getString("equipment_name") %></td>
                            <td><%= rs.getString("issue_date") %></td>
                            <td><span class="status-badge status-<%= rs.getString("status").toLowerCase() %>"><%= rs.getString("status") %></span></td>
                            <td>
                                <form action="mark_returned.jsp" method="post">
                                    <input type="hidden" name="issue_id" value="<%= rs.getInt("issue_id") %>">
                                    <input type="hidden" name="equipment_name" value="<%= rs.getString("equipment_name") %>">
                                    <button class="btn btn-return" type="submit">Mark Returned</button>
                                </form>
                            </td>
                        </tr>
                        <%
                                }
                                if(!hasRows){
                        %>
                        <tr>
                            <td colspan="6"><div class="empty-state">No approved items yet.</div></td>
                        </tr>
                        <%
                                }
                                conn.close();
                            }catch(Exception e){
                        %>
                        <tr>
                            <td colspan="6"><div class="empty-state">Error loading data.</div></td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
        </div>
    </main>
</div>
</body>
</html>

