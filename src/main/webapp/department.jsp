<%-- 
    Document   : department
    Created on : Feb 24, 2026, 8:44:47 AM
    Author     : HP
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="common/header.jsp" %>

<html>
<head>
    <title>Department Management</title>
</head>
<body>

<h2>Department Management Page</h2>

<!-- ===== ERROR MESSAGE ===== -->
<c:if test="${not empty error}">
    <p style="color:red; font-weight:bold;">
        ${error}
    </p>
</c:if>

<!-- ===== FORM ===== -->
<h3>
    <c:choose>
        <c:when test="${department != null}">
            Update Department
        </c:when>
        <c:otherwise>
            Add Department
        </c:otherwise>
    </c:choose>
</h3>

<form action="department" method="post"
      onsubmit="return validateDepartment()">

    <c:if test="${department != null}">
        <input type="hidden" name="id" value="${department.id}" />
        <input type="hidden" name="action" value="update" />
    </c:if>

    <c:if test="${department == null}">
        <input type="hidden" name="action" value="add" />
    </c:if>

    Department Name:
    <input type="text"
           name="departmentname"
           value="${department != null ? department.departmentname : param.departmentname}"
           required />

    <br><br>

    <button type="submit">
        <c:choose>
            <c:when test="${department != null}">Update</c:when>
            <c:otherwise>Add</c:otherwise>
        </c:choose>
    </button>
</form>

<hr>

<!-- ===== LIST ===== -->
<h3>Department List</h3>

<table border="1" cellpadding="5">
    <tr>
        <th>No</th>
        <th>Department Name</th>
        <th>Action</th>
    </tr>

    <c:forEach var="d" items="${list}" varStatus="loop">
        <tr>
            <td>${loop.index + 1}</td>
            <td>${d.departmentname}</td>
            <td>
                <a href="department?action=edit&id=${d.id}">Edit</a>
                |
                <a href="department?action=delete&id=${d.id}"
                   onclick="return confirm('Delete this department?')">
                    Delete
                </a>
            </td>
        </tr>
    </c:forEach>

</table>

<br>

<a href="student">
    <button>Back to Student</button>
</a>

<!-- ===== JAVASCRIPT VALIDATION ===== -->
<script>
function validateDepartment() {
    let input = document.querySelector("input[name='departmentname']");
    let name = document.querySelector("input[name='departmentname']").value.trim();

 if (name == null || name.trim().length === 0) {
        alert("Department name không được để trống hoặc chỉ có khoảng trắng!");
        input.focus();
        return false;
    }
    
    if (name.length < 5 || name.length > 50) {
        alert("Department name must be between 5 and 50 characters!");
        return false;
    }

    return true;
}
</script>

</body>
</html>
<%@ include file="common/footer.jsp" %>