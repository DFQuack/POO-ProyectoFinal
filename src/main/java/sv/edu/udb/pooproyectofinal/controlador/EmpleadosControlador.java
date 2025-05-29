package sv.edu.udb.pooproyectofinal.controlador;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import sv.edu.udb.pooproyectofinal.modelo.Empleados;
import sv.edu.udb.pooproyectofinal.util.Conexion;

import java.io.IOException;
import java.sql.*;

@WebServlet(name = "EmpleadosControlador", urlPatterns = "/EmpleadosControlador")
public class EmpleadosControlador extends HttpServlet {

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
        Empleados emp = new Empleados();
        StringBuilder html = new StringBuilder();
        boolean hayDatos = false;

        String accion = request.getParameter("accion");
        switch (accion) {
            case "tabla": // Para mostrar la tabla con los datos
                rs = st.executeQuery("SELECT * FROM empleado");
                while (rs.next()) {
                    // Se obtiene el carnet por separado para adjuntarlo más fácilmente en los enlaces GET
                    emp.setCarnet(rs.getString("carnet"));
                    // Generación de fila de datos
                    html.append("<tr>");
                    html.append("<td>").append(emp.getCarnet()).append("</td>");
                    datosTablaPersona(rs, html, true);
                    // Botón para editar
                    html.append("<td><div class=\"btn-group\">");
                    html.append("<a href=\"EmpleadosControlador?accion=form&editar=true&id=");
                    html.append(emp.getCarnet());
                    html.append("\" class=\"btn btn-empleado\">Editar</a>");
                    // Botón para eliminar
                    html.append("<a href=\"EmpleadosControlador?accion=pag-borrar&id=");
                    html.append(emp.getCarnet());
                    html.append("\" class=\"btn btn-empleado\">Eliminar</a>");
                    html.append("</div></td>");
                    html.append("</tr>");
                    hayDatos = true;
                }
                if (!hayDatos) {
                    html.append("No hay datos en esta tabla.");
                }

                request.setAttribute("resultado", html.toString());
                request.getRequestDispatcher("vistas/empleados-lista.jsp").forward(request, response);
                break;
            case "form":
                break;
        }
    }


    static void datosTablaPersona(ResultSet rs, StringBuilder html, boolean isEmpleado) throws SQLException {
        if (rs.getString("dui") == null) {
            html.append("<td>N/A</td>");
        } else {
            html.append("<td>").append(rs.getString("dui")).append("</td>");
        }
        html.append("<td>").append(rs.getString("nombre")).append("</td>");
        html.append("<td>").append(rs.getString("tipo_persona")).append("</td>");
        html.append("<td>").append(rs.getString("telefono")).append("</td>");
        html.append("<td>").append(rs.getString("email")).append("</td>");
        html.append("<td>").append(rs.getString("direccion")).append("</td>");
        if (isEmpleado) {
            html.append("<td>").append(rs.getString("tipo_contratacion")).append("</td>");
        }
        if (rs.getBoolean("estado")) {
            html.append("<td>Activo</td>");
        } else {
            html.append("<td>Inactivo</td>");
        }
        html.append("<td>").append(rs.getString("creado_por")).append("</td>");
        html.append("<td>").append(rs.getDate("fecha_creacion")).append("</td>");
        if (rs.getString("fecha_actualizacion") == null) {
            html.append("<td>N/A</td>");
        } else {
            html.append("<td>").append(rs.getString("fecha_actualizacion")).append("</td>");
        }
        if (rs.getString("fecha_inactivacion") == null) {
            html.append("<td>N/A</td>");
        } else {
            html.append("<td>").append(rs.getString("fecha_inactivacion")).append("</td>");
        }
    }
}