<%--
  Created by IntelliJ IDEA.
  User: kevin
  Date: 14/5/2025
  Time: 08:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
  <title>Registro de Usuario</title>
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
    <div class="flex-fill text-center"><a href="../EmpleadosControlador?accion=tabla" class="nav-link link empleado">Empleados</a></div>
    <div class="flex-fill text-center"><a href="../CotizacionesControlador?accion=tabla" class="nav-link link cotiz">Cotizaciones</a></div>
    <div class="flex-fill text-center"><a href="cuenta.jsp" class="nav-link link login-activo">Cuenta</a></div>
  </div>
</nav>
<div class="container mt-5">
  <div class="row justify-content-center">
    <div class="col-md-6">
      <div class="card">
        <div class="card-header">
          <h4>Registro de Usuario</h4>
        </div>
        <div class="card-body">
          <c:if test="${not empty error}">
            <div class="alert alert-danger">${error}</div>
          </c:if>
          <c:if test="${not empty success}">
            <div class="alert alert-success">${success}</div>
          </c:if>

          <form action="${pageContext.request.contextPath}/registro" method="post">
            <div class="mb-3">
              <label for="username" class="form-label">Nombre de Usuario</label>
              <input type="text" class="form-control" id="username" name="username" required>
            </div>
            <div class="mb-3">
              <label for="email" class="form-label">Email</label>
              <input type="email" class="form-control" id="email" name="email" required>
            </div>
            <div class="mb-3">
              <label for="password" class="form-label">Contraseña</label>
              <input type="password" class="form-control" id="password" name="password" required>
            </div>
            <div class="mb-3">
              <label for="confirmPassword" class="form-label">Confirmar Contraseña</label>
              <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" required>
            </div>
            <button type="submit" class="btn btn-primary w-100">Registrarse</button>
          </form>
        </div>
        <div class="card-footer text-center">
          ¿Ya tienes cuenta? <a href="${pageContext.request.contextPath}/vistas/login.jsp">Inicia sesión aquí</a>
        </div>
      </div>
    </div>
  </div>
</div>
</body>
</html>
