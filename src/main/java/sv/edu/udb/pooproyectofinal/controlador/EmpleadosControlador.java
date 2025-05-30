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
        StringBuilder html = new StringBuilder(), msg = new StringBuilder();
        boolean hayDatos = false;

        String accion = request.getParameter("accion");
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
                    html.append("<a href=\"EmpleadosControlador?accion=editar&id=");
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
            case "crear":
                response.sendRedirect("http://localhost:8080/vistas/empleados-crear.jsp");
                break;
            case "editar": // Para colocar los valores de la fila en los input al editar
                emp.setCarnet(request.getParameter("id"));
                rs = st.executeQuery("SELECT * FROM empleado WHERE carnet = '" + emp.getCarnet() + "'");
                while (rs.next()) {
                    emp.setDui(rs.getString("dui"));
                    emp.setNombre(rs.getString("nombre"));
                    emp.setTipoPersona(rs.getString("tipo_persona"));
                    emp.setTelefono(rs.getString("telefono"));
                    emp.setEmail(rs.getString("email"));
                    emp.setDireccion(rs.getString("direccion"));
                    emp.setTipoContratacion(rs.getString("tipo_contratacion"));
                    emp.setEstado(rs.getBoolean("estado"));
                    request.setAttribute("empleado", emp);
                }
                request.getRequestDispatcher("vistas/empleados-editar.jsp").forward(request, response);
                break;
            case "insertar": // Al subir el formulario para crear un registro
                // Obtener parámetros del formulario
                emp.setCarnet(request.getParameter("carnet"));
                emp.setDui(request.getParameter("dui"));
                emp.setNombre(request.getParameter("nombre"));
                if (request.getParameter("tipo_persona").equals("1")) {
                    emp.setTipoPersona("Natural");
                } else {
                    emp.setTipoPersona("Jurídica");
                }
                emp.setTelefono(request.getParameter("tel"));
                emp.setEmail(request.getParameter("correo"));
                emp.setDireccion(request.getParameter("direccion"));
                emp.setTipoContratacion(request.getParameter("contrato"));

                pst = conn.prepareStatement("CALL sp_create_empleado(?,?,?,?,?,?,?,?)");
                pst.setString(1, emp.getCarnet());
                pst.setString(2, emp.getDui());
                pst.setString(3, emp.getNombre());
                pst.setString(4, emp.getTipoPersona());
                pst.setString(5, emp.getTelefono());
                pst.setString(6, emp.getEmail());
                pst.setString(7, emp.getDireccion());
                pst.setString(8, emp.getTipoContratacion());
                pst.executeUpdate();
                response.sendRedirect("http://localhost:8080/EmpleadosControlador?accion=tabla");
                break;
            case "actualizar": // Al subir el formulario para actualizar un registro
                emp.setCarnet(request.getParameter("carnet"));
                emp.setDui(request.getParameter("dui"));
                emp.setNombre(request.getParameter("nombre"));
                if (request.getParameter("tipo_persona").equals("1")) {
                    emp.setTipoPersona("Natural");
                } else {
                    emp.setTipoPersona("Jurídica");
                }
                emp.setTelefono(request.getParameter("tel"));
                emp.setEmail(request.getParameter("correo"));
                emp.setDireccion(request.getParameter("direccion"));
                emp.setTipoContratacion(request.getParameter("contrato"));
                emp.setEstado(Boolean.parseBoolean(request.getParameter("estado")));

                pst = conn.prepareStatement("CALL sp_update_empleado(?,?,?,?,?,?,?,?,?)");
                pst.setString(1, emp.getCarnet());
                pst.setString(2, emp.getDui());
                pst.setString(3, emp.getNombre());
                pst.setString(4, emp.getTipoPersona());
                pst.setString(5, emp.getTelefono());
                pst.setString(6, emp.getEmail());
                pst.setString(7, emp.getDireccion());
                pst.setString(8, emp.getTipoContratacion());
                pst.setBoolean(9, emp.isEstado());
                pst.executeUpdate();
                response.sendRedirect("http://localhost:8080/EmpleadosControlador?accion=tabla");
                break;
            case "pag-borrar": // Lleva a la página de confirmación de borrado
                request.setAttribute("carnet", request.getParameter("id"));
                request.getRequestDispatcher("vistas/empleados-eliminar.jsp").forward(request, response);
                break;
            case "eliminar":
                emp.setCarnet(request.getParameter("carnet"));
                pst = conn.prepareStatement("CALL sp_delete_empleado(?)");
                pst.setString(1, emp.getCarnet());
                pst.executeUpdate();
                response.sendRedirect("EmpleadosControlador?accion=tabla");
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