<%@ page import="java.sql.*" %>
<%@ page session="true" %>
<%
    if(session.getAttribute("student_roll") == null){
        response.sendRedirect("index.jsp");
        return;
    }
    String username = (String) session.getAttribute("username");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student Dashboard | Sports Portal</title>
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
        .sidebar{
            width:260px;
            background:var(--surface);
            border-right:1px solid var(--border);
            padding:32px 22px;
            display:flex;
            flex-direction:column;
        }
        .sidebar-header h2{margin-bottom:4px;}
        .sidebar-header p{color:var(--muted);margin:0 0 20px;}
        .nav a{
            display:block;
            padding:10px 14px;
            border-radius:12px;
            text-decoration:none;
            color:var(--muted);
            font-weight:600;
            margin-bottom:8px;
        }
        .nav a.active{
            background:rgba(255,122,24,0.12);
            color:var(--primary-dark);
        }
        .main{flex:1;padding:40px;}
        .main-header p{color:var(--muted);}
        .cards{display:grid;grid-template-columns:repeat(auto-fit,minmax(220px,1fr));gap:18px;margin:24px 0;}
        .card{
            background:var(--surface);
            border:1px solid var(--border);
            border-radius:20px;
            padding:24px;
            box-shadow:0 15px 30px rgba(31,42,55,0.08);
        }
        .card h3{font-size:13px;text-transform:uppercase;color:var(--muted);letter-spacing:.5px;}
        .card .value{font-size:36px;font-weight:700;margin-top:12px;}
        .table-wrapper{
            background:var(--surface);
            border:1px solid var(--border);
            border-radius:22px;
            box-shadow:0 20px 45px rgba(31,42,55,0.08);
            overflow:hidden;
        }
        table{width:100%;border-collapse:collapse;}
        th,td{padding:18px 24px;text-align:left;}
        th{text-transform:uppercase;font-size:12px;color:var(--muted);letter-spacing:.4px;border-bottom:1px solid var(--border);}
        td{border-bottom:1px solid var(--border);}
        .equipment-name{font-weight:600;}
        .equipment-count{color:var(--primary-dark);font-weight:600;}
        .borrow-btn{
            padding:9px 16px;
            border:none;
            border-radius:10px;
            background:linear-gradient(135deg,var(--primary),var(--primary-dark));
            color:#fff;
            font-weight:600;
            cursor:pointer;
            box-shadow:0 12px 20px rgba(255,122,24,0.25);
        }
        .borrow-btn:disabled{
            background:#ddd7ce;
            color:#9ca3af;
            box-shadow:none;
            cursor:not-allowed;
        }
        .message{
            padding:14px 16px;
            border-radius:12px;
            margin:20px 0;
            font-weight:600;
        }
        .message.success{background:rgba(34,197,94,0.15);color:#1f9254;border:1px solid rgba(34,197,94,0.35);}
        .message.error{background:rgba(239,68,68,0.12);color:#b42318;border:1px solid rgba(239,68,68,0.3);}
        @media(max-width:900px){
            .layout{flex-direction:column;}
            .sidebar{width:100%;border-right:none;border-bottom:1px solid var(--border);flex-direction:row;flex-wrap:wrap;gap:12px;}
            .nav{display:flex;flex-wrap:wrap;gap:8px;}
            .nav a{margin:0;}
        }
    </style>
</head>
<body>
<div class="layout">
    <aside class="sidebar">
        <div class="sidebar-header">
            <h2>Sports Portal</h2>
            <p>Welcome, <%=username%></p>
        </div>
        <div class="nav">
            <a href="studentDashboard.jsp" class="active">Dashboard</a>
            <a href="viewIssued.jsp">My Issued Items</a>
            <a href="logout.jsp">Logout</a>
        </div>
    </aside>

    <main class="main">
        <div class="main-header">
            <h1>My Dashboard</h1>
            <p>Track available gear and your borrowed items.</p>
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
                <h3>My Requests</h3>
                <div class="value">
                    <%
                        try{
                            String url="jdbc:mysql://localhost:3306/sem";
                            String dbUser="root";
                            String dbPass="admin";
                            Class.forName("com.mysql.cj.jdbc.Driver");
                            Connection conn=DriverManager.getConnection(url,dbUser,dbPass);
                            Statement stmt=conn.createStatement();
                            Object rollObj = session.getAttribute("student_roll");
                            if(rollObj != null){
                                String rollNo = rollObj.toString();
                                ResultSet rs=stmt.executeQuery("SELECT COUNT(*) FROM issued WHERE student_roll='"+rollNo+"'");
                                if(rs.next()) out.print(rs.getInt(1));
                            }else{ out.print("0"); }
                            conn.close();
                        }catch(Exception e){ out.print("0"); }
                    %>
                </div>
            </div>
        </div>

        <div class="section">
            <h2 style="margin-bottom:16px;">Available Equipment</h2>
            <div class="table-wrapper">
                <table class="equipment-table">
                    <thead>
                        <tr>
                            <th>Equipment</th>
                            <th>Available</th>
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
                                ResultSet rs=stmt.executeQuery("SELECT name, quantity FROM equipments ORDER BY name");
                                boolean has=false;
                                while(rs.next()){
                                    has=true;
                                    String equipName=rs.getString("name");
                                    int count=rs.getInt("quantity");
                        %>
                        <tr>
                            <td class="equipment-name"><%=equipName%></td>
                            <td class="equipment-count"><%=count%></td>
                            <td>
                                <form action="requestBorrow.jsp" method="post" style="display:inline;">
                                    <input type="hidden" name="equipment_name" value="<%=equipName%>">
                                    <button class="borrow-btn" type="submit" <%=count==0?"disabled":""%>>
                                        <%=count==0?"Out of stock":"Request to borrow"%>
                                    </button>
                                </form>
                            </td>
                        </tr>
                        <% } if(!has){ %>
                        <tr><td colspan="3" style="text-align:center;color:var(--muted);padding:28px 0;">No equipment available.</td></tr>
                        <% }
                            conn.close();
                        }catch(Exception e){ %>
                        <tr><td colspan="3" style="text-align:center;color:#b42318;padding:28px 0;">Unable to load equipment list.</td></tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
        </div>
    </main>
</div>
</body>
</html>

