<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Eliminar cliente - Multi-Works Group</title>
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
        <div class="flex-fill text-center"><a href="../ClientesControlador?accion=tabla" class="nav-link link cliente-activo">Clientes</a></div>
        <div class="flex-fill text-center"><a href="../EmpleadosControlador?accion=tabla" class="nav-link link empleado">Empleados</a></div>
        <div class="flex-fill text-center"><a href="../CotizacionesControlador?accion=tabla" class="nav-link link cotiz">Cotizaciones</a></div>
        <div class="flex-fill text-center"><a href="cuenta.jsp" class="nav-link link login">Cuenta</a></div>
    </div>
</nav>
<main class="container my-5 p-5">
    <h2 class="display-6 text-center" id="fuente2">Eliminar cliente</h2>
    ¿Desea eliminar el cliente con id ?
</main>
</body>
</html>
