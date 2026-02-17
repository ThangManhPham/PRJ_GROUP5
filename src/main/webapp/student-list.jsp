<%-- 
    Document   : student-list
    Created on : Feb 15, 2026, 12:55:41?AM
    Author     : ACER
--%>

<%@ page contentType="text/html;charset=UTF-8" %>

<html>
<head>
    <title>Student List</title>
</head>
<body>

<h2>Student List</h2>

<a href="students?action=create">Add New Student</a>
<br><br>

<table border="1" cellpadding="5">
    <tr>
        <th>ID</th>
        <th>Student Code</th>
        <th>Name</th>
        <th>GPA</th>
        <th>Department</th>
        <th>Action</th>
    </tr>

    <c:forEach var="s" items="${students}">
        <tr>
            <td>${s.id}</td>
            <td>${s.studentid}</td>
            <td>${s.name}</td>
            <td>${s.gpa}</td>
            <td>${s.department.name}</td>
            <td>
                <c:if test="${sessionScope.user.username == s.createdBy}">
                    <a href="students?action=edit&id=${s.id}">Edit</a>
                    |
                    <a href="students?action=delete&id=${s.id}"
                       onclick="return confirm('Are you sure?')">
                        Delete
                    </a>
                </c:if>
            </td>
        </tr>
    </c:forEach>
</table>

<br>

<!-- Pagination for Staff -->
<c:if test="${not empty totalPages}">
    <c:forEach begin="1" end="${totalPages}" var="i">
        <a href="students?page=${i}">${i}</a>
    </c:forEach>
</c:if>

<br><br>
<a href="logout">Logout</a>

</body>
</html>