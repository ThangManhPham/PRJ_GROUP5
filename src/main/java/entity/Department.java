/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package entity;
import jakarta.persistence.*;
import java.util.List;

/**
 *
 * @author HP
 */
@Entity
@Table(name = "departments")
public class Department {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column(name = "departmentname", nullable = false, length = 50)
    private String departmentname;

    @OneToMany(mappedBy = "department")
    private List<Student> students;

    public Department() {
    }

    public Department(String departmentname) {
        this.departmentname = departmentname;
    }

    public Integer getId() {
        return id;
    }

    public String getDepartmentname() {
        return departmentname;
    }

    public void setDepartmentname(String departmentname) {
        this.departmentname = departmentname;
    } 
    public void setId(Integer id) {
    this.id = id;
}
}