<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%-- Header đã bao gồm các thư viện cần thiết --%>
<%@ include file="common/header.jsp" %>

<!DOCTYPE html>
<c:set var="errors" value="${requestScope.errors}" />
<c:set var="isUpdate" value="${not empty student and student.id > 0}" />
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản Lý Sinh Viên</title>
    <!-- Tailwind CSS CDN -->
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        .input-error {
            border-color: #ef4444 !important; /* đỏ */
        }
        .error-text {
            color: #fca5a5; /* đỏ nhạt */
            font-size: 0.75rem;
            margin-top: 0.35rem;
            margin-left: 0.25rem;
        }
        body {
            background-color: #0f172a; 
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
        select.input-field option {
            background-color: #1e1b4b;
            color: white;
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
        ::-webkit-scrollbar { width: 6px; }
        ::-webkit-scrollbar-track { background: transparent; }
        ::-webkit-scrollbar-thumb { background: rgba(255, 255, 255, 0.1); border-radius: 10px; }
        ::-webkit-scrollbar-thumb:hover { background: rgba(255, 255, 255, 0.2); }
    </style>
</head>
<body class="min-h-screen p-4 lg:p-10 text-slate-200">

    <div class="max-w-7xl mx-auto">
        <!-- Header Section -->
        <div class="flex flex-col md:flex-row justify-between items-end mb-10 gap-6">
            <div>
                <nav class="flex text-sm text-gray-400 mb-2 space-x-2">
                    <span class="hover:text-white cursor-pointer transition">Bảng điều khiển</span>
                    <span>/</span>
                    <span class="text-purple-400 font-medium">Sinh viên</span>
                </nav>
                <h2 class="text-4xl font-extrabold tracking-tight bg-clip-text text-transparent bg-gradient-to-r from-white via-white to-purple-400">
                    Quản Lý Sinh Viên
                </h2>
            </div>
            <a href="department" class="btn-secondary flex items-center px-5 py-2.5 rounded-xl text-sm font-semibold transition group">
                <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4 mr-2" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 21V5a2 2 0 00-2-2H7a2 2 0 00-2 2v16m14 0h2m-2 0h-5m-9 0H3m2 0h5M9 7h1m-1 4h1m4-4h1m-1 4h1m-5 10v-5a1 1 0 011-1h2a1 1 0 011 1v5m-4 0h4" />
                </svg>
                Quản lý Khoa
            </a>
        </div>

        <div class="grid grid-cols-1 lg:grid-cols-12 gap-8 items-start">
            
            <!-- FORM SECTION -->
            <div class="lg:col-span-4">
                <div class="glass-card p-8">
                    <div class="flex items-center space-x-3 mb-8">
                        <div class="w-10 h-10 rounded-lg bg-blue-500/20 flex items-center justify-center text-blue-400">
                            <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M18 9v3m0 0v3m0-3h3m-3 0h-3m-2-5a4 4 0 11-8 0 4 4 0 018 0zM3 20a6 6 0 0112 0v1H3v-1z" />
                            </svg>
                        </div>
                        <h3 class="text-xl font-bold text-white">
                            <c:choose>
                                <c:when test="${not empty student}">Cập Nhật Sinh Viên</c:when>
                                <c:otherwise>Thêm Sinh Viên Mới</c:otherwise>
                            </c:choose>
                        </h3>
                    </div>

                    <form action="student" method="post" id="studentForm" class="space-y-5">
                        <!-- Action hidden field quan trọng để Servlet biết cần Add hay Update -->
                        <input type="hidden" name="action" value="${not empty student ? 'update' : 'add'}" />
                        
                        <!-- ID hidden field cực kỳ quan trọng khi Update để tránh lỗi null primary key -->
                        <c:if test="${not empty student}">
                            <input type="hidden" name="id" value="${student.id}" />
                        </c:if>
                        
                            <div>
                                <label class="block text-xs font-semibold uppercase tracking-wider text-gray-400 mb-2 ml-1">
                                    Mã Số Sinh Viên (studentId)
                                </label>

                                <input type="text" name="studentId"
                                    class="input-field w-full px-5 py-3 rounded-xl text-base
                                    ${errors.studentId != null ? 'input-error' : ''}
                                    ${isUpdate ? 'opacity-50' : ''}"
                                    placeholder="Ví dụ: SE123456"
                                    value="${not empty student ? student.studentId : ''}"
                                    ${isUpdate ? 'readonly' : ''} />

                                <c:if test="${errors.studentId != null}">
                                    <div class="error-text">${errors.studentId}</div>
                                </c:if>
                            </div>
                                       <div>
                                           <label class="block text-xs font-semibold uppercase tracking-wider text-gray-400 mb-2 ml-1">Họ và Tên</label>

                                           <input type="text" name="name"
                                                  class="input-field w-full px-5 py-3 rounded-xl text-base
                                                  ${errors.name != null ? 'input-error' : ''}"
                                                  placeholder="Nguyễn Văn A"
                                                  value="${not empty student ? student.name : ''}" />

                                           <c:if test="${errors.name != null}">
                                               <div class="error-text">${errors.name}</div>
                                           </c:if>
                                       </div>


                        <div class="grid grid-cols-2 gap-4">
                            <div>
                                <label class="block text-xs font-semibold uppercase tracking-wider text-gray-400 mb-2 ml-1">Điểm GPA</label>

                                <input type="number" step="0.1" min="0" max="10" name="gpa"
                                       class="input-field w-full px-5 py-3 rounded-xl text-base
                                       ${errors.gpa != null ? 'input-error' : ''}"
                                       placeholder="0.0"
                                       value="${not empty student ? student.gpa : ''}" />

                                <c:if test="${errors.gpa != null}">
                                    <div class="error-text">${errors.gpa}</div>
                                </c:if>
                            </div>
                            <div>
                                <label class="block text-xs font-semibold uppercase tracking-wider text-gray-400 mb-2 ml-1">Khoa</label>

                                <select name="departmentId"
                                        class="input-field w-full px-5 py-3 rounded-xl text-base appearance-none cursor-pointer
                                        ${errors.departmentId != null ? 'input-error' : ''}">
                                    <option value="">-- Chọn Khoa --</option>
                                    <c:forEach var="dept" items="${departments}">
                                        <option value="${dept.id}"
                                                ${(not empty student && not empty student.department && student.department.id == dept.id) ? 'selected' : ''}>
                                            ${dept.departmentname}
                                        </option>
                                    </c:forEach>
                                </select>

                                <c:if test="${errors.departmentId != null}">
                                    <div class="error-text">${errors.departmentId}</div>
                                </c:if>
                            </div>
                        </div>

                        <button type="submit" class="btn-primary w-full py-4 rounded-xl font-bold text-white uppercase tracking-widest text-sm mt-4">
                            ${not empty student ? 'Lưu Thay Đổi' : 'Xác Nhận Thêm'}
                        </button>
                        
                        <c:if test="${not empty student}">
                            <a href="student" class="block text-center text-sm text-gray-500 hover:text-white mt-2 transition underline decoration-dotted">Hủy chỉnh sửa & Quay lại</a>
                        </c:if>
                    </form>
                </div>
            </div>

            <!-- LIST SECTION -->
            <div class="lg:col-span-8">
                <div class="glass-card flex flex-col h-full overflow-hidden">
                    <div class="p-6 border-b border-white/5 flex justify-between items-center bg-white/5">
                        <h3 class="text-xl font-bold text-white">Danh Sách Hiện Tại</h3>
                        <span class="px-3 py-1 bg-purple-500/20 text-purple-400 text-xs font-bold rounded-full border border-purple-500/30">
                            ${not empty students ? students.size() : 0} sinh viên
                        </span>
                    </div>
                    
                    <div class="overflow-x-auto">
                        <table class="w-full text-left">
                            <thead>
                                <tr class="text-gray-400 text-xs font-bold uppercase tracking-widest border-b border-white/5">
                                    <th class="px-6 py-4">MSSV</th>
                                    <th class="px-6 py-4">Họ Tên</th>
                                    <th class="px-6 py-4 text-center">GPA</th>
                                    <th class="px-6 py-4">Khoa</th>
                                    <th class="px-6 py-4 text-right">Hành động</th>
                                </tr>
                            </thead>
                            <tbody class="divide-y divide-white/5">
                                <c:forEach var="s" items="${students}">
                                    <tr class="hover:bg-white/[0.02] transition-colors group">
                                        <td class="px-6 py-5 text-sm font-mono text-purple-300 font-bold">${s.studentId}</td>
                                        <td class="px-6 py-5">
                                            <span class="font-semibold text-gray-200 group-hover:text-white">${s.name}</span>
                                        </td>
                                        <td class="px-6 py-5 text-center">
                                            <span class="px-2.5 py-1 rounded-lg text-xs font-black
                                                ${s.gpa >= 8.0 ? 'bg-green-500/20 text-green-400' : 
                                                  s.gpa >= 6.5 ? 'bg-yellow-500/20 text-yellow-400' : 
                                                  'bg-red-500/20 text-red-400'}">
                                                ${s.gpa}
                                            </span>
                                        </td>
                                        <td class="px-6 py-5">
                                            <span class="text-sm text-gray-400">${s.department.departmentname}</span>
                                        </td>
                                        <td class="px-6 py-5 text-right space-x-2">
                                            <a href="student?action=edit&id=${s.id}" class="inline-block px-3 py-1 bg-indigo-500/10 text-indigo-400 hover:bg-indigo-500 hover:text-white rounded-md transition-all text-xs font-bold">Sửa</a>
                                            <a href="student?action=delete&id=${s.id}" 
                                               onclick="return confirm('Bạn có chắc chắn muốn xóa sinh viên ${s.name} không?')" 
                                               class="inline-block px-3 py-1 bg-red-500/10 text-red-400 hover:bg-red-500 hover:text-white rounded-md transition-all text-xs font-bold">Xóa</a>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                        <c:if test="${empty students}">
                            <div class="py-20 text-center text-gray-500">
                                <div class="flex flex-col items-center">
                                    <svg xmlns="http://www.w3.org/2000/svg" class="h-12 w-12 mb-2 text-gray-600" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5" d="M12 4.354a4 4 0 110 5.292M15 21H3v-1a6 6 0 0112 0v1zm0 0h6v-1a6 6 0 00-9-5.197M13 7a4 4 0 11-8 0 4 4 0 018 0z" />
                                    </svg>
                                    <p>Chưa có dữ liệu sinh viên trong hệ thống.</p>
                                </div>
                            </div>
                        </c:if>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
<%@ include file="common/footer.jsp" %>