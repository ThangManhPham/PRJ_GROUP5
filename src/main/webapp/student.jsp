<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="common/header.jsp" %>

<h2>Student Management Page</h2>

<c:set var="role" value="${sessionScope.user.role}" />

<!-- ================= STAFF ONLY FORM ================= -->
<c:if test="${role == 2}">

    <h3>
        <c:choose>
            <c:when test="${student != null}">
                Update Student
            </c:when>
            <c:otherwise>
                Add Student
            </c:otherwise>
        </c:choose>
    </h3>

    <form action="student" method="post">

        <c:if test="${student != null}">
            <input type="hidden" name="id" value="${student.id}" />
        </c:if>

        Student ID:
        <input type="text" name="studentId"
               value="${student != null ? student.studentId : ''}"
               ${student != null ? 'readonly' : ''}
               required />
        <br><br>

        Name:
        <input type="text" name="name"
               value="${student != null ? student.name : ''}" required />
        <br><br>

        GPA:
        <input type="number" step="0.1" name="gpa"
               value="${student != null ? student.gpa : ''}" required />
        <br><br>

        Department:
        <select name="departmentId" required>
            <option value="">-- Select Department --</option>

            <c:forEach var="d" items="${departments}">
                <option value="${d.id}"
                    <c:if test="${student != null && student.department.id == d.id}">
                        selected
                    </c:if>>
                    ${d.departmentname}
                </option>
            </c:forEach>
        </select>

        <br><br>

        <button type="submit">
            <c:choose>
                <c:when test="${student != null}">Update</c:when>
                <c:otherwise>Add</c:otherwise>
            </c:choose>
        </button>

    </form>

    <hr>

</c:if>

<!-- ================= LIST ================= -->

<h3>
    <c:choose>
        <c:when test="${role == 1}">
            Top 5 Students (Manager View)
        </c:when>
        <c:otherwise>
            Student List
        </c:otherwise>
    </c:choose>
</h3>

<table border="1" cellpadding="5">
    <tr>
        <th>No</th>
        <th>Student ID</th>
        <th>Name</th>
        <th>GPA</th>
        <th>Department</th>
        <c:if test="${role == 2}">
            <th>Action</th>
        </c:if>
    </tr>

    <c:forEach var="s" items="${students}" varStatus="loop">
        <tr>
            <td>${loop.index + 1}</td>
            <td>${s.studentId}</td>
            <td>${s.name}</td>
            <td>${s.gpa}</td>
            <td>${s.department.departmentname}</td>

            <c:if test="${role == 2}">
                <td>
                    <a href="student?action=edit&id=${s.id}">Edit</a>
                    |
                    <a href="student?action=delete&id=${s.id}"
                       onclick="return confirm('Delete this student?')">
                        Delete
                    </a>
                </td>
            </c:if>

        </tr>
    </c:forEach>
</table>

<%@ include file="common/footer.jsp" %>