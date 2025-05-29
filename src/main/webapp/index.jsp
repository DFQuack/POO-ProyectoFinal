<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Multi-Works Group</title>
    <link rel="stylesheet" href="css/bootstrap.css">
    <link rel="stylesheet" href="css/style.css">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js"></script>
</head>
<body class="text-light bg-light">
<nav class="container-fluid bg-negro1">
    <h1 class="text-center display-1 p-3">
        <a href="index.jsp" class="link" id="titulo">
        <img src="img/logo.png" alt="logo-multiworks">  Multi-Works Group™
        </a>
    </h1>
    <div class="d-flex">
        <div class="flex-fill text-center"><a href="ClientesControlador?accion=tabla" class="nav-link link cliente">Clientes</a></div>
        <div class="flex-fill text-center"><a href="EmpleadosControlador?accion=tabla" class="nav-link link empleado">Empleados</a></div>
        <div class="flex-fill text-center"><a href="CotizacionesControlador?accion=tabla" class="nav-link link cotiz">Cotizaciones</a></div>
        <div class="flex-fill text-center"><a href="vistas/cuenta.jsp" class="nav-link link login">Cuenta</a></div>
    </div>
</nav>
<main class="container bg-negro2 my-5 p-5 text-center">
    <h2>Esta es la web app de Multi-Works Group™. Seleccione una opción.</h2>
    <a href="ClientesControlador?accion=tabla" class="link menu cliente">Clientes</a>
    <a href="EmpleadosControlador?accion=tabla" class="link menu empleado">Empleados</a>
    <a href="CotizacionesControlador?accion=tabla" class="link menu cotiz">Cotizaciones</a>
</main>

<footer class="container-fluid bg-negro1 p-5 text-center" id="abajo">
    &copy; Todos los derechos reservados.<br>
    <a href="https://www.flaticon.com/free-icons/business-and-finance" class="link">Logo creado por Iconsmeet - Flaticon</a>
</footer>
</body>
</html>