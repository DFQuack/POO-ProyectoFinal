<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Añadir subtarea - Multi-Works Group</title>
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
        <div class="flex-fill text-center"><a href="clientes-lista.jsp" class="nav-link link cliente">Clientes</a></div>
        <div class="flex-fill text-center"><a href="empleados-lista.jsp" class="nav-link link empleado">Empleados</a></div>
        <div class="flex-fill text-center"><a href="cotizaciones-lista.jsp" class="nav-link link cotiz-activo">Cotizaciones</a></div>
    </div>
</nav>
<h2 class="display-6 text-center p-2 mt-5 header-cotiz" id="fuente2">Añadir subtarea</h2>
<main class="container my-5 p-5">
    <form method="post" class="container px-5 form-cotiz">
        <div class="form-floating mb-3">
            <select class="form-select" id="asignacion" name="asignacion">
                <option>Asignación 1</option>
                <option>Asignación 2</option>
            </select>
            <label for="asignacion">Seleccionar asignación</label>
        </div>
        <div class="form-floating mb-3">
            <input type="text" class="form-control" name="nombre" id="nombre" placeholder="a">
            <label for="nombre">Nombre de subtarea</label>
        </div>
        <div class="form-floating mb-3">
            <textarea class="form-control" name="desc" id="desc" placeholder="a"></textarea>
            <label for="desc">Descripción</label>
        </div>
        <div class="text-center mt-3">
            <button type="submit" class="btn btn-cotiz">Añadir</button>
        </div>
    </form>
</main>
</body>
</html>
