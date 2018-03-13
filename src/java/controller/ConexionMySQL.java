package controller;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class ConexionMySQL {

    public ConexionMySQL(){}
    
    public static Connection conectar(){
        String host="localhost";
        String sid="scompras";
        String usuario="root";
        String contrasena="stmsc0nt";
        String cadenaconexion;
        cadenaconexion="jdbc:mysql://" + host +"/"+ sid;
        Connection connx;
        try {
            Class.forName("com.mysql.jdbc.Driver");
        }
        catch(ClassNotFoundException e){
            System.out.println("Ocurrio el siguiente error driver 1: "+e.getMessage());
            return null;
        }        
        try{
            connx=DriverManager.getConnection(cadenaconexion, usuario, contrasena);
            //System.out.println("Conexion Exitosa");
            return connx;
        }
        catch(SQLException e){
            System.out.println("Ocurrio el siguiente error al conectar:" +e.getMessage());
            return null;
        }
    }
}
