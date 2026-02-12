/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

package dao;

import entity.Department;
import jakarta.persistence.EntityManager;
import util.JPAUtil;

import java.util.List;

/**
 *
 * @author HP
 */

public class DepartmentDAO {

    
    public List<Department> getAll() {
        EntityManager em = JPAUtil.getEntityManager();

        List<Department> list =
                em.createQuery("SELECT d FROM Department d", Department.class)
                        .getResultList();

        em.close();
        return list;
    }

   
    public Department findById(int id) {
        EntityManager em = JPAUtil.getEntityManager();
        Department d = em.find(Department.class, id);
        em.close();
        return d;
    }


    public void insert(Department d) {
        EntityManager em = JPAUtil.getEntityManager();

        em.getTransaction().begin();
        em.persist(d);
        em.getTransaction().commit();

        em.close();
    }


    public void update(Department d) {
        EntityManager em = JPAUtil.getEntityManager();

        em.getTransaction().begin();
        em.merge(d);
        em.getTransaction().commit();

        em.close();
    }


    public void delete(int id) {
        EntityManager em = JPAUtil.getEntityManager();

        em.getTransaction().begin();

        Department d = em.find(Department.class, id);
        if (d != null) {
            em.remove(d);
        }

        em.getTransaction().commit();
        em.close();
    }
}

