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

        if (action.equals("add")) {
            insertDepartment(request, response);
        } else if (action.equals("update")) {
            updateDepartment(request, response);
        }
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
    
    if (name == null || name.trim().isEmpty()) {
            request.setAttribute("error", "Department name không được để trống!");
            listDepartments(request, response);
            return;
        }

    if (name == null || name.trim().length() < 5 || name.trim().length() > 50) {

        request.setAttribute("error",
                "Department name must be between 5 and 50 characters!");

        listDepartments(request, response); // forward lại trang
        return;
    }
    
     String trimmed = name.trim();
        if (dao.existsByNameIgnoreCase(trimmed)) {
            request.setAttribute("error", "Department name đã tồn tại!");
            listDepartments(request, response);
            return;
        }
    
    

    Department d = new Department();
    d.setDepartmentname(name.trim());

    dao.insert(d);

    response.sendRedirect("department");
}

    private void updateDepartment(HttpServletRequest request,
                                  HttpServletResponse response)
            throws  IOException, ServletException {

        int id = Integer.parseInt(request.getParameter("id"));
        String name = request.getParameter("departmentname");
        
        if (name == null || name.trim().isEmpty()) {
            request.setAttribute("error", "Department name không được để trống!");
            // giữ form edit + list
            showEditForm(request, response);
            return;
        }

        if (name == null || name.trim().length() < 5 || name.trim().length() > 50) {
            response.sendRedirect("department?error=invalid");
            return;
        }
        
        String trimmed = name.trim();
        if (dao.existsByNameIgnoreCaseExceptId(trimmed, id)) {
            request.setAttribute("error", "Không được đổi thành tên Department đã tồn tại!");
            showEditForm(request, response);
            return;
        }

        Department d = new Department();
        d.setId(id);
        d.setDepartmentname(name.trim());

        dao.update(d);

        response.sendRedirect("department");
    }

    private void deleteDepartment(HttpServletRequest request,
                                  HttpServletResponse response)
            throws IOException {

        int id = Integer.parseInt(request.getParameter("id"));
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