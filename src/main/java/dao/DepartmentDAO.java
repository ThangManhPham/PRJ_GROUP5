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