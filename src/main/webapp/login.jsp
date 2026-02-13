<%-- 
    Document   : login
    Created on : Feb 13, 2026, 10:45:20?PM
    Author     : THANH TAI
--%>

<%@include file="common/header.jsp" %>
<div class="row justify-content-center">
    <div class="col-md-4 card p-4">
        <h3 class="text-center">??ng nh?p</h3>
        <form action="LoginServlet" method="POST">
            <div class="mb-3">
                <label>Username:</label>
                <input type="text" name="username" class="form-control" required>
            </div>
            <div class="mb-3">
                <label>Password:</label>
                <input type="password" name="password" class="form-control" required>
            </div>
            <button type="submit" class="btn btn-primary w-100">Vào h? th?ng</button>
        </form>
    </div>
</div>
<%@include file="common/footer.jsp" %>