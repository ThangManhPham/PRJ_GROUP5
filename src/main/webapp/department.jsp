<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%-- Header đã bao gồm các thư viện cần thiết --%>
<%@ include file="common/header.jsp" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Department Management</title>
    <!-- Tailwind CSS CDN -->
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        body {
            background-color: #0f172a; /* Darker navy background */
            background-image: 
                radial-gradient(at 0% 0%, rgba(30, 58, 138, 0.3) 0, transparent 50%), 
                radial-gradient(at 100% 100%, rgba(88, 28, 135, 0.3) 0, transparent 50%);
            color: #ffffff;
            font-family: 'Inter', sans-serif;
        }
        .glass-card {
            background: rgba(255, 255, 255, 0.03);
            backdrop-filter: blur(12px);
            -webkit-backdrop-filter: blur(12px);
            border: 1px solid rgba(255, 255, 255, 0.1);
            border-radius: 1.25rem;
            box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.5);
        }
        .input-field {
            background: rgba(255, 255, 255, 0.05);
            border: 1px solid rgba(255, 255, 255, 0.1);
            color: white;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
        }
        .input-field:focus {
            background: rgba(255, 255, 255, 0.1);
            border-color: #8b5cf6;
            outline: none;
            box-shadow: 0 0 0 3px rgba(139, 92, 246, 0.2);
        }
        .btn-primary {
            background: linear-gradient(135deg, #6366f1 0%, #a855f7 100%);
            box-shadow: 0 4px 15px rgba(99, 102, 241, 0.3);
            transition: all 0.3s ease;
        }
        .btn-primary:hover {
            opacity: 0.9;
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(168, 85, 247, 0.4);
        }
        .btn-secondary {
            background: rgba(255, 255, 255, 0.05);
            border: 1px solid rgba(255, 255, 255, 0.1);
            transition: all 0.2s ease;
        }
        .btn-secondary:hover {
            background: rgba(255, 255, 255, 0.1);
        }
        /* Custom scrollbar for better look */
        ::-webkit-scrollbar {
            width: 6px;
        }
        ::-webkit-scrollbar-track {
            background: transparent;
        }
        ::-webkit-scrollbar-thumb {
            background: rgba(255, 255, 255, 0.1);
            border-radius: 10px;
        }
        ::-webkit-scrollbar-thumb:hover {
            background: rgba(255, 255, 255, 0.2);
        }
    </style>
</head>
<body class="min-h-screen p-4 lg:p-10">

    <div class="max-w-7xl mx-auto">
        <!-- Header Section -->
<div class="flex flex-col md:flex-row justify-between items-end mb-10 gap-6">
            <div>
                <nav class="flex text-sm text-gray-400 mb-2 space-x-2">
                    <span class="hover:text-white cursor-pointer transition">Dashboard</span>
                    <span>/</span>
                    <span class="text-purple-400 font-medium">Departments</span>
                </nav>
                <h2 class="text-4xl font-extrabold tracking-tight bg-clip-text text-transparent bg-gradient-to-r from-white via-white to-purple-400">
                    Hệ Thống Quản Lý Khoa
                </h2>
            </div>
            <a href="student" class="btn-secondary flex items-center px-5 py-2.5 rounded-xl text-sm font-semibold transition group">
                <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4 mr-2 transition-transform group-hover:-translate-x-1" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10 19l-7-7m0 0l7-7m-7 7h18" />
                </svg>
                Quản lý Sinh Viên
            </a>
        </div>

        <div class="grid grid-cols-1 lg:grid-cols-12 gap-8 items-start">
            
            <!-- FORM SECTION -->
            <div class="lg:col-span-4">
                <div class="glass-card p-8">
                    <div class="flex items-center space-x-3 mb-8">
                        <div class="w-10 h-10 rounded-lg bg-purple-500/20 flex items-center justify-center text-purple-400">
                            <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 21V5a2 2 0 00-2-2H7a2 2 0 00-2 2v16m14 0h2m-2 0h-5m-9 0H3m2 0h5M9 7h1m-1 4h1m4-4h1m-1 4h1m-5 10v-5a1 1 0 011-1h2a1 1 0 011 1v5m-4 0h4" />
                            </svg>
                        </div>
                        <h3 class="text-xl font-bold">
                            <c:choose>
                                <c:when test="${department != null}">Cập Nhật Khoa</c:when>
                                <c:otherwise>Thêm Khoa Mới</c:otherwise>
                            </c:choose>
                        </h3>
                    </div>

                    <c:if test="${not empty error}">
                        <div class="mb-6 p-4 bg-red-500/10 border border-red-500/20 text-red-400 text-sm rounded-xl flex items-start space-x-3 animate-pulse">
                            <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 shrink-0" viewBox="0 0 20 20" fill="currentColor">
                                <path fill-rule="evenodd" d="M18 10a8 8 0 11-16 0 8 8 0 0116 0zm-7-4a1 1 0 11-2 0 1 1 0 012 0zM9 9a1 1 0 000 2v3a1 1 0 001 1h1a1 1 0 100-2v-3a1 1 0 00-1-1H9z" clip-rule="evenodd" />
                            </svg>
<span>${error}</span>
                        </div>
                    </c:if>

                    <form action="department" method="post" onsubmit="return validateDepartment()" class="space-y-6">
                        <input type="hidden" name="action" value="${department != null ? 'update' : 'add'}" />
                        <c:if test="${department != null}">
                            <input type="hidden" name="id" value="${department.id}" />
                        </c:if>

                        <div>
                            <label class="block text-xs font-semibold uppercase tracking-wider text-gray-400 mb-2 ml-1">Tên Khoa / Phòng Ban</label>
                            <input type="text" name="departmentname" 
                                   class="input-field w-full px-5 py-4 rounded-xl text-base"
                                   placeholder="Ví dụ: Công Nghệ Thông Tin"
                                   value="${department != null ? department.departmentname : param.departmentname}"
                                   required />
                        </div>

                        <button type="submit" class="btn-primary w-full py-4 rounded-xl font-bold text-white uppercase tracking-widest text-sm">
                            <c:choose>
                                <c:when test="${department != null}">Lưu Thay Đổi</c:when>
                                <c:otherwise>Xác Nhận Thêm</c:otherwise>
                            </c:choose>
                        </button>
                        
                        <c:if test="${department != null}">
                            <a href="department" class="block text-center text-xs text-gray-500 hover:text-white transition duration-200 uppercase font-bold mt-4 tracking-tighter">
                                Hủy bỏ quá trình chỉnh sửa
                            </a>
                        </c:if>
                    </form>
                </div>
            </div>

            <!-- LIST SECTION -->
            <div class="lg:col-span-8">
                <div class="glass-card flex flex-col h-full">
                    <div class="p-8 border-b border-white/5 flex justify-between items-center bg-white/5 rounded-t-[1.25rem]">
                        <h3 class="text-xl font-bold">Danh Sách Các Khoa</h3>
                        <span class="px-3 py-1 bg-purple-500/20 text-purple-400 text-xs font-bold rounded-full border border-purple-500/30">
                            Tổng số: ${list != null ? list.size() : 0}
                        </span>
                    </div>
                    
                    <div class="overflow-x-auto p-4">
                        <table class="w-full text-left">
                            <thead>
                                <tr class="text-gray-400 text-xs font-bold uppercase tracking-widest border-b border-white/5">
                                    <th class="px-6 py-5">STT</th>
<th class="px-6 py-5">Tên Khoa</th>
                                    <th class="px-6 py-5 text-right">Thao tác</th>
                                </tr>
                            </thead>
                            <tbody class="divide-y divide-white/5">
                                <c:forEach var="d" items="${list}" varStatus="loop">
                                    <tr class="hover:bg-white/[0.02] transition-colors group">
                                        <td class="px-6 py-6 text-sm text-gray-500 font-medium">#${loop.index + 1}</td>
                                        <td class="px-6 py-6">
                                            <div class="flex items-center">
                                                <div class="w-8 h-8 rounded-full bg-gradient-to-br from-indigo-500 to-purple-600 flex items-center justify-center text-xs font-bold mr-3">
                                                    ${d.departmentname.substring(0, 1).toUpperCase()}
                                                </div>
                                                <span class="font-semibold text-gray-200 group-hover:text-white transition-colors capitalize">${d.departmentname}</span>
                                            </div>
                                        </td>
                                        <td class="px-6 py-6 text-right space-x-1">
                                            <a href="department?action=edit&id=${d.id}" 
                                               class="inline-flex items-center px-4 py-2 bg-indigo-500/10 text-indigo-400 hover:bg-indigo-500 hover:text-white rounded-lg text-xs font-bold transition-all shadow-sm">
                                                Sửa
                                            </a>
                                            <button onclick="return showConfirmDelete(event, 'department?action=delete&id=${d.id}')"
                                               class="inline-flex items-center px-4 py-2 bg-red-500/10 text-red-400 hover:bg-red-500 hover:text-white rounded-lg text-xs font-bold transition-all shadow-sm">
                                                Xóa
                                            </button>
                                        </td>
                                    </tr>
                                </c:forEach>
                                <c:if test="${empty list}">
                                    <tr>
                                        <td colspan="3" class="px-6 py-20 text-center">
                                            <div class="flex flex-col items-center opacity-40">
                                                <svg xmlns="http://www.w3.org/2000/svg" class="h-16 w-16 mb-4" fill="none" viewBox="0 0 24 24" stroke="currentColor">
<path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5" d="M20 13V6a2 2 0 00-2-2H6a2 2 0 00-2 2v7m16 0v5a2 2 0 01-2 2H6a2 2 0 01-2-2v-5m16 0h-2.586a1 1 0 00-.707.293l-2.414 2.414a1 1 0 01-.707.293h-3.172a1 1 0 01-.707-.293l-2.414-2.414A1 1 0 006.586 13H4" />
                                                </svg>
                                                <p class="text-lg">Chưa có dữ liệu khoa nào được tạo.</p>
                                            </div>
                                        </td>
                                    </tr>
                                </c:if>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Modal Confirm - Fixed structure -->
    <div id="confirmModal" class="fixed inset-0 bg-black/80 backdrop-blur-sm hidden flex items-center justify-center z-[100] p-4 transition-opacity duration-300">
        <div class="glass-card max-w-sm w-full p-8 text-center border-red-500/20 shadow-2xl scale-95 transition-transform duration-300 transform" id="modalContent">
            <div class="w-20 h-20 bg-red-500/10 text-red-500 rounded-full flex items-center justify-center mx-auto mb-6 border border-red-500/20">
                <svg xmlns="http://www.w3.org/2000/svg" class="h-10 w-10" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 7l-.867 12.142A2 2 0 0116.138 21H7.862a2 2 0 01-1.995-1.858L5 7m5 4v6m4-6v6m1-10V4a1 1 0 00-1-1h-4a1 1 0 00-1 1v3M4 7h16" />
                </svg>
            </div>
            <h4 class="text-2xl font-bold mb-3 text-white">Xác nhận xóa?</h4>
            <p class="text-gray-400 mb-8 text-sm leading-relaxed">
                Hành động này không thể hoàn tác. Mọi sinh viên thuộc khoa này sẽ bị ảnh hưởng. Bạn có chắc chắn?
            </p>
            <div class="flex gap-4">
                <button onclick="closeModal()" class="flex-1 px-4 py-3 bg-white/5 hover:bg-white/10 rounded-xl transition font-bold text-gray-300">
                    Hủy
                </button>
                <a id="confirmDeleteBtn" href="#" class="flex-1 px-4 py-3 bg-red-600 hover:bg-red-500 rounded-xl transition font-bold text-white shadow-lg shadow-red-600/20">
                    Xóa ngay
                </a>
            </div>
        </div>
    </div>

    <script>
        // Validation với UI feedback
        function validateDepartment() {
            const input = document.querySelector("input[name='departmentname']");
            const name = input.value.trim();

            if (name.length < 5 || name.length > 50) {
                input.classList.remove('border-white/10');
                input.classList.add('border-red-500', 'bg-red-500/5');
// Hiển thị lỗi tùy chỉnh thay vì alert truyền thống
                const errorBox = document.getElementById('errorMessage');
                if (errorBox) {
                    errorBox.innerText = "Tên khoa phải từ 5 đến 50 ký tự!";
                } else {
                    alert("Tên khoa phải từ 5 đến 50 ký tự!");
                }
                return false;
            }
            return true;
        }

        // Custom Confirm Dialog Logic
        function showConfirmDelete(event, url) {
            event.preventDefault();
            const modal = document.getElementById('confirmModal');
            const modalContent = document.getElementById('modalContent');
            const confirmBtn = document.getElementById('confirmDeleteBtn');
            
            confirmBtn.href = url;
            
            // Show modal with animation
            modal.classList.remove('hidden');
            setTimeout(() => {
                modal.classList.remove('opacity-0');
                modalContent.classList.remove('scale-95');
                modalContent.classList.add('scale-100');
            }, 10);
            
            return false;
        }

        function closeModal() {
            const modal = document.getElementById('confirmModal');
            const modalContent = document.getElementById('modalContent');
            
            modalContent.classList.remove('scale-100');
            modalContent.classList.add('scale-95');
            
            setTimeout(() => {
                modal.classList.add('hidden');
            }, 200);
        }

        // Đóng modal khi click ra ngoài
        window.onclick = function(event) {
            const modal = document.getElementById('confirmModal');
            if (event.target == modal) {
                closeModal();
            }
        }
    </script>

</body>
</html>

<%@ include file="common/footer.jsp" %>