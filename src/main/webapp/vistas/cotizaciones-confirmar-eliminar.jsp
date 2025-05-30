<%--
  Created by IntelliJ IDEA.
  User: kevin
  Date: 30/5/2025
  Time: 15:13
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Eliminar cotización - Multi-Works Group</title>
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

<main class="container my-5 p-5r">
    <h2 class="text-center mb-4">Confirmar Eliminación</h2>
    <div class="alert alert-warning text-center">
        <h4 class="d-inline-block align-middle ml-2">¿Está seguro que desea eliminar esta cotización?</h4>
    </div>

    <div class="text-center mt-5">
        <form action="${pageContext.request.contextPath}/CotizacionesControlador" method="post" class="d-inline">
            <input type="hidden" name="accion" value="eliminar">
            <input type="hidden" name="id" value="${param.id}">
            <button type="submit" class="btn btn-danger btn-lg mr-3">Eliminar</button>
        </form>

        <a href="${pageContext.request.contextPath}/CotizacionesControlador?accion=tabla" class="btn btn-cancel btn-lg">Cancelar</a>
    </div>
</main>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
