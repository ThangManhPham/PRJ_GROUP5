/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */


function validateStudentForm() {
    // Lấy đúng ID sẽ đặt trong file JSP
    let sid = document.getElementById("studentid");
    let name = document.getElementById("name");
    let gpa = document.getElementById("gpa");

    // Reset style
    [sid, name, gpa].forEach(el => el.classList.remove("error-border"));

    if (sid.value.trim() === "") {
        alert("Mã sinh viên (studentid) không được để trống!");
        sid.classList.add("error-border");
        return false;
    }
    if (name.value.trim() === "") {
        alert("Tên không được để trống!");
        name.classList.add("error-border");
        return false;
    }
    // GPA khớp với kiểu Double trong Class Student
    if (gpa.value !== "" && (isNaN(gpa.value) || gpa.value < 0 || gpa.value > 10)) {
        alert("GPA phải là số từ 0-10");
        gpa.classList.add("error-border");
        return false;
    }
    return true;
    //register
    function validateRegisterForm() {
    let u = document.getElementById("reg_user").value;
    let p = document.getElementById("reg_pass").value;
    
    if(u.length < 5) {
        alert("Tài khoản phải từ 5 ký tự trở lên!");
        return false;
    }
    if(p.length < 6) {
        alert("Mật khẩu phải từ 6 ký tự để bảo mật!");
        return false;
    }
    return true;
}
}