package controller;

import dao.DepartmentDAO;
import dao.StudentDAO;
import entity.Department;
import entity.Student;
import entity.UserAccount;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

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

        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        UserAccount user = (UserAccount) session.getAttribute("user");

        String action = request.getParameter("action");

        if ("edit".equals(action)) {

            int id = Integer.parseInt(request.getParameter("id"));
            Student student = studentDAO.getById(id);

            request.setAttribute("student", student);
            request.setAttribute("isUpdate", true);

        } else if ("delete".equals(action)) {

            int id = Integer.parseInt(request.getParameter("id"));
            studentDAO.delete(id);

            response.sendRedirect("student");
            return;
        }

        List<Student> list;

        if (user.getRole() == 1) {
            list = studentDAO.getTop5ByGpa();
        } else {
            list = studentDAO.getAll();
        }

        request.setAttribute("list", list);
        request.setAttribute("departments", departmentDAO.getAll());

        request.getRequestDispatcher("student.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        UserAccount user = (UserAccount) session.getAttribute("user");

        if (user.getRole() != 2) {
            response.sendRedirect("student");
            return;
        }

        String action = request.getParameter("action");

        if ("insert".equals(action)) {
            insertStudent(request, response, user);
        } else if ("update".equals(action)) {
            updateStudent(request, response);
        }
    }

    private void insertStudent(HttpServletRequest request, HttpServletResponse response, UserAccount user)
            throws ServletException, IOException {

        String studentId = request.getParameter("studentId");
        String name = request.getParameter("name");
        String gpaStr = request.getParameter("gpa");
        String deptIdStr = request.getParameter("departmentId");

        double gpa = Double.parseDouble(gpaStr);
        int deptId = Integer.parseInt(deptIdStr);

        Department department = departmentDAO.findById(deptId);

        Student s = new Student();
        s.setStudentId(studentId);
        s.setName(name);
        s.setGpa(gpa);
        s.setDepartment(department);
        s.setCreatedBy(user.getUsername());

        studentDAO.insert(s);

        response.sendRedirect("student");
    }

    private void updateStudent(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int id = Integer.parseInt(request.getParameter("id"));
        String name = request.getParameter("name");
        String gpaStr = request.getParameter("gpa");
        String deptIdStr = request.getParameter("departmentId");

        double gpa = Double.parseDouble(gpaStr);
        int deptId = Integer.parseInt(deptIdStr);

        Department department = departmentDAO.findById(id);

        Student existing = studentDAO.getById(id);

        existing.setName(name);
        existing.setGpa(gpa);
        existing.setDepartment(department);

        studentDAO.update(existing);

        response.sendRedirect("student");
    }
}