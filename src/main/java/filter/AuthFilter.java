package filter;

import entity.UserAccount;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebFilter("/*")
public class AuthFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response,
                         FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;

        String uri = req.getRequestURI();
        String contextPath = req.getContextPath();
        uri = uri.substring(contextPath.length());

        HttpSession session = req.getSession(false);

        // ===== Allow login & static files =====
<<<<<<< HEAD
       if (uri.equals("/login")
                || uri.startsWith("/css/") || uri.startsWith("/CSS/")
                || uri.startsWith("/js/") || uri.startsWith("/JS/")
                || uri.startsWith("/images/")) {
=======
        if (uri.equals("/login") ||
            uri.equals("/register") ||
            uri.startsWith("/css/") ||
            uri.startsWith("/js/") ||
            uri.startsWith("/images/")) {

>>>>>>> 62241a01d11c1d904bec7872ac1dfa7486e396a5
            chain.doFilter(request, response);
            return;
        }

        // ===== Not logged in =====
        if (session == null || session.getAttribute("user") == null) {
            res.sendRedirect(contextPath + "/login");
            return;
        }

        UserAccount user = (UserAccount) session.getAttribute("user");
        int role = user.getRole();

        // ===== Department: Manager only =====
        if (uri.startsWith("/department") && role != 1) {
            res.sendRedirect(contextPath + "/accessDenied.jsp");
            return;
        }

        // ===== Student: Manager + Staff =====
        if (uri.startsWith("/student") && !(role == 1 || role == 2)) {
            res.sendRedirect(contextPath + "/accessDenied.jsp");
            return;
        }

        chain.doFilter(request, response);
    }
}