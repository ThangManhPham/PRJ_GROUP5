/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import jakarta.persistence.EntityManager;
import entity.UserAccount;
import util.JPAUtil;

import java.util.List;

/**
 *
 * @author HP
 */

public class UserAccountDAO {

    // ===== 1. Get All =====
    public List<UserAccount> getAll() {
        EntityManager em = JPAUtil.getEntityManager();

        List<UserAccount> list =
                em.createQuery("SELECT u FROM UserAccount u", UserAccount.class)
                        .getResultList();

        em.close();
        return list;
    }

    // ===== 2. Find By ID =====
    public UserAccount findById(Integer id) {
        EntityManager em = JPAUtil.getEntityManager();

        UserAccount u = em.find(UserAccount.class, id);

        em.close();
        return u;
    }

    // ===== 3. Find By Username =====
    public UserAccount findByUsername(String username) {
        EntityManager em = JPAUtil.getEntityManager();

        UserAccount u = null;

        try {
            u = em.createQuery(
                    "SELECT u FROM UserAccount u WHERE u.username = :username",
                    UserAccount.class)
                    .setParameter("username", username)
                    .getSingleResult();
        } catch (Exception e) {
            u = null;
        }

        em.close();
        return u;
    }

    // ===== 4. Check Login =====
    public UserAccount checkLogin(String username, String password) {
        EntityManager em = JPAUtil.getEntityManager();

        UserAccount u = null;

        try {
            u = em.createQuery(
                    "SELECT u FROM UserAccount u WHERE u.username = :username AND u.password = :password",
                    UserAccount.class)
                    .setParameter("username", username)
                    .setParameter("password", password)
                    .getSingleResult();
        } catch (Exception e) {
            u = null;
        }

        em.close();
        return u;
    }

    // ===== 5. Insert =====
    public void insert(UserAccount user) {
        EntityManager em = JPAUtil.getEntityManager();

        em.getTransaction().begin();
        em.persist(user);
        em.getTransaction().commit();

        em.close();
    }

    // ===== 6. Update =====
    public void update(UserAccount user) {
        EntityManager em = JPAUtil.getEntityManager();

        em.getTransaction().begin();
        em.merge(user);
        em.getTransaction().commit();

        em.close();
    }

    // ===== 7. Delete =====
    public void delete(Integer id) {
        EntityManager em = JPAUtil.getEntityManager();

        em.getTransaction().begin();

        UserAccount u = em.find(UserAccount.class, id);
        if (u != null) {
            em.remove(u);
        }

        em.getTransaction().commit();
        em.close();
    }
}

