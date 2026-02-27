package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/logout")
public class LogoutServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        // 1. Lấy session hiện tại (nếu có)
        HttpSession session = request.getSession(false);

        if (session != null) {
            session.invalidate(); // Hủy session
        }

        // 2. Xóa cookie nếu có lưu username hoặc password
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if (cookie.getName().equals("username") ||
                    cookie.getName().equals("password")) {

                    cookie.setValue("");
                    cookie.setMaxAge(0);
                    response.addCookie(cookie);
                }
            }
        }

        // 3. Chống back sau logout
        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
        response.setHeader("Pragma", "no-cache");
        response.setDateHeader("Expires", 0);

        // 4. Quay về login
        response.sendRedirect(request.getContextPath() + "/login");
    }
}