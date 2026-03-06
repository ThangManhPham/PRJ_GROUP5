/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package listener;

import jakarta.servlet.ServletContext;
import jakarta.servlet.http.HttpSessionEvent;
import jakarta.servlet.http.HttpSessionListener;
import jakarta.servlet.annotation.WebListener;

/**
 *
 * @author HP
 */

@WebListener
public class OnlineUserListener implements HttpSessionListener {

    @Override
    public void sessionCreated(HttpSessionEvent se) {

        ServletContext context = se.getSession().getServletContext();

        int onlineUsers = (int) context.getAttribute("onlineUsers");
        onlineUsers++;

        context.setAttribute("onlineUsers", onlineUsers);

        System.out.println("User connected. Online users: " + onlineUsers);
    }

    @Override
    public void sessionDestroyed(HttpSessionEvent se) {

        ServletContext context = se.getSession().getServletContext();

        int onlineUsers = (int) context.getAttribute("onlineUsers");
        onlineUsers--;

        context.setAttribute("onlineUsers", onlineUsers);

        System.out.println("User disconnected. Online users: " + onlineUsers);
    }
}