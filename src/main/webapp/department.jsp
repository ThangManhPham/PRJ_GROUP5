<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="common/header.jsp" %>

<div class="max-w-7xl mx-auto px-6">
    <div class="flex justify-between items-center mb-10">
        <div>
            <p class="text-sm text-gray-500 uppercase tracking-widest font-bold">Dashboard / Khoa</p>
            <h2 class="text-4xl font-extrabold mt-1">Quản Lý Khoa</h2>
        </div>

        <button id="btn-theme" class="flex items-center gap-3 px-4 py-2 rounded-xl border border-white/10 bg-white/5 hover:bg-white/10 transition">
            <span class="text-sm font-bold uppercase tracking-tighter" id="theme-text"></span>
            <span id="theme-icon" class="text-xl">🌙</span>
        </button>
    </div>

    <div class="grid grid-cols-1 lg:grid-cols-12 gap-8">
        <div class="lg:col-span-4">
            <div class="glass-card p-8">
                <form action="department" method="post" class="space-y-6">
                    <input type="hidden" name="action" value="${department != null ? 'update' : 'add'}" />
                    <c:if test="${department != null}"><input type="hidden" name="id" value="${department.id}" /></c:if>
                    <div>
                        <label class="block text-xs font-bold uppercase text-gray-400 mb-2">Tên Khoa</label>
                        <input type="text" name="departmentname" class="input-field w-full px-5 py-4 rounded-xl outline-none focus:border-indigo-500 transition" value="${department.departmentname}" required>
                    </div>
                    <button type="submit" class="w-full py-4 bg-gradient-to-r from-indigo-600 to-purple-600 rounded-xl font-bold text-white shadow-lg hover:opacity-90 transition">
                        ${department != null ? 'CẬP NHẬT' : 'THÊM MỚI'}
                    </button>
                </form>
            </div>
        </div>

        <div class="lg:col-span-8">
            <div class="glass-card overflow-hidden">
                <table class="w-full text-left">
                    <thead class="bg-white/5 border-b border-white/10 text-xs font-bold uppercase text-gray-400">
                        <tr>
                            <th class="p-6">STT</th>
                            <th class="p-6">Tên Khoa</th>
                            <th class="p-6 text-right">Thao tác</th>
                        </tr>
                    </thead>
                    <tbody class="divide-y divide-white/5">
                        <c:forEach var="d" items="${list}" varStatus="loop">
                            <tr class="hover:bg-white/[0.02] transition">
                                <td class="p-6 text-gray-500">#${loop.index + 1}</td>
                                <td class="p-6 font-semibold">${d.departmentname}</td>
                                <td class="p-6 text-right">
<a href="department?action=edit&id=${d.id}" class="text-indigo-400 font-bold hover:underline">Sửa</a>
                                    <span class="mx-2 opacity-20">|</span>
                                    <a href="department?action=delete&id=${d.id}" onclick="return confirm('Xóa khoa này?')" class="text-red-400 font-bold hover:underline">Xóa</a>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

</main> <%@ include file="common/footer.jsp" %>

<script>
    const body = document.body;
    const themeBtn = document.getElementById('btn-theme');
    const themeIcon = document.getElementById('theme-icon');

    function updateUI(isLight) {
        if (isLight) {
            body.classList.add('light-mode');
            themeIcon.innerText = "☀️";
        } else {
            body.classList.remove('light-mode');
            themeIcon.innerText = "🌙";
        }
    }

    // Khởi tạo theme khi load trang
    const savedTheme = localStorage.getItem('theme') === 'light';
    updateUI(savedTheme);

    themeBtn.addEventListener('click', () => {
        const isLight = body.classList.toggle('light-mode');
        localStorage.setItem('theme', isLight ? 'light' : 'dark');
        updateUI(isLight);
    });
</script>