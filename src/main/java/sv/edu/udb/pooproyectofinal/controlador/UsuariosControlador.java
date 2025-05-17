package sv.edu.udb.pooproyectofinal.controlador;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import sv.edu.udb.pooproyectofinal.modelo.Usuarios;
import sv.edu.udb.pooproyectofinal.util.Conexion;
import org.mindrot.jbcrypt.BCrypt;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet(name = "UsuariosControlador", urlPatterns = {"/login"})
public class UsuariosControlador extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(UsuariosControlador.class.getName());
    private static final long serialVersionUID = 1L;
    private static final int MAX_INACTIVE_INTERVAL = 30 * 60; // 30 minutos en segundos

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        // Validación básica de campos
        if (username == null || username.isEmpty() || password == null || password.isEmpty()) {
            handleError(request, response, "Usuario y contraseña son requeridos");
            return;
        }

        try (Connection conn = Conexion.getConnection()) {
            Usuarios usuario = validarUsuario(conn, username, password);

            if (usuario != null) {
                HttpSession session = request.getSession();
                session.setAttribute("usuario", usuario);
                session.setMaxInactiveInterval(MAX_INACTIVE_INTERVAL);

                // Protección contra session fixation
                request.changeSessionId();

                response.sendRedirect(request.getContextPath() + "/index.jsp");
            } else {
                handleError(request, response, "Credenciales incorrectas");
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error de base de datos", e);
            handleError(request, response, "Error en el sistema. Por favor intente más tarde.");
        }
    }

    private Usuarios validarUsuario(Connection conn, String username, String password) throws SQLException {
        Usuarios usuario = null;
        String query = "SELECT username, email, password FROM usuarios WHERE username = ?";

        try (PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setString(1, username);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    String storedHash = rs.getString("password");

                    // Verificar contraseña con BCrypt
                    if (BCrypt.checkpw(password, storedHash)) {
                        usuario = new Usuarios();
                        usuario.setUsername(rs.getString("username"));
                        usuario.setEmail(rs.getString("email"));
                    }
                }
            }
        }
        return usuario;
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Redirige a login.jsp pero usando el contexto correcto
        response.sendRedirect(request.getContextPath() + "/login");
    }

    private void handleError(HttpServletRequest request, HttpServletResponse response, String errorMessage)
            throws ServletException, IOException {
        request.setAttribute("error", errorMessage);
        request.getRequestDispatcher("/login").forward(request, response);
    }
}