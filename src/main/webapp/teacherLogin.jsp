<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sports Portal | Teacher Login</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">

    <style>
        /* === Same styles as student login === */
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body {
            font-family: 'Inter', sans-serif;
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            background: linear-gradient(135deg, #0a1929 0%, #1a2332 50%, #0f1419 100%);
            padding: 20px;
            position: relative;
            overflow-x: hidden;
        }

        .bg-gradient {
            position: fixed; top: 0; left: 0; width: 100%; height: 100%;
            background: radial-gradient(circle at 20% 30%, rgba(0,150,255,0.15), transparent 50%),
            radial-gradient(circle at 80% 70%, rgba(0,200,255,0.1), transparent 50%);
        }

        .bg-pattern {
            position: fixed; top: 0; left: 0; width: 100%; height: 100%;
            background-image: repeating-linear-gradient(0deg, transparent, transparent 2px, rgba(255,255,255,0.02) 2px, rgba(255,255,255,0.02) 4px);
        }

        .container {
            background: rgba(255,255,255,0.05);
            backdrop-filter: blur(20px) saturate(180%);
            padding: 48px 40px;
            width: 100%;
            max-width: 420px;
            border-radius: 24px;
            border: 1px solid rgba(255,255,255,0.1);
            box-shadow: 0 8px 32px rgba(0,0,0,0.3);
            position: relative;
            z-index: 10;
        }

        .logo { display: flex; justify-content: center; margin-bottom: 26px; }
        .logo img { width: 74px; filter: drop-shadow(0 4px 12px rgba(0,150,255,0.4)); }

        /* ---------- ADDED TOGGLE BUTTON (SAME AS STUDENT PAGE) ---------- */
        .role-toggle {
            display:flex;
            justify-content:center;
            background:rgba(255,255,255,0.08);
            border-radius:999px;
            padding:6px;
            gap:4px;
            margin-bottom:24px;
            border:1px solid rgba(255,255,255,0.15);
        }
        .role-toggle a {
            flex:1;
            text-align:center;
            text-decoration:none;
            color:rgba(255,255,255,0.6);
            font-weight:600;
            font-size:14px;
            padding:8px 0;
            border-radius:999px;
            transition:0.3s;
        }
        .role-toggle a.active {
            background: linear-gradient(135deg,#0096ff,#0072e5);
            color:#fff;
        }
        .role-toggle a:hover:not(.active) {
            background:rgba(255,255,255,0.12);
        }
        /* --------------------------------------------------------------- */

        .title { color: #fff; text-align:center; font-size:28px; margin-bottom:6px; }
        .subtitle { color:rgba(255,255,255,0.6); text-align:center; margin-bottom:28px; }

        .form-group { margin-bottom:24px; }
        input {
            width: 100%; padding:14px 16px;
            border-radius:12px;
            border:1.5px solid rgba(255,255,255,0.15);
            background:rgba(255,255,255,0.07);
            color:#fff;
            font-size:15px;
            outline:none;
            transition:0.3s;
        }
        input::placeholder { color:rgba(255,255,255,0.4); }
        input:focus {
            background:rgba(255,255,255,0.1);
            border-color:#0096ff;
            box-shadow:0 0 0 4px rgba(0,150,255,0.15);
        }

        button {
            width:100%; padding:14px;
            border:none;
            border-radius:12px;
            background:linear-gradient(135deg,#0096ff,#0072e5);
            color:#fff; font-size:16px; font-weight:600;
            cursor:pointer;
            box-shadow:0 4px 12px rgba(0,150,255,0.3);
            transition:0.3s;
        }

        button:hover {
            transform:translateY(-2px);
            box-shadow:0 8px 20px rgba(0,150,255,0.4);
        }

        .error {
            background:rgba(255,80,80,0.18);
            color:#ff8b92;
            border:1px solid rgba(255,80,80,0.35);
            padding:12px 14px;
            border-radius:12px;
            margin-bottom:22px;
            text-align:center;
        }

        .footer { text-align:center; margin-top:26px; color:rgba(255,255,255,0.6); }
        .footer a { color:#00a8ff; font-weight:600; text-decoration:none; }
    </style>
</head>

<body>

<div class="bg-gradient"></div>
<div class="bg-pattern"></div>

<div class="container">

    <div class="logo">
        <img src="https://cdn-icons-png.flaticon.com/512/3135/3135715.png" alt="Teacher Logo">
    </div>

    <!-- 🔥 ADDED TOGGLE BUTTON -->
    <div class="role-toggle">
        <a href="index.jsp">Student</a>
        <a href="teacherLogin.jsp" class="active">Teacher</a>
    </div>

    <div class="title">Teacher Login</div>
    <div class="subtitle">Sign in with your mobile number</div>

    <% if(request.getParameter("error") != null){ %>
    <div class="error">Invalid mobile number or password. Please try again.</div>
    <% } %>

    <form action="teacher_login_process.jsp" method="post">
        <div class="form-group">
            <input type="text" name="mobile_no" placeholder="Enter Mobile Number" required>
        </div>

        <div class="form-group">
            <input type="password" name="password" placeholder="Password" required>
        </div>

        <button type="submit">Sign In</button>
    </form>

    <div class="footer">
        Don't have an account? <a href="teacher_register.jsp">Sign up</a>
    </div>

</div>

</body>
</html>
