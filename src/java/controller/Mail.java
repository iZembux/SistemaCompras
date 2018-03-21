package controller;

import java.util.Properties;
import javax.mail.Address;
import javax.mail.Message;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;
import javax.mail.MessagingException;

public class Mail {

    public boolean enviarCorreo(String para, String nombre, String apellido, String mensaje) {
        String asunto = "Sistema de Compras";
        boolean enviado = false;
        try {
            Properties properties = new Properties();
            properties.put("mail.smtp.host", "mail.continental.com.mx");
            properties.put("mail.smtp.starttls.enable", "true");
            properties.setProperty("mail.smtp.port", "2525");
            properties.put("mail.smtp.mail.sender", "intranet@continental.com.mx");
            properties.put("mail.smtp.user", "intranet@continental.com.mx");
            properties.put("mail.smtp.auth", "true");
            Session sesssion = Session.getDefaultInstance(properties);

            try {
                Address correo = new InternetAddress(para);
                MimeBodyPart texto = new MimeBodyPart();
                String mensajeCorreo = "Estimad@ " + nombre + " " + apellido + ", " + mensaje;
                texto.setText(mensajeCorreo);

                MimeMultipart multiParte = new MimeMultipart();
                multiParte.addBodyPart(texto);

                Message message = new MimeMessage(sesssion);
                message.setFrom(new InternetAddress((String) properties.get("mail.smtp.mail.sender")));
                message.setRecipient(Message.RecipientType.TO, correo);
                message.setSubject(asunto);
                message.setContent(multiParte);

                Transport t = sesssion.getTransport("smtp");
                t.connect((String) properties.get("mail.smtp.user"), "CONT-CS01");
                t.sendMessage(message, message.getAllRecipients());
                t.close();
                enviado = true;
            } catch (MessagingException e) {
                System.out.println("ERROR AL ENVIAR CORREO: " + e);
            }
        } catch (Exception e) {
            System.out.println("ERROR AL ENVIAR CORREO: " + e);
        }
        return enviado;
    }
    
    public boolean enviarCorreo2(String para, String asunto) {
        boolean enviado = false;
        try {
            Properties properties = new Properties();
            properties.put("mail.smtp.host", "mail.continental.com.mx");
            properties.put("mail.smtp.starttls.enable", "true");
            properties.setProperty("mail.smtp.port", "2525");
            properties.put("mail.smtp.mail.sender", "intranet@continental.com.mx");
            properties.put("mail.smtp.user", "intranet@continental.com.mx");
            properties.put("mail.smtp.auth", "true");
            Session sesssion = Session.getDefaultInstance(properties);

            try {
                Address correo = new InternetAddress(para);
                MimeBodyPart texto = new MimeBodyPart();
                String mensajeCorreo = "";
                texto.setText(mensajeCorreo);

                MimeMultipart multiParte = new MimeMultipart();
                multiParte.addBodyPart(texto);

                Message message = new MimeMessage(sesssion);
                message.setFrom(new InternetAddress((String) properties.get("mail.smtp.mail.sender")));
                message.setRecipient(Message.RecipientType.TO, correo);
                message.setSubject(asunto);
                message.setContent(multiParte);

                Transport t = sesssion.getTransport("smtp");
                t.connect((String) properties.get("mail.smtp.user"), "CONT-CS01");
                t.sendMessage(message, message.getAllRecipients());
                t.close();
                enviado = true;
            } catch (MessagingException e) {
                System.out.println("ERROR AL ENVIAR CORREO: " + e);
            }
        } catch (Exception e) {
            System.out.println("ERROR AL ENVIAR CORREO: " + e);
        }
        return enviado;
    }
}
