import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.*;
import org.eclipse.jetty.server.Server;
import org.eclipse.jetty.servlet.*;

import java.net.URI;
import java.net.URISyntaxException;
import java.sql.*;
/*
class ConnectionHolder implements HttpSessionBindingListener {
    private Connection con = null;

    public ConnectionHolder(Connection con) {
        // Save the Connection
        this.con = con;
        try {
            con.setAutoCommit(false); // transactions can extend between web pages!
        }
        catch (SQLException e) {
            // Perform error handling
        }
    }

    public Connection getConnection() {
        return con; // return the cargo
    }

    public void valueBound(HttpSessionBindingEvent event) {
        // Do nothing when added to a Session
    }

    public void valueUnbound(HttpSessionBindingEvent event) {
        // Roll back changes when removed from a Session
        // (or when the Session expires)
        try {
            if (con != null) {
                con.rollback(); // abandon any uncomitted data
                con.close();
            }
        }
        catch (SQLException e) {
            // Report it
        }
    }
}
*/



public class HelloWorld extends HttpServlet {

    private static Connection getConnection() throws URISyntaxException, SQLException {
        URI dbUri = new URI(System.getenv("DATABASE_URL"));
        
        String username = dbUri.getUserInfo().split(":")[0];
        String password = dbUri.getUserInfo().split(":")[1];
        String dbUrl = "jdbc:postgresql://" + dbUri.getHost() + dbUri.getPath();
        
        return DriverManager.getConnection(dbUrl, username, password);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.getWriter().print("Hello from Java!\n");
        try {
            Connection connection = getConnection();
            
            Statement stmt = connection.createStatement();
            stmt.executeUpdate("DROP TABLE IF EXISTS ticks");
            stmt.executeUpdate("CREATE TABLE ticks (tick timestamp)");
            stmt.executeUpdate("INSERT INTO ticks VALUES (now())");
            ResultSet rs = stmt.executeQuery("SELECT tick FROM ticks");
            while (rs.next()) {
                response.getWriter().print("Read from DB: " + rs.getTimestamp("tick"));
            }
        }
        catch (SQLException se) {
            response.getWriter().print("SQLException");
        }
        catch (URISyntaxException ue) {
            response.getWriter().print("URISyntaxException");
        }
    }

    private static void test() throws SQLException, URISyntaxException {

        Connection connection = getConnection();

        Statement stmt = connection.createStatement();
        stmt.executeUpdate("DROP TABLE IF EXISTS ticks");
        stmt.executeUpdate("CREATE TABLE ticks (tick timestamp)");
        stmt.executeUpdate("INSERT INTO ticks VALUES (now())");
        ResultSet rs = stmt.executeQuery("SELECT tick FROM ticks");
        while (rs.next()) {
            System.out.println("Read from DB: " + rs.getTimestamp("tick"));
        }
    }

    public static void main(String[] args) throws Exception{
        Server server = new Server(Integer.valueOf(System.getenv("PORT")));
        ServletContextHandler context = new ServletContextHandler(ServletContextHandler.SESSIONS);
        context.setContextPath("/");
        server.setHandler(context);
        context.addServlet(new ServletHolder(new HelloWorld()),"/*");
        server.start();
        server.join();   
    }
}

