<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="common/header.jsp" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản Lý Khoa - Student Management System</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;900&display=swap');

        :root {
            --bg-gradient-light: linear-gradient(135deg, #e0e7ff 0%, #a5b4fc 100%);
            --bg-gradient-dark: linear-gradient(135deg, #0f172a 0%, #1e1b4b 100%);
            --primary-indigo: #6366f1;
            --text-main: #ffffff;
            --text-sub: rgba(255, 255, 255, 0.6);
            --card-bg: rgba(15, 23, 42, 0.6);
            --border-color: rgba(99, 102, 241, 0.3);
        }

        .light {
            --text-main: #1e1b4b;
            --text-sub: rgba(30, 27, 75, 0.7);
            --card-bg: rgba(255, 255, 255, 0.4);
            --border-color: rgba(255, 255, 255, 0.8);
        }

        body {
            font-family: 'Inter', sans-serif;
            margin: 0;
            padding: 0;
            min-height: 100vh;
            width: 100vw;
            transition: background 0.5s ease;
            position: relative;
            overflow-x: hidden;
            background: var(--bg-gradient-dark);
        }

        body.light { background: var(--bg-gradient-light); }

        /* --- Hệ thống Tag nền --- */
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
            will-change: transform;
        }

        .light .floating-tag {
            background: rgba(255, 255, 255, 0.5);
            border-color: rgba(99, 102, 241, 0.2);
            color: var(--primary-indigo);
        }

        /* --- Glassmorphism Card --- */
        .glass-card {
            background: var(--card-bg);
            backdrop-filter: blur(40px);
            -webkit-backdrop-filter: blur(40px);
            border: 2px solid var(--border-color);
            border-radius: 32px;
            box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.4);
            transition: all 0.5s cubic-bezier(0.4, 0, 0.2, 1);
        }

        .light .glass-card {
            box-shadow: 0 20px 40px rgba(99, 102, 241, 0.1);
        }

        .theme-text-main { color: var(--text-main); transition: color 0.5s ease; }
        .theme-text-sub { color: var(--text-sub); transition: color 0.5s ease; }

        /* --- Input & Buttons --- */
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
            color: #1e1b4b;
        }

        .input-box:focus {
            background: rgba(255, 255, 255, 0.1);
            border-color: var(--primary-indigo);
            box-shadow: 0 0 15px rgba(99, 102, 241, 0.25);
        }

        .btn-primary {
            background: linear-gradient(135deg, #6366f1, #4f46e5);
            color: white;
            box-shadow: 0 10px 20px -5px rgba(79, 70, 229, 0.4);
            transition: all 0.3s ease;
            cursor: pointer;
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            filter: brightness(1.1);
            box-shadow: 0 15px 25px -5px rgba(79, 70, 229, 0.5);
        }

        /* --- Theme Toggle --- */
        .theme-toggle {
            position: fixed;
            top: 180px;
            right: 125px; /* Đã dời sang trái khoảng 100px (từ 25px thành 125px) */
            background: var(--card-bg);
            border: 1px solid var(--border-color);
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
            transition: all 0.6s cubic-bezier(0.34, 1.56, 0.64, 1);
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.2);
        }

        body.light .theme-toggle { transform: rotate(180deg); }
        #themeIcon { transition: transform 0.6s cubic-bezier(0.34, 1.56, 0.64, 1); }
        body.light #themeIcon { transform: rotate(-180deg); }

        .content-container {
            position: relative;
            z-index: 10;
            width: 100%;
            max-width: 1200px;
            margin: 60px auto;
            padding: 0 20px;
        }

        /* Custom Scrollbar */
        ::-webkit-scrollbar { width: 6px; }
        ::-webkit-scrollbar-track { background: transparent; }
        ::-webkit-scrollbar-thumb { background: rgba(99, 102, 241, 0.3); border-radius: 10px; }

        .table-row-hover:hover {
            background: rgba(99, 102, 241, 0.05);
        }
    </style>
