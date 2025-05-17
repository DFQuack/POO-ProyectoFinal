package sv.edu.udb.pooproyectofinal.controlador;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import sv.edu.udb.pooproyectofinal.modelo.Usuarios;
import sv.edu.udb.pooproyectofinal.modelo.UsuariosDAO;

import java.io.IOException;

@WebServlet(name = "RegistroControlador", value = "/registro")
public class RegistroControlador extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Redirige directamente al JSP en la raíz de webapp
        request.getRequestDispatcher("/registro.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");

        if (!password.equals(confirmPassword)) {
            request.setAttribute("error", "Las contraseñas no coinciden");
            request.getRequestDispatcher("/registro.jsp").forward(request, response);
            return;
        }

        Usuarios nuevoUsuario = new Usuarios(username, email, password);
        UsuariosDAO usuariosDAO = new UsuariosDAO();

        if (usuariosDAO.crearUsuario(nuevoUsuario, password)) {
            // Redirección absoluta al contexto de la aplicación
            response.sendRedirect(request.getContextPath() + "/login.jsp");
        } else {
            request.setAttribute("error", "Error al registrar usuario");
            request.getRequestDispatcher("/registro.jsp").forward(request, response);
        }
    }
}