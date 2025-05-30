package sv.edu.udb.pooproyectofinal.controlador;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import sv.edu.udb.pooproyectofinal.modelo.Clientes;
import sv.edu.udb.pooproyectofinal.util.Conexion;

import java.io.IOException;
import java.sql.*;
import java.util.regex.*;

@WebServlet(name = "ClientesControlador", urlPatterns = "/ClientesControlador")
public class ClientesControlador extends HttpServlet {

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
        Clientes cli = new Clientes();
        StringBuilder html = new StringBuilder(), msg = new StringBuilder();
        boolean hayDatos = false;

        String accion = request.getParameter("accion");
        switch (accion) {
            case "tabla": // Para mostrar la tabla con los datos
                rs = st.executeQuery("SELECT * FROM cliente");
                while (rs.next()) {
                    // Se obtiene el id por separado para adjuntarlo más fácilmente en los enlaces GET
                    cli.setId(rs.getInt("id"));
                    // Generación de fila de datos
                    html.append("<tr>");
                    html.append("<td>").append(cli.getId()).append("</td>");
                    EmpleadosControlador.datosTablaPersona(rs, html, false);
                    // Botón para editar
                    html.append("<td><div class=\"btn-group\">");
                    html.append("<a href=\"ClientesControlador?accion=editar&id=");
                    html.append(cli.getId());
                    html.append("\" class=\"btn btn-cliente\">Editar</a>");
                    // Botón para eliminar
                    html.append("<a href=\"ClientesControlador?accion=pag-borrar&id=");
                    html.append(cli.getId());
                    html.append("\" class=\"btn btn-cliente\">Eliminar</a>");
                    html.append("</div></td>");
                    html.append("</tr>");
                    hayDatos = true;
                }
                if (!hayDatos) {
                    html.append("No hay datos en esta tabla.");
                }
                request.setAttribute("resultado", html.toString());
                request.getRequestDispatcher("vistas/clientes-lista.jsp").forward(request, response);
                break;
            case "crear":
                response.sendRedirect("http://localhost:8080/vistas/clientes-crear.jsp");
                break;
            case "editar": // Para colocar los valores de la fila en los input al editar
                cli.setId(Integer.parseInt(request.getParameter("id")));
                rs = st.executeQuery("SELECT * FROM cliente WHERE id = " + cli.getId());
                while (rs.next()) {
                    cli.setDui(rs.getString("dui"));
                    cli.setNombre(rs.getString("nombre"));
                    cli.setTipoPersona(rs.getString("tipo_persona"));
                    cli.setTelefono(rs.getString("telefono"));
                    cli.setEmail(rs.getString("email"));
                    cli.setDireccion(rs.getString("direccion"));
                    cli.setEstado(rs.getBoolean("estado"));
                    request.setAttribute("cliente", cli);
                }
                request.getRequestDispatcher("vistas/clientes-editar.jsp").forward(request, response);
                break;
            case "insertar": // Al subir el formulario para crear un registro
                // Devuelve notificaciones de error
                msg.append(validarDatos(request));
                request.setAttribute("msg", msg.toString());
                // Si hay un mensaje de error
                if (msg.toString().length() > 25) {
                    request.getRequestDispatcher("vistas/clientes-crear.jsp").forward(request, response);
                    break;
                }
                cli.setDui(request.getParameter("dui"));
                cli.setNombre(request.getParameter("nombre"));
                if (request.getParameter("tipo_persona").equals("1")) {
                    cli.setTipoPersona("Natural");
                } else {
                    cli.setTipoPersona("Jurídica");
                }
                cli.setTelefono(request.getParameter("tel"));
                cli.setEmail(request.getParameter("correo"));
                cli.setDireccion(request.getParameter("direccion"));

                pst = conn.prepareStatement("CALL sp_create_cliente(?,?,?,?,?,?)");
                pst.setString(1, cli.getDui());
                pst.setString(2, cli.getNombre());
                pst.setString(3, cli.getTipoPersona());
                pst.setString(4, cli.getTelefono());
                pst.setString(5, cli.getEmail());
                pst.setString(6, cli.getDireccion());
                pst.executeUpdate();
                response.sendRedirect("http://localhost:8080/ClientesControlador?accion=tabla");
                break;
        }

    }

    private String validarDatos(HttpServletRequest request) {
        StringBuilder str = new StringBuilder();
        boolean patronCorrecto;
        str.append("<ul id=\"notif\">");
        // DUI
        if (request.getParameter("dui").isEmpty()) {
            str.append("<li>El campo de DUI no puede estar vacío</li>");
        }
        else {
            Pattern patronDui = Pattern.compile("[0-9]{8}-[0-9]");
            Matcher matcherDui = patronDui.matcher(request.getParameter("dui"));
            patronCorrecto = matcherDui.matches();
            if (!patronCorrecto) {
                str.append("<li>Inserte un DUI válido (00000000-0)</li>");
            }
        }
        // Nombre
        if (request.getParameter("nombre").isEmpty()) {
            str.append("<li>El campo de nombre no puede estar vacío</li>");
        }
        // Teléfono
        if (request.getParameter("tel").isEmpty()) {
            str.append("<li>El campo de teléfono no puede estar vacío</li>");
        }
        else {
            Pattern patronTel = Pattern.compile("[0-9]{4}-[0-9]{4}");
            Matcher matcherTel = patronTel.matcher(request.getParameter("tel"));
            patronCorrecto = matcherTel.matches();
            if (!patronCorrecto) {
                str.append("<li>Inserte un teléfono válido (7777-7777)</li>");
            }
        }
        // Email
        if (request.getParameter("correo").isEmpty()) {
            str.append("<li>El campo de email no puede estar vacío</li>");
        }
        else {
            Pattern patronEmail = Pattern.compile("^[A-Za-z0-9+_.-]+@(.+).com$");
            Matcher matcherEmail = patronEmail.matcher(request.getParameter("correo"));
            patronCorrecto = matcherEmail.matches();
            if (!patronCorrecto) {
                str.append("<li>Inserte un email válido (abc@dominio.com)</li>");
            }
        }
        // Dirección
        if (request.getParameter("direccion").isEmpty()) {
            str.append("<li>El campo de dirección no puede estar vacío</li>");
        }
        str.append("</ul>");
        return str.toString();
    }
}