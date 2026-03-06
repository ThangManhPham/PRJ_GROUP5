/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package listener;

import jakarta.servlet.http.HttpSessionAttributeListener;
import jakarta.servlet.http.HttpSessionBindingEvent;
import jakarta.servlet.annotation.WebListener;

/**
 *
 * @author HP
 */

@WebListener
public class LoginListener implements HttpSessionAttributeListener {

    @Override
    public void attributeAdded(HttpSessionBindingEvent event) {

        if ("user".equals(event.getName())) {

            System.out.println("User logged in: " + event.getValue());
        }
    }

    @Override
    public void attributeRemoved(HttpSessionBindingEvent event) {

        if ("user".equals(event.getName())) {

            System.out.println("User logged out: " + event.getValue());
        }
    }

    @Override
    public void attributeReplaced(HttpSessionBindingEvent event) {

        if ("user".equals(event.getName())) {

            System.out.println("User changed session: " + event.getValue());
        }
    }
}
