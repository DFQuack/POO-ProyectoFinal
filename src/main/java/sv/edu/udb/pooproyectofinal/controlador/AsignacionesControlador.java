package sv.edu.udb.pooproyectofinal.controlador;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import sv.edu.udb.pooproyectofinal.modelo.Asignaciones;
import sv.edu.udb.pooproyectofinal.util.Conexion;

import java.io.IOException;
import java.sql.*;

@WebServlet(name = "AsignacionesControlador", urlPatterns = "/AsignacionesControlador")
public class AsignacionesControlador extends HttpServlet {

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
        Asignaciones asi = new Asignaciones();
        StringBuilder html = new StringBuilder();
        boolean hayDatos = false;

        String accion = request.getParameter("accion");
        switch (accion) {
            case "tabla": // Para mostrar la tabla con los datos
                rs = st.executeQuery("SELECT * FROM vista_asignaciones");
                while (rs.next()) {
                    // Se obtiene el id por separado para adjuntarlo más fácilmente en los enlaces GET
                    asi.setId(rs.getInt("id"));
                    // Generación de fila de datos
                    html.append("<tr>");
                    html.append("<td>").append(asi.getId()).append("</td>");
                    html.append("<td>").append(rs.getInt("id_cotizacion")).append("</td>");
                    html.append("<td>").append(rs.getString("titulo")).append("</td>");
                    html.append("<td>").append(rs.getString("nombre")).append("</td>");
                    html.append("<td>").append(rs.getString("area")).append("</td>");
                    html.append("<td>").append(rs.getString("tiempo_inicio")).append("</td>");
                    html.append("<td>").append(rs.getString("tiempo_fin")).append("</td>");
                    html.append("<td>").append(rs.getDouble("costo_hora")).append("</td>");
                    html.append("<td>").append(rs.getInt("num_horas")).append("</td>");
                    html.append("<td>").append(rs.getDouble("costo_base")).append("</td>");
                    html.append("<td>").append(rs.getInt("incremento_extra")).append("</td>");
                    html.append("<td>").append(rs.getDouble("costo_total")).append("</td>");
                    // Botón para editar
                    html.append("<td><div class=\"btn-group\">");
                    html.append("<a href=\"AsignacionesControlador?accion=editar&id=");
                    html.append(asi.getId());
                    html.append("\" class=\"btn btn-cotiz\">Editar</a>");
                    // Botón para eliminar
                    html.append("<a href=\"AsignacionesControlador?accion=pag-borrar&id=");
                    html.append(asi.getId());
                    html.append("\" class=\"btn btn-cotiz\">Eliminar</a>");
                    html.append("</div></td>");
                    html.append("</tr>");
                    hayDatos = true;
                }
                if (!hayDatos) {
                    html.append("No hay datos en esta tabla.");
                }
                request.setAttribute("resultado", html.toString());
                request.getRequestDispatcher("vistas/asignaciones-lista.jsp").forward(request, response);
                break;
            case "crear":
                // Para obtener los empleados disponibles
                rs = st.executeQuery("SELECT carnet, nombre FROM empleado WHERE estado = 1");
                while (rs.next()) {
                    html.append("<option value=\"").append(rs.getString("carnet")).append("\">");
                    html.append(rs.getString("nombre"));
                    html.append("</option>");
                    hayDatos = true;
                }
                if (!hayDatos) {
                    html.append("<option value=\"0\">No hay líneas de venta</option>");
                }
                request.setAttribute("empleados", html.toString());
                request.getRequestDispatcher("vistas/asignaciones-crear.jsp").forward(request, response);
                break;
        }
    }
}