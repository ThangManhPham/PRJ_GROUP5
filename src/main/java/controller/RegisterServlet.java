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

        UserAccount existingUser = userDAO.findByUsername(username);

        if (existingUser != null) {
            request.setAttribute("error", "Username already exists!");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        UserAccount newUser = new UserAccount();
        newUser.setUsername(username);
        newUser.setPassword(password);
        newUser.setRole(2); // default role

        userDAO.insert(newUser);

        response.sendRedirect("login");
    }
}