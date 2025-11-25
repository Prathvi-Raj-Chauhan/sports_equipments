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
            animation: fadeIn 0.8s ease;
        }

        @keyframes fadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
        }

        /* Background Effects */
        .bg-gradient {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: 
                radial-gradient(circle at 20% 30%, rgba(0, 150, 255, 0.12) 0%, transparent 50%),
                radial-gradient(circle at 80% 70%, rgba(0, 200, 255, 0.08) 0%, transparent 50%);
            pointer-events: none;
            z-index: 0;
        }

        .bg-pattern {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-image: 
                repeating-linear-gradient(0deg, transparent, transparent 2px, rgba(255,255,255,0.015) 2px, rgba(255,255,255,0.015) 4px);
            pointer-events: none;
            z-index: 0;
        }

        /* Sidebar */
        .sidebar {
            position: fixed;
            left: 0;
            top: 0;
            width: 280px;
            height: 100vh;
            background: rgba(255, 255, 255, 0.05);
            backdrop-filter: blur(20px) saturate(180%);
            -webkit-backdrop-filter: blur(20px) saturate(180%);
            border-right: 1px solid rgba(255, 255, 255, 0.1);
            display: flex;
            flex-direction: column;
            padding: 32px 0;
            z-index: 100;
            box-shadow: 2px 0 20px rgba(0, 0, 0, 0.2);
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
            color: rgba(255, 255, 255, 0.5);
            font-weight: 400;
        }

        .sidebar-nav {
            flex: 1;
            padding: 0 16px;
        }

        .sidebar-nav a {
            display: flex;
            align-items: center;
            color: rgba(255, 255, 255, 0.7);
            text-decoration: none;
            padding: 12px 16px;
            margin-bottom: 4px;
            border-radius: 12px;
            font-size: 15px;
            font-weight: 500;
            transition: all 0.3s ease;
            position: relative;
        }

        .sidebar-nav a:hover {
            background: rgba(255, 255, 255, 0.08);
            color: #ffffff;
            transform: translateX(4px);
        }

        .sidebar-nav a.active {
            background: rgba(0, 150, 255, 0.15);
            color: #0096ff;
            border-left: 3px solid #0096ff;
        }

        .sidebar-footer {
            padding: 24px;
            border-top: 1px solid rgba(255, 255, 255, 0.1);
        }

        .sidebar-footer a {
            display: flex;
            align-items: center;
            color: rgba(255, 100, 100, 0.8);
            text-decoration: none;
            padding: 12px 16px;
            border-radius: 12px;
            font-size: 15px;
            font-weight: 500;
            transition: all 0.3s ease;
        }

        .sidebar-footer a:hover {
            background: rgba(255, 100, 100, 0.1);
            color: #ff6464;
        }

        /* Main Content */
        .main {
            margin-left: 280px;
            padding: 40px;
            position: relative;
            z-index: 10;
            min-height: 100vh;
        }

        .main-header {
            margin-bottom: 40px;
        }

        .main-header h1 {
            font-size: 32px;
            font-weight: 700;
            color: #ffffff;
            margin-bottom: 8px;
            letter-spacing: -0.5px;
        }

        .main-header p {
            font-size: 15px;
            color: rgba(255, 255, 255, 0.6);
            font-weight: 400;
        }

        /* Dashboard Cards */
        .cards {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: 24px;
            margin-top: 24px;
        }

        .card {
            background: rgba(255, 255, 255, 0.05);
            backdrop-filter: blur(20px) saturate(180%);
            -webkit-backdrop-filter: blur(20px) saturate(180%);
            padding: 28px;
            border-radius: 20px;
            border: 1px solid rgba(255, 255, 255, 0.1);
            box-shadow: 
                0 4px 16px rgba(0, 0, 0, 0.2),
                0 0 0 1px rgba(255, 255, 255, 0.05) inset;
            transition: all 0.4s cubic-bezier(0.16, 1, 0.3, 1);
            position: relative;
            overflow: hidden;
        }

        .card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 3px;
            background: linear-gradient(90deg, #0096ff, #00a8ff);
            transform: scaleX(0);
            transition: transform 0.4s ease;
        }

        .card:hover {
            transform: translateY(-4px);
            box-shadow: 
                0 8px 24px rgba(0, 0, 0, 0.3),
                0 0 0 1px rgba(255, 255, 255, 0.1) inset,
                0 0 40px rgba(0, 150, 255, 0.15);
            border-color: rgba(0, 150, 255, 0.3);
        }

        .card:hover::before {
            transform: scaleX(1);
        }

        .card h3 {
            font-size: 14px;
            font-weight: 500;
            color: rgba(255, 255, 255, 0.6);
            margin-bottom: 16px;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .card .value {
            font-size: 36px;
            font-weight: 700;
            color: #ffffff;
            line-height: 1.2;
            letter-spacing: -1px;
        }

        .card .icon {
            position: absolute;
            top: 24px;
            right: 24px;
            width: 48px;
            height: 48px;
            background: rgba(0, 150, 255, 0.15);
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 24px;
            opacity: 0.6;
        }

        /* Mobile Menu Toggle */
        .menu-toggle {
            display: none;
            position: fixed;
            top: 20px;
            left: 20px;
            z-index: 1000;
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255, 255, 255, 0.2);
            border-radius: 12px;
            padding: 12px;
            cursor: pointer;
            color: #ffffff;
            font-size: 20px;
        }

        /* Responsive Design */
        @media (max-width: 1024px) {
            .cards {
                grid-template-columns: repeat(auto-fit, minmax(240px, 1fr));
                gap: 20px;
            }
        }

        @media (max-width: 768px) {
            .menu-toggle {
                display: block;
            }

            .sidebar {
                transform: translateX(-100%);
                transition: transform 0.3s ease;
            }

            .sidebar.open {
                transform: translateX(0);
            }

            .main {
                margin-left: 0;
                padding: 24px 20px;
            }

            .main-header h1 {
                font-size: 28px;
            }

            .cards {
                grid-template-columns: 1fr;
                gap: 16px;
            }

            .card {
                padding: 24px;
            }
        }

        @media (max-width: 480px) {
            .main {
                padding: 20px 16px;
            }

            .main-header h1 {
                font-size: 24px;
            }

            .card {
                padding: 20px;
            }

            .card .value {
                font-size: 32px;
            }
        }

        /* Loading Animation */
        @keyframes pulse {
            0%, 100% { opacity: 1; }
            50% { opacity: 0.5; }
        }

        .loading {
            animation: pulse 1.5s ease-in-out infinite;
        }
    </style>
