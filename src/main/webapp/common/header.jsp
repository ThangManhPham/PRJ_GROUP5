<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Hệ Thống Quản Lý Sinh Viên</title>
    <!-- Tailwind CSS -->
    <script src="https://cdn.tailwindcss.com"></script>
    <!-- Google Fonts: Inter -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    
    <style>
        body {
            font-family: 'Inter', sans-serif;
            background-color: #0f172a; /* Nền tối sâu */
            color: #f1f5f9;
            margin: 0;
        }

        /* Hiệu ứng kính cho Navbar */
        .glass-nav {
            background: rgba(15, 23, 42, 0.8);
            backdrop-filter: blur(12px);
            -webkit-backdrop-filter: blur(12px);
            border-bottom: 1px solid rgba(255, 255, 255, 0.1);
        }

        .nav-item {
            transition: all 0.3s ease;
        }

        .nav-item:hover {
            color: #e9d5ff;
            transform: translateY(-1px);
        }
    </style>
</head>
<body class="min-h-screen flex flex-col">

<!-- Header Navigation -->
<nav class="glass-nav sticky top-0 z-50 w-full px-6 py-4">
    <div class="max-w-7xl mx-auto flex flex-wrap items-center justify-between">
        <!-- Logo -->
        <div class="flex items-center space-x-3">
            <div class="w-10 h-10 bg-gradient-to-br from-purple-600 to-indigo-600 rounded-xl flex items-center justify-center shadow-lg shadow-purple-500/20">
                <span class="text-white font-black text-xl italic">S</span>
            </div>
            <div>
                <h1 class="text-lg font-extrabold tracking-tight bg-clip-text text-transparent bg-gradient-to-r from-white to-gray-400">
                    SMS
                </h1>
                <p class="text-[10px] uppercase tracking-[0.2em] text-gray-500 font-bold leading-none">Management</p>
            </div>
        </div>

        <!-- Menu Links -->
        <div class="hidden md:flex items-center space-x-8">
            <a href="${pageContext.request.contextPath}/student" 
               class="nav-item text-sm font-semibold text-gray-400 hover:text-white flex items-center gap-2">
               <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                   <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4.354a4 4 0 110 5.292M15 21H3v-1a6 6 0 0112 0v1zm0 0h6v-1a6 6 0 00-9-5.197M13 7a4 4 0 11-8 0 4 4 0 018 0z" />
               </svg>
               Sinh viên
            </a>
            <a href="${pageContext.request.contextPath}/department" 
               class="nav-item text-sm font-semibold text-gray-400 hover:text-white flex items-center gap-2">
               <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                   <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 21V5a2 2 0 00-2-2H7a2 2 0 00-2 2v16m14 0h2m-2 0h-5m-9 0H3m2 0h5M9 7h1m-1 4h1m4-4h1m-1 4h1m-5 10v-5a1 1 0 011-1h2a1 1 0 011 1v5m-4 0h4" />
               </svg>
               Khoa đào tạo
            </a>
        </div>

        <!-- User Section -->
        <div class="flex items-center space-x-4 border-l border-white/10 pl-6">
            <div class="flex flex-col items-end">
                <span class="text-[10px] text-gray-500 font-bold uppercase tracking-wider">Tài khoản</span>
                <span class="text-sm font-bold text-indigo-400">
                    <%-- 
                        Sử dụng EL để lấy giá trị username từ session. 
                        Nếu sessionScope.username rỗng, hiển thị 'Chưa đăng nhập' 
                    --%>
                    ${not empty sessionScope.username ? sessionScope.username : 'Chưa đăng nhập'}
                </span>
            </div>
            
            <a href="${pageContext.request.contextPath}/logout" 
               title="Đăng xuất"
               class="p-2 rounded-full bg-red-500/10 text-red-400 hover:bg-red-500 hover:text-white transition-all duration-300">
                <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17 16l4-4m0 0l-4-4m4 4H7m6 4v1a3 3 0 01-3 3H6a3 3 0 01-3-3V7a3 3 0 013-3h4a3 3 0 013 3v1" />
                </svg>
            </a>
        </div>
    </div>
</nav>

<!-- Main Wrapper -->
<main class="flex-grow pt-8 pb-12 px-6">
    <div class="max-w-7xl mx-auto">
        <!-- Nội dung trang sẽ được chèn ở đây -->
    </div>
</main>



</body>
</html>