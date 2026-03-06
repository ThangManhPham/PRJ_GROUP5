/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package listener;

import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;

/**
 *
 * @author HP
 */

@WebListener
public class AppContextListener implements ServletContextListener {

    @Override
    public void contextInitialized(ServletContextEvent sce) {

        System.out.println("=================================");
        System.out.println(" Student Management System START ");
        System.out.println("=================================");

        sce.getServletContext().setAttribute("onlineUsers", 0);
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {

        System.out.println("=================================");
        System.out.println(" Student Management System STOP ");
        System.out.println("=================================");

    }
}
