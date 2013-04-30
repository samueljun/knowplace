import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.*;
import org.eclipse.jetty.server.Server;
import org.eclipse.jetty.servlet.*;

import java.sql.*;

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

    public void valueUnbound(HttpSessionBindingEven event) {
        // Roll back changes when removed from a Session
        // (or when the Session expires)
        try {
            if (con!= null) {
                con.rollback(); // abandon any uncomitted data
                con.close();
            }
        }
        catch (SQLException e) {
            // Report it
        }
    }
}

public class HelloWorld extends HttpServlet {

    public void init() throws ServletException {
        try {
            Class.forName("oracle.jbdc.driver.OracleDriver");
        }
        catch (ClassNotFoundException e) {
            System.out.println("Couldn't load OracleDriver");
            throw new UnavailableException("Couldn't load OracleDriver");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.getWriter().print("Hello from Java!\n");
        response.setContentType("text/plain");
        PrintWriter out = res.getWriter();

        HttpSession session = request.getSession(true);
        Connection con;

        synchronized (session) {
            ConnectionHolder holder = (ConnectionHolder) session.getAttribute("servletapp.connection");

            if (holder == null) {
                try {
                    holder = new ConnectionHolder(DriverManager.getConnection("us-cdbr-east-03.cleardb.com","b5965fbb74b8d2","940be6f5"));
                    session.setAttribute("servletapp.connection", holder);
                }
                catch (SQLException e) {
                    log("Couldn't get db connection", e);
                }
            }

            con = holder.getConnection();
        }

        try {
            Statement stmt = con.createStatement();
            stmt.execute("SHOW TABLES");
        }
        catch (Exception e) {
            try {
                con.rollback();
                session.removeAttribute("servletapp.connection");
            }
            catch (Exception ignored) {
            }
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

