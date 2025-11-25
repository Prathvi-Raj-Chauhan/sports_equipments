<%@ page import="java.sql.*" %>
<%@ page session="true" %>
<%
    if(session.getAttribute("student_roll") == null){
        response.sendRedirect("index.jsp");
        return;
    }
    String roll = session.getAttribute("student_roll").toString();
    String username = (String) session.getAttribute("username");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>My Issued Items | Sports Portal</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">

    <style>
        :root{
            --bg:#f9f7f3;
            --surface:#ffffff;
            --border:#e6e1d8;
            --text:#1f2a37;
            --muted:#6b7280;
            --primary:#ff7a18;
            --primary-dark:#ff5b00;
        }

        *{margin:0;padding:0;box-sizing:border-box;}

        body{font-family:'Inter',sans-serif;background:var(--bg);color:var(--text);}

        .layout{display:flex;min-height:100vh;}

        /* SIDEBAR (COPIED EXACTLY FROM FIRST FILE) */
        .sidebar{
            width:260px;
            background:var(--surface);
            border-right:1px solid var(--border);
            padding:32px 22px;
            display:flex;
            flex-direction:column;
        }
        .sidebar-header h2{margin-bottom:4px;}
        .sidebar-header p{color:var(--muted);margin-bottom:20px;}
        .nav a{
            display:block;padding:10px 14px;border-radius:12px;text-decoration:none;
            color:var(--muted);font-weight:600;margin-bottom:8px;
        }
        .nav a.active{
            background:rgba(255,122,24,0.12);
            color:var(--primary-dark);
        }

        .main{flex:1;padding:40px;}

        h1{margin-bottom:16px;}
        .subtitle{color:var(--muted);margin-bottom:24px;}

        table{
            width:100%;
            border-collapse:collapse;
            background:var(--surface);
            border:1px solid var(--border);
            border-radius:22px;
            overflow:hidden;
            box-shadow:0 20px 45px rgba(31,42,55,0.08);
        }

        th,td{padding:16px 20px;text-align:left;}
        th{
            text-transform:uppercase;font-size:12px;letter-spacing:0.6px;
            color:var(--muted);border-bottom:1px solid var(--border);
        }
        tr+tr td{border-top:1px solid var(--border);}

        /* STATUS BADGES SAME COLORS BUT MATCHED TO LIGHT UI */
        .status-badge{
            padding:6px 12px;border-radius:999px;font-size:12px;
            font-weight:600;border:1px solid transparent;
        }
        .status-pending{
            background:rgba(255,193,7,0.15);color:#b58100;
            border-color:rgba(255,193,7,0.35);
        }
        .status-approved{
            background:rgba(34,197,94,0.15);color:#1f9254;
            border-color:rgba(34,197,94,0.35);
        }
        .status-rejected{
            background:rgba(239,68,68,0.15);color:#b42318;
            border-color:rgba(239,68,68,0.35);
        }
        .status-returned{
            background:rgba(148,163,184,0.15);color:#475569;
            border-color:rgba(148,163,184,0.35);
        }

        @media(max-width:900px){
            .layout{flex-direction:column;}
            .sidebar{width:100%;border-right:none;border-bottom:1px solid var(--border);
                flex-direction:row;flex-wrap:wrap;gap:12px;}
            .nav{display:flex;flex-wrap:wrap;gap:8px;}
            .nav a{margin:0;}
        }
    </style>
</head>

<body>

<div class="layout">

    <!-- SIDEBAR -->
    <aside class="sidebar">
        <div class="sidebar-header">
            <h2>Sports Portal</h2>
            <p>Welcome, <%=username%></p>
        </div>

        <div class="nav">
            <a href="studentDashboard.jsp">Dashboard</a>
            <a href="viewIssued.jsp" class="active">My Issued Items</a>
            <a href="logout.jsp">Logout</a>
        </div>
    </aside>

    <!-- MAIN CONTENT -->
    <main class="main">

        <h1>My Issued Items</h1>
        <p class="subtitle">Student: <strong><%=username%></strong> (Roll <%=roll%>)</p>

        <table>
            <thead>
            <tr>
                <th>ID</th>
                <th>Equipment</th>
                <th>Requested On</th>
                <th>Status</th>
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
                    PreparedStatement ps=conn.prepareStatement(
                            "SELECT issue_id,equipment_name,issue_date,status FROM issued WHERE student_roll=? ORDER BY issue_date DESC"
                    );
                    ps.setString(1,roll);
                    ResultSet rs=ps.executeQuery();
                    boolean any=false;

                    while(rs.next()){ any=true;
            %>
            <tr>
                <td>#<%=rs.getInt("issue_id")%></td>
                <td><%=rs.getString("equipment_name")%></td>
                <td><%=rs.getString("issue_date")%></td>
                <td>
                        <span class="status-badge status-<%=rs.getString("status").toLowerCase()%>">
                            <%=rs.getString("status")%>
                        </span>
                </td>
            </tr>

            <% } if(!any){ %>
            <tr>
                <td colspan="4" style="text-align:center;padding:32px 0;color:var(--muted);">
                    No requests yet.
                </td>
            </tr>
            <% } conn.close(); }catch(Exception e){ %>
            <tr>
                <td colspan="4" style="text-align:center;padding:32px 0;color:#b42318;">
                    Error loading issued items.
                </td>
            </tr>
            <% } %>
            </tbody>
        </table>

    </main>
</div>

</body>
</html>
