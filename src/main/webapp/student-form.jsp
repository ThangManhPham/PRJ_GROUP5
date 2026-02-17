<%-- 
    Document   : student-form
    Created on : Feb 15, 2026, 12:55:54?AM
    Author     : ACER
--%>

<%@ page contentType="text/html;charset=UTF-8" %>


<html>
<head>
    <title>Student Form</title>
</head>
<body>

<h2>
    <c:if test="${student == null}">
        Create Student
    </c:if>
    <c:if test="${student != null}">
        Edit Student
    </c:if>
</h2>

<c:if test="${not empty error}">
    <p style="color:red">${error}</p>
</c:if>

<form action="students" method="post">

    <c:if test="${student != null}">
        <input type="hidden" name="id" value="${student.id}" />
    </c:if>

    Student Code:
    <input type="text" name="studentId"
           value="${student.studentid}" required />
    <br><br>

    Name:
    <input type="text" name="name"
           value="${student.name}" required />
    <br><br>

    GPA:
    <input type="number" step="0.1" name="gpa"
           value="${student.gpa}" required />
    <br><br>

    Department:
    <select name="departmentId">
        <c:forEach var="d" items="${departments}">
            <option value="${d.id}"
                <c:if test="${student != null && student.department.id == d.id}">
                    selected
                </c:if>>
                ${d.name}
            </option>
        </c:forEach>
    </select>

    <br><br>

    <button type="submit">Save</button>
    <a href="students">Back</a>

</form>

</body>
</html>
