package controller;

import dao.DepartmentDAO;
import entity.Department;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/department")
public class DepartmentServlet extends HttpServlet {

    private DepartmentDAO dao;

    @Override
    public void init() {
        dao = new DepartmentDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if (action == null) {
            listDepartments(request, response);
        } else if (action.equals("edit")) {
            showEditForm(request, response);
        } else if (action.equals("delete")) {
            deleteDepartment(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if ("add".equals(action)) {
    insertDepartment(request, response);
} else if ("update".equals(action)) {
    updateDepartment(request, response);
}
    }
    private String validateDepartmentName(String name) {
    if (name == null) {
        return "Department Name không được để trống!";
    }

    String trimmed = name.trim();

    if (trimmed.isEmpty()) {
        return "Department Name không được để trống hoặc toàn khoảng trắng!";
    }

    if (trimmed.length() < 2) {
        return "Department Name phải có tối thiểu 2 ký tự!";
    }

    return null; // hợp lệ
}
    private void listDepartments(HttpServletRequest request,
                                 HttpServletResponse response)
            throws ServletException, IOException {

        List<Department> list = dao.getAll();
        request.setAttribute("list", list);
        request.getRequestDispatcher("department.jsp")
                .forward(request, response);
    }
private void insertDepartment(HttpServletRequest request,
                              HttpServletResponse response)
        throws ServletException, IOException {

    String name = request.getParameter("departmentname");

    // 1) Validate cơ bản
    String errorMsg = validateDepartmentName(name);
    if (errorMsg != null) {
        request.setAttribute("error", errorMsg);
        listDepartments(request, response);
        return;
    }

    String trimmed = name.trim();

    // 2) Check trùng tên (không phân biệt hoa thường)
    if (dao.existsByNameIgnoreCase(trimmed)) {
        request.setAttribute("error", "Department Name đã tồn tại (không phân biệt hoa thường)!");
        listDepartments(request, response);
        return;
    }

    // 3) Insert
    Department d = new Department();
    d.setDepartmentname(trimmed);
    dao.insert(d);

    response.sendRedirect("department");
}
 private void updateDepartment(HttpServletRequest request,
                              HttpServletResponse response)
        throws IOException, ServletException {

    int id = Integer.parseInt(request.getParameter("id"));
    String name = request.getParameter("departmentname");

    // 1) Validate cơ bản
    String errorMsg = validateDepartmentName(name);
    if (errorMsg != null) {
        request.setAttribute("error", errorMsg);
        showEditForm(request, response);
        return;
    }

    String trimmed = name.trim();
    
    // 2) Check trùng tên (bỏ qua chính nó)
    if (dao.existsByNameIgnoreCaseExceptId(trimmed, id)) {
        request.setAttribute("error", "Không được đổi thành Department Name đã tồn tại!");
        showEditForm(request, response);
        return;
    }

    // 3) Update
    Department d = new Department();
    d.setId(id);
    d.setDepartmentname(trimmed);
    dao.update(d);

    response.sendRedirect("department");
}

    
private void deleteDepartment(HttpServletRequest request,
                              HttpServletResponse response)
        throws IOException, ServletException {

    int id = Integer.parseInt(request.getParameter("id"));

    // Check trước khi xóa
    long studentCount = dao.countStudentsInDepartment(id);
    if (studentCount > 0) {
        request.setAttribute("error",
                "Không thể xóa Department vì đang có Student thuộc Department này!");
        listDepartments(request, response); // forward lại trang + hiện lỗi
        return;
    }

    dao.delete(id);
    response.sendRedirect("department");
}
    

    private void showEditForm(HttpServletRequest request,
                              HttpServletResponse response)
            throws ServletException, IOException {

        int id = Integer.parseInt(request.getParameter("id"));
        Department d = dao.findById(id);

        request.setAttribute("department", d);
        listDepartments(request, response);
    }
}