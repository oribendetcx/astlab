import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import cnt.Security.*;

import java.lang.StringBuffer;
import java.sql;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.ResultSet;

import javax.servlet.http.HttpServletRequest;

// Class Declarati
class Login
{
    public static void main(String[] args)   
    {
        try {
            String email = request.getParameter("email");
            String token = request.getParameter("password");

            String sql = "select * from users where (email ='" + email +"' and password ='" + token + "')";

            Connection connection = pool.getConnection();
            Statement statement = connection.createStatement();
            
            HttpSession session = request.getSession();
            String role = (String)session.getAttribute("role");
            if (role.equals(ADMIN)) {
                ResultSet result = statement.executeQuery(sql);
                statement.close();
                connection.close();
            }

            if (result.next()) {
                loggedIn = true;
                // Successfully logged in and redirect to user profile page
            
            } else {
             // Auth failure - Redirect to Login Page
            }
        }
        catch (SQLException ex) {
            handleExceptions(ex);
        }
        finally {
            statement.close();
            connection.close();
        }
    }
} 
