<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng ký - Student Management System</title>
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
            overflow-y: auto;
            overflow-x: hidden;
        }

        body.light { background: var(--bg-gradient-light); }
        body.dark { background: var(--bg-gradient-dark); }

        #tag-container {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            pointer-events: none;
            z-index: 0;
        }

        .floating-tag {
            position: absolute;
            background: rgba(255, 255, 255, 0.08);
            backdrop-filter: blur(8px);
            border: 1px solid rgba(255, 255, 255, 0.15);
            border-radius: 12px;
            padding: 6px 14px;
            color: var(--text-main);
            font-weight: 500;
            font-size: 0.75rem;
            white-space: nowrap;
            user-select: none;
            transition: background 0.3s, border 0.3s, color 0.3s;
            will-change: transform;
        }

        .light .floating-tag {
            background: rgba(255, 255, 255, 0.5);
            border-color: rgba(99, 102, 241, 0.2);
            color: var(--primary-indigo);
        }

        .glass-card {
            background: var(--card-bg);
            backdrop-filter: blur(40px);
            -webkit-backdrop-filter: blur(40px);
            border: 2px solid rgba(16, 185, 129, 0.3); /* Emerald border for register */
            border-radius: 40px;
            padding: 30px 40px;
            width: 100%;
            max-width: 440px;
            box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.4);
            z-index: 10;
            position: relative;
            transition: all 0.5s cubic-bezier(0.4, 0, 0.2, 1);
        }

        .light .glass-card {
            border-color: rgba(16, 185, 129, 0.4);
            box-shadow: 0 20px 40px rgba(16, 185, 129, 0.1);
        }

        .theme-text-main { color: var(--text-main); transition: color 0.5s ease; }
        .theme-text-sub { color: var(--text-sub); transition: color 0.5s ease; }
        
        .input-box {
            width: 100%;
            background: rgba(255, 255, 255, 0.05);
            border: 1px solid rgba(99, 102, 241, 0.2);
            border-radius: 16px;
            padding: 12px 45px 12px 20px;
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
            border-color: #10b981;
            box-shadow: 0 0 15px rgba(16, 185, 129, 0.25);
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

        body.light .theme-toggle { transform: rotate(180deg); }
        #themeIcon { transition: transform 0.6s cubic-bezier(0.34, 1.56, 0.64, 1); }
        body.light #themeIcon { transform: rotate(-180deg); }

        .divider {
            display: flex;
            align-items: center;
            margin: 24px 0 20px 0;
        }

        .divider::before,
        .divider::after {
            content: '';
            flex: 1;
            height: 1px;
            background: rgba(16, 185, 129, 0.2);
        }

        .divider-text {
            padding: 0 12px;
            color: var(--text-sub);
            font-size: 12px;
            font-weight: 500;
        }

        .google-btn {
            width: 100%;
            padding: 14px;
            border-radius: 16px;
            font-weight: 600;
            letter-spacing: 0.5px;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
            cursor: pointer;
            border: 2px solid rgba(255, 255, 255, 0.2);
            background: rgba(255, 255, 255, 0.05);
            color: var(--text-main);
            text-decoration: none;
        }

        .light .google-btn {
            background: rgba(255, 255, 255, 0.7);
            border-color: rgba(16, 185, 129, 0.3);
        }

        .google-btn:hover {
            background: rgba(255, 255, 255, 0.1);
            border-color: #10b981;
            transform: translateY(-2px);
            box-shadow: 0 10px 20px -5px rgba(16, 185, 129, 0.3);
        }

       .content-wrapper {
    position: relative;
    width: 100%;
    min-height: 100vh;
    display: flex;
    justify-content: center;
    align-items: center;
    z-index: 1;
    padding: 20px;
    box-sizing: border-box;
}

        /* Custom Scrollbar */
        ::-webkit-scrollbar {
            width: 8px;
        }

        ::-webkit-scrollbar-track {
            background: rgba(255, 255, 255, 0.05);
        }

        ::-webkit-scrollbar-thumb {
            background: rgba(16, 185, 129, 0.3);
            border-radius: 4px;
        }

        ::-webkit-scrollbar-thumb:hover {
            background: rgba(16, 185, 129, 0.5);
        }

        .light ::-webkit-scrollbar-track {
            background: rgba(255, 255, 255, 0.1);
        }

        .light ::-webkit-scrollbar-thumb {
            background: rgba(16, 185, 129, 0.4);
        }

        .light ::-webkit-scrollbar-thumb:hover {
            background: rgba(16, 185, 129, 0.6);
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .glass-card {
                margin: 20px;
                padding: 30px;
                max-width: none;
                width: calc(100% - 40px);
            }

            .content-wrapper {
                padding: 10px;
                min-height: auto;
                padding-top: 60px;
                padding-bottom: 60px;
            }
        }

        @media (max-width: 480px) {
            .glass-card {
                padding: 25px;
                margin: 10px;
                width: calc(100% - 20px);
            }

            .content-wrapper {
                padding: 5px;
            }
        }
    </style>
</head>
<body class="dark">

    <!-- Container cho hiệu ứng tag lơ lửng -->
    <div id="tag-container"></div>

    <button onclick="toggleTheme()" class="theme-toggle" title="Thay đổi giao diện">
        <svg id="themeIcon" class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path id="iconPath" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M20.354 15.354A9 9 0 018.646 3.646 9.003 9.003 0 0012 21a9.003 9.003 0 008.354-5.646z" />
        </svg>
    </button>

    <div class="content-wrapper">
        <div class="glass-card">
            <div class="text-center mb-6">
                <div class="inline-block p-3 rounded-full bg-emerald-500/10 mb-3 border border-emerald-500/20">
                    <i class="fas fa-user-plus text-2xl text-emerald-400"></i>
                </div>
                <h1 class="text-3xl font-bold mb-1 tracking-tight theme-text-main">Tạo tài khoản</h1>
                <p class="theme-text-sub text-sm font-light italic">Chào mừng đến với thành viên Nhóm 5</p>
            </div>

            <form action="${pageContext.request.contextPath}/register" method="post" class="space-y-4">
                <div class="space-y-1">
                    <label class="text-[10px] font-black uppercase tracking-[0.2em] ml-1 theme-text-sub">Họ và Tên</label>
                    <input type="text" name="fullname" placeholder="Nguyễn Văn Nhân" class="input-box" required>
                </div>

                <div class="space-y-1">
                    <label class="text-[10px] font-black uppercase tracking-[0.2em] ml-1 theme-text-sub">Tài khoản FE (Email)</label>
                    <input type="text" name="username" placeholder="nhannvhe123456" class="input-box" required>
                </div>

                <div class="space-y-1">
                    <label class="text-[10px] font-black uppercase tracking-[0.2em] ml-1 theme-text-sub">Mật khẩu</label>
                    <div class="relative">
                        <input type="password" id="password" name="password" placeholder="********" class="input-box" required>
                        <i class="fas fa-eye absolute right-4 top-1/2 -translate-y-1/2 theme-text-sub cursor-pointer hover:text-emerald-500" onclick="togglePasswordVisibility('password', this)"></i>
                    </div>
                </div>

                <div class="space-y-1">
                    <label class="text-[10px] font-black uppercase tracking-[0.2em] ml-1 theme-text-sub">Xác nhận mật khẩu</label>
                    <div class="relative">
                        <input type="password" id="confirm_password" name="confirm_password" placeholder="********" class="input-box" required>
                        <i class="fas fa-eye absolute right-4 top-1/2 -translate-y-1/2 theme-text-sub cursor-pointer hover:text-emerald-500" onclick="togglePasswordVisibility('confirm_password', this)"></i>
                    </div>
                </div>

                <div class="pt-4">
                    <button type="submit" class="btn-base primary-btn">Đăng ký ngay</button>
                    <a href="${pageContext.request.contextPath}/login" class="btn-base secondary-btn">Đã có tài khoản? Đăng nhập</a>
                </div>

                <div class="divider">
                    <span class="divider-text">HOẶC</span>
                </div>

                <button type="button" class="google-btn" onclick="handleGoogleSignUp()">
                    <svg width="20" height="20" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                        <path d="M22.56 12.25c0-.78-.07-1.53-.2-2.25H12v4.26h5.92c-.26 1.37-1.04 2.53-2.21 3.31v2.77h3.57c2.08-1.92 3.28-4.74 3.28-8.09z" fill="#4285F4"/>
                        <path d="M12 23c2.97 0 5.46-.98 7.28-2.66l-3.57-2.77c-.98.66-2.23 1.06-3.71 1.06-2.86 0-5.29-1.93-6.16-4.53H2.18v2.84C3.99 20.53 7.7 23 12 23z" fill="#34A853"/>
                        <path d="M5.84 14.09c-.22-.66-.35-1.36-.35-2.09s.13-1.43.35-2.09V7.07H2.18C1.43 8.55 1 10.22 1 12s.43 3.45 1.18 4.93l2.85-2.22.81-.62z" fill="#FBBC05"/>
                        <path d="M12 5.38c1.62 0 3.06.56 4.21 1.64l3.15-3.15C17.45 2.09 14.97 1 12 1 7.7 1 3.99 3.47 2.18 7.07l3.66 2.84c.87-2.6 3.3-4.53 6.16-4.53z" fill="#EA4335"/>
                    </svg>
                    ĐĂNG KÝ VỚI GOOGLE
                </button>
            </form>
            
            <div class="mt-6 pt-4 border-t border-emerald-500/10 text-center">
                <p class="theme-text-sub text-[8px] uppercase tracking-[5px] font-medium">FPT University | Group 5 Project</p>
            </div>
        </div>
    </div>

    <script src="https://accounts.google.com/gsi/client" async defer></script>
    <script>
        function handleGoogleSignUp() {
            google.accounts.id.initialize({
                client_id: '991279627816-vehv4inre0nn7i6nh1gohi5nb3s8ee4t.apps.googleusercontent.com',
                callback: handleGoogleSignUpResponse
            });
            google.accounts.id.renderButton(
                document.querySelector('.google-btn'),
                { theme: 'outline', size: 'large', text: 'signup_with' }
            );
            google.accounts.id.prompt();
        }

        function handleGoogleSignUpResponse(response) {
            // Gửi token tới backend
            fetch('${pageContext.request.contextPath}/auth/google-register', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded',
                },
                body: 'idToken=' + response.credential
            })
            .then(res => res.json())
            .then(data => {
                if (data.success) {
                    window.location.href = '${pageContext.request.contextPath}/student';
                } else {
                    alert('Có lỗi khi đăng ký với Google: ' + (data.message || 'Vui lòng thử lại'));
                }
            })
            .catch(error => console.error('Lỗi:', error));
        }

        function toggleTheme() {
            const body = document.body;
            const path = document.getElementById('iconPath');
            if (body.classList.contains('light')) {
                body.classList.replace('light', 'dark');
                path.setAttribute('d', 'M20.354 15.354A9 9 0 018.646 3.646 9.003 9.003 0 0012 21a9.003 9.003 0 008.354-5.646z');
            } else {
                body.classList.replace('dark', 'light');
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

        // --- HỆ THỐNG TAGS GIỐNG TRANG LOGIN ---
        const seSubjects = [
            "PRJ301", "SWP391", "SWR302", "SWT301", "PRN211", 
            "PRN221", "PRN231", "ITE302c", "MLN131", "CSD201",
            "DBI202", "OSG202", "NWC203", "WDP301", "PRM392"
        ];
        const otherTags = ["Đăng ký", "Nhóm 5", "FPTU", "Nhân", "Quân", "Phước", "Thắng", "Tài", "Success"];
        const allTagNames = seSubjects.concat(otherTags);
        const container = document.getElementById('tag-container');
        const tags = [];
        const mouse = { x: -1000, y: -1000 };
        const repulsionRadius = 160; 
        const repulsionStrength = 0.6; 

        window.addEventListener('mousemove', (e) => {
            mouse.x = e.clientX;
            mouse.y = e.clientY;
        });

        function Tag(name) {
            this.element = document.createElement('div');
            this.element.className = 'floating-tag';
            this.element.innerText = name;
            
            if (seSubjects.indexOf(name) !== -1) {
                const colors = ['text-emerald-400', 'text-blue-400', 'text-yellow-400', 'text-pink-400'];
                this.element.classList.add(colors[Math.floor(Math.random() * colors.length)], 'font-semibold');
            }

            container.appendChild(this.element);
            this.x = Math.random() * window.innerWidth;
            this.y = Math.random() * window.innerHeight;
            this.vx = (Math.random() - 0.5) * 1.5;
            this.vy = (Math.random() - 0.5) * 1.5;
        }

        Tag.prototype.update = function() {
            const dx = this.x - mouse.x;
            const dy = this.y - mouse.y;
            const distance = Math.sqrt(dx * dx + dy * dy);

            if (distance < repulsionRadius) {
                const force = (repulsionRadius - distance) / repulsionRadius;
                this.vx += (dx / distance) * force * repulsionStrength;
                this.vy += (dy / distance) * force * repulsionStrength;
            }

            this.vx *= 0.97; 
            this.vy *= 0.97;
            this.x += this.vx + (Math.sign(this.vx) * 0.2);
            this.y += this.vy + (Math.sign(this.vy) * 0.2);

            const margin = 100;
            if (this.x < -margin) this.x = window.innerWidth + margin;
            if (this.x > window.innerWidth + margin) this.x = -margin;
            if (this.y < -margin) this.y = window.innerHeight + margin;
            if (this.y > window.innerHeight + margin) this.y = -margin;

            this.element.style.transform = 'translate(' + this.x + 'px, ' + this.y + 'px)';
        };

        function initTags() {
            for (let i = 0; i < 40; i++) {
                tags.push(new Tag(allTagNames[i % allTagNames.length]));
            }
        }

        function animate() {
            tags.forEach(t => t.update());
            requestAnimationFrame(animate);
        }

        window.onload = () => {
            initTags();
            animate();
        };
    </script>
</body>
</html>

                  