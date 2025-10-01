<%-- 
    Header/navbar include
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>SkyLine Airlines - Sistema de Reservas</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
        <link href="css/skyline-fixed.css" rel="stylesheet">
        <style>
            :root {
                --primary-color: #1e40af;
                --secondary-color: #3b82f6;
                --accent-color: #06b6d4;
                --dark-color: #1f2937;
                --light-color: #f8fafc;
                --gradient: linear-gradient(135deg, #1e40af 0%, #3b82f6 100%);
            }
            
            * {
                font-family: 'Poppins', sans-serif;
            }
            
            body {
                background-color: var(--light-color);
            }
            
            .navbar-custom {
                background: var(--gradient);
                box-shadow: 0 4px 20px rgba(30, 64, 175, 0.15);
                padding: 0.8rem 0;
            }
            
            .navbar-brand {
                font-weight: 700;
                font-size: 1.5rem;
                letter-spacing: -0.5px;
            }
            
            .navbar-nav .nav-link {
                font-weight: 500;
                padding: 0.7rem 1rem !important;
                border-radius: 25px;
                margin: 0 0.2rem;
                transition: all 0.3s ease;
                position: relative;
            }
            
            .navbar-nav .nav-link:hover {
                background-color: rgba(255, 255, 255, 0.1);
                transform: translateY(-1px);
            }
            
            .navbar-nav .nav-link.active {
                background-color: rgba(255, 255, 255, 0.2);
                font-weight: 600;
            }
            
            .dropdown-menu {
                border: none;
                box-shadow: 0 10px 30px rgba(0, 0, 0, 0.15);
                border-radius: 10px;
                padding: 0.5rem 0;
            }
            
            .dropdown-item {
                padding: 0.7rem 1.5rem;
                transition: all 0.3s ease;
            }
            
            .dropdown-item:hover {
                background-color: var(--primary-color);
                color: white;
                transform: translateX(5px);
            }
            
            .btn-primary {
                background: var(--gradient);
                border: none;
                padding: 0.6rem 1.5rem;
                border-radius: 25px;
                font-weight: 500;
                transition: all 0.3s ease;
            }
            
            .btn-primary:hover {
                transform: translateY(-2px);
                box-shadow: 0 8px 25px rgba(30, 64, 175, 0.3);
            }
            
            /* Global search styling */
            .global-search {
                max-width: 400px;
            }
            
            .global-search .form-control {
                border-radius: 25px 0 0 25px;
                border: none;
                padding: 0.7rem 1rem;
            }
            
            .global-search .btn {
                border-radius: 0 25px 25px 0;
                border: none;
                padding: 0.7rem 1rem;
            }
            
            .breadcrumb-custom {
                background: transparent;
                padding: 1rem 0;
                margin-bottom: 1rem;
            }
            
            .breadcrumb-custom .breadcrumb-item a {
                color: var(--secondary-color);
                text-decoration: none;
                transition: color 0.3s ease;
            }
            
            .breadcrumb-custom .breadcrumb-item a:hover {
                color: var(--primary-color);
            }
            
            /* Remove floating actions */
            .content-wrapper {
                padding-top: 80px;
            }
        </style>
    </head>
    <body>
        <!-- Navigation -->
        <nav class="navbar navbar-expand-lg navbar-dark navbar-custom fixed-top">
            <div class="container">
                <a class="navbar-brand" href="${pageContext.request.contextPath}/index.jsp">
                    <i class="fas fa-plane-departure me-2"></i>SkyLine Airlines
                </a>
                
                <!-- Global search bar in navbar -->
                <div class="d-none d-lg-flex flex-grow-1 justify-content-center mx-4">
                    <div class="input-group global-search">
                        <input type="text" class="form-control" placeholder="Buscar vuelos, destinos, pasajeros..." 
                               id="globalSearch" onkeypress="handleGlobalSearch(event)">
                        <button class="btn btn-light" type="button" onclick="performGlobalSearch()">
                            <i class="fas fa-search"></i>
                        </button>
                    </div>
                </div>
                
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                    <span class="navbar-toggler-icon"></span>
                </button>
                
                <div class="collapse navbar-collapse" id="navbarNav">
                    <ul class="navbar-nav ms-auto">
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/index.jsp">
                                <i class="fas fa-home me-1"></i>Inicio
                            </a>
                        </li>
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle" href="#" id="vuelosDropdown" role="button" data-bs-toggle="dropdown">
                                <i class="fas fa-plane me-1"></i>Vuelos
                            </a>
                            <ul class="dropdown-menu">
                                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/servlet_vuelos">
                                    <i class="fas fa-list me-2"></i>Ver Vuelos
                                </a></li>
                                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/servlet_vuelos?accion=add">
                                    <i class="fas fa-plus me-2"></i>Nuevo Vuelo
                                </a></li>
                                <li><hr class="dropdown-divider"></li>
                                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/servlet_vuelos?accion=con&search=" onclick="focusGlobalSearch()">
                                    <i class="fas fa-search me-2"></i>Buscar Vuelos
                                </a></li>
                            </ul>
                        </li>
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle" href="#" id="pasajerosDropdown" role="button" data-bs-toggle="dropdown">
                                <i class="fas fa-users me-1"></i>Pasajeros
                            </a>
                            <ul class="dropdown-menu">
                                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/servlet_pasajeros">
                                    <i class="fas fa-list me-2"></i>Ver Pasajeros
                                </a></li>
                                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/servlet_pasajeros?accion=add">
                                    <i class="fas fa-user-plus me-2"></i>Registrar Pasajero
                                </a></li>
                            </ul>
                        </li>
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle" href="#" id="reservacionesDropdown" role="button" data-bs-toggle="dropdown">
                                <i class="fas fa-ticket-alt me-1"></i>Reservaciones
                            </a>
                            <ul class="dropdown-menu">
                                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/servelt_reservacion">
                                    <i class="fas fa-list me-2"></i>Mis Reservaciones
                                </a></li>
                                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/servlet_reservacion_rapida">
                                    <i class="fas fa-plus me-2"></i>Reservación Rápida
                                </a></li>
                                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/servelt_reservacion?accion=add">
                                    <i class="fas fa-cog me-2"></i>Reservación Completa
                                </a></li>
                                <li><hr class="dropdown-divider"></li>
                                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/servelet_detalle_reservacion">
                                    <i class="fas fa-info-circle me-2"></i>Detalles
                                </a></li>
                            </ul>
                        </li>
                    </ul>
                </div>
            </div>
        </nav>
        
        <!-- Content wrapper with proper spacing -->
        <div class="content-wrapper">
            <script>
                // Global search functionality
                function handleGlobalSearch(event) {
                    if (event.key === 'Enter') {
                        performGlobalSearch();
                    }
                }
                
                function performGlobalSearch() {
                    const searchTerm = document.getElementById('globalSearch').value.trim();
                    if (searchTerm) {
                        // Redirect to flights search with the term
                        window.location.href = '${pageContext.request.contextPath}/servlet_vuelos?accion=con&search=' + encodeURIComponent(searchTerm);
                    }
                }
                
                function focusGlobalSearch() {
                    document.getElementById('globalSearch').focus();
                }
                
                // Scroll to top function
                function scrollToTop() {
                    window.scrollTo({ top: 0, behavior: 'smooth' });
                }
            </script>
            
            <!-- Bootstrap JS -->
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
