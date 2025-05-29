package sv.edu.udb.pooproyectofinal.modelo;

import java.time.LocalDate;

public class Cotizaciones {
    private int id, idCliente, numHoras;
    private LocalDate fechaInicio, fechaFin;
    private String estado;
    private double costoAsignaciones, costosAdicionales, costoTotal;

    public Cotizaciones() {}

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getIdCliente() {
        return idCliente;
    }

    public void setIdCliente(int idCliente) {
        this.idCliente = idCliente;
    }

    public int getNumHoras() {
        return numHoras;
    }

    public void setNumHoras(int numHoras) {
        this.numHoras = numHoras;
    }

    public LocalDate getFechaInicio() {
        return fechaInicio;
    }

    public void setFechaInicio(LocalDate fechaInicio) {
        this.fechaInicio = fechaInicio;
    }

    public LocalDate getFechaFin() {
        return fechaFin;
    }

    public void setFechaFin(LocalDate fechaFin) {
        this.fechaFin = fechaFin;
    }

    public String getEstado() {
        return estado;
    }

    public void setEstado(String estado) {
        this.estado = estado;
    }

    public double getCostoAsignaciones() {
        return costoAsignaciones;
    }

    public void setCostoAsignaciones(double costoAsignaciones) {
        this.costoAsignaciones = costoAsignaciones;
    }

    public double getCostosAdicionales() {
        return costosAdicionales;
    }

    public void setCostosAdicionales(double costosAdicionales) {
        this.costosAdicionales = costosAdicionales;
    }

    public double getCostoTotal() {
        return costoTotal;
    }

    public void setCostoTotal(double costoTotal) {
        this.costoTotal = costoTotal;
    }
}
