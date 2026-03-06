<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Access Denied - Group 5 System</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800;900&display=swap');

        :root {
            --bg-gradient-light: linear-gradient(135deg, #f0f4ff 0%, #c7d2fe 100%);
            --bg-gradient-dark: linear-gradient(135deg, #0f172a 0%, #1e1b4b 100%);
            --primary-indigo: #6366f1;
            --text-main: #ffffff;
            --text-sub: rgba(255, 255, 255, 0.6);
            --card-bg: rgba(15, 23, 42, 0.6);
            --error-red: #fb7185;
            --card-border: rgba(251, 113, 133, 0.3);
        }

        /* T?ng c??ng ?? t??ng ph?n cho Light Mode */
        .light {
            --text-main: #0f172a;
            --text-sub: #334155;
            --card-bg: rgba(255, 255, 255, 0.8);
            --card-border: #f43f5e; /* Vi?n ?? h?ng ??m h?n khi ? Light Mode */
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
            overflow: hidden;
        }

        body.light { background: var(--bg-gradient-light); }
        body.dark { background: var(--bg-gradient-dark); }

        /* Floating Tags Animation */
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
            background: rgba(255, 255, 255, 0.6);
            border: 2px solid #6366f1; /* Vi?n ??m h?n cho tag ? Light Mode */
            color: #4338ca;
            font-weight: 800;
        }

        @keyframes floatUpRight {
            0% { transform: translate(-100px, 150px) rotate(0deg); opacity: 0; }
            10% { opacity: 0.5; }
            90% { opacity: 0.5; }
            100% { transform: translate(400px, -500px) rotate(25deg); opacity: 0; }
        }

        /* Glassmorphism Card */
        .glass-card {
            background: var(--card-bg);
            backdrop-filter: blur(40px);
            -webkit-backdrop-filter: blur(40px);
            border: 2px solid var(--card-border);
            border-radius: 40px;
            padding: 45px 40px;
            width: 100%;
            max-width: 450px;
            box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.4);
            z-index: 10;
            position: relative;
            transition: all 0.5s cubic-bezier(0.4, 0, 0.2, 1);
            text-align: center;
        }

        .light .glass-card {
            border-width: 3px; /* Vi?n dày h?n ? Light Mode */
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
        }

        /* ??nh ngh?a font-weight in ??m cho Light Mode */
        .theme-text-main { color: var(--text-main); transition: all 0.5s ease; font-weight: 700; }
        .light .theme-text-main { font-weight: 900; }

        .theme-text-sub { color: var(--text-sub); transition: all 0.5s ease; font-weight: 400; }
        .light .theme-text-sub { font-weight: 700; }

        .icon-box {
            background: rgba(251, 113, 133, 0.1);
            color: var(--error-red);
            width: 80px; 
            height: 80px;
            border-radius: 24px;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 1.5rem;
            border: 2px solid rgba(251, 113, 133, 0.4);
            font-size: 2.5rem;
        }

        .light .icon-box {
            background: rgba(251, 113, 133, 0.2);
            border: 3px solid #f43f5e;
        }

        .btn-base {
            width: 100%;
            padding: 16px;
            border-radius: 16px;
            font-weight: 800; /* Font ch? m?c ??nh ??m */
            text-transform: uppercase;
            letter-spacing: 2px;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            text-decoration: none;
        }

        .primary-btn {
            background: linear-gradient(135deg, #6366f1, #4f46e5);
            color: white;
            box-shadow: 0 10px 20px -5px rgba(79, 70, 229, 0.4);
            margin-bottom: 12px;
        }

        .secondary-btn {
            background: rgba(255, 255, 255, 0.05);
            border: 1px solid rgba(255, 255, 255, 0.2);
            color: var(--text-main);
        }

        .light .secondary-btn {
            background: #ffffff;
            border: 2.5px solid #4f46e5; /* Vi?n xanh ??m rõ ràng ? Light Mode */
            color: #4f46e5;
        }

        .secondary-btn:hover {
            transform: translateY(-2px);
            background: rgba(255, 255, 255, 0.1);
        }

        .theme-toggle {
            position: fixed;
            top: 25px;
            right: 25px;
            background: var(--card-bg);
            border: 2px solid var(--card-border);
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
            transition: all 0.5s ease;
        }

        .content-wrapper {
            flex: 1;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
            z-index: 1;
        }
    </style>
</head>
<body class="dark">

    <div id="dynamic-tags">
        <div class="floating-tag" style="bottom: 5%; left: 5%; animation-delay: 0s;">Nhan</div>
        <div class="floating-tag" style="bottom: 15%; left: 10%; animation-delay: -2s;">Quy</div>
        <div class="floating-tag" style="bottom: 10%; left: 20%; animation-delay: -4s;">Phuoc</div>
        <div class="floating-tag" style="bottom: 25%; left: 30%; animation-delay: -6s;">Thang</div>
        <div class="floating-tag" style="bottom: 5%; left: 45%; animation-delay: -8s;">Tai</div>
        <div class="floating-tag font-bold text-orange-400 light:text-orange-700" style="bottom: 20%; left: 50%; animation-delay: -1s;">PRF192</div>
        <div class="floating-tag font-bold text-red-400 light:text-red-700" style="bottom: 40%; left: 80%; animation-delay: -2.5s;">DBI202</div>
        <div class="floating-tag font-bold text-orange-500 border-orange-500/30" style="bottom: 50%; left: 10%; animation-delay: -10s; font-size: 1rem;">FPTU</div>
    </div>

    <button onclick="toggleTheme()" class="theme-toggle" title="Switch Theme">
        <svg id="themeIcon" class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path id="iconPath" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 3v1m0 16v1m9-9h-1M4 12H3m15.364 6.364l-.707-.707M6.343 6.343l-.707-.707m12.728 0l-.707.707M6.343 17.657l-.707.707M16 12a4 4 0 11-8 0 4 4 0 018 0z" />
        </svg>
    </button>

    <div class="content-wrapper">
        <div class="glass-card">
            <div class="icon-box">
                <i class="fas fa-shield-virus"></i>
            </div>

            <h1 class="text-3xl mb-3 tracking-tight theme-text-main">Access Denied</h1>
            <p class="theme-text-sub mb-10 leading-relaxed px-4">
                Sorry! You do not have permission to access this area. Please contact the administrator or return to the previous page.
            </p>

            <div class="flex flex-col space-y-0">
                <a href="logout" class="btn-base primary-btn">
                    <i class="fas fa-sign-out-alt mr-2"></i> Back to Login Page
                </a>
                <a href="javascript:history.back()" class="btn-base secondary-btn">
                    <i class="fas fa-arrow-left mr-2"></i> Go Back Now
                </a>
            </div>

            <div class="mt-10 pt-6 border-t border-indigo-500/20 light:border-indigo-500/40">
                <p class="theme-text-sub text-[8px] uppercase tracking-[5px] font-black">FPT University / Group 5 Project</p>
            </div>
        </div>
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
    </script>
</body>
</html>