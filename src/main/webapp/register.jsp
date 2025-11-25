<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sports Portal | Register</title>
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

        /* Register Card */
        .register-container {
            background: rgba(255, 255, 255, 0.05);
            backdrop-filter: blur(20px) saturate(180%);
            -webkit-backdrop-filter: blur(20px) saturate(180%);
            padding: 48px 40px;
            width: 100%;
            max-width: 440px;
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
            margin-bottom: 20px;
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

        /* Messages */
        .error, .success {
            padding: 12px 16px;
            text-align: center;
            border-radius: 12px;
            margin-bottom: 24px;
            font-size: 14px;
            font-weight: 500;
            animation: slideDown 0.3s ease;
        }

        @keyframes slideDown {
            from {
                opacity: 0;
                transform: translateY(-10px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .error { 
            background: rgba(220, 53, 69, 0.15);
            border: 1px solid rgba(220, 53, 69, 0.3);
            color: #ff6b7a;
        }

        .success { 
            background: rgba(40, 167, 69, 0.15);
            border: 1px solid rgba(40, 167, 69, 0.3);
            color: #6bcf7f;
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
            .register-container {
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
            .register-container {
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

<div class="register-container">
    <div class="logo">
        <img src="https://cdn-icons-png.flaticon.com/512/1041/1041064.png" alt="Sports Logo">
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
            <input type="email" name="email" placeholder="Email Address" required autocomplete="email">
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
