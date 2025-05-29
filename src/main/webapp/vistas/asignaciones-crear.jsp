<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Añadir asignación - Multi-Works Group</title>
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
        <div class="flex-fill text-center"><a href="../CotizacionesControlador?accion=tabla" class="nav-link link cotiz">Cotizaciones</a></div>
        <div class="flex-fill text-center"><a href="cuenta.jsp" class="nav-link link login">Cuenta</a></div>
    </div>
</nav>
<h2 class="display-6 text-center p-2 mt-5 header-cotiz" id="fuente2">Añadir asignación</h2>
<main class="container my-5 p-5">
    <form method="post" class="container px-5 form-cotiz">
        <div class="form-floating mb-3">
            <select class="form-select" id="cliente" name="cliente">
                <option>Cotización 1</option>
                <option>Cotización 2</option>
            </select>
            <label for="cliente">Seleccionar cotización</label>
        </div>
        <div class="form-floating mb-3">
            <input type="text" class="form-control" name="nombre" id="nombre" placeholder="a">
            <label for="nombre">Título de asignación</label>
        </div>
        <div class="form-floating mb-3">
            <select class="form-select" id="empleado" name="empleado">
                <option>Empleado 1</option>
                <option>Empleado 2</option>
            </select>
            <label for="empleado">Asignar empleado</label>
        </div>
        <div class="form-floating mb-3">
            <input type="text" class="form-control" name="area" id="area" placeholder="a">
            <label for="area">Área asignada</label>
        </div>
        <div class="form-floating mb-3">
            <input type="datetime-local" class="form-control" name="inicio" id="inicio" placeholder="a">
            <label for="inicio">Fecha y hora de inicio</label>
        </div>
        <div class="form-floating mb-3">
            <input type="datetime-local" class="form-control" name="fin" id="fin" placeholder="a">
            <label for="fin">Fecha y hora de fin</label>
        </div>
        <div class="form-floating mb-3">
            <input type="number" class="form-control" name="costohora" id="costohora" placeholder="a">
            <label for="costohora">Costo por hora</label>
        </div>
        <div class="form-floating mb-3">
            <input type="number" class="form-control" name="horas" id="horas" placeholder="a">
            <label for="horas">Cantidad de horas aproximadas</label>
        </div>
        <div class="form-floating mb-3">
            <input type="number" class="form-control" name="costobase" id="costobase" placeholder="a">
            <label for="costobase">Costo base</label>
        </div>
        <div class="form-floating mb-3">
            <input type="number" class="form-control" name="extra" id="extra" placeholder="a">
            <label for="extra">Incremento extra</label>
        </div>
        <div class="text-center mt-3">
            <button type="submit" class="btn btn-cotiz">Añadir</button>
        </div>
    </form>
</main>
</body>
</html>
