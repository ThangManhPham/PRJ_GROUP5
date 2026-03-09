/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller;

import dao.UserAccountDAO;
import entity.GoogleAccount;
import entity.UserAccount;
import util.GoogleUtils;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.io.PrintWriter;

/**
 *
 * @author HP
 */

@WebServlet("/login-google")
public class GoogleLoginServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String idToken = request.getParameter("idToken");

        GoogleUtils googleUtils = new GoogleUtils();
        GoogleAccount googleAccount = googleUtils.verifyToken(idToken);

        response.setContentType("application/json");
        PrintWriter out = response.getWriter();

        if (googleAccount == null) {
            out.print("{\"success\":false}");
            return;
        }

        String username = googleAccount.getEmail(); // dùng email làm username

        UserAccountDAO dao = new UserAccountDAO();
        UserAccount user = dao.findByUsername(username);

        // nếu chưa có user thì tạo mới
        if (user == null) {

            user = new UserAccount();
            user.setUsername(username);
            user.setPassword("GOOGLE_LOGIN");
            user.setRole(3); // role bị hạn chế cho user Google

            dao.insert(user);
        }

        // tạo session login
        HttpSession session = request.getSession();
        session.setAttribute("user", user);

        // kiểm tra role
        if (user.getRole() == 3) {
            out.print("{\"warning\":\"Đăng nhập thành công, nhưng bạn không có quyền để truy cập chỉnh sửa trang web này!\"}");
        } else {
            out.print("{\"success\":true}");
        }
    }
}