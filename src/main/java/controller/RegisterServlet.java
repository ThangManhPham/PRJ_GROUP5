package controller;

import dao.UserAccountDAO;
import entity.UserAccount;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

    private UserAccountDAO userDAO;

    @Override
    public void init() {
        userDAO = new UserAccountDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.getRequestDispatcher("register.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");
        if (username != null) {
            username = username.trim();
        }
        String confirm = request.getParameter("confirm_password");

        if (username == null || username.isBlank() ||
                password == null || password.isBlank() ||
                confirm == null || confirm.isBlank()) {
            request.setAttribute("error", "Vui lòng nhập đầy đủ thông tin!");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        // Ưu tiên kiểm tra tài khoản đã tồn tại
        UserAccount existingUser = userDAO.findByUsername(username);

        if (existingUser != null) {
            request.setAttribute("error", "Tài khoản đã tồn tại!");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        // Sau đó mới kiểm tra mật khẩu xác nhận
        if (!password.equals(confirm)) {
            request.setAttribute("error", "Mật khẩu xác nhận không khớp!");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        UserAccount newUser = new UserAccount();
        newUser.setUsername(username);
        newUser.setPassword(password);
        newUser.setRole(3); // default role

        userDAO.insert(newUser);

        response.sendRedirect("login");
    }
}
