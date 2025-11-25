<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Sports Portal | Register</title>
    <style>
        body {
            margin: 0;
            font-family: "Roboto", sans-serif;
            height: 100vh;
            overflow: hidden;
            display: flex;
            justify-content: center;
            align-items: center;
            background: #00172D;
            animation: fadeIn 1s ease;
        }



        /* STADIUM LIGHT GLOW */
        .lights {
            position: absolute;
            width: 100%;
            height: 100%;
            background: radial-gradient(circle at 50% -20%, rgba(255,255,255,0.55), transparent 70%);
            pointer-events: none;
            animation: lightPulse 4s ease-in-out infinite;
        }
        @keyframes lightPulse { 0%,100% { opacity: 0.6; } 50% { opacity: 0.95; } }

        /* BALL ANIMATIONS */

        @keyframes ballMove {
            0%   { transform: translate(0,0); }
            25%  { transform: translate(40px, -60px); }
            50%  { transform: translate(80px, 20px); }
            75%  { transform: translate(20px, 60px); }
            100% { transform: translate(0,0); }
        }
        @keyframes spinBall { from { transform: rotate(0deg); } to { transform: rotate(360deg); } }

        /* REGISTER CARD */
        .register-container {
            background: rgba(0,0,0,0.55);
            padding: 35px;
            width: 400px;
            border-radius: 18px;
            backdrop-filter: blur(8px);
            box-shadow: 0 0 22px rgba(0,255,255,0.6);
            animation: slideUp 0.8s;
            position: relative;
            z-index: 10;
        }
        @keyframes slideUp { from { opacity:0; transform:translateY(40px); } to { opacity:1; transform:translateY(0); } }

        /* LOGO */
        .logo {
            display: flex;
            justify-content: center;
            margin-bottom: 18px;
        }
        .logo img {
            width: 95px;
            filter: drop-shadow(0 0 8px #00e5ff);
        }

        /* TITLE */
        .title {
            color: #ffffff;
            text-align: center;
            font-size: 26px;
            margin-bottom: 20px;
            font-weight: 700;
            text-shadow: 0 0 12px cyan;
        }

        /* INPUTS */
        input {
            width: 100%;
            padding: 12px;
            margin-top: 14px;
            border: none;
            border-bottom: 3px solid #00e5ff;
            background: transparent;
            color: white;
            font-size: 16px;
            outline: none;
            transition: 0.4s;
        }
        input::placeholder { color: #b2ebf2; }
        input:focus { transform: scale(1.04); border-bottom-color: yellow; }

        /* BUTTON */
        button {
            width: 100%;
            padding: 12px;
            margin-top: 22px;
            border: none;
            background: #00e5ff;
            color: #002b3d;
            font-size: 17px;
            font-weight: bold;
            border-radius: 6px;
            cursor: pointer;
            transition: 0.4s;
        }
        button:hover {
            background: yellow;
            transform: translateY(-4px);
        }

        /* MESSAGES */
        .error, .success {
            padding: 10px;
            text-align: center;
            border-radius: 6px;
            margin-bottom: 12px;
            font-weight: bold;
            animation: shake 0.3s;
        }
        .error { background: #e53935; color: white; }
        .success { background: #43a047; color: white; }

        @keyframes shake {
            0%   { transform: translateX(0); }
            25%  { transform: translateX(-5px); }
            50%  { transform: translateX(5px); }
            75%  { transform: translateX(-5px); }
            100% { transform: translateX(0); }
        }

        .footer {
            text-align: center;
            margin-top: 18px;
            color: white;
        }
        .footer a { color: cyan; font-weight: bold; text-decoration: none; }
        .footer a:hover { color: yellow; }

    </style>
</head>
<body>

<!-- Grass Background -->
<div class="grass"></div>

<!-- Stadium Lights -->
<div class="lights"></div>

<!-- Animated Sports Balls -->
<div class="ball"></div>
<div class="ball"></div>
<div class="ball"></div>

<!-- REGISTER CARD -->
<div class="register-container">

    <!-- LOGO -->
    <div class="logo">
        <img src="https://cdn-icons-png.flaticon.com/512/1041/1041064.png" alt="Sports Logo">
    </div>

    <div class="title">Create Account</div>

    <% if(request.getParameter("error") != null){ %>
    <div class="error">Email already exists!</div>
    <% } %>

    <% if(request.getParameter("success") != null){ %>
    <div class="success">Account Created Successfully!</div>
    <% } %>

    <form action="registerProcess.jsp" method="post">
        <input type="text" name="name" placeholder="Full Name" required>
        <input type="email" name="email" placeholder="Email Address" required>
        <input type="password" name="password" placeholder="Password" required>
        <button type="submit">Register</button>
    </form>

    <div class="footer">
        Already have an account? <a href="index.jsp">Login Here</a>
    </div>
</div>

</body>
</html>
