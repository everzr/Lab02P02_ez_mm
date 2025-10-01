<%-- 
    Página de inicio moderna para SkyLine Airlines
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file= "Vistas/header.jsp" %>

<div class="container-fluid p-0">
    <!-- Hero Section with Flight Search -->
    <section class="hero-section position-relative">
        <div style="background: linear-gradient(135deg, rgba(30, 64, 175, 0.9), rgba(59, 130, 246, 0.8)), url('https://images.unsplash.com/photo-1436491865332-7a61a109cc05?w=1920&h=1080&fit=crop') center/cover; min-height: 70vh; display: flex; align-items: center;">
            <div class="container">
                <div class="row align-items-center">
                    <div class="col-lg-6 text-white">
                        <h1 class="display-3 fw-bold mb-4">Vuela Hacia Tus Sueños</h1>
                        <p class="lead fs-4 mb-4">Descubre el mundo con SkyLine Airlines. Comodidad, seguridad y las mejores tarifas te esperan.</p>
                        <div class="d-flex flex-wrap gap-3">
                            <a href="servlet_vuelos" class="btn btn-light btn-lg px-4 py-3">
                                <i class="fas fa-search me-2"></i>Buscar Vuelos
                            </a>
                            <a href="servlet_pasajeros?accion=add" class="btn btn-outline-light btn-lg px-4 py-3">
                                <i class="fas fa-user-plus me-2"></i>Regístrate
                            </a>
                        </div>
                    </div>
                    <div class="col-lg-6">
                        <div class="hero-image text-center">
                            <img src="https://images.unsplash.com/photo-1556388158-158ea5ccacbd?w=600&h=400&fit=crop" 
                                 alt="Avión SkyLine" class="img-fluid rounded-4 shadow-lg" style="max-width: 500px;">
                        </div>
                    </div>
                </div>
            </div>
        </div>
        
        <!-- Quick Search Widget -->
        <div class="container">
            <div class="search-widget">
                <h4 class="text-center mb-4"><i class="fas fa-plane-departure text-primary me-2"></i>Encuentra tu vuelo ideal</h4>
                <form class="row g-3" action="servlet_vuelos" method="GET">
                    <div class="col-md-3">
                        <label class="form-label fw-semibold">Origen</label>
                        <div class="input-group">
                            <span class="input-group-text"><i class="fas fa-plane-departure"></i></span>
                            <input type="text" class="form-control" name="origen" placeholder="Ciudad de origen">
                        </div>
                    </div>
                    <div class="col-md-3">
                        <label class="form-label fw-semibold">Destino</label>
                        <div class="input-group">
                            <span class="input-group-text"><i class="fas fa-plane-arrival"></i></span>
                            <input type="text" class="form-control" name="destino" placeholder="Ciudad de destino">
                        </div>
                    </div>
                    <div class="col-md-2">
                        <label class="form-label fw-semibold">Fecha</label>
                        <input type="date" class="form-control" name="fecha">
                    </div>
                    <div class="col-md-2">
                        <label class="form-label fw-semibold">Pasajeros</label>
                        <select class="form-select" name="pasajeros">
                            <option value="1">1 Pasajero</option>
                            <option value="2">2 Pasajeros</option>
                            <option value="3">3 Pasajeros</option>
                            <option value="4">4+ Pasajeros</option>
                        </select>
                    </div>
                    <div class="col-md-2 d-flex align-items-end">
                        <button type="submit" class="btn btn-primary w-100 py-3">
                            <i class="fas fa-search me-1"></i>Buscar
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </section>

    <!-- Services Section -->
    <section class="py-5 bg-light">
        <div class="container">
            <div class="text-center mb-5">
                <h2 class="display-5 fw-bold text-dark">Nuestros Servicios</h2>
                <p class="lead text-muted">Todo lo que necesitas para un viaje perfecto</p>
            </div>
            
            <div class="row g-4">
                <div class="col-lg-4 col-md-6">
                    <div class="service-card h-100 p-4 bg-white rounded-4 shadow-sm text-center position-relative overflow-hidden">
                        <div class="service-icon mb-4">
                            <div class="bg-primary bg-gradient rounded-circle d-inline-flex align-items-center justify-content-center" style="width: 80px; height: 80px;">
                                <i class="fas fa-plane-departure fa-2x text-white"></i>
                            </div>
                        </div>
                        <h4 class="fw-bold mb-3">Gestión de Vuelos</h4>
                        <p class="text-muted mb-4">Administra vuelos, horarios y rutas de manera eficiente con nuestro sistema avanzado.</p>
                        <div class="d-grid gap-2">
                            <a href="servlet_vuelos" class="btn btn-primary">Ver Vuelos</a>
                            <a href="servlet_vuelos?accion=add" class="btn btn-outline-primary">Nuevo Vuelo</a>
                        </div>
                    </div>
                </div>
                
                <div class="col-lg-4 col-md-6">
                    <div class="service-card h-100 p-4 bg-white rounded-4 shadow-sm text-center position-relative overflow-hidden">
                        <div class="service-icon mb-4">
                            <div class="bg-success bg-gradient rounded-circle d-inline-flex align-items-center justify-content-center" style="width: 80px; height: 80px;">
                                <i class="fas fa-users fa-2x text-white"></i>
                            </div>
                        </div>
                        <h4 class="fw-bold mb-3">Registro de Pasajeros</h4>
                        <p class="text-muted mb-4">Sistema completo para el registro y gestión de información de pasajeros.</p>
                        <div class="d-grid gap-2">
                            <a href="servlet_pasajeros" class="btn btn-success">Ver Pasajeros</a>
                            <a href="servlet_pasajeros?accion=add" class="btn btn-outline-success">Registrar Nuevo</a>
                        </div>
                    </div>
                </div>
                
                <div class="col-lg-4 col-md-6">
                    <div class="service-card h-100 p-4 bg-white rounded-4 shadow-sm text-center position-relative overflow-hidden">
                        <div class="service-icon mb-4">
                            <div class="bg-warning bg-gradient rounded-circle d-inline-flex align-items-center justify-content-center" style="width: 80px; height: 80px;">
                                <i class="fas fa-ticket-alt fa-2x text-white"></i>
                            </div>
                        </div>
                        <h4 class="fw-bold mb-3">Reservaciones</h4>
                        <p class="text-muted mb-4">Crea y gestiona reservaciones de vuelos de forma rápida y segura.</p>
                        <div class="d-grid gap-2">
                            <a href="servelt_reservacion" class="btn btn-warning">Mis Reservaciones</a>
                            <a href="servelt_reservacion?accion=add" class="btn btn-outline-warning">Nueva Reservación</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Quick Stats Section -->
    <section class="py-5" style="background: var(--gradient);">
        <div class="container">
            <div class="row text-center text-white">
                <div class="col-md-3 mb-4">
                    <div class="stat-item">
                        <i class="fas fa-globe-americas fa-3x mb-3"></i>
                        <h3 class="fw-bold">150+</h3>
                        <p class="mb-0">Destinos Mundiales</p>
                    </div>
                </div>
                <div class="col-md-3 mb-4">
                    <div class="stat-item">
                        <i class="fas fa-plane fa-3x mb-3"></i>
                        <h3 class="fw-bold">500+</h3>
                        <p class="mb-0">Vuelos Diarios</p>
                    </div>
                </div>
                <div class="col-md-3 mb-4">
                    <div class="stat-item">
                        <i class="fas fa-heart fa-3x mb-3"></i>
                        <h3 class="fw-bold">1M+</h3>
                        <p class="mb-0">Clientes Satisfechos</p>
                    </div>
                </div>
                <div class="col-md-3 mb-4">
                    <div class="stat-item">
                        <i class="fas fa-award fa-3x mb-3"></i>
                        <h3 class="fw-bold">25</h3>
                        <p class="mb-0">Años de Experiencia</p>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Features Section -->
    <section class="py-5">
        <div class="container">
            <div class="text-center mb-5">
                <h2 class="display-5 fw-bold">¿Por qué elegir SkyLine?</h2>
                <p class="lead text-muted">Ventajas que nos hacen únicos</p>
            </div>
            
            <div class="row g-4">
                <div class="col-lg-3 col-md-6">
                    <div class="feature-item text-center h-100 p-4">
                        <div class="feature-icon mb-3">
                            <i class="fas fa-shield-alt fa-3x text-primary"></i>
                        </div>
                        <h5 class="fw-bold">Máxima Seguridad</h5>
                        <p class="text-muted mb-0">Protocolos de seguridad de última generación para tu tranquilidad.</p>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6">
                    <div class="feature-item text-center h-100 p-4">
                        <div class="feature-icon mb-3">
                            <i class="fas fa-dollar-sign fa-3x text-success"></i>
                        </div>
                        <h5 class="fw-bold">Precios Competitivos</h5>
                        <p class="text-muted mb-0">Las mejores tarifas del mercado sin comprometer la calidad.</p>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6">
                    <div class="feature-item text-center h-100 p-4">
                        <div class="feature-icon mb-3">
                            <i class="fas fa-headset fa-3x text-info"></i>
                        </div>
                        <h5 class="fw-bold">Soporte 24/7</h5>
                        <p class="text-muted mb-0">Atención al cliente disponible las 24 horas del día.</p>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6">
                    <div class="feature-item text-center h-100 p-4">
                        <div class="feature-icon mb-3">
                            <i class="fas fa-mobile-alt fa-3x text-warning"></i>
                        </div>
                        <h5 class="fw-bold">Tecnología Avanzada</h5>
                        <p class="text-muted mb-0">Plataforma moderna y fácil de usar desde cualquier dispositivo.</p>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Call to Action Section -->
    <section class="py-5 bg-light">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-lg-8">
                    <h3 class="fw-bold mb-3">¿Listo para tu próxima aventura?</h3>
                    <p class="lead mb-0">Únete a millones de viajeros que confían en SkyLine Airlines para sus viajes.</p>
                </div>
                <div class="col-lg-4 text-lg-end">
                    <a href="servlet_vuelos" class="btn btn-primary btn-lg me-3">
                        <i class="fas fa-search me-2"></i>Buscar Vuelos
                    </a>
                    <a href="servlet_pasajeros?accion=add" class="btn btn-outline-primary btn-lg">
                        <i class="fas fa-user-plus me-2"></i>Registrarse
                    </a>
                </div>
            </div>
        </div>
    </section>
</div>

<style>
    .service-card {
        transition: all 0.3s ease;
        border: 1px solid rgba(0,0,0,0.1);
    }
    
    .service-card:hover {
        transform: translateY(-10px);
        box-shadow: 0 20px 40px rgba(0,0,0,0.1) !important;
    }
    
    .feature-item {
        transition: all 0.3s ease;
    }
    
    .feature-item:hover {
        transform: translateY(-5px);
    }
    
    .stat-item {
        transition: all 0.3s ease;
    }
    
    .stat-item:hover {
        transform: scale(1.05);
    }
    
    .hero-image img {
        transition: all 0.3s ease;
    }
    
    .hero-image:hover img {
        transform: scale(1.05);
    }
</style>

<%@include file= "Vistas/footer.jsp" %>