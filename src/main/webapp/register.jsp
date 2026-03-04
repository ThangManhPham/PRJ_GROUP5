<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register - Student Management System</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap');

        :root {
            --bg-gradient-light: linear-gradient(135deg, #e0e7ff 0%, #a5b4fc 100%);
            --bg-gradient-dark: linear-gradient(135deg, #0f172a 0%, #1e1b4b 100%);
            --primary-indigo: #6366f1;
            --text-main: #ffffff;
            --text-sub: rgba(255, 255, 255, 0.6);
            --card-bg: rgba(15, 23, 42, 0.6);
        }

        .light {
            --text-main: #1e1b4b;
            --text-sub: rgba(30, 27, 75, 0.7);
            --card-bg: rgba(255, 255, 255, 0.4);
        }

        body {
            font-family: 'Inter', sans-serif;
            margin: 0;
            padding: 0;
            min-height: 100vh;
            width: 100vw;
            display: flex;
            flex-direction: column;
            transition: background 0.5s ease;
            position: relative;
            overflow-x: hidden;
        }

        body.light { background: var(--bg-gradient-light); }
        body.dark { background: var(--bg-gradient-dark); }

        .floating-tag {
            position: absolute;
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(5px);
            border: 1px solid rgba(255, 255, 255, 0.2);
            border-radius: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: var(--text-main);
            font-weight: 500;
            font-size: 0.75rem;
            z-index: 0;
            opacity: 0;
            animation: floatUpRight 14s infinite linear;
            padding: 5px 10px;
            white-space: nowrap;
            pointer-events: none;
        }

        .light .floating-tag {
            background: rgba(255, 255, 255, 0.4);
            border-color: rgba(99, 102, 241, 0.15);
            color: var(--primary-indigo);
        }

        @keyframes floatUpRight {
            0% { transform: translate(-100px, 150px) rotate(0deg); opacity: 0; }
            10% { opacity: 0.5; }
            90% { opacity: 0.5; }
            100% { transform: translate(400px, -500px) rotate(25deg); opacity: 0; }
        }

        .glass-card {
            background: var(--card-bg);
            backdrop-filter: blur(40px);
            -webkit-backdrop-filter: blur(40px);
            border: 2px solid rgba(99, 102, 241, 0.3);
            border-radius: 40px;
            padding: 30px 40px;
            width: 100%;
            max-width: 420px;
            box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.4);
            z-index: 10;
            position: relative;
            transition: all 0.5s cubic-bezier(0.4, 0, 0.2, 1);
        }

        .light .glass-card {
            border-color: rgba(255, 255, 255, 0.8);
            box-shadow: 0 20px 40px rgba(99, 102, 241, 0.1);
        }

        .theme-text-main { color: var(--text-main); transition: color 0.5s ease; }
        .theme-text-sub { color: var(--text-sub); transition: color 0.5s ease; }
        
        .input-box {
            width: 100%;
            background: rgba(255, 255, 255, 0.05);
            border: 1px solid rgba(99, 102, 241, 0.2);
            border-radius: 16px;
            padding: 10px 45px 10px 20px;
            color: var(--text-main);
            outline: none;
            transition: all 0.3s ease;
        }

        .light .input-box {
            background: rgba(255, 255, 255, 0.7);
            border-color: rgba(99, 102, 241, 0.1);
        }

        .input-box:focus {
            background: rgba(255, 255, 255, 0.1);
            border-color: var(--primary-indigo);
            box-shadow: 0 0 15px rgba(99, 102, 241, 0.25);
        }

        .toggle-password {
            position: absolute;
            right: 15px;
            top: 50%;
            transform: translateY(-50%);
            cursor: pointer;
            color: var(--text-sub);
            transition: color 0.3s ease;
            z-index: 20;
        }

        .btn-base {
            width: 100%;
            padding: 14px;
            border-radius: 16px;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 2px;
            transition: all 0.3s ease;
            display: block;
            text-align: center;
            text-decoration: none;
            cursor: pointer;
        }

        .primary-btn {
            background: linear-gradient(135deg, #10b981, #059669);
            color: white;
            box-shadow: 0 10px 20px -5px rgba(16, 185, 129, 0.4);
            border: none;
        }

        .primary-btn:hover { 
            transform: translateY(-2px); 
            box-shadow: 0 15px 25px -5px rgba(16, 185, 129, 0.5);
            filter: brightness(1.1);
        }

        .secondary-btn {
            background: transparent;
            border: 2px solid rgba(99, 102, 241, 0.5);
            color: var(--text-main);
            margin-top: 10px;
        }

        .theme-toggle {
            position: fixed;
            top: 25px;
            right: 25px;
            background: var(--card-bg);
            border: 1px solid rgba(255, 255, 255, 0.2);
            width: 48px;
            height: 48px;
            border-radius: 14px;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            z-index: 1000;
            color: var(--text-main);
            backdrop-filter: blur(10px);
            transition: background 0.3s ease, color 0.3s ease, transform 0.6s cubic-bezier(0.34, 1.56, 0.64, 1);
        }

        /* Xoay nút 180 ?? khi sang Light mode */
        body.light .theme-toggle {
            transform: rotate(180deg);
        }

        /* Xoay icon ng??c l?i ?? icon không b? ng??c hình */
        #themeIcon {
            transition: transform 0.6s cubic-bezier(0.34, 1.56, 0.64, 1);
        }

        body.light #themeIcon {
            transform: rotate(-180deg);
        }

        .content-wrapper {
            flex: 1;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 40px 20px;
            z-index: 1;
            overflow-y: auto;
        }
    </style>
