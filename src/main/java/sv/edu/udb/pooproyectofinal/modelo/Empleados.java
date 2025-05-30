package sv.edu.udb.pooproyectofinal.modelo;

public class Empleados extends Persona {
    private String carnet, tipoContratacion;
    public Empleados() {}

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
}
