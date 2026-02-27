<%-- 
    Document   : footer
    Created on : Feb 13, 2026, 10:44:56?PM
    Author     : THANH TAI
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Management System</title>

    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
        }

        .navbar {
            background-color: #2c3e50;
            padding: 12px 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .navbar a {
            color: white;
            text-decoration: none;
            margin-right: 15px;
            font-weight: bold;
        }

        .navbar a:hover {
            text-decoration: underline;
        }

        .user-info {
            color: #f1c40f;
        }
    </style>
</head>
<body>

<div class="navbar">
    <div>
        <a href="${pageContext.request.contextPath}/student">Student</a>
        <a href="${pageContext.request.contextPath}/department">Department</a>
    </div>

    <div>
        <span class="user-info">
            Welcome, ${sessionScope.username}
        </span>
        |
        <a href="${pageContext.request.contextPath}/logout">Logout</a>
    </div>
</div>

<hr>