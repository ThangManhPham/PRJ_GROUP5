<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="common/header.jsp" %>

<c:set var="isUpdate" value="${department != null}" />

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
        --input-bg: rgba(255, 255, 255, 0.05);
    }

    body.light-mode {
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
        background: var(--bg-gradient-dark);
        color: var(--text-main);
        transition: background 0.5s cubic-bezier(0.4, 0, 0.2, 1);
        position: relative;
        overflow-x: hidden;
    }

    body.light-mode { background: var(--bg-gradient-light); }

    /* Floating Tags Background Animation */
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

    /* Glass Cards */
    .glass-card { 
        background: var(--card-bg); 
        backdrop-filter: blur(40px); 
        border: 2px solid var(--border-color); 
        border-radius: 2rem; 
        box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.4);
        transition: all 0.5s cubic-bezier(0.4, 0, 0.2, 1);
    }

    .light-mode .glass-card { 
        box-shadow: 0 20px 40px rgba(99, 102, 241, 0.1);
    }

    /* Inputs */
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
    }

    /* Buttons */
    .btn-primary { 
        background: linear-gradient(135deg, #6366f1, #4f46e5); 
        color: white;
        box-shadow: 0 10px 20px -5px rgba(79, 70, 229, 0.4);
        transition: all 0.3s ease;
    }

    .btn-primary:hover {
        transform: translateY(-2px);
        filter: brightness(1.1);
    }

    /* Theme Toggle Sync with Student Style */
    #theme-toggle {
        width: 48px;
        height: 48px;
        background: var(--card-bg);
        border: 1px solid var(--border-color);
        border-radius: 14px;
        display: flex;
        align-items: center;
        justify-content: center;
        cursor: pointer;
        backdrop-filter: blur(10px);
        transition: all 0.5s cubic-bezier(0.34, 1.56, 0.64, 1);
    }
    
    #theme-toggle svg {
        transition: transform 0.5s cubic-bezier(0.34, 1.56, 0.64, 1);
    }
    
    #theme-toggle:hover {
        transform: scale(1.1) rotate(5deg);
        background: rgba(99, 102, 241, 0.15);
    }

    /* Icon Container Style for Section Titles */
    .icon-box {
        width: 48px;
        height: 48px;
        border-radius: 14px;
        background: rgba(99, 102, 241, 0.15);
        border: 1px solid rgba(99, 102, 241, 0.2);
        display: flex;
        align-items: center;
        justify-content: center;
        position: relative;
    }

    .icon-badge {
        position: absolute;
        top: -4px;
        right: -4px;
        width: 18px;
        height: 18px;
        background: #6366f1;
        border-radius: 6px;
        display: flex;
        align-items: center;
        justify-content: center;
        color: white;
        font-size: 10px;
        box-shadow: 0 4px 6px rgba(0,0,0,0.2);
    }
</style>

<!-- Floating Background Elements -->
<div id="tag-container"></div>

