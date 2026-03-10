package controller;

import dao.UserAccountDAO;
import entity.GoogleAccount;
import entity.UserAccount;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import util.GoogleUtils;

import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/auth/google-register")
public class GoogleRegisterServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String idToken = request.getParameter("idToken");

        response.setContentType("application/json");
        PrintWriter out = response.getWriter();

        if (idToken == null || idToken.isEmpty()) {
            out.print("{\"success\":false,\"message\":\"Missing token\"}");
            return;
        }

        GoogleUtils googleUtils = new GoogleUtils();
        GoogleAccount account = googleUtils.verifyToken(idToken);

        if (account == null || account.getEmail() == null) {
            out.print("{\"success\":false,\"message\":\"Invalid token\"}");
            return;
        }

        String email = account.getEmail();

        UserAccountDAO dao = new UserAccountDAO();
        UserAccount user = dao.findByUsername(email);

        if (user == null) {
            user = new UserAccount();
            user.setUsername(email);
            user.setPassword("123");
            user.setRole(3);
            dao.insert(user);
        }

        HttpSession session = request.getSession(true);
        session.setAttribute("user", user);

        out.print("{\"success\":true}");
    }
}
