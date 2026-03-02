<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Hệ thống Quản lý Sinh viên - Nhóm 5</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <!-- Font Awesome cho icon -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap');

        :root {
            --bg-gradient-light: linear-gradient(135deg, #a5b4fc 0%, #818cf8 100%);
            --bg-gradient-dark: linear-gradient(135deg, #1e1b4b 0%, #312e81 100%);
            --primary-indigo: #6366f1;
        }

        body {
            font-family: 'Inter', sans-serif;
            margin: 0;
            padding: 0;
            min-height: 100vh;
            width: 100vw;
            display: flex;
            flex-direction: column;
            transition: all 0.5s ease;
            position: relative;
            overflow-x: hidden;
        }

        body.light { background: var(--bg-gradient-light); }
        body.dark { background: var(--bg-gradient-dark); }

        /* Floating Background Shapes */
        .shape {
            position: absolute;
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(5px);
            border-radius: 24px;
            z-index: 0;
            animation: float 10s infinite ease-in-out;
        }

        @keyframes float {
            0%, 100% { transform: translate(0, 0) rotate(0deg); }
            33% { transform: translate(30px, -50px) rotate(10deg); }
            66% { transform: translate(-20px, 20px) rotate(-10deg); }
        }

        /* Glassmorphism Card */
        .glass-card {
            background: rgba(255, 255, 255, 0.15);
            backdrop-filter: blur(25px);
            -webkit-backdrop-filter: blur(25px);
            border: 1px solid rgba(255, 255, 255, 0.2);
            border-radius: 40px;
            padding: 50px 40px;
            width: 100%;
            max-width: 450px;
            box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.2);
            z-index: 10;
            position: relative;
        }

        .dark .glass-card {
            background: rgba(0, 0, 0, 0.2);
            border-color: rgba(255, 255, 255, 0.05);
        }

        /* Main Content Container */
        .main-container {
            z-index: 10;
            width: 95%;
            max-width: 1200px;
            margin: auto; /* Căn giữa hoàn toàn */
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(20px);
            border: 1px solid rgba(255, 255, 255, 0.2);
            border-radius: 30px;
            padding: 30px;
            color: white;
            box-shadow: 0 20px 40px rgba(0,0,0,0.1);
            flex: none; /* Tránh bị kéo dãn bởi flex-1 */
        }

        /* Input Styling */
        .input-box {
            width: 100%;
            background: rgba(255, 255, 255, 0.1);
            border: 1px solid rgba(255, 255, 255, 0.2);
            border-radius: 18px;
            padding: 14px 20px;
            color: white;
            outline: none;
            transition: all 0.3s ease;
            font-size: 15px;
        }
        .input-box:focus { background: rgba(255, 255, 255, 0.2); border-color: white; }
        .input-box::placeholder { color: rgba(255, 255, 255, 0.6); }

        /* Login Button */
        .login-btn {
            width: 100%;
            background: white;
            color: var(--primary-indigo);
            padding: 16px;
            border-radius: 18px;
            font-weight: 700;
            font-size: 16px;
            text-transform: uppercase;
            letter-spacing: 1px;
            transition: all 0.3s ease;
        }
        .dark .login-btn { background: var(--primary-indigo); color: white; }
        .login-btn:hover { transform: translateY(-2px); box-shadow: 0 10px 20px rgba(0,0,0,0.2); }

        /* Theme Toggle */
        .theme-toggle {
            position: fixed;
            top: 25px;
            right: 25px;
            background: rgba(255, 255, 255, 0.2);
            border: 1px solid rgba(255, 255, 255, 0.3);
            width: 50px;
            height: 50px;
            border-radius: 15px;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            z-index: 1000;
            color: white;
            backdrop-filter: blur(10px);
        }

        /* Nội dung bao quanh trang login hoặc nội dung chính */
        .content-wrapper {
            flex: 1;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
            z-index: 1;
        }

        @keyframes shake {
            0%, 100% { transform: translateX(0); }
            25% { transform: translateX(-10px); }
            75% { transform: translateX(10px); }
        }
        .shake { animation: shake 0.4s ease; }
    </style>
</head>
<body class="dark"> <!-- Mặc định Dark Mode -->

    <!-- Background Decoration -->
    <div class="shape w-32 h-32 top-20 left-[15%]" style="animation-delay: 0s;"></div>
    <div class="shape w-48 h-48 bottom-20 left-[25%]" style="animation-delay: -2s;"></div>
    <div class="shape w-24 h-24 top-40 right-[20%]" style="animation-delay: -5s;"></div>
    <div class="shape w-40 h-40 bottom-40 right-[10%]" style="animation-delay: -7s;"></div>

    <!-- Theme Switcher -->
    <button onclick="toggleTheme()" class="theme-toggle">
        <svg id="themeIcon" class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path id="iconPath" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 3v1m0 16v1m9-9h-1M4 12H3m15.364 6.364l-.707-.707M6.343 6.343l-.707-.707m12.728 0l-.707.707M6.343 17.657l-.707.707M16 12a4 4 0 11-8 0 4 4 0 018 0z" />
        </svg>
    </button>

    <div class="content-wrapper">
        <c:if test="${empty sessionScope.user}">
            <!-- LOGIN VIEW -->
            <div class="glass-card ${error != null ? 'shake' : ''}" id="loginCard">
                <div class="text-center text-white mb-10">
                    <h1 class="text-4xl font-bold mb-3 tracking-tight">Welcome!</h1>
                    <p class="text-white/70 font-light">Login to continue your journey</p>
                </div>

                <form action="login" method="post" class="space-y-5">
                    <div class="relative">
                        <input type="text" name="username" placeholder="Username" 
                               class="input-box" value="${cookie.rememberUser.value}" required>
                    </div>

                    <div class="relative">
                        <input type="password" id="password" name="password" placeholder="Password" 
                               class="input-box" required>
                        <span class="absolute right-5 top-1/2 -translate-y-1/2 text-white/50 cursor-pointer" onclick="togglePassword()">
                            <i id="eyeIcon" class="fas fa-eye"></i>
                        </span>
                    </div>

                    <div class="flex items-center justify-between text-xs text-white/80 mb-6 px-1">
                        <label class="flex items-center space-x-2 cursor-pointer">
                            <input type="checkbox" name="remember" value="true" ${not empty cookie.rememberUser.value ? 'checked' : ''}
                                   class="w-4 h-4 rounded border-white/20 bg-transparent text-indigo-600 focus:ring-0">
                            <span>Remember me</span>
                        </label>
                        <a href="#" class="hover:text-white transition-colors">Forgot password?</a>
                    </div>

                    <button type="submit" class="login-btn">Login</button>
                    <!-- Đã xóa phần hiển thị lỗi ${error} -->
                </form>
            </div>
        </c:if>

        <c:if test="${not empty sessionScope.user}">
            <!-- MAIN CONTENT CONTAINER (Khi đã login, Navbar đã bị xóa) -->
            <div class="main-container">
                <!-- Nội dung từ body các file khác sẽ chèn vào đây -->
        </c:if>
    </div>

    <script>
        function toggleTheme() {
            const body = document.body;
            const path = document.getElementById('iconPath');
            
            if (body.classList.contains('light')) {
                body.classList.replace('light', 'dark');
                path.setAttribute('d', 'M12 3v1m0 16v1m9-9h-1M4 12H3m15.364 6.364l-.707-.707M6.343 6.343l-.707-.707m12.728 0l-.707.707M6.343 17.657l-.707.707M16 12a4 4 0 11-8 0 4 4 0 018 0z');
            } else {
                body.classList.replace('dark', 'light');
                path.setAttribute('d', 'M20.354 15.354A9 9 0 018.646 3.646 9.003 9.003 0 0012 21a9.003 9.003 0 008.354-5.646z');
            }
        }

        function togglePassword() {
            const passInput = document.getElementById("password");
            const eyeIcon = document.getElementById("eyeIcon");
            if (passInput.type === "password") {
                passInput.type = "text";
                eyeIcon.classList.replace("fa-eye", "fa-eye-slash");
            } else {
                passInput.type = "password";
                eyeIcon.classList.replace("fa-eye-slash", "fa-eye");
            }
        }
    </script>
</body>
</html>