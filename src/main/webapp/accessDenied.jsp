<%-- 
    Document   : accessDenied
    Created on : Feb 27, 2026, 2:57:13 PM
    Author     : HP
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Access Denied</title>
    <style>
        body {
            font-family: Arial;
            text-align: center;
            margin-top: 100px;
            background-color: #f8f9fa;
        }
        .box {
            display: inline-block;
            padding: 40px;
            background: white;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        h1 {
            color: red;
        }
        a {
            text-decoration: none;
            color: white;
            background-color: #007bff;
            padding: 10px 20px;
            border-radius: 5px;
        }
        a:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>

<div class="box">
    <h1>Access Denied</h1>
    <p>You do not have permission to access this page.</p>
    <br>
    <a href="login.jsp">Back to Login</a>
</div>

</body>
</html>