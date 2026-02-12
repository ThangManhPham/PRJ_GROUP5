/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;

/**
 *
 * @author HP
 */

public class TestConnection {

    public static void main(String[] args) {

        try {
            EntityManagerFactory emf =
                    Persistence.createEntityManagerFactory("PRJ_Group5_PU");

            EntityManager em = emf.createEntityManager();

            System.out.println("   JPA CONNECTED SUCCESSFULLY!");

            em.close();
            emf.close();

        } catch (Exception e) {
            System.out.println(" JPA CONNECTION FAILED!");
            e.printStackTrace();
        }
    }
}

