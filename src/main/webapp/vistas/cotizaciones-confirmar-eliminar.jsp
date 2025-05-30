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
    <title>Confirmar Eliminación - Multi-Works Group</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <style>
        .confirmation-container {
            max-width: 600px;
            margin: 50px auto;
            padding: 30px;
            border-radius: 10px;
            background-color: #f8f9fa;
            box-shadow: 0 0 15px rgba(0, 0, 0, 0.1);
        }
        .btn-cancel {
            background-color: #6c757d;
            color: white;
        }
        .btn-cancel:hover {
            background-color: #5a6268;
            color: white;
        }
    </style>
</head>
<body class="bg-light">
<nav class="container-fluid bg-negro1">
    <h1 class="text-center display-1 p-3">
        <a href="${pageContext.request.contextPath}/index.jsp" class="link" id="titulo">
            <img src="${pageContext.request.contextPath}/img/logo.png" alt="logo-multiworks"> Multi-Works Group™
        </a>
    </h1>
</nav>

<div class="container confirmation-container">
    <h2 class="text-center mb-4">Confirmar Eliminación</h2>
    <div class="alert alert-warning text-center">
            <span class="material-symbols-outlined" style="font-size: 48px; vertical-align: middle;">
                warning
            </span>
        <h4 class="d-inline-block align-middle ml-2">¿Está seguro que desea eliminar esta cotización?</h4>
    </div>

    <div class="text-center mt-5">
        <form action="${pageContext.request.contextPath}/CotizacionesControlador" method="post" class="d-inline">
            <input type="hidden" name="accion" value="eliminar">
            <input type="hidden" name="id" value="${param.id}">
            <button type="submit" class="btn btn-danger btn-lg mr-3">
                <span class="material-symbols-outlined">delete</span> Eliminar
            </button>
        </form>

        <a href="${pageContext.request.contextPath}/CotizacionesControlador?accion=tabla" class="btn btn-cancel btn-lg">
            <span class="material-symbols-outlined">cancel</span> Cancelar
        </a>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
