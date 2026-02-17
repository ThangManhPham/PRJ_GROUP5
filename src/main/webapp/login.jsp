<%-- 
    Document   : login
    Created on : Feb 13, 2026, 10:45:20?PM
    Author     : THANH TAI
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Login</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f6f9;
        }

        .login-box {
            width: 350px;
            margin: 100px auto;
            padding: 30px;
            background: white;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
            border-radius: 8px;
        }

        h2 {
            text-align: center;
        }

        input[type=text],
        input[type=password] {
            width: 100%;
            padding: 8px;
            margin: 5px 0 15px 0;
            border: 1px solid #ccc;
            border-radius: 4px;
        }

        .remember {
            margin-bottom: 15px;
        }

        input[type=submit] {
            width: 100%;
            padding: 10px;
            background-color: #007bff;
            border: none;
            color: white;
            font-weight: bold;
            border-radius: 4px;
            cursor: pointer;
        }

        input[type=submit]:hover {
            background-color: #0056b3;
        }

        .error {
            color: red;
            text-align: center;
        }
    </style>
</head>
<body>

<div class="login-box">
    <h2>Login</h2>

    <form action="login" method="post">
        Username:
        <input type="text" name="username"
               value="${cookie.username.value}" required/>

        Password:
        <input type="password" name="password" required/>

        <div class="remember">
            <input type="checkbox" name="remember"
                <c:if test="${not empty cookie.username.value}">
                    checked
                </c:if>
            />
            Remember Me
        </div>

        <input type="submit" value="Login"/>
    </form>

    <p class="error">${error}</p>
</div>

</body>
</html>