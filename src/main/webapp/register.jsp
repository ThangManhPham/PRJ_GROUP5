<%-- 
    Document   : register
    Created on : Feb 13, 2026, 10:46:31?PM
    Author     : THANH TAI
--%>

<%@include file="common/header.jsp" %>
<div class="row justify-content-center">
    <div class="col-md-5 card p-4 shadow">
        <h3 class="text-center">T?o tài kho?n m?i</h3>
        <form action="UserServlet?action=insert" method="POST" onsubmit="return validateRegisterForm()">
            <div class="mb-3">
                <label>Username:</label>
                <input type="text" name="username" id="reg_user" class="form-control" placeholder="Ít nh?t 5 ký t?">
            </div>
            <div class="mb-3">
                <label>Password:</label>
                <input type="password" name="password" id="reg_pass" class="form-control">
            </div>
            <div class="mb-3">
                <label>Role:</label>
                <select name="role" class="form-select">
                    <option value="1">Manager</option>
                    <option value="2">Staff</option>
                </select>
            </div>
            <button type="submit" class="btn btn-success w-100">??ng ký ngay</button>
        </form>
    </div>
</div>
<%@include file="common/footer.jsp" %>  