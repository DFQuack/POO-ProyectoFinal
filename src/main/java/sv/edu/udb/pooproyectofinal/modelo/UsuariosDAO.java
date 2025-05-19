package sv.edu.udb.pooproyectofinal.modelo;

import sv.edu.udb.pooproyectofinal.util.Conexion;
import org.mindrot.jbcrypt.BCrypt;
import java.sql.*;

public class UsuariosDAO {
    private final Connection conn;

    public UsuariosDAO() {
        this.conn = Conexion.getConnection();
    }

    // Método para crear un nuevo usuario con el modelo simplificado
    public boolean crearUsuario(Usuarios usuario, String passwordPlana) {
        String sql = "INSERT INTO usuarios (username, email, password) VALUES (?, ?, ?)";

        try (PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            // Hashear la contraseña antes de almacenarla
            String hashedPassword = BCrypt.hashpw(passwordPlana, BCrypt.gensalt());

            ps.setString(1, usuario.getUsername());
            ps.setString(2, usuario.getEmail());
            ps.setString(3, hashedPassword);

            int affectedRows = ps.executeUpdate();

            if (affectedRows > 0) {
                try (ResultSet rs = ps.getGeneratedKeys()) {
                    if (rs.next()) {
                        return true;
                    }
                }
            }
        } catch (SQLException e) {
            System.err.println("Error al crear usuario: " + e.getMessage());
        }
        return false;
    }

    // Método adicional para verificar credenciales de usuario
    public Usuarios verificarUsuario(String username, String passwordPlana) {
        String sql = "SELECT * FROM usuarios WHERE username = ?";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, username);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    String hashedPassword = rs.getString("password");

                    // Verificar si la contraseña coincide
                    if (BCrypt.checkpw(passwordPlana, hashedPassword)) {
                        Usuarios usuario = new Usuarios();
                        usuario.setUsername(rs.getString("username"));
                        usuario.setEmail(rs.getString("email"));
                        return usuario;
                    }
                }
            }
        } catch (SQLException e) {
            System.err.println("Error al verificar usuario: " + e.getMessage());
        }
        return null;
    }
}