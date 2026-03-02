<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Access Denied</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600;700&display=swap');
        body {
            font-family: 'Inter', sans-serif;
            background-color: #1a1a3c;
            color: white;
            overflow: hidden;
            height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .bg-shapes { position: fixed; top: 0; left: 0; width: 100%; height: 100%; z-index: -1; }
        .shape {
            position: absolute;
            background: rgba(255, 255, 255, 0.05);
            border-radius: 20px;
            animation: float 6s ease-in-out infinite;
        }
        @keyframes float {
            0%, 100% { transform: translateY(0) rotate(15deg); }
            50% { transform: translateY(-20px) rotate(10deg); }
        }
        .shape-1 { width: 150px; height: 150px; top: 10%; left: 10%; }
        .shape-2 { width: 100px; height: 100px; bottom: 15%; right: 10%; animation-delay: 2s; }
        .glass-card {
            background: rgba(30, 30, 60, 0.8);
            backdrop-filter: blur(15px);
            border: 1px solid rgba(255, 255, 255, 0.1);
            border-radius: 32px;
            padding: 3rem;
            text-align: center;
            max-width: 450px;
            width: 90%;
            box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.6);
        }
        .icon-box {
            background: rgba(244, 63, 94, 0.1);
            color: #fb7185;
            width: 80px; height: 80px;
            border-radius: 24px;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 1.5rem;
            border: 1px solid rgba(244, 63, 94, 0.2);
        }
        .btn-back {
            background: linear-gradient(135deg, #6366f1 0%, #4f46e5 100%);
            display: inline-block;
            width: 100%;
            padding: 1rem;
            border-radius: 16px;
            font-weight: 700;
            text-transform: uppercase;
            transition: all 0.3s ease;
        }
        .btn-back:hover {
            transform: scale(1.02);
            box-shadow: 0 10px 20px -5px rgba(79, 70, 229, 0.5);
        }
    </style>
</head>
<body>

    <div class="bg-shapes">
        <div class="shape shape-1"></div>
        <div class="shape shape-2"></div>
    </div>

    <div class="glass-card">
        <div class="icon-box">
            <svg xmlns="http://www.w3.org/2000/svg" class="h-10 w-10" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 15v2m0 0v2m0-2h2m-2 0H10m4-11a4 4 0 11-8 0 4 4 0 018 0zm-4 7v3m0 0v3m0-3h3m-3 0H7" />
            </svg>
        </div>

        <h1 class="text-3xl font-bold text-white mb-2">Access Denied</h1>
        <p class="text-gray-400 mb-8 leading-relaxed">
            Sorry! You do not have permission to access this area. Please contact the administrator or return to the previous page.
        </p>

        <a href="logout" class="btn-back">
            Back to Login Page
        </a>

        <div class="mt-6">
            <a href="javascript:history.back()" class="text-sm text-gray-500 hover:text-indigo-400 transition-colors">
                Go Back
            </a>
        </div>
    </div>

</body>
</html>