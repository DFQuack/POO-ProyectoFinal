<%--
  Created by IntelliJ IDEA.
  User: kevin
  Date: 13/5/2025
  Time: 20:43
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Iniciar Sesión - POO Proyecto Final</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<%-- Mostrar mensaje de éxito si existe --%>
<c:if test="${not empty sessionScope.success}">
  <div style="color: green;">${sessionScope.success}</div>
  <%
    // Eliminar el mensaje de la sesión después de mostrarlo
    session.removeAttribute("success");
  %>
</c:if>
<div class="container">
  <div class="login-container">
    <h2 class="text-center mb-4">Iniciar Sesión</h2>

    <c:if test="${not empty error}">
      <div class="alert alert-danger">${error}</div>
    </c:if>

    <form action="${pageContext.request.contextPath}/login" method="post">
      <div class="mb-3">
        <label for="username" class="form-label">Usuario</label>
        <input type="text" class="form-control" id="username" name="username" required>
      </div>

      <div class="mb-3">
        <label for="password" class="form-label">Contraseña</label>
        <input type="password" class="form-control" id="password" name="password" required>
      </div>

      <button type="submit" class="btn btn-primary w-100">Ingresar</button>
    </form>
  </div>
</div>
</body>
</html>