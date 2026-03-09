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
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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

        request.setAttribute("students", list);
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

    // ========= VALIDATION =========
    private Map<String, String> validateStudentForCreate(String studentId, String name,
                                                         String gpaStr, String deptIdStr) {
        Map<String, String> errors = new HashMap<>();

        // 1) StudentID
        if (studentId == null || studentId.trim().isEmpty()) {
            errors.put("studentId", "Mã số sinh viên không được để trống.");
        } else {
            String trimmed = studentId.trim();
            if (trimmed.length() > 50) {
                errors.put("studentId", "Mã số sinh viên không được vượt quá 50 ký tự.");
            } else if (!trimmed.matches("^[A-Za-z0-9]+$")) {
                errors.put("studentId", "Mã số sinh viên chỉ được chứa chữ và số, không có ký tự đặc biệt.");
            } else if (studentDAO.existsStudentId(trimmed)) {
                errors.put("studentId", "Mã số sinh viên này đã được sử dụng, vui lòng nhập MSSV khác.");
            }
        }

        // 2) Full name (khớp constraint: LEN(name) BETWEEN 5 AND 50)
        if (name == null || name.trim().isEmpty()) {
            errors.put("name", "Họ và tên không được để trống.");
        } else {
            String trimmed = name.trim();
            int len = trimmed.length();
            if (len < 5 || len > 50) {
                errors.put("name", "Họ và tên phải từ 5 đến 50 ký tự.");
            } else if (!trimmed.matches("^[\\p{L} ]+$")) {
                errors.put("name", "Họ và tên chỉ được chứa chữ cái và khoảng trắng, không có số hoặc ký tự đặc biệt.");
            }
        }

        // 3) GPA
        if (gpaStr == null || gpaStr.trim().isEmpty()) {
            errors.put("gpa", "GPA không được để trống.");
        } else {
            try {
                double gpa = Double.parseDouble(gpaStr.trim());
                if (gpa < 0 || gpa > 10) {
                    errors.put("gpa", "GPA phải nằm trong khoảng từ 0 đến 10.");
                }
            } catch (NumberFormatException e) {
                errors.put("gpa", "GPA phải là số hợp lệ.");
            }
        }

        // 4) Department
        if (deptIdStr == null || deptIdStr.trim().isEmpty()) {
            errors.put("departmentId", "Khoa/Ngành bắt buộc phải chọn.");
        } else {
            try {
                int deptId = Integer.parseInt(deptIdStr.trim());
                if (!departmentDAO.existsById(deptId)) {
                    errors.put("departmentId", "Khoa/Ngành không tồn tại trong hệ thống.");
                }
            } catch (NumberFormatException e) {
                errors.put("departmentId", "Khoa/Ngành không hợp lệ.");
            }
        }

        return errors;
    }

    private Map<String, String> validateStudentForUpdate(String name,
                                                         String gpaStr, String deptIdStr) {
        Map<String, String> errors = new HashMap<>();

        // Full name (khớp constraint: LEN(name) BETWEEN 5 AND 50)
        if (name == null || name.trim().isEmpty()) {
            errors.put("name", "Họ và tên không được để trống.");
        } else {
            String trimmed = name.trim();
            int len = trimmed.length();
            if (len < 5 || len > 50) {
                errors.put("name", "Họ và tên phải từ 5 đến 50 ký tự.");
            } else if (!trimmed.matches("^[\\p{L} ]+$")) {
                errors.put("name", "Họ và tên chỉ được chứa chữ cái và khoảng trắng, không có số hoặc ký tự đặc biệt.");
            }
        }

        // GPA
        if (gpaStr == null || gpaStr.trim().isEmpty()) {
            errors.put("gpa", "GPA không được để trống.");
        } else {
            try {
                double gpa = Double.parseDouble(gpaStr.trim());
                if (gpa < 0 || gpa > 10) {
                    errors.put("gpa", "GPA phải nằm trong khoảng từ 0 đến 10.");
                }
            } catch (NumberFormatException e) {
                errors.put("gpa", "GPA phải là số hợp lệ.");
            }
        }

        // Department
        if (deptIdStr == null || deptIdStr.trim().isEmpty()) {
            errors.put("departmentId", "Khoa/Ngành bắt buộc phải chọn.");
        } else {
            try {
                int deptId = Integer.parseInt(deptIdStr.trim());
                if (!departmentDAO.existsById(deptId)) {
                    errors.put("departmentId", "Khoa/Ngành không tồn tại trong hệ thống.");
                }
            } catch (NumberFormatException e) {
                errors.put("departmentId", "Khoa/Ngành không hợp lệ.");
            }
        }

        return errors;
    }

    private void insertStudent(HttpServletRequest request, HttpServletResponse response, UserAccount user)
            throws ServletException, IOException {

        String studentId = request.getParameter("studentId");
        String name = request.getParameter("name");
        String gpaStr = request.getParameter("gpa");
        String deptIdStr = request.getParameter("departmentId");

        Map<String, String> errors = validateStudentForCreate(studentId, name, gpaStr, deptIdStr);

        if (!errors.isEmpty()) {
            // Giữ lại dữ liệu người dùng đã nhập
            Student temp = new Student();
            temp.setStudentId(studentId);
            temp.setName(name);
            try {
                temp.setGpa(Double.parseDouble(gpaStr));
            } catch (Exception ignored) {
            }
            try {
                int deptId = Integer.parseInt(deptIdStr);
                Department d = departmentDAO.findById(deptId);
                temp.setDepartment(d);
            } catch (Exception ignored) {
            }

            request.setAttribute("student", temp);
            request.setAttribute("errors", errors);
            request.setAttribute("departments", departmentDAO.getAll());

            // load lại danh sách sinh viên (Staff xem all, Manager xem top 5)
            HttpSession session = request.getSession(false);
            UserAccount userAcc = (UserAccount) session.getAttribute("user");
            List<Student> list = userAcc.getRole() == 1
                    ? studentDAO.getTop5ByGpa()
                    : studentDAO.getAll();
            request.setAttribute("students", list);

            request.getRequestDispatcher("student.jsp").forward(request, response);
            return;
        }

        double gpa = Double.parseDouble(gpaStr.trim());
        int deptId = Integer.parseInt(deptIdStr.trim());

        Department department = departmentDAO.findById(deptId);

        Student s = new Student();
        s.setStudentId(studentId.trim());
        s.setName(name.trim());
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

        Map<String, String> errors = validateStudentForUpdate(name, gpaStr, deptIdStr);

        if (!errors.isEmpty()) {
            Student existing = studentDAO.getById(id);
            // Cập nhật tạm giá trị người dùng vừa nhập (trừ studentId vì không cho sửa)
            existing.setName(name);
            try {
                existing.setGpa(Double.parseDouble(gpaStr));
            } catch (Exception ignored) {
            }
            try {
                int deptId = Integer.parseInt(deptIdStr);
                Department d = departmentDAO.findById(deptId);
                existing.setDepartment(d);
            } catch (Exception ignored) {
            }

            request.setAttribute("student", existing);
            request.setAttribute("errors", errors);
            request.setAttribute("departments", departmentDAO.getAll());

            HttpSession session = request.getSession(false);
            UserAccount userAcc = (UserAccount) session.getAttribute("user");
            List<Student> list = userAcc.getRole() == 1
                    ? studentDAO.getTop5ByGpa()
                    : studentDAO.getAll();
            request.setAttribute("students", list);

            request.getRequestDispatcher("student.jsp").forward(request, response);
            return;
        }

        double gpa = Double.parseDouble(gpaStr.trim());
        int deptId = Integer.parseInt(deptIdStr.trim());

        Department department = departmentDAO.findById(deptId);

        Student existing = studentDAO.getById(id);

        // Không cho sửa studentId – chỉ update các trường còn lại
        existing.setName(name.trim());
        existing.setGpa(gpa);
        existing.setDepartment(department);

        studentDAO.update(existing);

        response.sendRedirect("student");
    }
}