</head>
<body class="dark">

    <!-- Nền Tag trôi nổi -->
    <div id="tag-container"></div>

    <!-- Nút đổi Theme -->
    <button onclick="toggleTheme()" class="theme-toggle" title="Thay đổi giao diện">
        <svg id="themeIcon" class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path id="iconPath" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M20.354 15.354A9 9 0 018.646 3.646 9.003 9.003 0 0012 21a9.003 9.003 0 008.354-5.646z" />
        </svg>
    </button>

    <div class="content-container">
        <!-- Header Section -->
        <div class="mb-12">
            <p class="text-[10px] font-black uppercase tracking-[0.4em] theme-text-sub mb-2">Hệ Thống Quản Lý / Nhóm 5</p>
            <h1 class="text-4xl font-black theme-text-main tracking-tight">Quản Lý Khoa</h1>
        </div>

        <div class="grid grid-cols-1 lg:grid-cols-12 gap-8 items-start">
            
            <!-- Cột trái: Form nhập liệu -->
            <div class="lg:col-span-4">
                <div class="glass-card p-8">
                    <div class="flex items-center gap-4 mb-8">
                        <div class="w-12 h-12 rounded-2xl bg-indigo-500/10 flex items-center justify-center border border-indigo-500/20">
                            <i class="fas fa-plus-circle text-indigo-400 text-xl"></i>
                        </div>
                        <h2 class="text-xl font-bold theme-text-main">Thêm Khoa Mới</h2>
                    </div>

                    <form onsubmit="event.preventDefault();" class="space-y-6">
                        <div class="space-y-2">
                            <label class="text-[10px] font-black uppercase tracking-[0.2em] ml-1 theme-text-sub">Tên Khoa</label>
                            <input type="text" name="departmentname" placeholder="Ví dụ: Công nghệ thông tin" class="input-box" required>
                        </div>

                        <div class="pt-2">
                            <button type="submit" class="w-full py-4 rounded-2xl btn-primary font-black uppercase tracking-widest text-sm">
                                Xác Nhận Thêm
                            </button>
                        </div>
                    </form>

                    <div class="mt-8 pt-6 border-t border-indigo-500/10">
                        <p class="theme-text-sub text-[9px] uppercase tracking-[2px] text-center italic">FPT University | SE Department</p>
                    </div>
                </div>
            </div>

            <!-- Cột phải: Danh sách dữ liệu -->
            <div class="lg:col-span-8">
                <div class="glass-card overflow-hidden">
                    <div class="p-6 border-b border-indigo-500/10 bg-white/5 flex justify-between items-center">
                        <h3 class="text-lg font-bold theme-text-main">Danh Sách Hiện Có</h3>
                        <span class="px-3 py-1 rounded-full bg-indigo-500/10 border border-indigo-500/20 text-[10px] font-bold theme-text-sub uppercase tracking-wider">
                            3 Khoa
                        </span>
                    </div>

                    <div class="overflow-x-auto">
                        <table class="w-full text-left">
                            <thead>
                                <tr class="theme-text-sub text-[10px] font-black uppercase tracking-[0.2em] border-b border-indigo-500/10">
                                    <th class="px-6 py-5">STT</th>
                                    <th class="px-6 py-5">Tên Khoa</th>
                                    <th class="px-6 py-5 text-right">Thao Tác</th>
                                </tr>
                            </thead>
                            <tbody class="divide-y divide-indigo-500/5">
                                <tr class="table-row-hover transition-colors">
                                    <td class="px-6 py-5 theme-text-sub font-mono font-bold">#1</td>
                                    <td class="px-6 py-5 font-bold theme-text-main">Kỹ thuật phần mềm</td>
                                    <td class="px-6 py-5 text-right space-x-3">
                                        <button class="text-indigo-400 hover:text-indigo-300 text-[10px] font-black uppercase tracking-tighter transition-opacity hover:opacity-80">
                                            <i class="fas fa-edit mr-1"></i> Sửa
                                        </button>
                                        <button class="text-red-400 hover:text-red-300 text-[10px] font-black uppercase tracking-tighter transition-opacity hover:opacity-80">
                                            <i class="fas fa-trash mr-1"></i> Xóa
                                        </button>
                                    </td>
                                </tr>
                                <tr class="table-row-hover transition-colors">
                                    <td class="px-6 py-5 theme-text-sub font-mono font-bold">#2</td>
                                    <td class="px-6 py-5 font-bold theme-text-main">An toàn thông tin</td>
                                    <td class="px-6 py-5 text-right space-x-3">
                                        <button class="text-indigo-400 hover:text-indigo-300 text-[10px] font-black uppercase tracking-tighter transition-opacity hover:opacity-80">
                                            <i class="fas fa-edit mr-1"></i> Sửa
                                        </button>
                                        <button class="text-red-400 hover:text-red-300 text-[10px] font-black uppercase tracking-tighter transition-opacity hover:opacity-80">
                                            <i class="fas fa-trash mr-1"></i> Xóa
                                        </button>
                                    </td>
                                </tr>
                                <tr class="table-row-hover transition-colors">
                                    <td class="px-6 py-5 theme-text-sub font-mono font-bold">#3</td>
                                    <td class="px-6 py-5 font-bold theme-text-main">Trí tuệ nhân tạo (AI)</td>
                                    <td class="px-6 py-5 text-right space-x-3">
                                        <button class="text-indigo-400 hover:text-indigo-300 text-[10px] font-black uppercase tracking-tighter transition-opacity hover:opacity-80">
                                            <i class="fas fa-edit mr-1"></i> Sửa
                                        </button>
                                        <button class="text-red-400 hover:text-red-300 text-[10px] font-black uppercase tracking-tighter transition-opacity hover:opacity-80">
                                            <i class="fas fa-trash mr-1"></i> Xóa
                                        </button>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script>
        function toggleTheme() {
            const body = document.body;
            const path = document.getElementById('iconPath');
            if (body.classList.contains('light')) {
                body.classList.remove('light');
                path.setAttribute('d', 'M20.354 15.354A9 9 0 018.646 3.646 9.003 9.003 0 0012 21a9.003 9.003 0 008.354-5.646z');
            } else {
                body.classList.add('light');
                path.setAttribute('d', 'M12 3v1m0 16v1m9-9h-1M4 12H3m15.364 6.364l-.707-.707M6.343 6.343l-.707-.707m12.728 0l-.707.707M6.343 17.657l-.707.707M16 12a4 4 0 11-8 0 4 4 0 018 0z');
            }
        }

        const seSubjects = ["PRJ301", "SWP391", "SWR302", "SWT301", "PRN211", "PRN221", "PRN231", "ITE302c", "MLN131", "EXE101", "EXE201", "SYB301", "PFP191", "JSW301", "IOT102", "NWC203", "SDW301", "WDP301", "PRM392", "WAD201"];
        const otherTags = ["Nhan", "Quay", "Phuoc", "Thang", "Tai", "FPTU", "Group 5", "SE", "Software Engineering"];
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
                const colors = ['text-blue-400', 'text-green-400', 'text-pink-400', 'text-yellow-400', 'text-cyan-400'];
                this.element.classList.add(colors[Math.floor(Math.random() * colors.length)], 'font-semibold');
            }
            container.appendChild(this.element);
            this.x = Math.random() * window.innerWidth;
            this.y = Math.random() * window.innerHeight;
            this.vx = (Math.random() - 0.5) * 1.5;
            this.vy = (Math.random() - 0.5) * 1.5;
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
            const minSpeed = 0.2;
            this.x += this.vx + (Math.sign(this.vx || 1) * minSpeed);
            this.y += this.vy + (Math.sign(this.vy || 1) * minSpeed);
            const margin = 80;
            if (this.x < -margin) this.x = window.innerWidth + margin;
            if (this.x > window.innerWidth + margin) this.x = -margin;
            if (this.y < -margin) this.y = window.innerHeight + margin;
            if (this.y > window.innerHeight + margin) this.y = -margin;
            this.element.style.transform = 'translate(' + this.x + 'px, ' + this.y + 'px)';
        };

        function initTags() {
            const count = window.innerWidth < 768 ? 15 : 35;
            for (let i = 0; i < count; i++) {
                tags.push(new Tag(allTagNames[i % allTagNames.length]));
            }
        }

        function animate() {
            for (let i = 0; i < tags.length; i++) tags[i].update();
            requestAnimationFrame(animate);
        }

        window.onload = function() { initTags(); animate(); };
        window.addEventListener('resize', () => {
            tags.forEach(t => {
                if (t.x > window.innerWidth) t.x = Math.random() * window.innerWidth;
                if (t.y > window.innerHeight) t.y = Math.random() * window.innerHeight;
            });
        });
    </script>
</body>
</html>