/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package test;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;
import entity.Student;

import java.util.List;

public class TestQueryStudent {

    public static void main(String[] args) {

        EntityManagerFactory emf =
                Persistence.createEntityManagerFactory("PRJ_Group5_PU");

        EntityManager em = emf.createEntityManager();

        try {

            List<Student> list =
                    em.createQuery("SELECT s FROM Student s", Student.class)
                            .getResultList();

            for (Student s : list) {
                System.out.println(
                        s.getStudentid() + " | " +
                        s.getName() + " | " +
                        s.getGpa() + " | " +
                        s.getDepartment().getDepartmentname()
                );
            }

            System.out.println("✅ QUERY SUCCESS!");

        } catch (Exception e) {
            System.out.println("❌ QUERY FAILED!");
            e.printStackTrace();
        }

        em.close();
        emf.close();
    }
}
