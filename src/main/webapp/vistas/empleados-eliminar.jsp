<%@ page contentType="text/html;charset=UTF-8" %>
<% String carnetEmp = request.getAttribute("carnet").toString(); %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Eliminar empleado - Multi-Works Group</title>
    <link rel="stylesheet" href="../css/bootstrap.css">
    <link rel="stylesheet" href="../css/style.css">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js"></script>
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
        <div class="flex-fill text-center"><a href="../EmpleadosControlador?accion=tabla" class="nav-link link empleado-activo">Empleados</a></div>
        <div class="flex-fill text-center"><a href="../CotizacionesControlador?accion=tabla" class="nav-link link cotiz">Cotizaciones</a></div>
        <div class="flex-fill text-center"><a href="cuenta.jsp" class="nav-link link login">Cuenta</a></div>
    </div>
</nav>
<main class="container text-center my-5 p-5 elim">
    <h2 class="display-6" id="fuente2">Eliminar empleado</h2>
    ¿Desea eliminar el cliente con carnet <%= carnetEmp %>?
    <form action="../EmpleadosControlador" method="post" class="container px-5">
        <input type="hidden" name="accion" value="eliminar">
        <input type="hidden" name="carnet" value="<%= carnetEmp %>">
        <div class="text-center mt-3">
            <button type="submit" class="btn btn-empleado">Eliminar</button>
        </div>
    </form>
</main>
</body>
</html>