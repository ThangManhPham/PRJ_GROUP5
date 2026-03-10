<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Truy cập bị hạn chế</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600;800&display=swap');
        :root {
            --bg-gradient-light: linear-gradient(135deg, #e0e7ff 0%, #a5b4fc 100%);
            --bg-gradient-dark: linear-gradient(135deg, #0f172a 0%, #1e1b4b 100%);
            --text-main: #ffffff;
            --text-sub: rgba(255,255,255,0.7);
            --card-bg: rgba(15, 23, 42, 0.6);
            --border: rgba(255,255,255,0.08);
        }
        .light {
            --text-main: #1e1b4b;
            --text-sub: rgba(30,27,75,0.7);
            --card-bg: rgba(255,255,255,0.5);
            --border: rgba(99,102,241,0.2);
        }
        body{font-family:'Inter',sans-serif}
        .wrap{max-width:720px;width:100%}
        .card{background:var(--card-bg);border:1px solid var(--border);backdrop-filter:blur(8px)}
        .title{color:var(--text-main)}
        .subtitle{color:var(--text-sub)}
        .warn{background:rgba(239,68,68,.18);border-color:rgba(248,113,113,.6);color:#fecaca}
        .hello{background:rgba(99,102,241,.15);border-color:rgba(99,102,241,.5);color:#c7d2fe}
        .role-badge{border:1px solid rgba(99,102,241,.5);background:transparent;color:#c7d2fe;padding:.2rem .6rem;border-radius:9999px;font-weight:800;font-size:.75rem;letter-spacing:.08em}
        .btn{display:flex;align-items:center;justify-content:center;border-radius:12px;padding:.75rem 1rem;font-weight:700}
        .btn-dark{background:rgba(255,255,255,.06);color:var(--text-main);border:1px solid rgba(255,255,255,.1)}
        .btn-dark:hover{background:rgba(255,255,255,.1)}
        /* tags */
        #tag-container{position:fixed;inset:0;pointer-events:none;z-index:0}
        .floating-tag{position:absolute;white-space:nowrap;font-size:12px;color:var(--text-sub);transition:transform .1s}
        /* theme toggle */
        .theme-toggle{position:fixed;top:24px;right:24px;background:var(--card-bg);border:1px solid var(--border);width:48px;height:48px;border-radius:14px;display:flex;align-items:center;justify-content:center;color:var(--text-main);z-index:50}
    </style>
</head>
<body class="dark min-h-screen flex items-center justify-center p-6" style="background: var(--bg-gradient-dark);">
    <div id="tag-container"></div>
    <button class="theme-toggle" id="themeBtn" title="Đổi giao diện">
        <svg id="themeIcon" class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path id="iconPath" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M20.354 15.354A9 9 0 018.646 3.646 9.003 9.003 0 0012 21a9.003 9.003 0 008.354-5.646z" />
        </svg>
    </button>
    <div class="wrap">
        <div class="card rounded-2xl p-8 shadow-2xl">
            <!-- Khung chào mừng -->
            <div class="flex items-center justify-between hello rounded-xl p-5 border mb-6">
                <div class="flex items-center gap-4">
                    <i class="fas fa-user-circle text-2xl"></i>
                    <div>
                        <div class="title text-2xl font-extrabold">Xin chào, ${sessionScope.user.username}</div>
                        <div class="subtitle">Chào mừng bạn đã đăng nhập vào hệ thống</div>
                    </div>
                </div>
                <span class="role-badge">GUEST</span>
            </div>
            <!-- Khung quyền truy cập hạn chế -->
            <div class="flex items-center gap-4 warn rounded-xl p-5 border mb-6">
                <i class="fas fa-ban text-2xl"></i>
                <div>
                    <div class="title text-2xl font-extrabold mb-1">Truy cập bị hạn chế</div>
                    <div class="subtitle">Bạn đã đăng nhập thành công nhưng không có quyền thao tác trên hệ thống.</div>
                </div>
            </div>
            <div class="flex items-center justify-between">
                <a href="${pageContext.request.contextPath}/login" class="btn btn-dark">Quay lại đăng nhập</a>
                <a href="${pageContext.request.contextPath}/logout" class="btn btn-dark">Đăng xuất</a>
            </div>
        </div>
    </div>
    <script>
        // Dark/Light toggle
        const body = document.body;
        const iconPath = document.getElementById('iconPath');
        document.getElementById('themeBtn').addEventListener('click', () => {
            if (body.classList.contains('light')) {
                body.classList.remove('light');
                body.style.background = getComputedStyle(document.documentElement).getPropertyValue('--bg-gradient-dark');
                iconPath.setAttribute('d','M20.354 15.354A9 9 0 018.646 3.646 9.003 9.003 0 0012 21a9.003 9.003 0 008.354-5.646z');
            } else {
                body.classList.add('light');
                body.style.background = getComputedStyle(document.documentElement).getPropertyValue('--bg-gradient-light');
                iconPath.setAttribute('d','M12 3v1m0 16v1m9-9h-1M4 12H3m15.364 6.364l-.707-.707M6.343 6.343l-.707-.707m12.728 0l-.707.707M6.343 17.657l-.707.707M16 12a4 4 0 11-8 0 4 4 0 018 0z');
            }
        });
        const tagNames = ["ACCESS", "DENIED", "GUEST", "ROLE 3", "GROUP 5", "FPTU", "SECURITY", "READ ONLY", "NO PERMISSION", "LOGIN", "REGISTER"];
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
            this.el = document.createElement('div');
            this.el.className = 'floating-tag';
            this.el.innerText = name;
            container.appendChild(this.el);
            this.x = Math.random() * window.innerWidth;
            this.y = Math.random() * window.innerHeight;
            this.vx = (Math.random() - 0.5) * 1.2;
            this.vy = (Math.random() - 0.5) * 1.2;
            this.ax = 0;
            this.ay = 0;
        }

        Tag.prototype.update = function () {
            const dx = this.x - mouse.x;
            const dy = this.y - mouse.y;
            const distance = Math.sqrt(dx * dx + dy * dy) || 1;
            if (distance < repulsionRadius) {
                const force = (repulsionRadius - distance) / repulsionRadius;
                this.vx += (dx / distance) * force * repulsionStrength;
                this.vy += (dy / distance) * force * repulsionStrength;
            }
            this.vx *= 0.96;
            this.vy *= 0.96;
            this.x += this.vx + (Math.sign(this.vx || 1) * 0.2);
            this.y += this.vy + (Math.sign(this.vy || 1) * 0.2);

            const margin = 100;
            if (this.x < -margin) this.x = window.innerWidth + margin;
            if (this.x > window.innerWidth + margin) this.x = -margin;
            if (this.y < -margin) this.y = window.innerHeight + margin;
            if (this.y > window.innerHeight + margin) this.y = -margin;

            this.el.style.transform = 'translate(' + this.x + 'px, ' + this.y + 'px)';
        };

        function initTags() {
            for (let i = 0; i < 40; i++) {
                tags.push(new Tag(tagNames[i % tagNames.length]));
            }
        }

        function animate() {
            tags.forEach(t => t.update());
            requestAnimationFrame(animate);
        }

        window.addEventListener('load', () => {
            initTags();
            animate();
        });
    </script>
</body>
</html>
