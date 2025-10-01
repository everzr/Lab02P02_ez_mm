<%-- 
    Página de inicio
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file= "Vistas/header.jsp" %>

<!-- Hero Section -->
<div class="bg-primary text-white py-5 mb-5">
    <div class="container">
        <div class="row align-items-center">
            <div class="col-md-6">
                <h1 class="display-4 fw-bold">Viaja con Comodidad y Seguridad</h1>
                <p class="lead">Descubre los mejores destinos y reserva tu próximo viaje con nosotros.</p>
                <a href="servlet_vuelos" class="btn btn-light btn-lg">Buscar Vuelos</a>
            </div>
            <div class="col-md-6">
                <img src="https://placehold.co/600x400" alt="Avión" class="img-fluid rounded">
            </div>
        </div>
    </div>
    
</div>

<!-- Features Section -->
<div class="container mb-5">
    <div class="row g-4">
        <div class="col-md-4">
            <div class="card h-100 shadow-sm">
                <div class="card-body text-center">
                    <i class="fas fa-plane-departure fa-3x text-primary mb-3"></i>
                    <h3 class="card-title">Vuelos Disponibles</h3>
                    <p class="card-text">Explora nuestra amplia selección de vuelos a diferentes destinos.</p>
                    <a href="servlet_vuelos" class="btn btn-outline-primary">Ver Vuelos</a>
                </div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="card h-100 shadow-sm">
                <div class="card-body text-center">
                    <i class="fas fa-users fa-3x text-primary mb-3"></i>
                    <h3 class="card-title">Registro de Pasajeros</h3>
                    <p class="card-text">Gestiona tus datos de pasajero de manera fácil y segura.</p>
                    <a href="servlet_pasajeros" class="btn btn-outline-primary">Registrarse</a>
                </div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="card h-100 shadow-sm">
                <div class="card-body text-center">
                    <i class="fas fa-ticket-alt fa-3x text-primary mb-3"></i>
                    <h3 class="card-title">Mis Reservaciones</h3>
                    <p class="card-text">Accede y gestiona tus reservaciones de vuelo.</p>
                    <a href="servelt_reservacion" class="btn btn-outline-primary">Ver Reservaciones</a>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Why Choose Us Section -->
<div class="bg-light py-5 mb-5">
    <div class="container">
        <h2 class="text-center mb-4">¿Por qué elegirnos?</h2>
        <div class="row g-4">
            <div class="col-md-3">
                <div class="text-center">
                    <i class="fas fa-shield-alt fa-2x text-primary mb-3"></i>
                    <h4>Seguridad</h4>
                    <p>Tu seguridad es nuestra prioridad en cada vuelo.</p>
                </div>
            </div>
            <div class="col-md-3">
                <div class="text-center">
                    <i class="fas fa-dollar-sign fa-2x text-primary mb-3"></i>
                    <h4>Mejores Precios</h4>
                    <p>Ofertas competitivas para todos los destinos.</p>
                </div>
            </div>
            <div class="col-md-3">
                <div class="text-center">
                    <i class="fas fa-headset fa-2x text-primary mb-3"></i>
                    <h4>Atención 24/7</h4>
                    <p>Soporte disponible en todo momento.</p>
                </div>
            </div>
            <div class="col-md-3">
                <div class="text-center">
                    <i class="fas fa-smile fa-2x text-primary mb-3"></i>
                    <h4>Satisfacción</h4>
                    <p>Miles de clientes satisfechos nos respaldan.</p>
                </div>
            </div>
        </div>
    </div>
</div>

<%@include file= "Vistas/footer.jsp" %>
<%-- 
    Document   : index
    Created on : 30 sept 2025, 11:29:34 p. m.
    Author     : EverZr
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Hello World!</h1>
    </body>
</html>