<div class="relative z-10 max-w-7xl mx-auto px-6 py-10">
    <!-- Header Section -->
    <div class="flex flex-col md:flex-row justify-between items-end mb-10 gap-6">
        <div>
            <p class="text-[10px] font-black uppercase tracking-[0.2em] text-indigo-500 opacity-80">System / Management</p>
            <h2 class="text-4xl font-black tracking-tight mt-1">Quản Lý Khoa</h2>
        </div>
        
        <div class="flex gap-3">
            <button id="theme-toggle">
                <svg class="w-6 h-6 text-indigo-500" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path id="theme-path" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d=""></path>
                </svg>
            </button>
        </div>
    </div>

    <div class="grid grid-cols-1 lg:grid-cols-12 gap-10 items-start">
        <!-- Form Column -->
        <div class="lg:col-span-4">
            <div class="glass-card p-8">
                 <div class="flex items-center gap-4 mb-8">
                            <div class="w-12 h-12 rounded-2xl bg-indigo-500/10 flex items-center justify-center border border-indigo-500/20">
                                <i class="fas ${isUpdate ? 'fa-edit' : 'fa-plus-circle'} text-indigo-400 text-xl"></i>
                            </div>
                            <h3 class="text-xl font-bold">
                                ${isUpdate ? 'Cập Nhật Thông Tin' : 'Thêm  Khoa Mới'}
                            </h3>
                        </div>

                <form action="department" method="post" class="space-y-6">
                    <input type="hidden" name="action" value="${isUpdate ? 'update' : 'add'}" />
                    <c:if test="${isUpdate}">
                        <input type="hidden" name="id" value="${department.id}" />
                    </c:if>
                    
                    <div>
                        <label class="block text-[10px] font-black uppercase tracking-wider mb-2 ml-1 opacity-60">Tên Khoa</label>
                        <input type="text" name="departmentname" value="${department.departmentname}" 
                               class="input-field w-full px-5 py-4 rounded-xl outline-none" 
                               required placeholder="VD: Công nghệ thông tin">
                    </div>

                    <button type="submit" class="btn-primary w-full py-4 rounded-xl font-bold uppercase tracking-widest active:scale-95">
                        ${isUpdate ? 'Lưu Thay Đổi' : 'Xác Nhận Thêm'}
                    </button>
                    
                    <c:if test="${isUpdate}">
                        <a href="department" class="block text-center text-[10px] font-black text-indigo-400 hover:text-indigo-300 uppercase tracking-widest mt-4">
                            <i class="fas fa-times mr-2"></i>Hủy Bỏ Thay Đổi
                        </a>
                    </c:if>
                </form>
            </div>
        </div>

        <!-- Table Column -->
        <div class="lg:col-span-8">
            <div class="glass-card overflow-hidden">
                <div class="p-6 border-b border-white/5 bg-white/5 flex justify-between items-center">
                    <h3 class="text-lg font-bold">Danh Sách Khoa</h3>
                    <div class="text-[10px] font-bold px-3 py-1 bg-indigo-500/10 text-indigo-400 border border-indigo-500/20 rounded-full uppercase tracking-widest">
                        Department Data
                    </div>
                </div>
                
                <div class="overflow-x-auto">
                    <table class="w-full text-left">
                        <thead>
                            <tr class="text-[10px] font-black uppercase tracking-widest border-b border-white/5 opacity-50">
                                <th class="px-6 py-5">STT</th>
                                <th class="px-6 py-5">Tên Khoa</th>
                                <th class="px-6 py-5 text-right">Thao tác</th>
                            </tr>
                        </thead>
                        <tbody class="divide-y divide-white/5">
                            <c:forEach var="d" items="${list}" varStatus="loop">
                                <tr class="hover:bg-indigo-500/5 transition-colors group">
                                    <td class="px-6 py-4 font-mono text-indigo-500 font-bold">#${loop.index + 1}</td>
                                    <td class="px-6 py-4 font-bold text-lg">${d.departmentname}</td>
                                    <td class="px-6 py-4 text-right space-x-4">
                                        <a href="department?action=edit&id=${d.id}" class="text-[10px] font-black text-indigo-400 hover:text-indigo-300 transition uppercase tracking-tighter">
                                            <i class="fas fa-edit mr-1"></i> Sửa
                                        </a>
                                        <a href="department?action=delete&id=${d.id}" onclick="return confirm('Xóa khoa này?')" class="text-[10px] font-black text-red-500/70 hover:text-red-500 transition uppercase tracking-tighter">
                                            <i class="fas fa-trash mr-1"></i> Xóa
                                        </a>
                                    </td>
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
    // --- THEME LOGIC (Synced with Student Animation) ---
    const themeBtn = document.getElementById('theme-toggle');
    const themePath = document.getElementById('theme-path');
    const sunPath = "M12 3v1m0 16v1m9-9h-1M4 12H3m15.364 6.364l-.707-.707M6.343 6.343l-.707-.707m12.728 0l-.707.707M6.343 17.657l-.707.707M16 12a4 4 0 11-8 0 4 4 0 018 0z";
    const moonPath = "M20.354 15.354A9 9 0 018.646 3.646 9.003 9.003 0 0012 21a9.003 9.003 0 008.354-5.646z";

    function updateThemeUI(isLight) {
        if (isLight) {
            document.body.classList.add('light-mode');
            themePath.setAttribute('d', sunPath);
            themeBtn.style.transform = "rotate(360deg)";
        } else {
            document.body.classList.remove('light-mode');
            themePath.setAttribute('d', moonPath);
            themeBtn.style.transform = "rotate(0deg)";
        }
    }

    const savedTheme = localStorage.getItem('theme') === 'light';
    updateThemeUI(savedTheme);

    themeBtn.addEventListener('click', () => {
        const isCurrentlyLight = document.body.classList.contains('light-mode');
        const nextThemeIsLight = !isCurrentlyLight;
        localStorage.setItem('theme', nextThemeIsLight ? 'light' : 'dark');
        updateThemeUI(nextThemeIsLight);
    });

    // --- FLOATING TAGS ANIMATION ---
    const tagNames = ["IT", "Business", "Language", "Marketing", "Engineering", "Design", "FPTU", "Department", "Admin"];
    const container = document.getElementById('tag-container');
    const tagsArr = [];
    const mousePos = { x: -1000, y: -1000 };

    window.addEventListener('mousemove', (e) => { mousePos.x = e.clientX; mousePos.y = e.clientY; });

    function TagObj(name) {
        this.element = document.createElement('div');
        this.element.className = 'floating-tag';
        this.element.innerText = name;
        container.appendChild(this.element);
        this.x = Math.random() * window.innerWidth;
        this.y = Math.random() * window.innerHeight;
        this.vx = (Math.random() - 0.5) * 1.5;
        this.vy = (Math.random() - 0.5) * 1.5;
    }

    TagObj.prototype.update = function() {
        const dx = this.x - mousePos.x;
        const dy = this.y - mousePos.y;
        const dist = Math.sqrt(dx*dx + dy*dy);
        if (dist < 150) {
            this.x += (dx/dist) * 2;
            this.y += (dy/dist) * 2;
        }
        this.x += this.vx; this.y += this.vy;
        if (this.x < -100) this.x = window.innerWidth + 100;
        if (this.x > window.innerWidth + 100) this.x = -100;
        if (this.y < -100) this.y = window.innerHeight + 100;
        if (this.y > window.innerHeight + 100) this.y = -100;
        
        this.element.style.transform = `translate(\${this.x}px, \${this.y}px)`;
    };

    function initTags() {
        const count = window.innerWidth < 768 ? 10 : 20;
        for(let i=0; i<count; i++) tagsArr.push(new TagObj(tagNames[i % tagNames.length]));
    }

    function animateTags() {
        tagsArr.forEach(t => t.update());
        requestAnimationFrame(animateTags);
    }

    initTags();
    animateTags();
</script>

<%@ include file="common/footer.jsp" %>