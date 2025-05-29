package sv.edu.udb.pooproyectofinal.controlador;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import sv.edu.udb.pooproyectofinal.modelo.Cotizaciones;
import sv.edu.udb.pooproyectofinal.util.Conexion;

import java.io.IOException;
import java.sql.*;

@WebServlet(name = "CotizacionesControlador", urlPatterns = "/CotizacionesControlador")
public class CotizacionesControlador extends HttpServlet {

    public void doGet(HttpServletRequest request, HttpServletResponse response) {
        try {
            ProcessRequest(request, response);
        } catch (SQLException | ServletException | IOException e) {
            throw new RuntimeException(e);
        }
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response) {
        try {
            ProcessRequest(request, response);
        } catch (SQLException | ServletException | IOException e) {
            throw new RuntimeException(e);
        }
    }

    protected void ProcessRequest(HttpServletRequest request, HttpServletResponse response) throws SQLException, ServletException, IOException {
        Connection conn = Conexion.getConnection();
        Statement st = conn.createStatement();
        PreparedStatement pst;
        ResultSet rs;
        Cotizaciones cot = new Cotizaciones();
        StringBuilder html = new StringBuilder();
        boolean hayDatos = false;

        String accion = request.getParameter("accion");
        switch (accion) {
            case "tabla": // Para mostrar la tabla con los datos
                rs = st.executeQuery("SELECT * FROM vista_cotizaciones");
                while (rs.next()) {
                    // Se obtiene el carnet por separado para adjuntarlo más fácilmente en los enlaces GET
                    cot.setId(rs.getInt("id"));
                    // Generación de fila de datos
                    html.append("<tr>");
                    html.append("<td>").append(cot.getId()).append("</td>");
                    html.append("<td>").append(rs.getString("nombre")).append("</td>");
                    html.append("<td>").append(rs.getInt("num_horas")).append("</td>");
                    html.append("<td>").append(rs.getDate("fecha_inicio")).append("</td>");
                    html.append("<td>").append(rs.getDate("fecha_fin")).append("</td>");
                    html.append("<td>").append(rs.getString("estado")).append("</td>");
                    html.append("<td>").append(rs.getDouble("costo_asignaciones")).append("</td>");
                    html.append("<td>").append(rs.getDouble("costos_adicionales")).append("</td>");
                    html.append("<td>").append(rs.getDouble("costo_total")).append("</td>");
                    // Botón para editar
                    html.append("<td><div class=\"btn-group\">");
                    html.append("<a href=\"CotizacionesControlador?accion=form&editar=true&id=");
                    html.append(cot.getId());
                    html.append("\" class=\"btn btn-cotiz\">Editar</a>");
                    // Botón para eliminar
                    html.append("<a href=\"CotizacionesControlador?accion=pag-borrar&id=");
                    html.append(cot.getId());
                    html.append("\" class=\"btn btn-cotiz\">Eliminar</a>");
                    html.append("</div></td>");
                    html.append("</tr>");
                    hayDatos = true;
                }
                if (!hayDatos) {
                    html.append("No hay datos en esta tabla.");
                }
                request.setAttribute("resultado", html.toString());
                request.getRequestDispatcher("vistas/cotizaciones-lista.jsp").forward(request, response);
                break;
            case "form":
                break;
        }
    }
}