</head>
<body class="dark">

    <!-- Background Decoration Tags -->
    <div id="dynamic-tags">
        <div class="floating-tag" style="bottom: 5%; left: 5%; animation-delay: 0s;">Nhan</div>
        <div class="floating-tag" style="bottom: 15%; left: 10%; animation-delay: -2s;">Quay</div>
        <div class="floating-tag" style="bottom: 10%; left: 20%; animation-delay: -4s;">Phuoc</div>
        <div class="floating-tag" style="bottom: 25%; left: 30%; animation-delay: -6s;">Thang</div>
        <div class="floating-tag" style="bottom: 5%; left: 45%; animation-delay: -8s;">Tai</div>
        <div class="floating-tag font-bold text-cyan-400" style="bottom: 65%; left: 55%; animation-delay: -13s;">CSD201</div>
        <div class="floating-tag font-bold text-red-400" style="bottom: 40%; left: 80%; animation-delay: -2.5s;">DBI202</div>
        <div class="floating-tag font-bold text-orange-500 border-orange-500/30" style="bottom: 50%; left: 10%; animation-delay: -10s; font-size: 1rem;">FPTU</div>
    </div>

    <!-- Theme Switcher -->
    <button onclick="toggleTheme()" class="theme-toggle" title="Switch Theme">
        <svg id="themeIcon" class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <!-- M?c ??nh Dark Mode hi?n th? M?t Tr?ng -->
            <path id="iconPath" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M20.354 15.354A9 9 0 018.646 3.646 9.003 9.003 0 0012 21a9.003 9.003 0 008.354-5.646z" />
        </svg>
    </button>

    <!-- Main Content Area -->
    <div class="content-wrapper">
        <div class="glass-card">
            <!-- Header Section -->
            <div class="text-center mb-5">
                <div class="inline-block p-3 rounded-full bg-emerald-500/10 mb-3 border border-emerald-500/20">
                    <i class="fas fa-user-plus text-2xl text-emerald-400"></i>
                </div>
                <h1 class="text-3xl font-bold mb-1 tracking-tight theme-text-main">Register</h1>
                <p class="theme-text-sub text-sm font-light italic">Join the FPTU Group 5 Community</p>
            </div>

            <!-- Registration Form -->
            <form action="${pageContext.request.contextPath}/register" method="post" class="space-y-3">
                <div class="space-y-1">
                    <label class="text-[10px] font-black uppercase tracking-[0.2em] ml-1 theme-text-sub">Full Name</label>
                    <input type="text" name="fullname" placeholder="Nguyen Van Nhan" class="input-box" required>
                </div>

                <div class="space-y-1">
                    <label class="text-[10px] font-black uppercase tracking-[0.2em] ml-1 theme-text-sub">FE Account (Email)</label>
                    <input type="text" name="username" placeholder="nhannvhe123456" class="input-box" required>
                </div>

                <div class="space-y-1">
                    <label class="text-[10px] font-black uppercase tracking-[0.2em] ml-1 theme-text-sub">Password</label>
                    <div class="relative">
                        <input type="password" id="password" name="password" placeholder="********" class="input-box" required>
                        <i class="fas fa-eye toggle-password" onclick="togglePasswordVisibility('password', this)"></i>
                    </div>
                </div>

                <div class="space-y-1">
                    <label class="text-[10px] font-black uppercase tracking-[0.2em] ml-1 theme-text-sub">Confirm Password</label>
                    <div class="relative">
                        <input type="password" id="confirm_password" name="confirm_password" placeholder="********" class="input-box" required>
                        <i class="fas fa-eye toggle-password" onclick="togglePasswordVisibility('confirm_password', this)"></i>
                    </div>
                </div>

                <div class="pt-2">
                    <button type="submit" class="btn-base primary-btn">Register Now</button>
                    <a href="${pageContext.request.contextPath}/login" class="btn-base secondary-btn">
                        Already have an account? Login
                    </a>
                </div>
            </form>
            
            <div class="mt-5 pt-4 border-t border-indigo-500/10 text-center">
                <p class="theme-text-sub text-[8px] uppercase tracking-[5px] font-medium">FPT University ? Group 5 Project</p>
            </div>
        </div>
    </div>

    <script>
        function toggleTheme() {
            const body = document.body;
            const path = document.getElementById('iconPath');
            
            if (body.classList.contains('light')) {
                // Sang Dark Mode
                body.classList.replace('light', 'dark');
                // N?n t?i: Hi?n icon M?t Tr?ng
                path.setAttribute('d', 'M20.354 15.354A9 9 0 018.646 3.646 9.003 9.003 0 0012 21a9.003 9.003 0 008.354-5.646z');
            } else {
                // Sang Light Mode
                body.classList.replace('dark', 'light');
                // N?n sáng: Hi?n icon M?t Tr?i
                path.setAttribute('d', 'M12 3v1m0 16v1m9-9h-1M4 12H3m15.364 6.364l-.707-.707M6.343 6.343l-.707-.707m12.728 0l-.707.707M6.343 17.657l-.707.707M16 12a4 4 0 11-8 0 4 4 0 018 0z');
            }
        }

        function togglePasswordVisibility(inputId, icon) {
            const input = document.getElementById(inputId);
            if (input.type === 'password') {
                input.type = 'text';
                icon.classList.replace('fa-eye', 'fa-eye-slash');
            } else {
                input.type = 'password';
                icon.classList.replace('fa-eye-slash', 'fa-eye');
            }
        }
    </script>
</body>
</html>