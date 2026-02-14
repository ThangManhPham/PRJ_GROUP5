package controller;

import dao.StudentDAO;
import dao.DepartmentDAO;
import entity.Student;
import entity.Department;
import entity.UserAccount;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.time.LocalDate;
import java.util.Comparator;
import java.util.List;
import java.util.stream.Collectors;

@WebServlet("/students")
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

        UserAccount user = (UserAccount) request.getSession().getAttribute("user");

        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String action = request.getParameter("action");

        if (action == null) {
            listStudents(request, response, user);
        } else {
            switch (action) {
                case "create":
                    showForm(request, response, null);
                    break;
                case "edit":
                    int id = Integer.parseInt(request.getParameter("id"));
                    Student student = studentDAO.findById(id);
                    showForm(request, response, student);
                    break;
                case "delete":
                    deleteStudent(request, response, user);
                    break;
                default:
                    listStudents(request, response, user);
            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        UserAccount user = (UserAccount) request.getSession().getAttribute("user");

        String id = request.getParameter("id");

        if (id == null || id.isEmpty()) {
            insertStudent(request, response, user);
        } else {
            updateStudent(request, response, user);
        }
    }

    // ================= LIST =================

    private void listStudents(HttpServletRequest request, HttpServletResponse response,
                              UserAccount user)
            throws ServletException, IOException {

        List<Student> allStudents = studentDAO.getAll();
        List<Student> students;

        if (user.getRole() == 1) { // Manager

            // Sort GPA desc và lấy top 5
            students = allStudents.stream()
                    .sorted(Comparator.comparing(Student::getGpa).reversed())
                    .limit(5)
                    .collect(Collectors.toList());

        } else { // Staff

            int page = 1;
            int recordsPerPage = 5;

            String pageParam = request.getParameter("page");
            if (pageParam != null) {
                page = Integer.parseInt(pageParam);
            }

            int start = (page - 1) * recordsPerPage;
            int end = Math.min(start + recordsPerPage, allStudents.size());

            students = allStudents.subList(start, end);

            int totalPages = (int) Math.ceil((double) allStudents.size() / recordsPerPage);

            request.setAttribute("totalPages", totalPages);
            request.setAttribute("currentPage", page);
        }

        request.setAttribute("students", students);
        request.getRequestDispatcher("student-list.jsp").forward(request, response);
    }

    // ================= FORM =================

    private void showForm(HttpServletRequest request, HttpServletResponse response,
                          Student student)
            throws ServletException, IOException {

        List<Department> departments = departmentDAO.getAll();
        request.setAttribute("departments", departments);
        request.setAttribute("student", student);

        request.getRequestDispatcher("student-form.jsp").forward(request, response);
    }

    // ================= INSERT =================
private void insertStudent(HttpServletRequest request, HttpServletResponse response,
                           UserAccount user)
        throws IOException, ServletException {

    String studentId = request.getParameter("studentId");
    String name = request.getParameter("name");
    Double gpa = Double.parseDouble(request.getParameter("gpa"));
    Integer departmentId = Integer.parseInt(request.getParameter("departmentId"));

    // Validation
    if (name.length() < 5 || name.length() > 50 || gpa < 0 || gpa > 10) {
        request.setAttribute("error", "Invalid input!");
        showForm(request, response, null);
        return;
    }

    Student student = new Student();
    student.setStudentid(studentId);  // đúng tên setter
    student.setName(name);
    student.setGpa(gpa);
    student.setDepartment(departmentDAO.findById(departmentId));
    student.setCreatedAt(new java.util.Date());   // đúng kiểu Date
    student.setUpdatedAt(new java.util.Date());
    student.setCreatedBy(user.getUsername());

    studentDAO.insert(student);

    response.sendRedirect("students");
}

    // ================= UPDATE =================

private void updateStudent(HttpServletRequest request, HttpServletResponse response,
                           UserAccount user)
        throws IOException {

    Integer id = Integer.parseInt(request.getParameter("id"));
    Student student = studentDAO.findById(id);

    if (student == null || 
        !student.getCreatedBy().equals(user.getUsername())) {
        response.sendRedirect("students");
        return;
    }

    student.setName(request.getParameter("name"));
    student.setGpa(Double.parseDouble(request.getParameter("gpa")));
    student.setUpdatedAt(new java.util.Date());   // đúng kiểu Date

    studentDAO.update(student);

    response.sendRedirect("students");
}


    // ================= DELETE =================

    private void deleteStudent(HttpServletRequest request, HttpServletResponse response,
                               UserAccount user)
            throws IOException {

        int id = Integer.parseInt(request.getParameter("id"));
        Student student = studentDAO.findById(id);

        if (student != null && student.getCreatedBy().equals(user.getUsername())) {
            studentDAO.delete(id);
        }

        response.sendRedirect("students");
    }
}
