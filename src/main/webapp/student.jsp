<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="common/header.jsp" %>

<c:set var="errors" value="${requestScope.errors}" />
<c:set var="user" value="${sessionScope.user}" />
<c:set var="isUpdate" value="${not empty student and student.id > 0}" />

<style>
    /* Chỉ giữ lại các style đặc thù của trang Sinh viên */
    .glass-card { background: rgba(255, 255, 255, 0.03); backdrop-filter: blur(12px); border: 1px solid rgba(255, 255, 255, 0.1); border-radius: 1.25rem; }
    .input-field { background: rgba(255, 255, 255, 0.05); border: 1px solid rgba(255, 255, 255, 0.1); color: white; transition: all 0.2s; }
    .input-field:focus { border-color: #8b5cf6; outline: none; box-shadow: 0 0 0 3px rgba(139, 92, 246, 0.2); }
    
    .light-mode .glass-card { background: rgba(255, 255, 255, 0.8); border: 1px solid #e2e8f0; box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.1); }
    .light-mode .input-field { background: #fff; border: 1px solid #cbd5e1; color: #1e293b; }
    .btn-primary { background: linear-gradient(135deg, #6366f1 0%, #a855f7 100%); }
</style>

<div class="max-w-7xl mx-auto px-6">
    <div class="flex flex-col md:flex-row justify-between items-end mb-10 gap-6">
        <div>
            <h2 class="text-4xl font-extrabold tracking-tight">Quản Lý Sinh Viên</h2>
            <p class="text-sm opacity-70 mt-1">Xin chào, <span class="font-bold text-purple-400">${user.username}</span> (${user.role == 1 ? 'Manager' : 'Staff'})</p>
        </div>
        
        <div class="flex gap-3">
            <button id="theme-toggle" class="p-2.5 rounded-xl border border-white/10 bg-white/5 hover:bg-white/10 transition">
                <span id="theme-toggle-dark-icon" class="text-xl">🌙</span>
                <span id="theme-toggle-light-icon" class="hidden text-xl">☀️</span>
            </button>
        </div>
    </div>

    <div class="grid grid-cols-1 lg:grid-cols-12 gap-8 items-start">
        <c:if test="${user.role == 2}">
            <div class="lg:col-span-4">
                <div class="glass-card p-8">
                    <h3 class="text-xl font-bold mb-6">${isUpdate ? 'Cập Nhật Sinh Viên' : 'Thêm Mới'}</h3>
                    <form action="student" method="post" class="space-y-4">
                        <input type="hidden" name="id" value="${student.id}" />
                        <div>
                            <label class="block text-xs font-bold uppercase text-gray-400 mb-1 ml-1">MSSV</label>
                            <input type="text" name="studentId" value="${student.studentId}" 
                                   class="input-field w-full px-4 py-3 rounded-xl ${errors.studentId != null ? 'border-red-500' : ''} ${isUpdate ? 'opacity-50' : ''}" 
                                   ${isUpdate ? 'readonly' : ''} placeholder="VD: SE123">
                        </div>

                        <div>
                            <label class="block text-xs font-bold uppercase text-gray-400 mb-1 ml-1">Họ Tên</label>
                            <input type="text" name="name" value="${student.name}" 
                                   class="input-field w-full px-4 py-3 rounded-xl ${errors.name != null ? 'border-red-500' : ''}">
                        </div>

                        <div class="grid grid-cols-2 gap-4">
                            <div>
                                <label class="block text-xs font-bold uppercase text-gray-400 mb-1 ml-1">GPA</label>
                                <input type="number" step="0.1" name="gpa" value="${student.gpa}" 
                                       class="input-field w-full px-4 py-3 rounded-xl">
                            </div>
                            <div>
                                <label class="block text-xs font-bold uppercase text-gray-400 mb-1 ml-1">Khoa</label>
                                <select name="departmentId" class="input-field w-full px-4 py-3 rounded-xl appearance-none">
                                    <c:forEach var="d" items="${departments}">
                                        <option value="${d.id}" ${student.department.id == d.id ? 'selected' : ''}>${d.departmentname}</option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>

                        <button type="submit" class="btn-primary w-full py-4 rounded-xl font-bold text-white shadow-lg uppercase tracking-widest mt-2 hover:opacity-90 transition">
                            ${isUpdate ? 'Lưu Thay Đổi' : 'Xác Nhận Thêm'}
                        </button>
                    </form>
                </div>
            </div>
        </c:if>

        <div class="${user.role == 2 ? 'lg:col-span-8' : 'lg:col-span-12'}">
            <div class="glass-card overflow-hidden">
                <div class="p-6 border-b border-white/5 bg-white/5">
                    <h3 class="text-xl font-bold">${user.role == 1 ? 'Top 5 GPA' : 'Danh Sách Sinh Viên'}</h3>
                </div>
                <div class="overflow-x-auto">
                    <table class="w-full text-left">
                        <thead>
                            <tr class="text-gray-400 text-[10px] font-black uppercase tracking-widest border-b border-white/5">
                                <th class="px-6 py-4">MSSV</th>
                                <th class="px-6 py-4">Họ Tên</th>
                                <th class="px-6 py-4 text-center">GPA</th>
                                <th class="px-6 py-4">Khoa</th>
                                <c:if test="${user.role == 2}">
                                    <th class="px-6 py-4 text-right">Hành động</th>
                                </c:if>
                            </tr>
                        </thead>
                        <tbody class="divide-y divide-white/5">
                            <c:forEach var="s" items="${students}">
                                <tr class="hover:bg-white/[0.02] transition-colors">
                                    <td class="px-6 py-4 font-mono text-indigo-400 font-bold">${s.studentId}</td>
                                    <td class="px-6 py-4 font-semibold">${s.name}</td>
                                    <td class="px-6 py-4 text-center">
                                        <span class="px-2.5 py-1 rounded-lg text-xs font-black ${s.gpa >= 8 ? 'bg-green-500/20 text-green-400' : 'bg-yellow-500/20 text-yellow-400'}">
                                            ${s.gpa}
                                        </span>
                                    </td>
                                    <td class="px-6 py-4 text-sm opacity-70">${s.department.departmentname}</td>
                                    <c:if test="${user.role == 2}">
                                        <td class="px-6 py-4 text-right space-x-3 text-[11px] font-bold">
                                            <a href="student?action=edit&id=${s.id}" class="text-indigo-400 hover:underline">SỬA</a>
                                            <a href="student?action=delete&id=${s.id}" onclick="return confirm('Xóa?')" class="text-red-400 hover:underline">XÓA</a>
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

</main> <script>
    const themeBtn = document.getElementById('theme-toggle');
    const darkIcon = document.getElementById('theme-toggle-dark-icon');
    const lightIcon = document.getElementById('theme-toggle-light-icon');

    function updateTheme(isLight) {
        if (isLight) {
            document.body.classList.add('light-mode');
            lightIcon.classList.remove('hidden');
            darkIcon.classList.add('hidden');
        } else {
            document.body.classList.remove('light-mode');
            darkIcon.classList.remove('hidden');
            lightIcon.classList.add('hidden');
        }
    }

    updateTheme(localStorage.getItem('theme') === 'light');

    themeBtn.addEventListener('click', () => {
        const isLight = document.body.classList.toggle('light-mode');
        localStorage.setItem('theme', isLight ? 'light' : 'dark');
        updateTheme(isLight);
    });
</script>

<%@ include file="common/footer.jsp" %>