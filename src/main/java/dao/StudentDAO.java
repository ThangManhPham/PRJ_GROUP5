/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;
import entity.Student;
import util.JPAUtil;
        
import java.util.List;

/**
 *
 * @author HP
 */

public class StudentDAO {

    // ===== 1. Get All =====
    public List<Student> getAll() {
        EntityManager em = JPAUtil.getEntityManager();

        List<Student> list =
                em.createQuery("SELECT s FROM Student s", Student.class)
                        .getResultList();

        em.close();
        return list;
    }

    // ===== 2. Insert =====
    public void insert(Student student) {
        EntityManager em = JPAUtil.getEntityManager();

        em.getTransaction().begin();
        em.persist(student);
        em.getTransaction().commit();

        em.close();
    }

    // ===== 3. Find By ID =====
    public Student findById(Integer id) {
        EntityManager em = JPAUtil.getEntityManager();

        Student s = em.find(Student.class, id);

        em.close();
        return s;
    }

    // ===== 4. Update =====
    public void update(Student student) {
        EntityManager em = JPAUtil.getEntityManager();

        em.getTransaction().begin();
        em.merge(student);
        em.getTransaction().commit();

        em.close();
    }

    // ===== 5. Delete =====
    public void delete(Integer id) {
        EntityManager em = JPAUtil.getEntityManager();

        em.getTransaction().begin();

        Student s = em.find(Student.class, id);
        if (s != null) {
            em.remove(s);
        }

        em.getTransaction().commit();
        em.close();
    }
}