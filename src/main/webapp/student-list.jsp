<%-- 
    Document   : student-list
    Created on : Feb 15, 2026, 12:55:41?AM
    Author     : ACER
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<h2>Student Management Page</h2>

<p>Welcome: ${sessionScope.user.username}</p>
<a href="students?action=create">Add Student</a>
<a href="logout">Logout</a>

<table border="1">
<tr>
    <th>ID</th>
    <th>StudentID</th>
    <th>Name</th>
    <th>GPA</th>
    <th>Department</th>
    <th>CreatedBy</th>
    <th>CreatedAt</th>
    <th>UpdatedAt</th>
    <th>Action</th>
</tr>

<c:forEach var="s" items="${students}">
<tr>
    <td>${s.id}</td>
    <td>${s.studentId}</td>
    <td>${s.name}</td>
    <td>${s.gpa}</td>
    <td>${s.department.departmentname}</td>
    <td>${s.createdBy}</td>
    <td>${s.createdAt}</td>
    <td>${s.updatedAt}</td>
    <td>
        <a href="students?action=edit&id=${s.id}">Edit</a>
        <a href="students?action=delete&id=${s.id}">Delete</a>
    </td>
</tr>
</c:forEach>
</table>

