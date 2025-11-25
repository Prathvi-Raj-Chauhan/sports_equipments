<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sports Portal | Login</title>
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
            display: flex;
            justify-content: center;
            align-items: center;
            background: linear-gradient(135deg, #0a1929 0%, #1a2332 50%, #0f1419 100%);
            padding: 20px;
            position: relative;
            overflow-x: hidden;
            animation: fadeIn 0.8s ease;
        }

        @keyframes fadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
        }

        /* Subtle Background Effects */
        .bg-gradient {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: 
                radial-gradient(circle at 20% 30%, rgba(0, 150, 255, 0.15) 0%, transparent 50%),
                radial-gradient(circle at 80% 70%, rgba(0, 200, 255, 0.1) 0%, transparent 50%);
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
                repeating-linear-gradient(0deg, transparent, transparent 2px, rgba(255,255,255,0.02) 2px, rgba(255,255,255,0.02) 4px);
            pointer-events: none;
            z-index: 0;
        }

        /* Login Card */
        .container {
            background: rgba(255, 255, 255, 0.05);
            backdrop-filter: blur(20px) saturate(180%);
            -webkit-backdrop-filter: blur(20px) saturate(180%);
            padding: 48px 40px;
            width: 100%;
            max-width: 420px;
            border-radius: 24px;
            border: 1px solid rgba(255, 255, 255, 0.1);
            box-shadow: 
                0 8px 32px rgba(0, 0, 0, 0.3),
                0 0 0 1px rgba(255, 255, 255, 0.05) inset,
                0 2px 8px rgba(0, 150, 255, 0.2);
            animation: slideUp 0.6s cubic-bezier(0.16, 1, 0.3, 1);
            position: relative;
            z-index: 10;
        }

        @keyframes slideUp {
            from { 
                transform: translateY(30px); 
                opacity: 0; 
            }
            to { 
                transform: translateY(0); 
                opacity: 1; 
            }
        }

        /* Logo */
        .logo {
            display: flex;
            justify-content: center;
            margin-bottom: 32px;
        }

        .logo img {
            width: 80px;
            height: 80px;
            filter: drop-shadow(0 4px 12px rgba(0, 150, 255, 0.4));
            transition: transform 0.3s ease;
        }

        .logo:hover img {
            transform: scale(1.05) rotate(5deg);
        }

        /* Title */
        .title {
            color: #ffffff;
            text-align: center;
            font-size: 28px;
            font-weight: 600;
            margin-bottom: 8px;
            letter-spacing: -0.5px;
        }

        .subtitle {
            color: rgba(255, 255, 255, 0.6);
            text-align: center;
            font-size: 14px;
            margin-bottom: 32px;
            font-weight: 400;
        }

        /* Form */
        .form-group {
            margin-bottom: 24px;
            position: relative;
        }

        input {
            width: 100%;
            padding: 14px 16px;
            border: 1.5px solid rgba(255, 255, 255, 0.1);
            background: rgba(255, 255, 255, 0.05);
            color: #ffffff;
            font-size: 15px;
            border-radius: 12px;
            outline: none;
            transition: all 0.3s ease;
            font-family: inherit;
        }

        input::placeholder { 
            color: rgba(255, 255, 255, 0.4); 
        }

        input:focus {
            border-color: rgba(0, 150, 255, 0.6);
            background: rgba(255, 255, 255, 0.08);
            box-shadow: 0 0 0 4px rgba(0, 150, 255, 0.1);
            transform: translateY(-1px);
        }

        input:hover:not(:focus) {
            border-color: rgba(255, 255, 255, 0.2);
            background: rgba(255, 255, 255, 0.06);
        }

        /* Button */
        button {
            width: 100%;
            padding: 14px;
            margin-top: 8px;
            border: none;
            background: linear-gradient(135deg, #0096ff 0%, #0072e5 100%);
            color: #ffffff;
            font-size: 16px;
            font-weight: 600;
            border-radius: 12px;
            cursor: pointer;
            transition: all 0.3s ease;
            font-family: inherit;
            box-shadow: 0 4px 12px rgba(0, 150, 255, 0.3);
            position: relative;
            overflow: hidden;
        }

        button::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255,255,255,0.2), transparent);
            transition: left 0.5s;
        }

        button:hover::before {
            left: 100%;
        }

        button:hover {
            background: linear-gradient(135deg, #00a8ff 0%, #0088ff 100%);
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(0, 150, 255, 0.4);
        }

        button:active {
            transform: translateY(0);
            box-shadow: 0 2px 8px rgba(0, 150, 255, 0.3);
        }

        /* Error Message */
        .error {
            background: rgba(220, 53, 69, 0.15);
            border: 1px solid rgba(220, 53, 69, 0.3);
            color: #ff6b7a;
            padding: 12px 16px;
            border-radius: 12px;
            margin-bottom: 24px;
            text-align: center;
            font-size: 14px;
            font-weight: 500;
            animation: shake 0.4s ease;
        }

        @keyframes shake {
            0%, 100% { transform: translateX(0); }
            25% { transform: translateX(-8px); }
            75% { transform: translateX(8px); }
        }

        /* Footer */
        .footer {
            text-align: center;
            margin-top: 32px;
            color: rgba(255, 255, 255, 0.6);
            font-size: 14px;
        }

        .footer a {
            color: #0096ff;
            font-weight: 500;
            text-decoration: none;
            transition: color 0.3s ease;
            margin-left: 4px;
        }

        .footer a:hover {
            color: #00a8ff;
            text-decoration: underline;
        }

        /* Responsive Design */
        @media (max-width: 480px) {
            .container {
                padding: 36px 28px;
                border-radius: 20px;
            }

            .title {
                font-size: 24px;
            }

            .logo img {
                width: 64px;
                height: 64px;
            }

            input, button {
                padding: 12px 14px;
                font-size: 15px;
            }
        }

        @media (max-width: 360px) {
            .container {
                padding: 32px 24px;
            }

            .title {
                font-size: 22px;
            }
        }

        /* Loading State */
        button:disabled {
            opacity: 0.6;
            cursor: not-allowed;
            transform: none !important;
        }
    </style>
</head>
<body>

<div class="bg-gradient"></div>
<div class="bg-pattern"></div>

<div class="container">
    <div class="logo">
        <img src="https://cdn-icons-png.flaticon.com/512/1041/1041064.png" alt="Sports Logo">
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
