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
        if (accion == null) accion = "tabla"; // Acción por defecto
        
        switch (accion) {
            case "tabla": // Para mostrar la tabla con los datos
                rs = st.executeQuery("SELECT * FROM empleado");
                while (rs.next()) {
                    emp.setCarnet(rs.getString("carnet"));
                    html.append("<tr>");
                    html.append("<td>").append(emp.getCarnet()).append("</td>");
                    datosTablaPersona(rs, html, true);
                    // Botones de acción
                    html.append("<td><div class=\"btn-group\">");
                    html.append("<a href=\"EmpleadosControlador?accion=form&editar=true&id=");
                    html.append(emp.getCarnet());
                    html.append("\" class=\"btn btn-empleado\">Editar</a>");
                    html.append("<a href=\"EmpleadosControlador?accion=pag-borrar&id=");
                    html.append(emp.getCarnet());
                    html.append("\" class=\"btn btn-empleado\">Eliminar</a>");
                    html.append("</div></td>");
                    html.append("</tr>");
                    hayDatos = true;
                }
                if (!hayDatos) {
                    html.append("<tr><td colspan='12'>No hay datos en esta tabla.</td></tr>");
                }

                request.setAttribute("resultado", html.toString());
                request.getRequestDispatcher("vistas/empleados-lista.jsp").forward(request, response);
                break;
                
            case "form":
                String id = request.getParameter("id");
                boolean editar = Boolean.parseBoolean(request.getParameter("editar"));
                
                if (editar && id != null && !id.isEmpty()) {
                    emp.cargarPorId(conn, id);
                    request.setAttribute("empleado", emp);
                }
                
                request.setAttribute("editar", editar);
                request.getRequestDispatcher("vistas/empleados-form.jsp").forward(request, response);
                break;
                
            case "guardar":
                // Obtener parámetros del formulario
                emp.setCarnet(request.getParameter("carnet"));
                emp.setDui(request.getParameter("dui"));
                emp.setNombre(request.getParameter("nombre"));
                emp.setTipoPersona(request.getParameter("tipo_persona"));
                emp.setTelefono(request.getParameter("telefono"));
                emp.setEmail(request.getParameter("email"));
                emp.setDireccion(request.getParameter("direccion"));
                emp.setTipoContratacion(request.getParameter("tipo_contratacion"));
                emp.setEstado(Boolean.parseBoolean(request.getParameter("estado")));
                emp.setCreadoPor(request.getParameter("creado_por"));
                
                boolean exito;
                if (request.getParameter("editar") != null && request.getParameter("editar").equals("true")) {
                    emp.setActualizadoPor(request.getParameter("actualizado_por"));
                    exito = emp.actualizar(conn);
                } else {
                    exito = emp.insertar(conn);
                }
                
                if (exito) {
                    response.sendRedirect("EmpleadosControlador?accion=tabla");
                } else {
                    request.setAttribute("error", "No se pudo guardar el empleado");
                    request.getRequestDispatcher("vistas/error.jsp").forward(request, response);
                }
                break;
                
            case "pag-borrar":
                id = request.getParameter("id");
                if (id != null && !id.isEmpty()) {
                    emp.cargarPorId(conn, id);
                    request.setAttribute("empleado", emp);
                    request.getRequestDispatcher("vistas/empleados-borrar.jsp").forward(request, response);
                }
                break;
                
            case "borrar":
                id = request.getParameter("id");
                if (id != null && !id.isEmpty()) {
                    String sql = "UPDATE empleado SET estado = false, fecha_inactivacion = CURRENT_TIMESTAMP WHERE carnet = ?";
                    pst = conn.prepareStatement(sql);
                    pst.setString(1, id);
                    int filas = pst.executeUpdate();
                    
                    if (filas > 0) {
                        response.sendRedirect("EmpleadosControlador?accion=tabla");
                    } else {
                        request.setAttribute("error", "No se pudo inactivar el empleado");
                        request.getRequestDispatcher("vistas/error.jsp").forward(request, response);
                    }
                }
                break;
                
            default:
                response.sendRedirect("EmpleadosControlador?accion=tabla");
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
