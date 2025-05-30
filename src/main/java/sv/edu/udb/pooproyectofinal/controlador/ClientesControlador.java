package sv.edu.udb.pooproyectofinal.controlador;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import sv.edu.udb.pooproyectofinal.modelo.Clientes;
import sv.edu.udb.pooproyectofinal.util.Conexion;

import java.io.IOException;
import java.sql.*;

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
        StringBuilder html = new StringBuilder();
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
        }
    }
}