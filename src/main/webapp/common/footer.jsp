<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<style>
    /* CSS đồng bộ cho các chế độ Mode */
    .glass-nav { 
        transition: all 0.3s ease;
    }
    
    .light-mode .glass-nav { 
        background: rgba(255, 255, 255, 0.8); 
        border-bottom: 1px solid #e2e8f0; 
    }
    
    .nav-link { 
        color: #94a3b8; 
        font-weight: 600; 
        transition: color 0.2s; 
    }
    
    .light-mode .nav-link { 
        color: #64748b; 
    }
    
    .nav-link:hover, .light-mode .nav-link:hover { 
        color: #6366f1; 
    }
    
    .active-link { 
        color: #818cf8 !important; 
    }

    /* CSS bổ sung cho Footer để đồng bộ với Light Mode */
    .light-mode footer {
        background-color: rgba(241, 245, 249, 0.8);
        border-color: rgba(0, 0, 0, 0.05);
    }
    
    .light-mode .footer-text-main { color: #1e293b; }
    .light-mode .footer-text-sub { color: #64748b; }
</style>

</main> 

<!-- Footer với các class hỗ trợ chuyển đổi mode -->
<footer class="mt-16 pb-8 border-t border-white/[0.05] bg-[#0f172a]/40 backdrop-blur-sm transition-colors duration-300">
    <div class="max-w-7xl mx-auto px-8 pt-10">
        
        <div class="flex flex-col md:flex-row justify-between items-center gap-6">
            
            <!-- Logo & Copyright Section -->
            <div class="flex items-center space-x-3 group opacity-80 hover:opacity-100 transition-opacity">
                <div class="w-8 h-8 bg-indigo-600 rounded-lg flex items-center justify-center text-xs font-bold text-white shadow-lg italic">
                    G
                </div>
                <div>
                    <h4 class="footer-text-main text-[10px] font-black tracking-[0.15em] text-gray-200 uppercase leading-none">GPA System</h4>
                    <p class="footer-text-sub text-[8px] text-gray-500 font-medium mt-1">© 2026 Made for Group 5.</p>
                </div>
            </div>

            <!-- Navigation Links -->
            <nav class="flex items-center gap-x-6 text-[9px] uppercase tracking-[0.15em] font-bold">
                <a href="#" class="nav-link">Privacy Policy</a>
                <a href="#" class="nav-link">Documentation</a>
                <a href="#" class="nav-link">Support</a>
            </nav>

            <!-- Status Indicator -->
            <div class="flex items-center gap-2.5 pl-4 pr-3 py-2 rounded-xl bg-black/20 border border-white/5 shadow-inner light-mode:bg-white/50">
                <div class="text-right">
                    <p class="text-[6px] text-gray-500 uppercase font-black leading-none mb-0.5">Hệ thống</p>
                    <p class="text-[10px] font-black text-emerald-500 uppercase leading-none">Trực tuyến</p>
                </div>
                <div class="relative flex h-2 w-2">
                    <span class="animate-ping absolute inline-flex h-full w-full rounded-full bg-emerald-400 opacity-40"></span>
                    <span class="relative inline-flex rounded-full h-2 w-2 bg-emerald-500 shadow-[0_0_6px_rgba(16,185,129,0.5)]"></span>
                </div>
            </div>
        </div>
        
        <!-- Bottom Credits -->
        <div class="mt-10 flex flex-col items-center">
            <div class="w-16 h-[1px] bg-gradient-to-r from-transparent via-gray-700 to-transparent"></div>
            <p class="mt-3 text-[8px] font-bold text-indigo-400/60 tracking-[0.4em] uppercase">
                Built with Java Maven
            </p>
        </div>
    </div>
</footer>

</body>
</html>