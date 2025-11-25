<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sports Portal | Login</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">

    <style>
        :root {
            --bg: #f8f7f4;
            --card: #ffffff;
            --border: #ece8de;
            --primary: #ff7a18;
            --primary-dark: #ff5b00;
            --text: #1f2a37;
            --muted: #6b7280;
            --accent: #ffd7b2;
        }
        * { margin:0; padding:0; box-sizing:border-box; }
        body {
            font-family:'Inter',sans-serif;
            min-height:100vh;
            display:flex;
            justify-content:center;
            align-items:center;
            background:var(--bg);
            padding:20px;
        }
        .container {
            width:100%;
            max-width:420px;
            background:var(--card);
            border-radius:24px;
            padding:48px 40px;
            box-shadow:0 25px 60px rgba(255,122,24,0.15);
            border:1px solid var(--border);
        }
        .logo { display:flex; justify-content:center; margin-bottom:24px; }
        .logo img { width:78px; }
        .role-toggle {
            display:flex;
            justify-content:center;
            background:#f1eee7;
            border-radius:999px;
            padding:6px;
            gap:4px;
            margin-bottom:24px;
        }
        .role-toggle a {
            flex:1;
            text-align:center;
            text-decoration:none;
            color:var(--muted);
            font-weight:600;
            font-size:14px;
            padding:8px 0;
            border-radius:999px;
        }
        .role-toggle a.active {
            background:linear-gradient(135deg,var(--primary),var(--primary-dark));
            color:#fff;
        }
        .title {
            color:var(--text);
            text-align:center;
            font-size:28px;
            font-weight:600;
            margin-bottom:6px;
        }
        .subtitle {
            color:var(--muted);
            text-align:center;
            font-size:14px;
            margin-bottom:28px;
        }
        .form-group { margin-bottom:20px; }
        input {
            width:100%;
            padding:14px 16px;
            border:1.5px solid var(--border);
            background:#fdfbf6;
            color:var(--text);
            font-size:15px;
            border-radius:12px;
            outline:none;
            transition:all 0.25s ease;
        }
        input:focus {
            border-color:var(--primary);
            box-shadow:0 0 0 4px rgba(255,122,24,0.15);
            background:#fff;
        }
        button {
            width:100%;
            padding:14px;
            border:none;
            border-radius:12px;
            background:linear-gradient(135deg,var(--primary),var(--primary-dark));
            color:#fff;
            font-size:16px;
            font-weight:600;
            cursor:pointer;
            transition:transform 0.2s ease, box-shadow 0.2s ease;
        }
        button:hover { transform:translateY(-2px); box-shadow:0 12px 24px rgba(255,122,24,0.3); }
        .error {
            background:rgba(255,91,0,0.12);
            border:1px solid rgba(255,91,0,0.4);
            color:#c03600;
            padding:12px 14px;
            border-radius:12px;
            text-align:center;
            font-size:14px;
            margin-bottom:20px;
        }
        .footer {
            text-align:center;
            margin-top:28px;
            color:var(--muted);
            font-size:14px;
        }
        .footer a { color:var(--primary-dark); font-weight:600; text-decoration:none; }
    </style>
</head>
<body>

<div class="bg-gradient"></div>
<div class="bg-pattern"></div>

<div class="container">
    <div class="logo">
        <img src="https://cdn-icons-png.flaticon.com/512/1041/1041064.png" alt="Sports Logo">
    </div>
    <div class="role-toggle">
        <a href="index.jsp" class="active">Student</a>
        <a href="teacherLogin.jsp">Teacher</a>
    </div>
    <div class="title">Welcome Back</div>
    <div class="subtitle">Sign in to your account</div>

    <% if(request.getParameter("error") != null){ %>
    <div class="error">Invalid email or password. Please try again.</div>
    <% } %>

    <form action="login.jsp" method="post">
        <div class="form-group">
            <input type="text" name="roll_no" placeholder="Enter Roll Number">
        </div>
        <div class="form-group">
            <input type="password" name="password" placeholder="Password" required autocomplete="current-password">
        </div>
        <button type="submit">Sign In</button>
    </form>

    <div class="footer">
        Don't have an account? <a href="register.jsp">Sign up</a>
    </div>
</div>

</body>
</html>
