package sv.edu.udb.pooproyectofinal.controlador;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import sv.edu.udb.pooproyectofinal.modelo.Cotizaciones;
import sv.edu.udb.pooproyectofinal.util.Conexion;

import java.io.IOException;
import java.sql.*;
import java.time.LocalDate;

@WebServlet(name = "CotizacionesControlador", urlPatterns = "/CotizacionesControlador")
public class CotizacionesControlador extends HttpServlet {

    public void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (SQLException e) {
            throw new ServletException("Error de base de datos", e);
        }
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (SQLException e) {
            throw new ServletException("Error de base de datos", e);
        }
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        String accion = request.getParameter("accion");
        if (accion == null) accion = "tabla";

        switch (accion) {
            case "form" -> mostrarFormulario(request, response);
            case "editar" -> editarCotizacion(request, response);
            case "crear" -> crearCotizacion(request, response);
            case "eliminar" -> eliminarCotizacion(request, response);
            case "pag-borrar" -> mostrarConfirmacionEliminar(request, response);
            default -> mostrarTabla(request, response);
        }
    }

    private void mostrarTabla(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        StringBuilder html = new StringBuilder();
        boolean hayDatos = false;

        try (Connection conn = Conexion.getConnection();
             Statement st = conn.createStatement();
             ResultSet rs = st.executeQuery("SELECT * FROM vista_cotizaciones")) {

            while (rs.next()) {
                Cotizaciones cot = mapCotizacion(rs);

                html.append("<tr>")
                        .append("<td>").append(cot.getId()).append("</td>")
                        .append("<td>").append(rs.getString("nombre")).append("</td>")
                        .append("<td>").append(cot.getNumHoras()).append("</td>")
                        .append("<td>").append(cot.getFechaInicio()).append("</td>")
                        .append("<td>").append(cot.getFechaFin()).append("</td>")
                        .append("<td>").append(cot.getEstado()).append("</td>")
                        .append("<td>").append(cot.getCostoAsignaciones()).append("</td>")
                        .append("<td>").append(cot.getCostosAdicionales()).append("</td>")
                        .append("<td>").append(cot.getCostoTotal()).append("</td>")
                        .append("<td><div class=\"btn-group\">")
                        .append("<a href=\"CotizacionesControlador?accion=form&id=").append(cot.getId()).append("\" class=\"btn btn-cotiz\">Editar</a>")
                        .append("<a href=\"CotizacionesControlador?accion=pag-borrar&id=").append(cot.getId()).append("\" class=\"btn btn-cotiz\">Eliminar</a>")
                        .append("</div></td></tr>");

                hayDatos = true;
            }
        }

        request.setAttribute("resultado", hayDatos ? html.toString() : "<tr><td colspan='10'>No hay datos en esta tabla.</td></tr>");
        request.getRequestDispatcher("vistas/cotizaciones-lista.jsp").forward(request, response);
    }

    private void mostrarFormulario(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        String idStr = request.getParameter("id");
        Cotizaciones cotizacion = new Cotizaciones();

        if (idStr != null && !idStr.isEmpty()) {
            try (Connection conn = Conexion.getConnection();
                 PreparedStatement pst = conn.prepareStatement("SELECT * FROM cotizacion WHERE id = ?")) {

                pst.setInt(1, Integer.parseInt(idStr));
                try (ResultSet rs = pst.executeQuery()) {
                    if (rs.next()) {
                        cotizacion = mapCotizacion(rs);
                    }
                }
            }
        }

        request.setAttribute("cotizacion", cotizacion);
        request.getRequestDispatcher("vistas/cotizaciones-form.jsp").forward(request, response);
    }

    private void editarCotizacion(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        Cotizaciones cotizacion = parseCotizacionFromRequest(request);

        try (Connection conn = Conexion.getConnection();
             PreparedStatement pst = conn.prepareStatement(
                     "UPDATE cotizacion SET id_cliente=?, num_horas=?, fecha_inicio=?, fecha_fin=?, estado=?, " +
                             "costo_asignaciones=?, costos_adicionales=?, costo_total=? WHERE id=?")) {

            setCotizacionParameters(pst, cotizacion);

            pst.executeUpdate();
        }

        response.sendRedirect("CotizacionesControlador?accion=tabla");
    }

    private void crearCotizacion(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        Cotizaciones cotizacion = parseCotizacionFromRequest(request);

        try (Connection conn = Conexion.getConnection();
             PreparedStatement pst = conn.prepareStatement(
                     "INSERT INTO cotizacion (id_cliente, num_horas, fecha_inicio, fecha_fin, estado, " +
                             "costo_asignaciones, costos_adicionales, costo_total) VALUES (?, ?, ?, ?, ?, ?, ?, ?)")) {

            setCotizacionParameters(pst, cotizacion);
            pst.executeUpdate();
        }

        response.sendRedirect("http://localhost:8080/CotizacionesControlador?accion=tabla");
    }

    private void eliminarCotizacion(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));

        try (Connection conn = Conexion.getConnection();
             PreparedStatement pst = conn.prepareStatement("DELETE FROM cotizacion WHERE id=?")) {

            pst.setInt(1, id);
            pst.executeUpdate();
        }

        response.sendRedirect("http://localhost:8080/CotizacionesControlador?accion=tabla");
    }

    private void mostrarConfirmacionEliminar(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setAttribute("id", request.getParameter("id"));
        request.getRequestDispatcher("vistas/cotizaciones-confirmar-eliminar.jsp").forward(request, response);
    }

    // Métodos auxiliares
    private Cotizaciones mapCotizacion(ResultSet rs) throws SQLException {
        Cotizaciones cot = new Cotizaciones();
        cot.setId(rs.getInt("id"));
        cot.setNumHoras(rs.getInt("num_horas"));

        Date fechaInicio = rs.getDate("fecha_inicio");
        cot.setFechaInicio(fechaInicio != null ? fechaInicio.toLocalDate() : null);

        Date fechaFin = rs.getDate("fecha_fin");
        cot.setFechaFin(fechaFin != null ? fechaFin.toLocalDate() : null);

        cot.setEstado(rs.getString("estado"));
        cot.setCostoAsignaciones(rs.getDouble("costo_asignaciones"));
        cot.setCostosAdicionales(rs.getDouble("costos_adicionales"));
        cot.setCostoTotal(rs.getDouble("costo_total"));

        return cot;
    }

    private Cotizaciones parseCotizacionFromRequest(HttpServletRequest request) {
        Cotizaciones cotizacion = new Cotizaciones();
        if (request.getParameter("id") != null) {
            cotizacion.setId(Integer.parseInt(request.getParameter("id")));
        }
        cotizacion.setIdCliente(Integer.parseInt(request.getParameter("id_cliente")));
        cotizacion.setNumHoras(Integer.parseInt(request.getParameter("num_horas")));
        cotizacion.setFechaInicio(LocalDate.parse(request.getParameter("fecha_inicio")));
        cotizacion.setFechaFin(LocalDate.parse(request.getParameter("fecha_fin")));
        cotizacion.setEstado(request.getParameter("estado"));
        cotizacion.setCostoAsignaciones(Double.parseDouble(request.getParameter("costo_asignaciones")));
        cotizacion.setCostosAdicionales(Double.parseDouble(request.getParameter("costos_adicionales")));
        cotizacion.setCostoTotal(Double.parseDouble(request.getParameter("costo_total")));

        return cotizacion;
    }

    private void setCotizacionParameters(PreparedStatement pst, Cotizaciones cotizacion) throws SQLException {
        pst.setInt(1, cotizacion.getIdCliente());
        pst.setInt(2, cotizacion.getNumHoras());
        pst.setDate(3, Date.valueOf(cotizacion.getFechaInicio()));
        pst.setDate(4, Date.valueOf(cotizacion.getFechaFin()));
        pst.setString(5, cotizacion.getEstado());
        pst.setDouble(6, cotizacion.getCostoAsignaciones());
        pst.setDouble(7, cotizacion.getCostosAdicionales());
        pst.setDouble(8, cotizacion.getCostoTotal());
    }
}