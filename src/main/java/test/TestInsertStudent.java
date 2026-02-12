/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package test;

/**
 *
 * @author HP
 */
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;

import entity.Department;
import entity.Student;

import java.util.Date;

public class TestInsertStudent {

    public static void main(String[] args) {

        EntityManagerFactory emf =
                Persistence.createEntityManagerFactory("PRJ_Group5_PU");

        EntityManager em = emf.createEntityManager();

        try {
            em.getTransaction().begin();

            // Lấy Department có id = 1 (đã có sẵn trong DB)
            Department dept = em.find(Department.class, 1);

            // Tạo Student mới
            Student student = new Student();
            student.setStudentid("SE999");
            student.setName("Pham Manh Thang");
            student.setGpa(9.5);
            student.setDepartment(dept);
            student.setCreatedAt(new Date());
            student.setCreatedBy("manager");

            // Lưu vào database
            em.persist(student);

            em.getTransaction().commit();

            System.out.println("✅ INSERT STUDENT SUCCESS!");

        } catch (Exception e) {
            em.getTransaction().rollback();
            System.out.println("❌ INSERT FAILED!");
            e.printStackTrace();
        }

        em.close();
        emf.close();
    }
}

