package sv.edu.udb.pooproyectofinal.modelo;

public class Asignaciones {
    private int id, idCotizacion, numHoras, incrementoExtra;
    private String titulo, carnetEmpleado, area, tiempoInicio, tiempoFin;
    private double costoHora, costoBase, costoTotal;

    public Asignaciones() {}

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getIdCotizacion() {
        return idCotizacion;
    }

    public void setIdCotizacion(int idCotizacion) {
        this.idCotizacion = idCotizacion;
    }

    public int getNumHoras() {
        return numHoras;
    }

    public void setNumHoras(int numHoras) {
        this.numHoras = numHoras;
    }

    public int getIncrementoExtra() {
        return incrementoExtra;
    }

    public void setIncrementoExtra(int incrementoExtra) {
        this.incrementoExtra = incrementoExtra;
    }

    public String getTitulo() {
        return titulo;
    }

    public void setTitulo(String titulo) {
        this.titulo = titulo;
    }

    public String getCarnetEmpleado() {
        return carnetEmpleado;
    }

    public void setCarnetEmpleado(String carnetEmpleado) {
        this.carnetEmpleado = carnetEmpleado;
    }

    public String getArea() {
        return area;
    }

    public void setArea(String area) {
        this.area = area;
    }

    public String getTiempoInicio() {
        return tiempoInicio;
    }

    public void setTiempoInicio(String tiempoInicio) {
        this.tiempoInicio = tiempoInicio;
    }

    public String getTiempoFin() {
        return tiempoFin;
    }

    public void setTiempoFin(String tiempoFin) {
        this.tiempoFin = tiempoFin;
    }

    public double getCostoHora() {
        return costoHora;
    }

    public void setCostoHora(double costoHora) {
        this.costoHora = costoHora;
    }

    public double getCostoBase() {
        return costoBase;
    }

    public void setCostoBase(double costoBase) {
        this.costoBase = costoBase;
    }

    public double getCostoTotal() {
        return costoTotal;
    }

    public void setCostoTotal(double costoTotal) {
        this.costoTotal = costoTotal;
    }
}
