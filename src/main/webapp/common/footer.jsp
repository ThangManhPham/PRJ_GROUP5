<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<style>
    /* Online Badge Component (Đồng bộ với Header) */
    .online-badge {
        background: rgba(30, 41, 59, 0.5);
        border: 1px solid rgba(255, 255, 255, 0.05);
        border-radius: 9999px;
        padding: 6px 16px;
        display: flex;
        align-items: center;
        gap: 10px;
        box-shadow: inset 0 1px 1px rgba(255,255,255,0.05);
        transition: all 0.3s ease;
    }
    .light-mode .online-badge {
        background: rgba(241, 245, 249, 0.8);
        border: 1px solid rgba(0, 0, 0, 0.05);
    }

    /* Hiệu ứng đèn LED */
    .dot-container {
        position: relative;
        display: flex;
        align-items: center;
        justify-content: center;
    }
    .dot-main {
        width: 10px;
        height: 10px;
        background-color: #10b981;
        border-radius: 50%;
        z-index: 2;
    }
    .dot-pulse {
        position: absolute;
        width: 10px;
        height: 10px;
        background-color: #10b981;
        border-radius: 50%;
        animation: pulse-animation 2s infinite;
        z-index: 1;
    }
    @keyframes pulse-animation {
        0% { transform: scale(1); opacity: 0.8; }
        100% { transform: scale(3.5); opacity: 0; }
    }

    /* Typography cho Status */
    .status-text-top {
        font-size: 10px;
        font-weight: 700;
        color: #64748b;
        text-transform: uppercase;
        letter-spacing: 0.05em;
        line-height: 1;
    }
    .status-text-main {
        font-size: 14px;
        font-weight: 800;
        color: #10b981;
        text-transform: uppercase;
        line-height: 1.2;
    }

    /* Footer Styles */
    footer {
        border-top: 1px solid rgba(255, 255, 255, 0.05);
        background: rgba(15, 23, 42, 0.4);
        backdrop-filter: blur(8px);
        transition: all 0.3s ease;
    }
    .light-mode footer {
        background: rgba(241, 245, 249, 0.8);
        border-top: 1px solid #e2e8f0;
    }
    .footer-text-title { 
        color: #f1f5f9; 
        transition: color 0.3s; 
    }
    .light-mode .footer-text-title { 
        color: #1e293b; 
    }
</style>

<footer class="mt-16 pb-12">
    <div class="max-w-7xl mx-auto px-8 pt-12">
        <div class="flex flex-col md:flex-row justify-between items-center gap-8">
            
            <!-- Phần Logo & Bản quyền -->
            <div class="flex items-center space-x-4 group">
                <div class="w-10 h-10 bg-indigo-600 rounded-xl flex items-center justify-center text-lg font-black text-white shadow-lg italic">
                    G
                </div>
                <div>
                    <h4 class="footer-text-title text-lg font-black tracking-tighter uppercase leading-none">GPA System</h4>
                    <p class="text-sm text-gray-500 font-medium mt-1">© 2026 Made for Group 5.</p>
                </div>
            </div>

            <!-- Điều hướng Links -->
            <nav class="flex items-center gap-x-8 text-xs uppercase tracking-widest font-bold">
                <a href="#" class="nav-link text-slate-400 hover:text-indigo-500 transition-colors">Privacy Policy</a>
                <a href="#" class="nav-link text-slate-400 hover:text-indigo-500 transition-colors">Documentation</a>
                <a href="#" class="nav-link text-slate-400 hover:text-indigo-500 transition-colors">Support</a>
            </nav>

            <!-- Chỉ số Trực tuyến (Đồng bộ với Header) -->
            <div class="online-badge">
                <div class="flex flex-col items-end">
                    <span class="status-text-top">Hệ thống</span>
                    <span class="status-text-main">Trực tuyến</span>
                </div>
                <div class="dot-container">
                    <div class="dot-main"></div>
                    <div class="dot-pulse"></div>
                </div>
            </div>
        </div>
        
        <!-- Dòng Credit cuối trang -->
        <div class="mt-12 flex flex-col items-center">
            <div class="w-24 h-[1px] bg-gradient-to-r from-transparent via-indigo-500/50 to-transparent"></div>
            <p class="mt-4 text-[10px] font-black text-indigo-400/60 tracking-[0.5em] uppercase">
                Built with Java Maven
            </p>
        </div>
    </div>
</footer>