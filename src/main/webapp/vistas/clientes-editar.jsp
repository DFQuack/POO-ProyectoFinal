<%@ page import="sv.edu.udb.pooproyectofinal.modelo.Clientes" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<% Clientes cli = (Clientes) request.getAttribute("cliente"); %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Añadir cliente - Multi-Works Group</title>
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
<h2 class="display-6 text-center p-2 mt-5 header-cliente" id="fuente2">Añadir cliente</h2>
<main class="container my-5 p-5">
    <form action="../ClientesControlador" method="post" class="container px-5 form-cliente">
        <input type="hidden" name="accion" value="actualizar">
        <div class="form-floating mb-3">
            <input type="text" class="form-control" name="id_cli" id="id_cli" placeholder="a" value="<%= cli.getId() %>" readonly>
            <label for="id_cli">ID</label>
        </div>
        <div class="form-floating mb-3">
            <input type="text" class="form-control" name="dui" id="dui" placeholder="a" value="<%= cli.getDui() %>">
            <label for="dui">DUI</label>
        </div>
        <div class="form-floating mb-3">
            <input type="text" class="form-control" name="nombre" id="nombre" placeholder="a" value="<%= cli.getNombre() %>">
            <label for="nombre">Nombre completo</label>
        </div>
        <div class="form-floating mb-3">
            <select class="form-select" id="tipo_persona" name="tipo_persona">
                <option value="1">Natural</option>
                <option value="2">Jurídica</option>
            </select>
            <label for="tipo_persona">Tipo de persona</label>
        </div>
        <div class="form-floating mb-3">
            <input type="tel" class="form-control" name="tel" id="tel" placeholder="a" value="<%= cli.getTelefono() %>">
            <label for="tel">Número de teléfono</label>
        </div>
        <div class="form-floating mb-3">
            <input type="email" class="form-control" name="correo" id="correo" placeholder="a" value="<%= cli.getEmail() %>">
            <label for="correo">Correo electrónico</label>
        </div>
        <div class="form-floating mb-3">
            <input type="text" class="form-control" name="direccion" id="direccion" placeholder="a" value="<%= cli.getDireccion() %>">
            <label for="direccion">Dirección</label>
        </div>
        <div class="form-floating mb-3">
            <select class="form-select" id="estado" name="estado">
                <option value="1">Activo</option>
                <option value="0">Inactivo</option>
            </select>
            <label for="estado">Estado</label>
        </div>
        <div class="text-center mt-3">
            <button type="submit" class="btn btn-cliente">Efectuar cambios</button>
        </div>
    </form>
</main>
</body>
</html>