package dao;

import entity.Student;
import jakarta.persistence.*;

import java.time.LocalDateTime;
import java.util.List;

public class StudentDAO {

    private EntityManagerFactory emf
            = Persistence.createEntityManagerFactory("PRJ_Group5_PU");

    // ===============================
    // 1. STAFF – GET ALL
    // ===============================
    public List<Student> getAll() {
        EntityManager em = emf.createEntityManager();
        List<Student> list
                = em.createQuery("SELECT s FROM Student s", Student.class)
                        .getResultList();
        em.close();
        return list;
    }

    // ===============================
    // 2. MANAGER – TOP 5 GPA
    // ===============================
    public List<Student> getTop5ByGpa() {
        EntityManager em = emf.createEntityManager();
        List<Student> list
                = em.createQuery("SELECT s FROM Student s ORDER BY s.gpa DESC", Student.class)
                        .setMaxResults(5)
                        .getResultList();
        em.close();
        return list;
    }

    // ===============================
    // 3. GET BY ID
    // ===============================
    public Student getById(int id) {
        EntityManager em = emf.createEntityManager();
        Student s = em.find(Student.class, id);
        em.close();
        return s;
    }

    // ===============================
    // 4. INSERT
    // ===============================
    public void insert(Student s) {
        EntityManager em = emf.createEntityManager();
        EntityTransaction tx = em.getTransaction();

        try {
            tx.begin();
            LocalDateTime now = LocalDateTime.now();
            s.setCreatedAt(now);
            s.setUpdatedAt(now); 
            em.persist(s);
            tx.commit();
        } catch (Exception e) {
            tx.rollback();
            e.printStackTrace();
        } finally {
            em.close();
        }
    }

    // ===============================
    // 5. UPDATE
    // ===============================
    public void update(Student s) {
        EntityManager em = emf.createEntityManager();
        EntityTransaction tx = em.getTransaction();

        try {
            tx.begin();
            s.setUpdatedAt(LocalDateTime.now());
            em.merge(s);
            tx.commit();
        } catch (Exception e) {
            tx.rollback();
            e.printStackTrace();
        } finally {
            em.close();
        }
    }

    // ===============================
    // 6. DELETE
    // ===============================
    public void delete(int id) {
        EntityManager em = emf.createEntityManager();
        EntityTransaction tx = em.getTransaction();

        try {
            tx.begin();
            Student s = em.find(Student.class, id);
            if (s != null) {
                em.remove(s);
            }
            tx.commit();
        } catch (Exception e) {
            tx.rollback();
            e.printStackTrace();
        } finally {
            em.close();
        }
    }
    // === CHECK TRÙNG StudentID (create) ===

    public boolean existsStudentId(String studentId) {
        EntityManager em = emf.createEntityManager();
        try {
            String norm = studentId == null ? "" : studentId.trim().toLowerCase();
            Long cnt = em.createQuery(
                    "SELECT COUNT(s) FROM Student s "
                    + "WHERE LOWER(TRIM(s.studentId)) = :sid",
                    Long.class
            ).setParameter("sid", norm)
                    .getSingleResult();
            return cnt != null && cnt > 0;
        } finally {
            em.close();
        }
    }

// === CHECK TRÙNG StudentID (update) - loại trừ chính nó ===
    public boolean existsStudentIdExceptId(String studentId, int id) {
        EntityManager em = emf.createEntityManager();
        try {
            Long cnt = em.createQuery(
                    "SELECT COUNT(s) FROM Student s WHERE s.studentId = :sid AND s.id <> :id", Long.class)
                    .setParameter("sid", studentId)
                    .setParameter("id", id)
                    .getSingleResult();
            return cnt != null && cnt > 0;
        } finally {
            em.close();
        }
    }
    
}
