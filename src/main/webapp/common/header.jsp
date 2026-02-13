<%-- 
    Document   : header
    Created on : Feb 13, 2026, 10:44:40 PM
    Author     : THANH TAI
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark mb-4">
        <div class="container">
            <a class="navbar-brand" href="#">GROUP 5 - SMS</a>
            <div class="navbar-nav">
                <a class="nav-link" href="StudentServlet">Sinh viên</a>
                <a class="nav-link" href="DepartmentServlet">Phòng ban</a>
            </div>
        </div>
    </nav>
    <div class="container">