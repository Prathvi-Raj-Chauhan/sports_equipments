<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Sports Portal | Login</title>

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

        @keyframes lightPulse {
            0%,100% { opacity: 0.6; }
            50%     { opacity: 0.95; }
        }

        /* BALL ANIMATIONS */
        .ball {
            position: absolute;
            width: 90px;
            height: 90px;
            background-size: contain;
            background-repeat: no-repeat;
            animation: ballMove 7s linear infinite, spinBall 5s infinite linear;
            filter: drop-shadow(0 0 12px rgba(255,255,255,0.7));
        }


        @keyframes ballMove {
            0%   { transform: translate(0,0); }
            25%  { transform: translate(40px, -60px); }
            50%  { transform: translate(80px, 20px); }
            75%  { transform: translate(20px, 60px); }
            100% { transform: translate(0,0); }
        }

        @keyframes spinBall {
            from { transform: rotate(0deg); }
            to   { transform: rotate(360deg); }
        }

        /* LOGIN CARD */
        .container {
            background: rgba(0,0,0,0.5);
            padding: 35px;
            width: 380px;
            border-radius: 18px;
            backdrop-filter: blur(8px);
            box-shadow: 0 0 22px rgba(0,255,255,0.6);
            animation: slideUp 0.8s;
            position: relative;
            z-index: 10;
        }

        @keyframes slideUp {
            from { transform: translateY(40px); opacity: 0; }
            to   { transform: translateY(0); opacity: 1; }
        }

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

        /* ERROR */
        .error {
            background: #e53935;
            color: white;
            padding: 10px;
            border-radius: 6px;
            margin-bottom: 12px;
            text-align: center;
            font-weight: bold;
            animation: shake 0.3s;
        }

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

        .footer a {
            color: cyan;
            font-weight: bold;
            text-decoration: none;
        }

        .footer a:hover {
            color: yellow;
        }

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

<!-- LOGIN CARD -->
<div class="container">

    <!-- LOGO -->
    <div class="logo">
        <img src="https://cdn-icons-png.flaticon.com/512/1041/1041064.png" alt="Sports Logo">
    </div>

    <div class="title">SPORTS LOGIN</div>

    <% if(request.getParameter("error") != null){ %>
    <div class="error">Invalid Credentials!</div>
    <% } %>

    <form action="login.jsp" method="post">
        <input type="email" name="email" placeholder="Enter Email" required>
        <input type="password" name="password" placeholder="Enter Password" required>
        <button type="submit">Login</button>
    </form>

    <div class="footer">
        New user? <a href="register.jsp">Register Here</a>
    </div>
</div>

</body>
</html>
