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

        request.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession(false);
        UserAccount user = (UserAccount) session.getAttribute("user");

        // Manager không được POST
        if (user.getRole() != 2) {
            response.sendRedirect("student");
            return;
        }

        String idStr = request.getParameter("id");
        String studentIdRaw = request.getParameter("studentId");
        String nameRaw = request.getParameter("name");
        String gpaRaw = request.getParameter("gpa");
        String deptRaw = request.getParameter("departmentId");

        java.util.Map<String, String> errors = new java.util.HashMap<>();

        boolean isUpdate = (idStr != null && !idStr.trim().isEmpty());

        // ========== 1) StudentID ==========
        String studentId = (studentIdRaw == null) ? "" : studentIdRaw.trim();
        if (!isUpdate) {
            if (studentId.isEmpty()) {
                errors.put("studentId", "StudentID không được để trống.");
            } else if (!studentId.matches("^[A-Za-z0-9]+$")) {
                errors.put("studentId", "StudentID chỉ gồm chữ và số (không ký tự đặc biệt/khoảng trắng).");
            } else if (studentDAO.existsStudentId(studentId)) {
                errors.put("studentId", "StudentID bị trùng (đã tồn tại).");
            }
        }

        // ========== 2) Full Name ==========
        String name = (nameRaw == null) ? "" : nameRaw.trim().replaceAll("\\s{2,}", " ");
        if (name.isEmpty()) {
            errors.put("name", "Họ và tên không được để trống.");
        } else if (name.length() < 2) { // theo nhiệm vụ bạn ghi
            errors.put("name", "Họ và tên tối thiểu 2 ký tự.");
        } else if (name.matches(".*\\d.*")) {
            errors.put("name", "Họ và tên không được chứa số.");
        }

        // ========== 3) GPA ==========
        Double gpa = null;
        String gpaStr = (gpaRaw == null) ? "" : gpaRaw.trim();
        if (gpaStr.isEmpty()) {
            errors.put("gpa", "GPA không được để trống.");
        } else {
            try {
                gpa = Double.parseDouble(gpaStr);
                if (gpa < 0 || gpa > 10) {
                    errors.put("gpa", "GPA phải trong khoảng 0 → 10.");
                }
            } catch (NumberFormatException e) {
                errors.put("gpa", "GPA phải là số (không nhập chữ).");
            }
        }

        // ========== 4) Department ==========
        Integer deptId = null;
        Department department = null;
        String deptStr = (deptRaw == null) ? "" : deptRaw.trim();
        if (deptStr.isEmpty()) {
            errors.put("departmentId", "Bắt buộc chọn Department.");
        } else {
            try {
                deptId = Integer.parseInt(deptStr);
                department = departmentDAO.findById(deptId);
                if (department == null) {
                    errors.put("departmentId", "Department không tồn tại trong DB.");
                }
            } catch (NumberFormatException e) {
                errors.put("departmentId", "Department không hợp lệ.");
            }
        }

        // ========== 5) Update: không cho sửa StudentID (backend chặn) ==========
        Student existing = null;
        Integer id = null;
        if (isUpdate) {
            try {
                id = Integer.parseInt(idStr.trim());
                existing = studentDAO.getById(id);
                if (existing == null) {
                    errors.put("global", "Student không tồn tại.");
                } else {
                    String postedSid = (studentIdRaw == null) ? "" : studentIdRaw.trim();
                    if (!postedSid.isEmpty() && !postedSid.equals(existing.getStudentId())) {
                        errors.put("studentId", "Không được sửa StudentID khi Update.");
                    }
                }
            } catch (NumberFormatException e) {
                errors.put("global", "ID không hợp lệ.");
            }
        }

        // ========== Nếu có lỗi: forward + giữ dữ liệu + không reset ==========
        if (!errors.isEmpty()) {
            // giữ form bằng cách đẩy lại 1 Student "form"
            Student formStudent = new Student();
            if (isUpdate && id != null) formStudent.setId(id);

            // nếu update thì ưu tiên StudentID từ existing để không bị sửa
            formStudent.setStudentId(isUpdate && existing != null ? existing.getStudentId() : studentId);
            formStudent.setName(name);
            formStudent.setGpa(gpa != null ? gpa : 0);
            formStudent.setDepartment(department); // có thể null nếu dept lỗi

            request.setAttribute("errors", errors);
            request.setAttribute("student", formStudent); // JSP của bạn đang dùng attr "student" khi edit :contentReference[oaicite:4]{index=4}

            // load data để JSP render lại
            request.setAttribute("departments", departmentDAO.getAll());
            request.setAttribute("students", studentDAO.getAll());

            request.getRequestDispatcher("student.jsp").forward(request, response);
            return;
        }

        // ========== OK: Insert/Update ==========
        if (!isUpdate) {
            Student s = new Student();
            s.setStudentId(studentId);
            s.setName(name);
            s.setGpa(gpa);
            s.setDepartment(department);
            s.setCreatedBy(user.getUsername());
            studentDAO.insert(s);
        } else {
            // update trên entity existing để không mất createdAt/createdBy
            existing.setName(name);
            existing.setGpa(gpa);
            existing.setDepartment(department);
            studentDAO.update(existing);
        }

        response.sendRedirect("student");
    }
}