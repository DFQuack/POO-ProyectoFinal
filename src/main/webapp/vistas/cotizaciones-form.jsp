<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="sv.edu.udb.pooproyectofinal.modelo.Cotizaciones" %>
<%
    Cotizaciones cotizacion = (Cotizaciones) request.getAttribute("cotizacion");
    boolean esEdicion = cotizacion != null && cotizacion.getId() != 0;
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><%= esEdicion ? "Editar" : "Añadir" %> cotización - Multi-Works Group</title>
    <link rel="stylesheet" href="../css/bootstrap.css">
    <link rel="stylesheet" href="../css/style.css">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20,500,0,0&icon_names=add" />
</head>
<body class="text-light bg-light">
<nav class="container-fluid bg-negro1">
    <h1 class="text-center display-1 p-3">
        <a href="../index.jsp" class="link" id="titulo">
            <img src="../img/logo.png" alt="logo-multiworks">  Multi-Works Group™
        </a>
    </h1>
    <div class="d-flex">
        <div class="flex-fill text-center"><a href="../ClientesControlador?accion=tabla" class="nav-link link cliente">Clientes</a></div>
        <div class="flex-fill text-center"><a href="../EmpleadosControlador?accion=tabla" class="nav-link link empleado">Empleados</a></div>
        <div class="flex-fill text-center"><a href="../CotizacionesControlador?accion=tabla" class="nav-link link cotiz">Cotizaciones</a></div>
        <div class="flex-fill text-center"><a href="cuenta.jsp" class="nav-link link login">Cuenta</a></div>
    </div>
</nav>
<h2 class="display-6 text-center p-2 mt-5 header-cotiz" id="fuente2"><%= esEdicion ? "Editar" : "Añadir" %> cotización</h2>
<main class="container my-5 p-5">
    <form method="post" action="CotizacionesControlador?accion=<%= esEdicion ? "editar" : "crear" %>" class="container px-5 form-cotiz">
        <% if (esEdicion) { %>
        <input type="hidden" name="id" value="<%= cotizacion.getId() %>">
        <% } %>

        <div class="form-floating mb-3">
            <input type="number" class="form-control" name="num_horas" id="num_horas"
                   placeholder="Número de horas" value="<%= esEdicion ? cotizacion.getNumHoras() : "" %>" required>
            <label for="num_horas">Número de horas</label>
        </div>

        <div class="form-floating mb-3">
            <input type="date" class="form-control" name="fecha_inicio" id="fecha_inicio"
                   placeholder="Fecha de inicio" value="<%= esEdicion ? cotizacion.getFechaInicio() : "" %>" required>
            <label for="fecha_inicio">Fecha tentativa de inicio</label>
        </div>

        <div class="form-floating mb-3">
            <input type="date" class="form-control" name="fecha_fin" id="fecha_fin"
                   placeholder="Fecha de fin" value="<%= esEdicion ? cotizacion.getFechaFin() : "" %>" required>
            <label for="fecha_fin">Fecha tentativa de fin</label>
        </div>

        <div class="form-floating mb-3">
            <select class="form-select" id="estado" name="estado" required>
                <option value="No iniciada" <%= esEdicion && "No iniciada".equals(cotizacion.getEstado()) ? "selected" : "" %>>No iniciada</option>
                <option value="En proceso" <%= esEdicion && "En proceso".equals(cotizacion.getEstado()) ? "selected" : "" %>>En proceso</option>
                <option value="Finalizada" <%= esEdicion && "Finalizada".equals(cotizacion.getEstado()) ? "selected" : "" %>>Finalizada</option>
            </select>
            <label for="estado">Estado</label>
        </div>

        <div class="form-floating mb-3">
            <input type="number" step="0.01" class="form-control" name="costo_asignaciones" id="costo_asignaciones"
                   placeholder="Costo de asignaciones" value="<%= esEdicion ? cotizacion.getCostoAsignaciones() : "" %>" required>
            <label for="costo_asignaciones">Costo de asignaciones ($)</label>
        </div>

        <div class="form-floating mb-3">
            <input type="number" step="0.01" class="form-control" name="costos_adicionales" id="costos_adicionales"
                   placeholder="Costos adicionales" value="<%= esEdicion ? cotizacion.getCostosAdicionales() : "" %>" required>
            <label for="costos_adicionales">Costos adicionales ($)</label>
        </div>

        <div class="form-floating mb-3">
            <input type="number" step="0.01" class="form-control" name="costo_total" id="costo_total"
                   placeholder="Costo total" value="<%= esEdicion ? cotizacion.getCostoTotal() : "" %>" required>
            <label for="costo_total">Costo total ($)</label>
        </div>

        <div class="text-center mt-3">
            <button type="submit" class="btn btn-cotiz"><%= esEdicion ? "Actualizar" : "Añadir" %></button>
            <a href="../CotizacionesControlador?accion=tabla" class="btn btn-cotiz">Cancelar</a>
        </div>
    </form>
</main>
</body>
</html>