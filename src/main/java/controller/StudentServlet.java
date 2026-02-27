package controller;

import dao.StudentDAO;
import dao.DepartmentDAO;
import entity.Student;
import entity.Department;
import entity.UserAccount;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.util.List;

@WebServlet("/student")
public class StudentServlet extends HttpServlet {

    private StudentDAO studentDAO;
    private DepartmentDAO departmentDAO;

    @Override
    public void init() {
        studentDAO = new StudentDAO();
        departmentDAO = new DepartmentDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        UserAccount user = (UserAccount) session.getAttribute("user");
        int role = user.getRole();   // 1=Manager, 2=Staff

        String action = request.getParameter("action");

        if (action == null) action = "list";

        // ===== STAFF ONLY ACTIONS =====
        if (role == 2) {

            if ("edit".equals(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                Student s = studentDAO.getById(id);
                request.setAttribute("student", s);
            }

            if ("delete".equals(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                studentDAO.delete(id);
                response.sendRedirect("student");
                return;
            }

            request.setAttribute("departments", departmentDAO.getAll());
        }

        // ===== LIST DATA =====
        List<Student> list;

        if (role == 1) {
            list = studentDAO.getTop5ByGpa();
        } else {
            list = studentDAO.getAll();
        }

        request.setAttribute("students", list);
        request.getRequestDispatcher("student.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        UserAccount user = (UserAccount) session.getAttribute("user");

        // Manager không được POST
        if (user.getRole() != 2) {
            response.sendRedirect("student");
            return;
        }

        String idStr = request.getParameter("id");
        String studentId = request.getParameter("studentId");
        String name = request.getParameter("name");
        double gpa = Double.parseDouble(request.getParameter("gpa"));
        int departmentId = Integer.parseInt(request.getParameter("departmentId"));

        Department department = departmentDAO.findById(departmentId);

        Student s = new Student();
        s.setStudentId(studentId);
        s.setName(name);
        s.setGpa(gpa);
        s.setDepartment(department);
        s.setCreatedBy(user.getUsername());

        if (idStr == null || idStr.isEmpty()) {
            studentDAO.insert(s);
        } else {
            s.setId(Integer.parseInt(idStr));
            studentDAO.update(s);
        }

        response.sendRedirect("student");
    }
}