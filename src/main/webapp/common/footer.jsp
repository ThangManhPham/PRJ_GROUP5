<%@ page contentType="text/html;charset=UTF-8" language="java" %>
</main> <!-- Đóng thẻ main từ header -->

<!-- Thêm padding-top (pt-20) để tạo khoảng cách với nội dung phía trên -->
<footer class="mt-auto pt-20 pb-12 border-t border-white/5 bg-[#0a0c14]/80 backdrop-blur-xl">
    <div class="max-w-7xl mx-auto px-8">
        <div class="flex flex-col md:flex-row justify-between items-center gap-8">
            
            <!-- Branding Section -->
            <div class="flex flex-col items-center md:items-start group">
                <div class="flex items-center space-x-3 opacity-50 group-hover:opacity-100 transition-all duration-500">
                    <div class="w-8 h-8 bg-gradient-to-br from-indigo-600 to-violet-700 rounded-lg flex items-center justify-center text-[14px] font-black text-white shadow-lg shadow-indigo-500/20 italic">
                        G
                    </div>
                    <div class="flex flex-col">
                        <span class="text-xs font-black tracking-[0.2em] text-gray-300 uppercase">GPA System</span>
                        <p class="text-[10px] text-gray-600 font-medium">Student Management Solution</p>
                    </div>
                </div>
                <p class="text-gray-700 text-[10px] mt-4 font-semibold tracking-wide">
                    © 2026 Made with <span class="text-rose-500 animate-pulse">❤</span> for Group 5.
                </p>
            </div>

            <!-- Navigation Links -->
            <nav class="flex flex-wrap justify-center items-center gap-x-8 gap-y-4 text-[10px] uppercase tracking-[0.15em] font-bold">
                <a href="#" class="text-gray-500 hover:text-indigo-400 transition-all duration-300 transform hover:-translate-y-0.5">Privacy Policy</a>
                <div class="hidden md:block w-1 h-1 bg-gray-800 rounded-full"></div>
                <a href="#" class="text-gray-500 hover:text-indigo-400 transition-all duration-300 transform hover:-translate-y-0.5">Documentation</a>
                <div class="hidden md:block w-1 h-1 bg-gray-800 rounded-full"></div>
                <a href="#" class="text-gray-500 hover:text-indigo-400 transition-all duration-300 transform hover:-translate-y-0.5">Support</a>
            </nav>

            <!-- Real-time Status Indicator -->
            <div class="flex items-center gap-4 pl-6 pr-4 py-3 rounded-2xl bg-black/40 border border-white/5 shadow-2xl backdrop-sm">
                <div class="flex flex-col items-end">
                    <span class="text-[8px] text-gray-600 font-black uppercase tracking-tighter leading-none mb-1">Hệ thống</span>
                    <span class="text-[11px] font-black text-emerald-500 uppercase tracking-wider">Trực tuyến</span>
                </div>
                <div class="relative flex h-3 w-3">
                    <span class="animate-ping absolute inline-flex h-full w-full rounded-full bg-emerald-400 opacity-40"></span>
                    <span class="relative inline-flex rounded-full h-3 w-3 bg-emerald-500 shadow-[0_0_10px_rgba(16,185,129,0.5)]"></span>
                </div>
            </div>
        </div>
        
        <!-- Technology Stack Branding -->
        <div class="mt-16 pt-6 border-t border-white/[0.03] flex flex-col items-center gap-2">
            <span class="text-[9px] font-black text-gray-800 tracking-[0.6em] uppercase">
                Built with Java & Tailwind CSS
            </span>
            <div class="h-0.5 w-12 bg-gradient-to-r from-transparent via-gray-800 to-transparent"></div>
        </div>
    </div>
</footer>

<!-- Lưu ý: Đảm bảo thẻ <body> của bạn có class "min-h-screen flex flex-col" 
     và thẻ <main> có class "flex-grow" để footer luôn nằm dưới cùng -->
</body>
</html>