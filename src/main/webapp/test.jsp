<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Test Page - SkyLine Airlines</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container mt-5">
        <div class="alert alert-success" role="alert">
            <h4 class="alert-heading">¡Sistema Funcionando!</h4>
            <p>Esta es una página de prueba para verificar que el sistema está funcionando correctamente.</p>
            <hr>
            <p class="mb-0">Si puedes ver esta página, significa que los cambios se aplicaron correctamente.</p>
        </div>
        
        <div class="card">
            <div class="card-header">
                <h5>Enlaces de Navegación</h5>
            </div>
            <div class="card-body">
                <div class="row">
                    <div class="col-md-3">
                        <a href="index.jsp" class="btn btn-primary w-100 mb-2">Página Principal</a>
                    </div>
                    <div class="col-md-3">
                        <a href="servlet_vuelos" class="btn btn-success w-100 mb-2">Vuelos</a>
                    </div>
                    <div class="col-md-3">
                        <a href="servlet_pasajeros" class="btn btn-info w-100 mb-2">Pasajeros</a>
                    </div>
                    <div class="col-md-3">
                        <a href="servelt_reservacion" class="btn btn-warning w-100 mb-2">Reservaciones</a>
                    </div>
                </div>
            </div>
        </div>
        
        <div class="card mt-3">
            <div class="card-header">
                <h5>Información del Sistema</h5>
            </div>
            <div class="card-body">
                <p><strong>Fecha y hora:</strong> <%= new java.util.Date() %></p>
                <p><strong>Versión JSP:</strong> <%= application.getMajorVersion() %>.<%= application.getMinorVersion() %></p>
                <p><strong>Servidor:</strong> <%= application.getServerInfo() %></p>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>