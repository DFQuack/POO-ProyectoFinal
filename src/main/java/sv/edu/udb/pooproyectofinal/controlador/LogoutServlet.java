package sv.edu.udb.pooproyectofinal.controlador;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(name = "LogoutServlet", urlPatterns = "/logout")
public class LogoutServlet extends HttpServlet{
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 1. Invalidar la sesión actual
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();  // Elimina todos los atributos de la sesión
        }

        // 2. Redirigir al login con mensaje de éxito (opcional)
        request.getSession().setAttribute("success", "Has cerrado sesión correctamente");
        response.sendRedirect(request.getContextPath() + "/login");
    }
}
