<%@ page import="java.sql.*" %>
<%@ page session="true" %>
<%
    if(session.getAttribute("student_id") == null){
        response.sendRedirect("login.jsp");
        return;
    }
    String username = (String) session.getAttribute("username");
%>

<!DOCTYPE html>
<html>
<head>
    <title>Student Dashboard | Sports Portal</title>
    <style>
        body {
            margin: 0;
            font-family: "Roboto", sans-serif;
            height: 100vh;
            overflow-x: hidden;
            background: #00172D;
            animation: fadeIn 1s ease;
        }

        /* Moving Grass Background */
        .grass {
            position: absolute;
            width: 300%;
            height: 100%;
            background: url("https://img.freepik.com/premium-photo/green-grass-texture-background_110893-199.jpg") repeat-x;
            opacity: 0.25;
            animation: moveGrass 28s linear infinite;
            z-index: 0;
        }
        @keyframes moveGrass { from { transform: translateX(0); } to { transform: translateX(-100%); } }

        /* Stadium Lights */
        .lights {
            position: absolute;
            width: 100%;
            height: 100%;
            background: radial-gradient(circle at 50% -20%, rgba(255,255,255,0.55), transparent 70%);
            pointer-events: none;
            animation: lightPulse 4s ease-in-out infinite;
            z-index: 0;
        }
        @keyframes lightPulse { 0%,100% { opacity:0.6 } 50% { opacity:0.95 } }

        /* Sidebar */
        .sidebar {
            position: fixed;
            margin-left: auto;
            left: 0;
            top: 0;
            width: 300px;
            height: 100%;
            background: rgba(0,0,0,0.7);
            backdrop-filter: blur(6px);
            color: white;
            display: flex;
            flex-direction: column;
            align-items: center;
            padding-top: 30px;
            box-shadow: 2px 0 15px rgba(0,255,255,0.5);
            z-index: 10;
        }
        .sidebar h2 {
            margin-bottom: 40px;
            text-align: center;
            color: cyan;
            text-shadow: 0 0 6px #00e5ff;
        }
        .sidebar a {
            color: white;
            text-decoration: none;
            margin: 15px 0;
            font-size: 16px;
            width: 100%;
            padding: 10px 20px;
            border-radius: 6px;
            transition: 0.3s;
        }
        .sidebar a:hover {
            background: #00e5ff;
            color: #002b3d;
            transform: translateX(5px);
        }

        /* Main Content */
        .main {
            margin-left: 240px;
            padding: 30px;
            color: white;
            position: relative;
            z-index: 10;
        }
        .main h1 {
            text-shadow: 0 0 12px cyan;
        }

        /* Dashboard Cards */
        .cards {
            display: flex;
            flex-wrap: wrap;
            gap: 20px;
            margin-top: 20px;
        }
        .card {
            background: rgba(0,0,0,0.55);
            backdrop-filter: blur(6px);
            padding: 20px;
            width: 250px;
            border-radius: 12px;
            box-shadow: 0 0 15px rgba(0,255,255,0.5);
            transition: 0.4s;
        }
        .card:hover {
            transform: translateY(-6px);
            box-shadow: 0 0 22px rgba(0,255,255,0.8);
        }
        .card h3 {
            margin: 0;
            color: #00e5ff;
            font-size: 18px;
            margin-bottom: 10px;
        }
        .card p {
            font-size: 24px;
            font-weight: bold;
            color: white;
        }

        /* Flying Balls */

        @keyframes ballMove {
            0%   { transform: translate(0,0); }
            25%  { transform: translate(60px, -50px); }
            50%  { transform: translate(120px, 20px); }
            75%  { transform: translate(20px, 60px); }
            100% { transform: translate(0,0); }
        }
        @keyframes spinBall { from { transform: rotate(0deg); } to { transform: rotate(360deg); } }

        @keyframes fadeIn { from { opacity:0; } to { opacity:1; } }

        /* Responsive */
        @media(max-width: 800px){
            .main { margin-left: 0; padding: 20px; }
            .cards { flex-direction: column; align-items: center; }
            .sidebar { width: 100%; height: auto; flex-direction: row; justify-content: space-around; padding: 15px; }
            .sidebar a { margin: 5px; }
        }
    </style>
</head>
<body>

<!-- Background Effects -->
<div class="grass"></div>
<div class="lights"></div>
<div class="ball"></div>
<div class="ball"></div>
<div class="ball"></div>

<!-- Sidebar -->
<div class="sidebar">
    <h2>Welcome, <%=username%>!</h2>
    <a href="studentDashboard.jsp">Dashboard</a>
    <a href="equipmentList.jsp">Equipment List</a>
    <a href="viewIssued.jsp">My Issued Items</a>
    <a href="profile.jsp">Profile</a>
    <a href="logout.jsp">Logout</a>
</div>

<!-- Main Content -->
<div class="main">
    <h1>Student Dashboard</h1>
    <div class="cards">
        <div class="card">
            <h3>Total Equipments</h3>
            <p>
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
            </p>
        </div>

        <div class="card">
            <h3>Issued Items</h3>
            <p>
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
            </p>
        </div>
    </div>
</div>

</body>
</html>
