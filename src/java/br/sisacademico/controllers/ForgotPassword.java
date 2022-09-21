package br.sisacademico.controllers;

import br.sisacademico.dao.UsuarioDAO;
import java.io.IOException;
import java.security.Security;
import java.util.Properties;
import java.util.Random;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class ForgotPassword
 */
@WebServlet("/forgotPassword")
public class ForgotPassword extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        RequestDispatcher dispatcher = null;
        int otpvalue = 0;
        UsuarioDAO u = new UsuarioDAO();
        HttpSession mySession = request.getSession();

        if (email != null || !email.equals("")) {
            if (u.verificaUsuario(email) == false) {
                request.setAttribute("erro", "erro");
                dispatcher = request.getRequestDispatcher("forgotPassword.jsp");
                dispatcher.forward(request, response);
            }
            // sending otp
            Random rand = new Random();
            otpvalue = rand.nextInt(1255650);
            Security.addProvider(new com.sun.net.ssl.internal.ssl.Provider());
            String to = email;// change accordingly
            // Get the session object
            Properties prop = new Properties();
            prop.put("mail.smtp.auth", true);
            prop.put("mail.smtp.ssl.enable", true);
            prop.put("mail.smtp.host", "smtp.gmail.com");
            prop.put("mail.smtp.port", "465");
            Session session = Session.getInstance(prop, new javax.mail.Authenticator() {
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication("wennisrocha@gmail.com", "ujbfmgnqhoqpbhka");// Put your email
                }
            });
            // compose message
            try {
                MimeMessage message = new MimeMessage(session);
                message.setFrom(new InternetAddress(email));// change accordingly
                message.addRecipient(Message.RecipientType.TO, new InternetAddress(to));
                message.setSubject("Reset de Senha - SisAcadêmico");
                message.setText("Seu código é: " + otpvalue);
                // send message
                Transport.send(message);
                System.out.println("message sent successfully");
            } catch (MessagingException e) {
                throw new RuntimeException(e);
            }
            dispatcher = request.getRequestDispatcher("EnterOtp.jsp");
            request.setAttribute("message", "Foi encaminhada ao seu e-mail o código para o reset de senha");
            //request.setAttribute("connection", con);
            mySession.setAttribute("otp", otpvalue);
            mySession.setAttribute("email", email);
            dispatcher.forward(request, response);
            //request.setAttribute("status", "success");
        }

    }

}
