package sv.edu.udb.pooproyectofinal.modelo;

import java.sql.*;

public class Empleados extends Persona {
    private String carnet;
    private String tipoContratacion;
    
    public Empleados() {}

    // Getters y setters
    public String getCarnet() {
        return carnet;
    }

    public void setCarnet(String carnet) {
        this.carnet = carnet;
    }

    public String getTipoContratacion() {
        return tipoContratacion;
    }

    public void setTipoContratacion(String tipoContratacion) {
        this.tipoContratacion = tipoContratacion;
    }

    // Métodos para operaciones con la base de datos
    public boolean insertar(Connection conn) throws SQLException {
        String sql = "INSERT INTO empleado (carnet, dui, nombre, tipo_persona, telefono, email, direccion, tipo_contratacion, estado, creado_por) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        
        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, this.carnet);
            pstmt.setString(2, this.getDui());
            pstmt.setString(3, this.getNombre());
            pstmt.setString(4, this.getTipoPersona());
            pstmt.setString(5, this.getTelefono());
            pstmt.setString(6, this.getEmail());
            pstmt.setString(7, this.getDireccion());
            pstmt.setString(8, this.tipoContratacion);
            pstmt.setBoolean(9, this.isEstado());
            pstmt.setString(10, this.getCreadoPor());
            
            return pstmt.executeUpdate() > 0;
        }
    }

    public boolean actualizar(Connection conn) throws SQLException {
        String sql = "UPDATE empleado SET dui=?, nombre=?, tipo_persona=?, telefono=?, email=?, " +
                     "direccion=?, tipo_contratacion=?, estado=?, actualizado_por=?, fecha_actualizacion=CURRENT_TIMESTAMP " +
                     "WHERE carnet=?";
        
        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, this.getDui());
            pstmt.setString(2, this.getNombre());
            pstmt.setString(3, this.getTipoPersona());
            pstmt.setString(4, this.getTelefono());
            pstmt.setString(5, this.getEmail());
            pstmt.setString(6, this.getDireccion());
            pstmt.setString(7, this.tipoContratacion);
            pstmt.setBoolean(8, this.isEstado());
            pstmt.setString(9, this.getActualizadoPor());
            pstmt.setString(10, this.carnet);
            
            return pstmt.executeUpdate() > 0;
        }
    }

    public boolean cargarPorId(Connection conn, String carnet) throws SQLException {
        String sql = "SELECT * FROM empleado WHERE carnet = ?";
        
        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, carnet);
            ResultSet rs = pstmt.executeQuery();
            
            if (rs.next()) {
                this.carnet = rs.getString("carnet");
                this.setDui(rs.getString("dui"));
                this.setNombre(rs.getString("nombre"));
                this.setTipoPersona(rs.getString("tipo_persona"));
                this.setTelefono(rs.getString("telefono"));
                this.setEmail(rs.getString("email"));
                this.setDireccion(rs.getString("direccion"));
                this.tipoContratacion = rs.getString("tipo_contratacion"));
                this.setEstado(rs.getBoolean("estado"));
                this.setCreadoPor(rs.getString("creado_por"));
                return true;
            }
            return false;
        }
    }
}
