<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="common/header.jsp" %>

<c:set var="isUpdate" value="${department != null}" />

<style>
    /* 1. Biến số giao diện & Glassmorphism */
    :root {
        --glass-bg: rgba(255, 255, 255, 0.03);
        --glass-border: rgba(255, 255, 255, 0.12);
        --accent-primary: #6366f1;
        --accent-secondary: #a855f7;
        --text-main: #f8fafc;
        --text-muted: #94a3b8;
    }

    .light-mode {
        --glass-bg: rgba(255, 255, 255, 0.7);
        --glass-border: rgba(0, 0, 0, 0.08);
        --text-main: #1e293b;
        --text-muted: #64748b;
        background-color: #f1f5f9;
    }

    /* 2. Panels & Containers */
    .glass-panel {
        background: var(--glass-bg);
        backdrop-filter: blur(16px);
        -webkit-backdrop-filter: blur(16px);
        border: 1px solid var(--glass-border);
        border-radius: 1.5rem;
        transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
        color: var(--text-main);
    }

    .glass-panel:hover {
        border-color: rgba(99, 102, 241, 0.3);
        transform: translateY(-4px);
        box-shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.1);
    }

    /* 3. Inputs & Forms */
    .modern-input {
        background: rgba(255, 255, 255, 0.05);
        border: 1.5px solid rgba(255, 255, 255, 0.1);
        color: var(--text-main);
        transition: all 0.3s ease;
    }

    .light-mode .modern-input {
        background: #ffffff;
        border-color: #cbd5e1;
    }

    .modern-input:focus {
        border-color: var(--accent-primary);
        background: rgba(255, 255, 255, 0.1);
        box-shadow: 0 0 0 4px rgba(99, 102, 241, 0.15);
        outline: none;
    }

    /* 4. Table Styles */
    .table-container {
        border-radius: 1.5rem;
        overflow: hidden;
    }

    .custom-table thead {
        background: rgba(99, 102, 241, 0.08);
    }

    .table-row-animate {
        transition: all 0.25s ease;
        border-bottom: 1px solid var(--glass-border);
    }

    .table-row-animate:hover {
        background: rgba(99, 102, 241, 0.06) !important;
        transform: scale(1.005);
    }

    /* 5. Animations */
    @keyframes slideInUp {
        from { opacity: 0; transform: translateY(30px); }
        to { opacity: 1; transform: translateY(0); }
    }

    .animate-up {
        animation: slideInUp 0.6s cubic-bezier(0.16, 1, 0.3, 1) forwards;
    }

    /* 6. Action Buttons */
    .btn-gradient {
        background: linear-gradient(135deg, var(--accent-primary) 0%, var(--accent-secondary) 100%);
        transition: all 0.3s ease;
    }

    .btn-gradient:hover {
        filter: brightness(1.1);
        transform: scale(1.02);
        box-shadow: 0 10px 15px -3px rgba(99, 102, 241, 0.4);
    }

    .action-icon-btn {
        padding: 0.6rem;
        border-radius: 0.75rem;
        transition: all 0.2s;
    }

    .action-icon-btn:hover {
        background: rgba(99, 102, 241, 0.1);
    }
</style>