</head>
<body>

<div class="bg-gradient"></div>
<div class="bg-pattern"></div>

<!-- Mobile Menu Toggle -->
<div class="menu-toggle" onclick="toggleSidebar()">☰</div>

<!-- Sidebar -->
<div class="sidebar" id="sidebar">
    <div class="sidebar-header">
        <h2>Welcome back!</h2>
        <p><%=username%></p>
    </div>
    
    <nav class="sidebar-nav">
        <a href="studentDashboard.jsp" class="active">Dashboard</a>
        <a href="equipmentList.jsp">Equipment List</a>
        <a href="viewIssued.jsp">My Issued Items</a>
        <a href="profile.jsp">Profile</a>
    </nav>

    <div class="sidebar-footer">
        <a href="logout.jsp">Logout</a>
    </div>
</div>

<!-- Main Content -->
<div class="main">
    <div class="main-header">
        <h1>Dashboard</h1>
        <p>Overview of your sports equipment management</p>
    </div>

    <div class="cards">
        <div class="card">

            <h3>Total Equipments</h3>
            <div class="value">
                <%
                    try{
                        String url="jdbc:mysql://localhost:3306/sportsdb";
                        String dbUser="root";
                        String dbPass="@Rajput9405";
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        Connection conn=DriverManager.getConnection(url,dbUser,dbPass);
                        Statement stmt=conn.createStatement();
                        ResultSet rs=stmt.executeQuery("SELECT COUNT(*) FROM equipment");
                        if(rs.next()){ out.print(rs.getInt(1)); }
                        conn.close();
                    }catch(Exception e){ out.print("0"); }
                %>
            </div>
        </div>

        <div class="card">
            <div class="icon">📦</div>
            <h3>Issued Items</h3>
            <div class="value">
                <%
                    try{
                        String url="jdbc:mysql://localhost:3306/sportsdb";
                        String dbUser="root";
                        String dbPass="@Rajput9405";
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        Connection conn=DriverManager.getConnection(url,dbUser,dbPass);
                        Statement stmt=conn.createStatement();
                        int sid = (Integer) session.getAttribute("student_id");
                        ResultSet rs=stmt.executeQuery("SELECT COUNT(*) FROM issued WHERE student_id="+sid);
                        if(rs.next()){ out.print(rs.getInt(1)); }
                        conn.close();
                    }catch(Exception e){ out.print("0"); }
                %>
            </div>
        </div>
    </div>
</div>

<script>
    function toggleSidebar() {
        const sidebar = document.getElementById('sidebar');
        sidebar.classList.toggle('open');
    }

    // Close sidebar when clicking outside on mobile
    document.addEventListener('click', function(event) {
        const sidebar = document.getElementById('sidebar');
        const menuToggle = document.querySelector('.menu-toggle');
        
        if (window.innerWidth <= 768) {
            if (!sidebar.contains(event.target) && !menuToggle.contains(event.target)) {
                sidebar.classList.remove('open');
            }
        }
    });

    // Close sidebar on window resize
    window.addEventListener('resize', function() {
        const sidebar = document.getElementById('sidebar');
        if (window.innerWidth > 768) {
            sidebar.classList.remove('open');
        }
    });
</script>

</body>
</html>
