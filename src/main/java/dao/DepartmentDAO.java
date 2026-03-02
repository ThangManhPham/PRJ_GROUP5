package dao;

import entity.Department;
import jakarta.persistence.EntityManager;
import jakarta.persistence.TypedQuery;
import java.util.List;
import util.JPAUtil;

public class DepartmentDAO {

    // =========================
    // READ ALL
    // =========================
    public List<Department> getAll() {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            TypedQuery<Department> query =
                    em.createQuery("SELECT d FROM Department d", Department.class);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    // =========================
    // FIND BY ID
    // =========================
    public Department findById(int id) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.find(Department.class, id);
        } finally {
            em.close();
        }
    }
     public boolean existsByNameIgnoreCase(String name) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            String norm = name.trim().toLowerCase();
            Long cnt = em.createQuery(
                    "SELECT COUNT(d) FROM Department d " +
                    "WHERE LOWER(TRIM(d.departmentname)) = :n",
                    Long.class
            ).setParameter("n", norm).getSingleResult();
            return cnt > 0;
        } finally {
            em.close();
        }
    }
     public boolean existsByNameIgnoreCaseExceptId(String name, int id) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            String norm = name.trim().toLowerCase();
            Long cnt = em.createQuery(
                    "SELECT COUNT(d) FROM Department d " +
                    "WHERE d.id <> :id AND LOWER(TRIM(d.departmentname)) = :n",
                    Long.class
            ).setParameter("id", id)
             .setParameter("n", norm)
             .getSingleResult();
            return cnt > 0;
        } finally {
            em.close();
        }
    }
     public long countStudentsInDepartment(int depId) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.createQuery(
                    "SELECT COUNT(s) FROM Student s WHERE s.department.id = :depId",
                    Long.class
            ).setParameter("depId", depId)
             .getSingleResult();
        } finally {
            em.close();
        }
    }

    // =========================
    // INSERT
    // =========================
    public void insert(Department department) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            em.persist(department);
            em.getTransaction().commit();
        } catch (Exception e) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            throw e;
        } finally {
            em.close();
        }
    }

    // =========================
    // UPDATE
    // =========================
    public void update(Department department) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            em.merge(department);
            em.getTransaction().commit();
        } catch (Exception e) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            throw e;
        } finally {
            em.close();
        }
    }

    // =========================
    // DELETE
    // =========================
    public void delete(int id) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            Department department = em.find(Department.class, id);
            if (department != null) {
                em.getTransaction().begin();
                em.remove(department);
                em.getTransaction().commit();
            }
        } catch (Exception e) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            throw e;
        } finally {
            em.close();
        }
    }
}