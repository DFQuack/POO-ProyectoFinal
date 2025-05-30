<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<% String datos = request.getAttribute("resultado").toString(); %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Lista de asignaciones - Multi-Works Group</title>
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
        <div class="flex-fill text-center"><a href="../CotizacionesControlador?accion=tabla" class="nav-link link cotiz-activo">Cotizaciones</a></div>
    </div>
</nav>
<main class="container my-5 p-5 text-center">
    <div class="subheader-cotiz d-flex text-center">
        <a href="../CotizacionesControlador?accion=tabla" class="btn-subcotiz flex-fill p-2">Cotizaciones</a>
        <a href="../AsignacionesControlador?accion=tabla" class="btn-subcotiz-activo flex-fill p-2">Asignaciones</a>
        <a href="subtareas-lista.jsp" class="btn-subcotiz flex-fill p-2">Subtareas</a>
    </div>
    <div class="header header-cotiz p-2 d-flex justify-content-between">
        <h2 class="mb-0">Lista de asignaciones</h2>
        <a href="../AsignacionesControlador?accion=crear" class="btn btn-cotiz d-flex align-items-center"><span class="material-symbols-outlined">add</span>Añadir asignación</a>
    </div>
    <div class="table-responsive">
        <table class="table text-center alinear">
            <thead class="text-light tabla-cotiz">
            <tr>
                <th>ID</th>
                <th>ID Cotización</th>
                <th>Título</th>
                <th>Empleado asignado</th>
                <th>Área asignada</th>
                <th>Tiempo de inicio</th>
                <th>Tiempo de fin</th>
                <th>Costo por hora ($)</th>
                <th>Núm. horas (aprox.)</th>
                <th>Costo base ($)</th>
                <th>Incremento extra (%)</th>
                <th>Total ($)</th>
                <th>Opciones</th>
            </tr>
            </thead>
            <tbody class="text-dark">
            <%= datos %>>
            </tbody>
        </table>
    </div>
</main>

<footer class="container-fluid bg-negro1 p-5 text-center">
    &copy; Todos los derechos reservados.<br>
    <a href="https://www.flaticon.com/free-icons/business-and-finance" class="link">Logo creado por Iconsmeet - Flaticon</a>
</footer>
</body>
</html>