<%-- 
    Document   : student-form
    Created on : Feb 15, 2026, 12:55:54?AM
    Author     : ACER
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<h2>Student Form</h2>

<c:if test="${not empty error}">
    <p style="color:red">${error}</p>
</c:if>

<form action="students" method="post">
    <input type="hidden" name="id" value="${student.id}" />

    StudentID:
    <input type="text" name="studentId" value="${student.studentId}" /><br/>

    Name:
    <input type="text" name="name" value="${student.name}" /><br/>

    GPA:
    <input type="text" name="gpa" value="${student.gpa}" /><br/>

    Department:
    <select name="departmentId">
        <c:forEach var="d" items="${departments}">
            <option value="${d.id}">
                ${d.departmentname}
            </option>
        </c:forEach>
    </select>

    <button type="submit">Save</button>
</form>

