/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package entity;
import jakarta.persistence.*;
/**
 *
 * @author HP
 */


@Entity
@Table(name = "departments")
public class Department {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @Column(name = "departmentname", nullable = false, length = 50)
    private String departmentName;

    public Department() {
    }

    public Department(String departmentName) {
        this.departmentName = departmentName;
    }

    public int getId() {
        return id;
    }

    public String getDepartmentName() {
        return departmentName;
    }

    public void setDepartmentName(String departmentName) {
        this.departmentName = departmentName;
    }
}

