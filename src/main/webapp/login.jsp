<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - Student Management System</title>
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
            border: 2px solid rgba(99, 102, 241, 0.3);
            border-radius: 40px;
            padding: 40px;
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
            padding: 16px 20px;
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

        .btn-base {
            width: 100%;
            padding: 16px;
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

        .login-btn {
            background: linear-gradient(135deg, #6366f1, #4f46e5);
            color: white;
            box-shadow: 0 10px 20px -5px rgba(79, 70, 229, 0.4);
            border: none;
        }

        .login-btn:hover { 
            transform: translateY(-2px); 
            box-shadow: 0 15px 25px -5px rgba(79, 70, 229, 0.5);
            filter: brightness(1.1);
        }

        .register-btn {
            background: transparent;
            border: 2px solid rgba(99, 102, 241, 0.5);
            color: var(--text-main);
            margin-top: 12px;
        }

        .register-btn:hover {
            background: rgba(99, 102, 241, 0.1);
            border-color: var(--primary-indigo);
            transform: translateY(-2px);
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
            background: rgba(99, 102, 241, 0.2);
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

    <div id="tag-container"></div>

    <button onclick="toggleTheme()" class="theme-toggle" title="Thay ??i giao di?n">
        <svg id="themeIcon" class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path id="iconPath" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M20.354 15.354A9 9 0 018.646 3.646 9.003 9.003 0 0012 21a9.003 9.003 0 008.354-5.646z" />
        </svg>
    </button>

    <div class="content-wrapper">
        <div class="glass-card">
            <div class="text-center mb-8">
                <div class="inline-block p-4 rounded-full bg-indigo-500/10 mb-4 border border-indigo-500/20">
                    <i class="fas fa-university text-3xl text-indigo-400"></i>
                </div>
                <h1 class="text-3xl font-bold mb-2 tracking-tight theme-text-main">Trang Đăng Nhập</h1>
                <p class="theme-text-sub font-light italic text-sm">Chào mừng đến với thành viên Nhóm 5</p>
            </div>

            <% if (request.getAttribute("warning") != null) { %>
                <div class="bg-yellow-600/30 border-2 border-yellow-400 rounded-lg p-4 mb-5 animate-pulse">
                    <p class="text-yellow-300 text-base font-bold flex items-center">
                        <i class="fas fa-exclamation-triangle mr-3 text-lg"></i>
                        <%= request.getAttribute("warning") %>
                    </p>
                </div>
            <% } %>

            <% if (request.getAttribute("error") != null) { %>
                <div class="bg-red-600/30 border-2 border-red-400 rounded-lg p-4 mb-5 animate-pulse">
                    <p class="text-red-400 text-base font-bold flex items-center">
                        <i class="fas fa-exclamation-triangle mr-3 text-lg"></i>
                        <%= request.getAttribute("error") %>
                    </p>
                </div>
            <% } %>

            <form action="${pageContext.request.contextPath}/login" method="post" class="space-y-5">
                <div class="space-y-2">
                    <label class="text-[10px] font-black uppercase tracking-[0.2em] ml-1 theme-text-sub">Tài khoản FE (Email)</label>
                    <input type="text" name="username" placeholder="nhannvhe123" class="input-box" required>
                </div>

                <div class="space-y-2">
                    <label class="text-[10px] font-black uppercase tracking-[0.2em] ml-1 theme-text-sub">Mật khẩu</label>
                    <div class="relative">
                        <input type="password" id="password" name="password" placeholder="********" class="input-box" required>
                        <span class="absolute right-4 top-1/2 -translate-y-1/2 theme-text-sub hover:text-indigo-500 cursor-pointer" onclick="togglePassword()">
                            <i id="eyeIcon" class="fas fa-eye"></i>
                        </span>
                    </div>
                </div>

                <div class="flex items-center justify-between text-xs px-1">
                    <label class="flex items-center space-x-2 cursor-pointer group">
                        <input type="checkbox" name="remember" value="true" class="w-4 h-4 rounded border-indigo-300 bg-transparent text-indigo-600 focus:ring-0">
                        <span class="theme-text-sub group-hover:theme-text-main transition-colors">Ghi nhớ đăng nhập</span>
                    </label>
                    <a href="#" class="theme-text-sub hover:text-indigo-500 transition-colors font-bold">Quên mật khẩu</a>
                </div>

                <div class="pt-2">
                    <button type="submit" class="btn-base login-btn">đăng nhập ngay</button>
                    <a href="${pageContext.request.contextPath}/register" class="btn-base register-btn">Tạo tài khoảng</a>
                </div>

                <div class="divider">
                    <span class="divider-text">HOẶC</span>
                </div>

                <div class="google-btn"></div>
                   
                </button>
            </form>
            
            <div class="mt-8 pt-6 border-t border-indigo-500/10 text-center">
                <p class="theme-text-sub text-[8px] uppercase tracking-[5px] font-medium">FPT University | Group 5 Project</p>
            </div>
        </div>
    </div>

    <script src="https://accounts.google.com/gsi/client" async defer></script>
    <script>

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

        function handleGoogleSignIn() {

    google.accounts.id.initialize({
        client_id: '991279627816-vehv4inre0nn7i6nh1gohi5nb3s8ee4t.apps.googleusercontent.com',
        callback: handleCredentialResponse
    });

    google.accounts.id.renderButton(
        document.querySelector('.google-btn'),
        {
            theme: 'outline',
            size: 'large',
            width: 350
        }
    );
}

window.addEventListener("load", handleGoogleSignIn);

        function handleCredentialResponse(response) {
            // Gửi token tới backend
            fetch('${pageContext.request.contextPath}/login-google', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded',
                },
                body: 'idToken=' + encodeURIComponent(response.credential)
            })
            .then(res => res.json())
            .then(data => {
                if (data.success) {
                    window.location.href = '${pageContext.request.contextPath}/student';
                } else if (data.warning) {
                    // Hiển thị warning message và ở lại trang login
                    const warningDiv = document.createElement('div');
                    warningDiv.className = 'bg-yellow-600/30 border-2 border-yellow-400 rounded-lg p-4 mb-5 animate-pulse';
                    warningDiv.innerHTML = `
                        <p class="text-yellow-300 text-base font-bold flex items-center">
                            <i class="fas fa-exclamation-triangle mr-3 text-lg"></i>
                            ${data.warning}
                        </p>
                    `;

                    // Thêm warning vào đầu form
                    const form = document.querySelector('form');
                    form.insertBefore(warningDiv, form.firstChild);

                    // Tự động ẩn warning sau 5 giây
                    setTimeout(() => {
                        warningDiv.remove();
                    }, 5000);
                } else {
                    alert('Có lỗi khi đăng nhập với Google');
                }
            })
            .catch(error => console.error('Lỗi:', error));
        }

        // --- H? TH?NG TAG V?I MÔN H?C SE FPTU ---
        const seSubjects = [
            "PRJ301", "SWP391", "SWR302", "SWT301", "PRN211", 
            "PRN221", "PRN231", "ITE302c", "MLN131", "EXE101",
            "EXE201", "SYB301", "PFP191", "JSW301", "IOT102",
            "NWC203", "SDW301", "WDP301", "PRM392", "WAD201"
        ];

        const otherTags = ["Nhan", "Quay", "Phuoc", "Thang", "Tai", "FPTU", "Group 5", "SE", "Software Engineering"];
        
        const allTagNames = seSubjects.concat(otherTags);
        const container = document.getElementById('tag-container');
        const tags = [];
        const mouse = { x: -1000, y: -1000 };
        const repulsionRadius = 160; 
        const repulsionStrength = 0.6; 

        window.addEventListener('mousemove', function(e) {
            mouse.x = e.clientX;
            mouse.y = e.clientY;
        });

        function Tag(name) {
            this.element = document.createElement('div');
            this.element.className = 'floating-tag';
            this.element.innerText = name;
            
            if (seSubjects.indexOf(name) !== -1) {
                const colors = ['text-blue-400', 'text-green-400', 'text-pink-400', 'text-yellow-400', 'text-cyan-400'];
                const randomColor = colors[Math.floor(Math.random() * colors.length)];
                this.element.classList.add(randomColor, 'font-semibold');
            }

            container.appendChild(this.element);

            this.x = Math.random() * window.innerWidth;
            this.y = Math.random() * window.innerHeight;
            this.vx = (Math.random() - 0.5) * 1.8;
            this.vy = (Math.random() - 0.5) * 1.8;
            this.ax = 0;
            this.ay = 0;
        }

        Tag.prototype.update = function() {
            const dx = this.x - mouse.x;
            const dy = this.y - mouse.y;
            const distance = Math.sqrt(dx * dx + dy * dy);

            if (distance < repulsionRadius) {
                const force = (repulsionRadius - distance) / repulsionRadius;
                this.ax += (dx / distance) * force * repulsionStrength;
                this.ay += (dy / distance) * force * repulsionStrength;
            }

            this.vx += this.ax;
            this.vy += this.ay;
            this.vx *= 0.96; 
            this.vy *= 0.96;
            
            this.ax = 0;
            this.ay = 0;

            const minSpeed = 0.3;
            this.x += this.vx + (Math.sign(this.vx || 1) * minSpeed);
            this.y += this.vy + (Math.sign(this.vy || 1) * minSpeed);

            const margin = 80;
            if (this.x < -margin) this.x = window.innerWidth + margin;
            if (this.x > window.innerWidth + margin) this.x = -margin;
            if (this.y < -margin) this.y = window.innerHeight + margin;
            if (this.y > window.innerHeight + margin) this.y = -margin;

            // S?a l?i JSP EL b?ng cách dùng n?i chu?i thay vì Template Literals
            this.element.style.transform = 'translate(' + this.x + 'px, ' + this.y + 'px)';
        };

        function initTags() {
            for (let i = 0; i < 50; i++) {
                const name = allTagNames[i % allTagNames.length];
                tags.push(new Tag(name));
            }
        }

        function animate() {
            for (let i = 0; i < tags.length; i++) {
                tags[i].update();
            }
            requestAnimationFrame(animate);
        }

        window.onload = function() {
            initTags();
            animate();
        };

        window.addEventListener('resize', function() {
            for (let i = 0; i < tags.length; i++) {
                if (tags[i].x > window.innerWidth) tags[i].x = Math.random() * window.innerWidth;
                if (tags[i].y > window.innerHeight) tags[i].y = Math.random() * window.innerHeight;
            }
        });
 
    </script>
</body>
</html> 
   
       