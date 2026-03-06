<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="common/header.jsp" %>

<c:set var="isUpdate" value="${department != null}" />

<style>
    /* 1. Base Styles (Dark Mode mặc định) */
    .glass-card { 
        background: rgba(255, 255, 255, 0.03); 
        backdrop-filter: blur(12px); 
        border: 1px solid rgba(255, 255, 255, 0.15);
        border-radius: 1.25rem; 
        transition: all 0.3s ease;
    }
    .input-field { 
        background: rgba(255, 255, 255, 0.05); 
        border: 1px solid rgba(255, 255, 255, 0.1); 
        color: white; 
        transition: all 0.2s; 
    }
    .input-field:focus { border-color: #8b5cf6; outline: none; box-shadow: 0 0 0 3px rgba(139, 92, 246, 0.2); }
    .btn-primary { background: linear-gradient(135deg, #6366f1 0%, #a855f7 100%); }

    /* 2. Light Mode Styles */
    .light-mode {
        background-color: #e2e8f0;
        color: #1e293b; 
    }

    .light-mode .glass-card { 
        background: #ffffff; 
        border: 1px solid #cbd5e1;
        box-shadow: 0 10px 25px -5px rgba(0, 0, 0, 0.1), 0 8px 10px -6px rgba(0, 0, 0, 0.1); 
        color: #1e293b;
    }

    .light-mode .input-field { 
        background: #f1f5f9; 
        border: 1.5px solid #cbd5e1; 
        color: #0f172a; 
        font-weight: 500; 
    }
    
    .light-mode .input-field:focus {
        background: #ffffff;
        border-color: #4f46e5;
        box-shadow: 0 0 0 4px rgba(79, 70, 229, 0.15);
    }

    .light-mode h2, .light-mode h3 {
        color: #0f172a !important;
        font-weight: 800 !important; 
    }

    .light-mode .text-gray-400 {
        color: #475569 !important;
        font-weight: 700;
    }

    .light-mode .btn-primary {
        background: #4f46e5; 
        color: #ffffff;
        font-weight: 700;
    }

    /* Table Light Mode */
    .light-mode thead {
        background-color: #f1f5f9;
        border-bottom: 2px solid #cbd5e1 !important;
    }

    .light-mode tr {
        border-bottom: 1px solid #e2e8f0 !important;
    }

    .light-mode th {
        color: #1e293b !important;
        font-weight: 800 !important;
    }

    .light-mode td {
        color: #334155 !important;
        font-weight: 600;
    }
    
    .light-mode .bg-white\/5 {
        background-color: #f1f5f9 !important;
        border-bottom-color: #cbd5e1 !important;
    }

    /* Theme Toggle Button Style */
    #theme-toggle {
        display: flex;
        align-items: center;
        justify-content: center;
        width: 44px;
        height: 44px;
        transition: all 0.3s ease;
    }
</style>

<div class="max-w-7xl mx-auto px-6 py-10">
    <div class="flex flex-col md:flex-row justify-between items-end mb-10 gap-6">
        <div>
            <p class="text-sm text-indigo-600 dark:text-gray-400 uppercase tracking-widest font-bold">Dashboard / Khoa</p>
            <h2 class="text-4xl font-extrabold tracking-tight mt-1">Quản Lý Khoa</h2>
        </div>
        
        <div class="flex gap-3">
            <!-- Nút Toggle với Icon SVG động -->
            <button id="theme-toggle" class="rounded-xl border border-white/10 bg-white/5 hover:bg-white/10 transition shadow-sm text-indigo-500 dark:text-yellow-400">
                <svg id="theme-svg" class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path id="theme-path" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d=""></path>
                </svg>
            </button>
        </div>
    </div>

    <div class="grid grid-cols-1 lg:grid-cols-12 gap-8 items-start">
        <!-- Form Section -->
        <div class="lg:col-span-4">
            <div class="glass-card p-8">
                <h3 class="text-xl font-bold mb-6">${isUpdate ? 'Cập Nhật Khoa' : 'Thêm Khoa Mới'}</h3>
                <form action="department" method="post" class="space-y-6">
                    <input type="hidden" name="action" value="${isUpdate ? 'update' : 'add'}" />
                    <c:if test="${isUpdate}">
                        <input type="hidden" name="id" value="${department.id}" />
                    </c:if>
                    
                    <div>
                        <label class="block text-xs font-bold uppercase text-gray-400 mb-2 ml-1">Tên Khoa</label>
                        <input type="text" name="departmentname" value="${department.departmentname}" 
                               class="input-field w-full px-5 py-4 rounded-xl outline-none" 
                               required placeholder="VD: Công nghệ thông tin">
                    </div>

                    <button type="submit" class="btn-primary w-full py-4 rounded-xl font-bold text-white shadow-lg uppercase tracking-widest hover:opacity-90 transition">
                        ${isUpdate ? 'Lưu Thay Đổi' : 'Xác Nhận Thêm'}
                    </button>
                    
                    <c:if test="${isUpdate}">
                        <a href="department" class="block text-center text-xs font-bold text-gray-500 hover:text-indigo-600 transition mt-4">HỦY BỎ THAY ĐỔI</a>
                    </c:if>
                </form>
            </div>
        </div>

        <!-- Table Section -->
        <div class="lg:col-span-8">
            <div class="glass-card overflow-hidden">
                <div class="p-6 border-b border-white/10 bg-white/5">
                    <h3 class="text-xl font-bold">Danh Sách Khoa</h3>
                </div>
                <div class="overflow-x-auto">
                    <table class="w-full text-left">
                        <thead>
                            <tr class="text-gray-400 text-[10px] font-black uppercase tracking-widest">
                                <th class="px-6 py-5">STT</th>
                                <th class="px-6 py-5">Tên Khoa</th>
                                <th class="px-6 py-5 text-right">Thao tác</th>
                            </tr>
                        </thead>
                        <tbody class="divide-y divide-white/10">
                            <c:forEach var="d" items="${list}" varStatus="loop">
                                <tr class="hover:bg-white/[0.04] transition-colors">
                                    <td class="px-6 py-4 text-gray-500 font-mono font-bold">#${loop.index + 1}</td>
                                    <td class="px-6 py-4 font-bold text-base">${d.departmentname}</td>
                                    <td class="px-6 py-4 text-right space-x-3 text-sm font-black uppercase tracking-tight">
                                        <a href="department?action=edit&id=${d.id}" class="text-indigo-600 dark:text-indigo-400 hover:underline">Sửa</a>
                                        <span class="opacity-20 text-gray-400 font-normal">|</span>
                                        <a href="department?action=delete&id=${d.id}" onclick="return confirm('Xóa khoa này?')" class="text-red-600 dark:text-red-400 hover:underline">Xóa</a>
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

    // Các đường dẫn SVG
    const sunPath = "M12 3v1m0 16v1m9-9h-1M4 12H3m15.364 6.364l-.707-.707M6.343 6.343l-.707-.707m12.728 0l-.707.707M6.343 17.657l-.707.707M16 12a4 4 0 11-8 0 4 4 0 018 0z";
    const moonPath = "M20.354 15.354A9 9 0 018.646 3.646 9.003 9.003 0 0012 21a9.003 9.003 0 008.354-5.646z";

    function updateThemeUI(isLight) {
        if (isLight) {
            document.body.classList.add('light-mode');
            themePath.setAttribute('d', sunPath); // Hiện mặt trời khi ở chế độ sáng
        } else {
            document.body.classList.remove('light-mode');
            themePath.setAttribute('d', moonPath); // Hiện mặt trăng khi ở chế độ tối
        }
    }

    // Khởi tạo theme từ localStorage
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