<div class="max-w-7xl mx-auto px-6 py-12">
    <!-- Header Section -->
    <div class="flex flex-col md:flex-row justify-between items-start md:items-center mb-12 gap-6 animate-up">
        <div>
            <div class="flex items-center gap-3 mb-2">
                <span class="px-3 py-1 rounded-full bg-indigo-500/10 text-indigo-500 text-[10px] font-black uppercase tracking-widest">
                    Academic Management
                </span>
            </div>
            <h2 class="text-4xl font-black tracking-tight dark:text-white text-slate-900">
                Quản lý <span class="text-transparent bg-clip-text bg-gradient-to-r from-indigo-500 to-purple-500">Khoa</span>
            </h2>
            <p class="text-slate-500 dark:text-gray-400 mt-2 font-medium">Tổ chức bộ máy và quản trị danh mục đơn vị học thuật.</p>
        </div>
        
        <button id="theme-toggle" class="p-3 glass-panel hover:scale-110 active:scale-95 text-indigo-500 dark:text-yellow-400 transition-all">
            <svg id="theme-svg" class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path id="theme-path" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d=""></path>
            </svg>
        </button>
    </div>

    <div class="grid grid-cols-1 lg:grid-cols-12 gap-10">
        <!-- FORM SECTION -->
        <div class="lg:col-span-4 animate-up" style="animation-delay: 0.1s">
            <div class="glass-panel p-8 sticky top-10">
                <div class="flex items-center gap-4 mb-8">
                    <div class="p-3 rounded-2xl bg-indigo-500/10 text-indigo-500">
                        <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 21V5a2 2 0 00-2-2H7a2 2 0 00-2 2v16m14 0h2m-2 0h-5m-9 0H3m2 0h5M9 7h1m-1 4h1m4-4h1m-1 4h1m-5 10v-5a1 1 0 011-1h2a1 1 0 011 1v5m-4 0h4"></path>
                        </svg>
                    </div>
                    <h3 class="text-xl font-bold">${isUpdate ? 'Cập nhật Khoa' : 'Thêm Khoa mới'}</h3>
                </div>

                <form action="department" method="post" class="space-y-6">
                    <input type="hidden" name="action" value="${isUpdate ? 'update' : 'add'}" />
                    <c:if test="${isUpdate}">
                        <input type="hidden" name="id" value="${department.id}" />
                    </c:if>
                    
                    <div class="space-y-2">
                        <label class="block text-xs font-bold uppercase tracking-widest text-slate-400 ml-1">Tên khoa</label>
                        <input type="text" name="departmentname" value="${department.departmentname}" 
                               class="modern-input w-full px-5 py-4 rounded-2xl outline-none text-base" 
                               required placeholder="VD: Công nghệ thông tin">
                    </div>

                    <button type="submit" class="btn-gradient w-full py-4 rounded-2xl font-bold text-white shadow-xl uppercase tracking-widest text-sm">
                        ${isUpdate ? 'Lưu thay đổi' : 'Xác nhận thêm'}
                    </button>
                    
                    <c:if test="${isUpdate}">
                        <a href="department" class="block text-center text-xs font-bold text-slate-500 hover:text-indigo-500 transition-colors mt-4 uppercase tracking-tighter">
                            Hủy bỏ chỉnh sửa
                        </a>
                    </c:if>
                </form>
            </div>
        </div>

        <!-- TABLE SECTION -->
        <div class="lg:col-span-8 animate-up" style="animation-delay: 0.2s">
            <div class="glass-panel table-container">
                <div class="p-6 border-b border-white/10 flex justify-between items-center">
                    <h3 class="text-lg font-bold">Danh sách đơn vị</h3>
                    <span class="px-3 py-1 bg-white/5 rounded-lg text-xs font-mono text-slate-400">Total: ${list.size()}</span>
                </div>
                
                <div class="overflow-x-auto custom-scrollbar">
                    <table class="w-full custom-table">
                        <thead>
                            <tr class="text-slate-400 text-[11px] font-black uppercase tracking-[0.2em]">
                                <th class="px-8 py-5 text-left w-20">ID</th>
                                <th class="px-8 py-5 text-left">Tên đơn vị Khoa</th>
                                <th class="px-8 py-5 text-right">Thao tác</th>
                            </tr>
                        </thead>
                        <tbody class="divide-y divide-white/5">
                            <c:forEach var="d" items="${list}" varStatus="loop">
                                <tr class="table-row-animate group">
                                    <td class="px-8 py-5">
                                        <span class="text-indigo-500 font-mono font-bold">#${loop.index + 1}</span>
                                    </td>
                                    <td class="px-8 py-5">
                                        <div class="font-bold text-base group-hover:text-indigo-400 transition-colors">
                                            ${d.departmentname}
                                        </div>
                                    </td>
                                    <td class="px-8 py-5 text-right">
                                        <div class="flex justify-end gap-2 opacity-60 group-hover:opacity-100 transition-opacity">
                                            <a href="department?action=edit&id=${d.id}" class="action-icon-btn text-indigo-500 hover:bg-indigo-500/10" title="Chỉnh sửa">
                                                <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M11 5H6a2 2 0 00-2 2v11a2 2 0 002 2h11a2 2 0 002-2v-5m-1.414-9.414a2 2 0 112.828 2.828L11.828 15H9v-2.828l8.586-8.586z"></path>
                                                </svg>
                                            </a>
                                            <a href="department?action=delete&id=${d.id}" 
                                               onclick="return confirm('Bạn có chắc chắn muốn xóa khoa này không?')" 
                                               class="action-icon-btn text-red-500 hover:bg-red-500/10" title="Xóa">
                                                <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 7l-.867 12.142A2 2 0 0116.138 21H7.862a2 2 0 01-1.995-1.858L5 7m5 4v6m4-6v6m1-10V4a1 1 0 00-1-1h-4a1 1 0 00-1 1v3M4 7h16"></path>
                                                </svg>
                                            </a>
                                        </div>
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
    const themeBtn = document.getElementById('theme-toggle');
    const themePath = document.getElementById('theme-path');

    // SVG Paths cho biểu tượng
    const sunPath = "M12 3v1m0 16v1m9-9h-1M4 12H3m15.364 6.364l-.707-.707M6.343 6.343l-.707-.707m12.728 0l-.707.707M6.343 17.657l-.707.707M16 12a4 4 0 11-8 0 4 4 0 018 0z";
    const moonPath = "M20.354 15.354A9 9 0 018.646 3.646 9.003 9.003 0 0012 21a9.003 9.003 0 008.354-5.646z";

    function updateThemeUI(isLight) {
        if (isLight) {
            document.body.classList.add('light-mode');
            themePath.setAttribute('d', sunPath);
        } else {
            document.body.classList.remove('light-mode');
            themePath.setAttribute('d', moonPath);
        }
    }

    // Load trạng thái từ localStorage
    const savedTheme = localStorage.getItem('theme') === 'light';
    updateThemeUI(savedTheme);

    themeBtn.addEventListener('click', () => {
        const isCurrentlyLight = document.body.classList.contains('light-mode');
        const nextThemeIsLight = !isCurrentlyLight;
        localStorage.setItem('theme', nextThemeIsLight ? 'light' : 'dark');
        updateThemeUI(nextThemeIsLight);
    });
</script>

<%@ include file="common/footer.jsp" %>