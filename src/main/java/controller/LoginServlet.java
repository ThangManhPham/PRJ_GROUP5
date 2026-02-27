package controller;

import dao.UserAccountDAO;
import entity.UserAccount;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    private UserAccountDAO userDAO;

    @Override
    public void init() {
        userDAO = new UserAccountDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.getRequestDispatcher("login.jsp").forward(request, response);
    }

   @Override
protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

    String username = request.getParameter("username");
    String password = request.getParameter("password");
    String remember = request.getParameter("remember");

    UserAccount user = userDAO.checkLogin(username, password);

    if (user != null) {

        if (user.getRole() == 3) {
            request.setAttribute("error", "You have no permission to access this function!");
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }

        // Xóa session cũ
        HttpSession oldSession = request.getSession(false);
        if (oldSession != null) {
            oldSession.invalidate();
        }

        // Tạo session mới
        HttpSession session = request.getSession(true);
        session.setAttribute("user", user);
        session.setMaxInactiveInterval(30 * 60);

        // ===== REMEMBER ME =====
        if ("true".equals(remember)) {
            Cookie cookie = new Cookie("rememberUser", username);
            cookie.setMaxAge(7 * 24 * 60 * 60); // 7 ngày
            cookie.setHttpOnly(true);
            response.addCookie(cookie);
        } else {
            Cookie cookie = new Cookie("rememberUser", "");
            cookie.setMaxAge(0); // Xóa cookie
            response.addCookie(cookie);
        }

        response.sendRedirect("student");

    } else {
        request.setAttribute("error", "Username or password is invalid!");
        request.getRequestDispatcher("login.jsp").forward(request, response);
    }
}
}