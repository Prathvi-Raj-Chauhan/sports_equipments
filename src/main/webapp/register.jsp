<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sports Portal | Register</title>
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
        .register-container {
            width:100%;
            max-width:440px;
            background:var(--card);
            border-radius:26px;
            padding:48px 40px;
            box-shadow:0 25px 60px rgba(255,122,24,0.16);
            border:1px solid var(--border);
        }
        .logo { display:flex; justify-content:center; margin-bottom:20px; }
        .logo img { width:78px; }
        .role-toggle{
            display:flex;
            justify-content:center;
            background:#f1eee7;
            border-radius:999px;
            padding:6px;
            gap:4px;
            margin-bottom:20px;
        }
        .role-toggle a{
            flex:1;
            text-align:center;
            text-decoration:none;
            color:var(--muted);
            font-weight:600;
            font-size:14px;
            padding:8px 0;
            border-radius:999px;
        }
        .role-toggle a.active{
            background:linear-gradient(135deg,var(--primary),var(--primary-dark));
            color:#fff;
        }
        .title{text-align:center;color:var(--text);font-size:28px;margin-bottom:6px;}
        .subtitle{text-align:center;color:var(--muted);margin-bottom:24px;}
        .form-group{margin-bottom:18px;}
        input{
            width:100%;
            padding:14px 16px;
            border:1.5px solid var(--border);
            border-radius:12px;
            background:#fdfbf6;
            font-size:15px;
            color:var(--text);
            outline:none;
            transition:all .25s ease;
        }
        input:focus{
            border-color:var(--primary);
            box-shadow:0 0 0 4px rgba(255,122,24,0.15);
            background:#fff;
        }
        button{
            width:100%;
            padding:14px;
            border:none;
            border-radius:12px;
            background:linear-gradient(135deg,var(--primary),var(--primary-dark));
            color:#fff;
            font-size:16px;
            font-weight:600;
            cursor:pointer;
            box-shadow:0 12px 24px rgba(255,122,24,0.25);
        }
        button:hover{transform:translateY(-2px);}
        .error,.success{
            padding:12px 14px;
            border-radius:10px;
            margin-bottom:18px;
            font-size:14px;
        }
        .error{background:rgba(255,91,0,0.12);color:#b42318;border:1px solid rgba(255,91,0,0.4);}
        .success{background:rgba(34,197,94,0.12);color:#1f9254;border:1px solid rgba(34,197,94,0.35);}
        .footer{text-align:center;margin-top:24px;color:var(--muted);}
        .footer a{color:var(--primary-dark);font-weight:600;text-decoration:none;}
    </style>
</head>
<body>

<div class="bg-gradient"></div>
<div class="bg-pattern"></div>

<div class="register-container">
    <div class="logo">
        <img src="https://cdn-icons-png.flaticon.com/512/1041/1041064.png" alt="Sports Logo">
    </div>

    <div class="role-toggle">
        <a href="register.jsp" class="active">Student</a>
        <a href="teacher_register.jsp">Teacher</a>
    </div>

    <div class="title">Create Account</div>
    <div class="subtitle">Join us to get started</div>

    <% if(request.getParameter("error") != null){ %>
    <div class="error">This email is already registered. Please use a different email.</div>
    <% } %>

    <% if(request.getParameter("success") != null){ %>
    <div class="success">Account created successfully! You can now sign in.</div>
    <% } %>

    <form action="registerProcess.jsp" method="post">
        <div class="form-group">
            <input type="text" name="name" placeholder="Full Name" required autocomplete="name">
        </div>
        <div class="form-group">
            <input type="number" name="rollNo" placeholder="Roll Number" required autocomplete="email">
        </div>
        <div class="form-group">
            <input type="password" name="password" placeholder="Password" required autocomplete="new-password">
        </div>
        <button type="submit">Create Account</button>
    </form>

    <div class="footer">
        Already have an account? <a href="index.jsp">Sign in</a>
    </div>
</div>

</body>
</html>
