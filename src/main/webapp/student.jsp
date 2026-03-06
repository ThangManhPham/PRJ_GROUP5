<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="common/header.jsp" %>

<c:set var="errors" value="${requestScope.errors}" />
<c:set var="user" value="${sessionScope.user}" />
<c:set var="isUpdate" value="${not empty student and student.id > 0}" />

<style>
    /* --- 1. Base & Dark Mode (Default) --- */
    :root {
        --primary-gradient: linear-gradient(135deg, #6366f1 0%, #a855f7 100%);
        --glass-bg: rgba(255, 255, 255, 0.03);
        --glass-border: rgba(255, 255, 255, 0.1);
        --input-bg: rgba(255, 255, 255, 0.05);
    }

    body {
        transition: background-color 0.3s, color 0.3s;
    }

    .glass-card { 
        background: var(--glass-bg); 
        backdrop-filter: blur(12px); 
        border: 1px solid var(--glass-border); 
        border-radius: 1.25rem; 
        transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
    }

    .input-field { 
        background: var(--input-bg); 
        border: 1px solid var(--glass-border); 
        color: white; 
        transition: all 0.2s ease; 
    }

    .input-field:focus { 
        border-color: #8b5cf6; 
        outline: none; 
        box-shadow: 0 0 0 3px rgba(139, 92, 246, 0.2); 
        background: rgba(255, 255, 255, 0.08);
    }

    .btn-primary { 
        background: var(--primary-gradient); 
        box-shadow: 0 4px 15px rgba(139, 92, 246, 0.3);
    }

    /* --- 2. Light Mode Override --- */
    .light-mode {
        background-color: #f1f5f9;
        color: #1e293b; 
    }

    .light-mode .glass-card { 
        background: #ffffff; 
        border: 1px solid rgba(0, 0, 0, 0.05);
        box-shadow: 0 10px 25px -5px rgba(0, 0, 0, 0.05), 0 8px 10px -6px rgba(0, 0, 0, 0.05); 
        color: #1e293b;
    }

    .light-mode .input-field { 
        background: #ffffff; 
        border: 1.5px solid #cbd5e1; 
        color: #0f172a; 
        font-weight: 500; 
    }

    .light-mode .input-field:focus {
        border-color: #6366f1;
        box-shadow: 0 0 0 4px rgba(99, 102, 241, 0.1);
    }

    .light-mode h2, .light-mode h3 {
        color: #0f172a !important;
        font-weight: 800 !important; 
    }

    .light-mode .label-text {
        color: #64748b !important;
        font-weight: 700;
    }

    .light-mode .btn-primary {
        background: #4f46e5; 
        box-shadow: 0 10px 20px -5px rgba(79, 70, 229, 0.4);
    }

    /* Table Styles in Light Mode */
    .light-mode thead {
        background: #f8fafc;
        border-bottom: 2px solid #e2e8f0 !important;
    }
    
    /* Đặc biệt cho tiêu đề Top 5 */
    .light-mode .header-top5 {
        background: #f1f5f9 !important; /* Màu nền khác biệt cho dòng tiêu đề Top 5 */
    }

    .light-mode tr { border-bottom: 1px solid #f1f5f9 !important; }
    .light-mode tr:hover { background-color: #f8fafc !important; }
    .light-mode th { color: #475569 !important; }
    .light-mode td { color: #334155 !important; }

    /* Theme Toggle Button Animation */
    #theme-toggle {
        transition: transform 0.2s, background-color 0.3s;
    }
    #theme-toggle:active { transform: scale(0.9); }
</style>

<div class="max-w-7xl mx-auto px-6 py-10">
    <!-- Header Section -->
    <div class="flex flex-col md:flex-row justify-between items-end mb-10 gap-6">
        <div>
            <h2 class="text-4xl font-extrabold tracking-tight">Quản Lý Sinh Viên</h2>
            <p class="text-sm opacity-70 mt-1">
                Xin chào, <span class="font-bold text-purple-500">${user.username}</span> 
                <span class="mx-2 text-gray-500">•</span>
                <span class="px-2 py-0.5 rounded-md bg-white/10 text-[10px] font-bold uppercase tracking-widest">
                    ${user.role == 1 ? 'Manager' : 'Staff'}
                </span>
            </p>
        </div>
        
        <div class="flex gap-3">
            <button id="theme-toggle" class="p-3 rounded-2xl border border-white/10 bg-white/5 hover:bg-white/10 transition shadow-sm">
                <span id="theme-toggle-dark-icon" class="text-xl">🌙</span>
                <span id="theme-toggle-light-icon" class="hidden text-xl">☀️</span>
            </button>
        </div>
    </div>

    <div class="grid grid-cols-1 lg:grid-cols-12 gap-10 items-start">
        <c:if test="${user.role == 2}">
            <!-- Form: Thêm/Sửa -->
            <div class="lg:col-span-4">
                <div class="glass-card p-8">
                    <h3 class="text-xl font-bold mb-6 flex items-center gap-2">
                        <span class="w-2 h-6 bg-purple-500 rounded-full"></span>
                        ${isUpdate ? 'Cập Nhật Thông Tin' : 'Thêm Sinh Viên Mới'}
                    </h3>
                    <form action="student" method="post" class="space-y-5">
                        <input type="hidden" name="id" value="${student.id}" />
                        
                        <div>
                            <label class="label-text block text-[10px] uppercase tracking-wider mb-1.5 ml-1 opacity-60">Mã Số Sinh Viên</label>
                            <input type="text" name="studentId" value="${student.studentId}" 
                                   class="input-field w-full px-4 py-3.5 rounded-xl ${errors.studentId != null ? 'border-red-500' : ''} ${isUpdate ? 'opacity-50 cursor-not-allowed' : ''}" 
                                   ${isUpdate ? 'readonly' : ''} placeholder="VD: SE180000">
                        </div>

                        <div>
                            <label class="label-text block text-[10px] uppercase tracking-wider mb-1.5 ml-1 opacity-60">Họ Và Tên</label>
                            <input type="text" name="name" value="${student.name}" 
                                   class="input-field w-full px-4 py-3.5 rounded-xl ${errors.name != null ? 'border-red-500' : ''}"
                                   placeholder="Nhập tên đầy đủ">
                        </div>

                        <div class="grid grid-cols-2 gap-4">
                            <div>
                                <label class="label-text block text-[10px] uppercase tracking-wider mb-1.5 ml-1 opacity-60">Điểm GPA</label>
                                <input type="number" step="0.1" min="0" max="10" name="gpa" value="${student.gpa}" 
                                       class="input-field w-full px-4 py-3.5 rounded-xl">
                            </div>
                            <div>
                                <label class="label-text block text-[10px] uppercase tracking-wider mb-1.5 ml-1 opacity-60">Khoa / Ngành</label>
                                <div class="relative">
                                    <select name="departmentId" class="input-field w-full px-4 py-3.5 rounded-xl appearance-none cursor-pointer">
                                        <c:forEach var="d" items="${departments}">
                                            <option value="${d.id}" ${student.department.id == d.id ? 'selected' : ''}>${d.departmentname}</option>
                                        </c:forEach>
                                    </select>
                                    <div class="absolute inset-y-0 right-3 flex items-center pointer-events-none opacity-50">
                                        <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 9l-7 7-7-7"></path></svg>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <button type="submit" class="btn-primary w-full py-4 rounded-xl font-bold text-white uppercase tracking-widest mt-4 transition hover:brightness-110 active:scale-[0.98]">
                            ${isUpdate ? 'Cập Nhật Ngay' : 'Thêm Vào Danh Sách'}
                        </button>
                    </form>
                </div>
            </div>
        </c:if>

        <!-- Table: Danh sách -->
        <div class="${user.role == 2 ? 'lg:col-span-8' : 'lg:col-span-12'}">
            <div class="glass-card overflow-hidden">
                <!-- Phần tiêu đề này sẽ có màu khác ở Light Mode nếu là Manager -->
                <div class="p-6 border-b border-white/5 bg-white/5 flex justify-between items-center ${user.role == 1 ? 'header-top5' : ''}">
                    <h3 class="text-lg font-bold">${user.role == 1 ? 'Bảng Xếp Hạng Top 5' : 'Danh Sách Sinh Viên'}</h3>
                    <div class="text-[10px] font-bold px-2 py-1 bg-indigo-500/10 text-indigo-400 rounded-lg uppercase">
                        ${students.size()} Sinh viên
                    </div>
                </div>
                <!-- Phần bảng bên dưới giữ nguyên nền trắng trong Light Mode -->
                <div class="overflow-x-auto bg-transparent">
                    <table class="w-full text-left">
                        <thead>
                            <tr class="text-gray-400 text-[10px] font-black uppercase tracking-widest">
                                <th class="px-6 py-5">MSSV</th>
                                <th class="px-6 py-5">Họ Tên</th>
                                <th class="px-6 py-5 text-center">GPA</th>
                                <th class="px-6 py-5">Khoa</th>
                                <c:if test="${user.role == 2}">
                                    <th class="px-6 py-5 text-right">Hành động</th>
                                </c:if>
                            </tr>
                        </thead>
                        <tbody class="divide-y divide-white/5">
                            <c:forEach var="s" items="${students}">
                                <tr class="hover:bg-white/[0.03] transition-colors group">
                                    <td class="px-6 py-4 font-mono text-indigo-500 font-bold">${s.studentId}</td>
                                    <td class="px-6 py-4 font-semibold">${s.name}</td>
                                    <td class="px-6 py-4 text-center">
                                        <span class="inline-block min-w-[40px] px-2 py-1 rounded-lg text-xs font-black shadow-sm 
                                            ${s.gpa >= 8 ? 'bg-green-500/20 text-green-500 border border-green-500/20' : 
                                              s.gpa >= 5 ? 'bg-yellow-500/20 text-yellow-500 border border-yellow-500/20' : 
                                              'bg-red-500/20 text-red-500 border border-red-500/20'}">
                                            ${s.gpa}
                                        </span>
                                    </td>
                                    <td class="px-6 py-4 text-sm opacity-70">${s.department.departmentname}</td>
                                    <c:if test="${user.role == 2}">
                                        <td class="px-6 py-4 text-right space-x-4">
                                            <a href="student?action=edit&id=${s.id}" 
                                               class="text-[11px] font-black text-indigo-400 hover:text-indigo-300 transition uppercase">Sửa</a>
                                            <a href="student?action=delete&id=${s.id}" 
                                               onclick="return confirm('Bạn có chắc chắn muốn xóa sinh viên ${s.name}?')" 
                                               class="text-[11px] font-black text-red-500/70 hover:text-red-500 transition uppercase">Xóa</a>
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
    const darkIcon = document.getElementById('theme-toggle-dark-icon');
    const lightIcon = document.getElementById('theme-toggle-light-icon');

    function applyTheme(theme) {
        if (theme === 'light') {
            document.body.classList.add('light-mode');
            lightIcon.classList.remove('hidden');
            darkIcon.classList.add('hidden');
        } else {
            document.body.classList.remove('light-mode');
            darkIcon.classList.remove('hidden');
            lightIcon.classList.add('hidden');
        }
    }

    // Initialize theme
    const savedTheme = localStorage.getItem('theme') || 'dark';
    applyTheme(savedTheme);

    themeBtn.addEventListener('click', () => {
        const currentTheme = document.body.classList.contains('light-mode') ? 'light' : 'dark';
        const newTheme = currentTheme === 'light' ? 'dark' : 'light';
        localStorage.setItem('theme', newTheme);
        applyTheme(newTheme);
    });
</script>

<%@ include file="common/footer.jsp" %>