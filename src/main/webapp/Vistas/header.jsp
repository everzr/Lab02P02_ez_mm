<%-- 
    Header/navbar include
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Sistema de Reserva de Vuelos</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    </head>
    <body>
        <nav class="navbar navbar-expand-lg navbar-dark bg-primary">
            <div class="container">
                <a class="navbar-brand" href="index.jsp">
                    <i class="fas fa-plane-departure me-2"></i>AeroReservas
                </a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarNav">
                    <ul class="navbar-nav ms-auto">
                        <li class="nav-item"><a class="nav-link" href="index.jsp"><i class="fas fa-home me-1"></i>Inicio</a></li>
                        <li class="nav-item"><a class="nav-link" href="servlet_vuelos"><i class="fas fa-plane me-1"></i>Vuelos</a></li>
                        <li class="nav-item"><a class="nav-link" href="servlet_pasajeros"><i class="fas fa-users me-1"></i>Pasajeros</a></li>
                        <li class="nav-item"><a class="nav-link" href="servelt_reservacion"><i class="fas fa-ticket-alt me-1"></i>Reservaciones</a></li>
                    </ul>
                </div>
            </div>
        </nav>
        <div class="container my-4">
