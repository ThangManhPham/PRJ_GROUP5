<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Hệ Thống Quản Lý GPA</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    <style>
        body { font-family: 'Inter', sans-serif; background-color: #0f172a; color: #f1f5f9; transition: all 0.3s ease; margin: 0; }
        body.light-mode { background-color: #f8fafc; color: #1e293b; }
        
        .glass-nav { 
            background: rgba(15, 23, 42, 0.8); 
            backdrop-filter: blur(12px); 
            border-bottom: 1px solid rgba(255, 255, 255, 0.1); 
            position: sticky; 
            top: 0; 
            z-index: 50;
        }
        .light-mode .glass-nav { background: rgba(255, 255, 255, 0.8); border-bottom: 1px solid #e2e8f0; }
        
        /* Đồng bộ màu sắc cho menu khi đổi mode */
        .nav-link { color: #94a3b8; font-weight: 600; transition: color 0.2s; }
        .light-mode .nav-link { color: #64748b; }
        .nav-link:hover, .light-mode .nav-link:hover { color: #6366f1; }
        .active-link { color: #818cf8 !important; }
    </style>
</head>
<body class="min-h-screen flex flex-col">

<nav class="glass-nav w-full px-6 py-4">
    <div class="max-w-7xl mx-auto flex items-center justify-between">
        <div class="flex items-center space-x-3">
            <div class="w-10 h-10 bg-indigo-600 rounded-xl flex items-center justify-center shadow-lg shadow-indigo-500/20">
                <span class="text-white font-black italic text-xl">G</span>
            </div>
            <h1 class="text-lg font-black tracking-tighter uppercase">GPA System</h1>
        </div>

        <div class="flex items-center space-x-8">
            <div class="hidden md:flex items-center space-x-6">
                <a href="student" class="nav-link text-sm uppercase tracking-wider">Sinh viên</a>
                <a href="department" class="nav-link text-sm uppercase tracking-wider active-link">Khoa</a>
            </div>

            <div class="flex items-center border-l border-white/10 pl-6 space-x-4">
                <a href="${pageContext.request.contextPath}/logout" 
                   title="Đăng xuất"
                   class="flex items-center justify-center w-10 h-10 rounded-full bg-red-500/10 text-red-400 hover:bg-red-500 hover:text-white transition-all duration-300 shadow-sm">
                    <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17 16l4-4m0 0l-4-4m4 4H7m6 4v1a3 3 0 01-3 3H6a3 3 0 01-3-3V7a3 3 0 013-3h4a3 3 0 013 3v1" />
                    </svg>
                </a>
            </div>
        </div>
    </div>
</nav>

<main class="flex-grow pt-10">