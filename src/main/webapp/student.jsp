<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="common/header.jsp" %>

<c:set var="errors" value="${requestScope.errors}" />
<c:set var="user" value="${sessionScope.user}" />
<c:set var="isUpdate" value="${not empty student and student.id > 0}" />

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản Lý Sinh Viên - Student Management System</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;900&display=swap');

        /* --- 1. Base & Dark Mode (Default) --- */
        :root {
            --bg-gradient-light: linear-gradient(135deg, #e0e7ff 0%, #a5b4fc 100%);
            --bg-gradient-dark: linear-gradient(135deg, #0f172a 0%, #1e1b4b 100%);
            --primary-indigo: #6366f1;
            --text-main: #ffffff;
            --text-sub: rgba(255, 255, 255, 0.6);
            --card-bg: rgba(15, 23, 42, 0.6);
            --border-color: rgba(99, 102, 241, 0.3);
            --input-bg: rgba(255, 255, 255, 0.05);
        }

        .light-mode {
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
            color: var(--text-main);
        }

        body.light-mode { background: var(--bg-gradient-light); }

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

        .light-mode .floating-tag {
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
            border-radius: 2rem; 
            box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.4);
            transition: all 0.5s cubic-bezier(0.4, 0, 0.2, 1);
        }

        .light-mode .glass-card { 
            box-shadow: 0 20px 40px rgba(99, 102, 241, 0.1);
        }

        .input-field { 
            background: var(--input-bg); 
            border: 1px solid var(--border-color); 
            color: var(--text-main); 
            transition: all 0.3s ease; 
        }

        .light-mode .input-field {
            background: rgba(255, 255, 255, 0.7);
            border-color: rgba(99, 102, 241, 0.1);
            color: #1e1b4b;
        }

        .input-field:focus { 
            border-color: var(--primary-indigo); 
            outline: none; 
            box-shadow: 0 0 15px rgba(99, 102, 241, 0.25); 
            background: rgba(255, 255, 255, 0.1);
        }

        .btn-primary { 
            background: linear-gradient(135deg, #6366f1, #4f46e5); 
            color: white;
            box-shadow: 0 10px 20px -5px rgba(79, 70, 229, 0.4);
            transition: all 0.3s ease;
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            filter: brightness(1.1);
            box-shadow: 0 15px 25px -5px rgba(79, 70, 229, 0.5);
        }

        /* Theme Toggle */
        .theme-toggle {
            position: fixed;
            top: 20px;
            right: 20px;
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
        }

        body.light-mode .theme-toggle { transform: rotate(180deg); }
        .theme-text-sub { color: var(--text-sub); transition: color 0.5s ease; }

        /* Scrollbar */
        ::-webkit-scrollbar { width: 6px; }
        ::-webkit-scrollbar-thumb { background: rgba(99, 102, 241, 0.3); border-radius: 10px; }
    </style>
</head>
<body class="dark">

    <!-- Nền Tag trôi nổi -->
    <div id="tag-container"></div>

    <!-- Nút đổi Theme -->
    <button id="theme-toggle" class="theme-toggle" title="Thay đổi giao diện">
        <svg id="themeIcon" class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path id="iconPath" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M20.354 15.354A9 9 0 018.646 3.646 9.003 9.003 0 0012 21a9.003 9.003 0 008.354-5.646z" />
        </svg>
    </button>

    <div class="relative z-10 max-w-7xl mx-auto px-6 py-10">
        <!-- Header Section -->
        <div class="mb-10">
            <div class="flex flex-col md:flex-row justify-between items-end gap-6">
                <div>
                    <h2 class="text-4xl font-black tracking-tight">Quản Lý Sinh Viên</h2>
                    <p class="theme-text-sub text-sm mt-1">
                        Xin chào, <span class="font-bold text-indigo-500">${user.username}</span> 
                        <span class="mx-2 opacity-30">•</span>
                        <span class="px-2 py-0.5 rounded-md bg-indigo-500/10 text-[10px] font-bold uppercase tracking-widest text-indigo-400 border border-indigo-500/20">
                            ${user.role == 1 ? 'Manager' : 'Staff'}
                        </span>
                    </p>
                </div>
            </div>
        </div>

        <div class="grid grid-cols-1 lg:grid-cols-12 gap-10 items-start">
            <c:if test="${user.role == 2}">
                <!-- Form Column -->
                <div class="lg:col-span-4">
                    <div class="glass-card p-8">
                        <div class="flex items-center gap-4 mb-8">
                            <div class="w-12 h-12 rounded-2xl bg-indigo-500/10 flex items-center justify-center border border-indigo-500/20">
                                <i class="fas ${isUpdate ? 'fa-edit' : 'fa-plus-circle'} text-indigo-400 text-xl"></i>
                            </div>
                            <h3 class="text-xl font-bold">
                                ${isUpdate ? 'Cập Nhật Thông Tin' : 'Thêm Sinh Viên Mới'}
                            </h3>
                        </div>

                        <form action="student" method="post" class="space-y-5">
                            <input type="hidden" name="action" value="${isUpdate ? 'update' : 'insert'}">
                            <input type="hidden" name="id" value="${student != null ? student.id : ''}">

                            <div>
                                <label class="block text-[10px] font-black uppercase tracking-wider mb-2 ml-1 theme-text-sub">Mã Số Sinh Viên</label>
                                <input type="text" name="studentId" value="${student != null ? student.studentId : ''}" 
                                       class="input-field w-full px-4 py-3.5 rounded-xl ${isUpdate ? 'opacity-50 cursor-not-allowed' : ''}"
                                       ${isUpdate ? 'readonly' : ''} placeholder="VD: SE180000">
                            </div>

                            <div>
                                <label class="block text-[10px] font-black uppercase tracking-wider mb-2 ml-1 theme-text-sub">Họ Và Tên</label>
                                <input type="text" name="name" value="${student != null ? student.name : ''}" 
                                       class="input-field w-full px-4 py-3.5 rounded-xl" placeholder="Nhập tên đầy đủ">
                            </div>

                            <div class="grid grid-cols-2 gap-4">
                                <div>
                                    <label class="block text-[10px] font-black uppercase tracking-wider mb-2 ml-1 theme-text-sub">Điểm GPA</label>
                                    <input type="number" step="0.1" min="0" max="10" name="gpa" value="${student != null ? student.gpa : ''}" 
                                           class="input-field w-full px-4 py-3.5 rounded-xl">
                                </div>
                                <div>
                                    <label class="block text-[10px] font-black uppercase tracking-wider mb-2 ml-1 theme-text-sub">Khoa / Ngành</label>
                                    <div class="relative">
                                        <select name="departmentId" class="input-field w-full px-4 py-3.5 rounded-xl appearance-none cursor-pointer">
                                            <c:forEach items="${departments}" var="d">
                                                <option value="${d.id}" ${student != null && student.department.id == d.id ? 'selected' : ''}>
                                                    ${d.departmentname}
                                                </option>
                                            </c:forEach>
                                        </select>
                                        <div class="absolute inset-y-0 right-3 flex items-center pointer-events-none opacity-50">
                                            <i class="fas fa-chevron-down text-xs"></i>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <button type="submit" class="btn-primary w-full py-4 rounded-xl font-bold text-white uppercase tracking-widest mt-4 active:scale-[0.98]">
                                ${isUpdate ? 'Cập Nhật Ngay' : 'Thêm Vào Danh Sách'}
                            </button>
                            
                            <c:if test="${isUpdate}">
                                <a href="student" class="block text-center text-xs font-bold theme-text-sub hover:text-indigo-400 transition-colors">
                                    Hủy bỏ và quay lại
                                </a>
                            </c:if>
                        </form>
                    </div>
                </div>
            </c:if>

            <!-- Table Column -->
            <div class="${user.role == 2 ? 'lg:col-span-8' : 'lg:col-span-12'}">
                <div class="glass-card overflow-hidden">
                    <div class="p-6 border-b border-white/5 bg-white/5 flex justify-between items-center ${user.role == 1 ? 'bg-indigo-500/5' : ''}">
                        <h3 class="text-lg font-bold">${user.role == 1 ? 'Bảng Xếp Hạng Top 5' : 'Danh Sách Sinh Viên'}</h3>
                        <div class="text-[10px] font-bold px-3 py-1 bg-indigo-500/10 text-indigo-400 border border-indigo-500/20 rounded-full uppercase tracking-wider">
                            ${students.size()} Sinh viên
                        </div>
                    </div>
                    
                    <div class="overflow-x-auto">
                        <table class="w-full text-left">
                            <thead>
                                <tr class="theme-text-sub text-[10px] font-black uppercase tracking-widest border-b border-white/5">
                                    <th class="px-6 py-5">MSSV</th>
                                    <th class="px-6 py-5">Họ Tên</th>
                                    <th class="px-6 py-5 text-center">GPA</th>
                                    <th class="px-6 py-5">Khoa</th>
                                    <c:if test="${user.role == 2}">
                                        <th class="px-6 py-5 text-right">Thao tác</th>
                                    </c:if>
                                </tr>
                            </thead>
                            <tbody class="divide-y divide-white/5">
                                <c:forEach var="s" items="${students}">
                                    <tr class="hover:bg-indigo-500/5 transition-colors group">
                                        <td class="px-6 py-4 font-mono text-indigo-500 font-bold">${s.studentId}</td>
                                        <td class="px-6 py-4 font-bold">${s.name}</td>
                                        <td class="px-6 py-4 text-center">
                                            <span class="inline-block min-w-[40px] px-2 py-1 rounded-lg text-xs font-black shadow-sm 
                                                ${s.gpa >= 8 ? 'bg-green-500/20 text-green-500 border border-green-500/20' : 
                                                  s.gpa >= 5 ? 'bg-yellow-500/20 text-yellow-500 border border-yellow-500/20' : 
                                                  'bg-red-500/20 text-red-500 border border-red-500/20'}">
                                                ${s.gpa}
                                            </span>
                                        </td>
                                        <td class="px-6 py-4 text-sm theme-text-sub font-medium">${s.department.departmentname}</td>
                                        <c:if test="${user.role == 2}">
                                            <td class="px-6 py-4 text-right space-x-4">
                                                <a href="student?action=edit&id=${s.id}" 
                                                   class="text-[10px] font-black text-indigo-400 hover:text-indigo-300 transition uppercase tracking-tighter">
                                                    <i class="fas fa-edit mr-1"></i> Sửa
                                                </a>
                                                <a href="student?action=delete&id=${s.id}" 
                                                   onclick="return confirm('Bạn có chắc chắn muốn xóa sinh viên ${s.name}?')" 
                                                   class="text-[10px] font-black text-red-500/70 hover:text-red-500 transition uppercase tracking-tighter">
                                                    <i class="fas fa-trash mr-1"></i> Xóa
                                                </a>
                                            </td>
                                        </c:if>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script>
        const themeBtn = document.getElementById('theme-toggle');
        const iconPath = document.getElementById('iconPath');

        function applyTheme(theme) {
            if (theme === 'light') {
                document.body.classList.add('light-mode');
                iconPath.setAttribute('d', 'M12 3v1m0 16v1m9-9h-1M4 12H3m15.364 6.364l-.707-.707M6.343 6.343l-.707-.707m12.728 0l-.707.707M6.343 17.657l-.707.707M16 12a4 4 0 11-8 0 4 4 0 018 0z');
            } else {
                document.body.classList.remove('light-mode');
                iconPath.setAttribute('d', 'M20.354 15.354A9 9 0 018.646 3.646 9.003 9.003 0 0012 21a9.003 9.003 0 008.354-5.646z');
            }
        }

        const savedTheme = localStorage.getItem('theme') || 'dark';
        applyTheme(savedTheme);

        themeBtn.addEventListener('click', () => {
            const currentTheme = document.body.classList.contains('light-mode') ? 'light' : 'dark';
            const newTheme = currentTheme === 'light' ? 'dark' : 'light';
            localStorage.setItem('theme', newTheme);
            applyTheme(newTheme);
        });

        // --- HỆ THỐNG TAG NỀN (Né chuột) ---
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

<%@ include file="common/footer.jsp" %>