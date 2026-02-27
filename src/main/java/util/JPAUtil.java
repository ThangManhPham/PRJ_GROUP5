/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

package util;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;

/**
 *
 * @author HP
 */
public class JPAUtil {

    // TẠO DUY NHẤT 1 LẦN
    private static final EntityManagerFactory emf =
            Persistence.createEntityManagerFactory("PRJ_Group5_PU");

    public static EntityManager getEntityManager() {
        return emf.createEntityManager();
    }

    public static void close() {
        if (emf.isOpen()) {
            emf.close();
        }
    }
}
