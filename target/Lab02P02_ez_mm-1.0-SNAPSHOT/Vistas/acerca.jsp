<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file= "header.jsp" %>

<div class="container-fluid">
    <!-- Hero Section -->
    <section class="py-5 mb-5" style="background: var(--gradient); color: white;">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-lg-6">
                    <h1 class="display-4 fw-bold mb-4">Acerca de SkyLine Airlines</h1>
                    <p class="lead mb-4">Conectamos el mundo con experiencias de vuelo excepcionales desde 1999. Somos más que una aerolínea, somos tu compañero de viaje ideal.</p>
                    <div class="d-flex gap-3">
                        <a href="servlet_vuelos" class="btn btn-light btn-lg">
                            <i class="fas fa-search me-2"></i>Explorar Vuelos
                        </a>
                        <a href="servlet_pasajeros?accion=add" class="btn btn-outline-light btn-lg">
                            <i class="fas fa-user-plus me-2"></i>Únete a Nosotros
                        </a>
                    </div>
                </div>
                <div class="col-lg-6 text-center">
                    <img src="https://images.unsplash.com/photo-1556388158-158ea5ccacbd?w=500&h=350&fit=crop" 
                         alt="Avión SkyLine" class="img-fluid rounded-4 shadow-lg">
                </div>
            </div>
        </div>
    </section>

    <!-- Mission & Vision -->
    <section class="py-5 mb-5">
        <div class="container">
            <div class="row">
                <div class="col-lg-6 mb-4">
                    <div class="card h-100 border-primary">
                        <div class="card-body p-4">
                            <div class="d-flex align-items-center mb-3">
                                <div class="bg-primary rounded-circle d-flex align-items-center justify-content-center me-3" style="width: 60px; height: 60px;">
                                    <i class="fas fa-bullseye fa-2x text-white"></i>
                                </div>
                                <h3 class="fw-bold text-primary mb-0">Nuestra Misión</h3>
                            </div>
                            <p class="lead">Brindar servicios de transporte aéreo de la más alta calidad, conectando personas y culturas alrededor del mundo con seguridad, comodidad y excelencia en el servicio.</p>
                            <p class="text-muted">Nos comprometemos a hacer que cada viaje sea una experiencia memorable, desde el momento de la reserva hasta el destino final.</p>
                        </div>
                    </div>
                </div>
                <div class="col-lg-6 mb-4">
                    <div class="card h-100 border-success">
                        <div class="card-body p-4">
                            <div class="d-flex align-items-center mb-3">
                                <div class="bg-success rounded-circle d-flex align-items-center justify-content-center me-3" style="width: 60px; height: 60px;">
                                    <i class="fas fa-eye fa-2x text-white"></i>
                                </div>
                                <h3 class="fw-bold text-success mb-0">Nuestra Visión</h3>
                            </div>
                            <p class="lead">Ser la aerolínea líder en innovación y satisfacción del cliente, reconocida mundialmente por nuestra excelencia operacional y compromiso con la sostenibilidad.</p>
                            <p class="text-muted">Aspiramos a ser la primera opción de los viajeros que buscan calidad, confiabilidad y una experiencia de vuelo superior.</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Company Stats -->
    <section class="py-5 mb-5 bg-light">
        <div class="container">
            <div class="text-center mb-5">
                <h2 class="display-5 fw-bold">SkyLine en Números</h2>
                <p class="lead text-muted">Datos que respaldan nuestra excelencia</p>
            </div>
            <div class="row text-center">
                <div class="col-md-3 mb-4">
                    <div class="stat-card">
                        <i class="fas fa-globe-americas fa-4x text-primary mb-3"></i>
                        <h2 class="fw-bold display-4 text-primary">150+</h2>
                        <h5 class="fw-semibold">Destinos</h5>
                        <p class="text-muted">En más de 60 países</p>
                    </div>
                </div>
                <div class="col-md-3 mb-4">
                    <div class="stat-card">
                        <i class="fas fa-plane fa-4x text-success mb-3"></i>
                        <h2 class="fw-bold display-4 text-success">25M+</h2>
                        <h5 class="fw-semibold">Pasajeros</h5>
                        <p class="text-muted">Transportados anualmente</p>
                    </div>
                </div>
                <div class="col-md-3 mb-4">
                    <div class="stat-card">
                        <i class="fas fa-award fa-4x text-warning mb-3"></i>
                        <h2 class="fw-bold display-4 text-warning">25</h2>
                        <h5 class="fw-semibold">Años</h5>
                        <p class="text-muted">De experiencia</p>
                    </div>
                </div>
                <div class="col-md-3 mb-4">
                    <div class="stat-card">
                        <i class="fas fa-users fa-4x text-info mb-3"></i>
                        <h2 class="fw-bold display-4 text-info">10K+</h2>
                        <h5 class="fw-semibold">Empleados</h5>
                        <p class="text-muted">Profesionales dedicados</p>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Company Values -->
    <section class="py-5 mb-5">
        <div class="container">
            <div class="text-center mb-5">
                <h2 class="display-5 fw-bold">Nuestros Valores</h2>
                <p class="lead text-muted">Los principios que guían cada una de nuestras acciones</p>
            </div>
            <div class="row g-4">
                <div class="col-lg-4 col-md-6">
                    <div class="value-card text-center p-4 h-100">
                        <div class="value-icon mb-4">
                            <div class="bg-primary bg-gradient rounded-circle d-inline-flex align-items-center justify-content-center" style="width: 80px; height: 80px;">
                                <i class="fas fa-shield-alt fa-2x text-white"></i>
                            </div>
                        </div>
                        <h4 class="fw-bold mb-3">Seguridad</h4>
                        <p class="text-muted">La seguridad de nuestros pasajeros y tripulación es nuestra máxima prioridad. Cumplimos y superamos todos los estándares internacionales.</p>
                    </div>
                </div>
                <div class="col-lg-4 col-md-6">
                    <div class="value-card text-center p-4 h-100">
                        <div class="value-icon mb-4">
                            <div class="bg-success bg-gradient rounded-circle d-inline-flex align-items-center justify-content-center" style="width: 80px; height: 80px;">
                                <i class="fas fa-heart fa-2x text-white"></i>
                            </div>
                        </div>
                        <h4 class="fw-bold mb-3">Excelencia</h4>
                        <p class="text-muted">Nos esforzamos por la perfección en cada detalle, desde el servicio al cliente hasta la puntualidad en nuestros vuelos.</p>
                    </div>
                </div>
                <div class="col-lg-4 col-md-6">
                    <div class="value-card text-center p-4 h-100">
                        <div class="value-icon mb-4">
                            <div class="bg-info bg-gradient rounded-circle d-inline-flex align-items-center justify-content-center" style="width: 80px; height: 80px;">
                                <i class="fas fa-lightbulb fa-2x text-white"></i>
                            </div>
                        </div>
                        <h4 class="fw-bold mb-3">Innovación</h4>
                        <p class="text-muted">Adoptamos las últimas tecnologías para mejorar continuamente la experiencia de viaje de nuestros clientes.</p>
                    </div>
                </div>
                <div class="col-lg-4 col-md-6">
                    <div class="value-card text-center p-4 h-100">
                        <div class="value-icon mb-4">
                            <div class="bg-warning bg-gradient rounded-circle d-inline-flex align-items-center justify-content-center" style="width: 80px; height: 80px;">
                                <i class="fas fa-handshake fa-2x text-white"></i>
                            </div>
                        </div>
                        <h4 class="fw-bold mb-3">Compromiso</h4>
                        <p class="text-muted">Estamos comprometidos con nuestros clientes, empleados y las comunidades en las que operamos.</p>
                    </div>
                </div>
                <div class="col-lg-4 col-md-6">
                    <div class="value-card text-center p-4 h-100">
                        <div class="value-icon mb-4">
                            <div class="bg-danger bg-gradient rounded-circle d-inline-flex align-items-center justify-content-center" style="width: 80px; height: 80px;">
                                <i class="fas fa-leaf fa-2x text-white"></i>
                            </div>
                        </div>
                        <h4 class="fw-bold mb-3">Sostenibilidad</h4>
                        <p class="text-muted">Trabajamos activamente para reducir nuestro impacto ambiental y promover prácticas sostenibles en la aviación.</p>
                    </div>
                </div>
                <div class="col-lg-4 col-md-6">
                    <div class="value-card text-center p-4 h-100">
                        <div class="value-icon mb-4">
                            <div class="bg-dark bg-gradient rounded-circle d-inline-flex align-items-center justify-content-center" style="width: 80px; height: 80px;">
                                <i class="fas fa-globe fa-2x text-white"></i>
                            </div>
                        </div>
                        <h4 class="fw-bold mb-3">Diversidad</h4>
                        <p class="text-muted">Celebramos la diversidad y promovemos un ambiente inclusivo donde todos pueden prosperar.</p>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Team Section -->
    <section class="py-5 mb-5 bg-light">
        <div class="container">
            <div class="text-center mb-5">
                <h2 class="display-5 fw-bold">Nuestro Equipo</h2>
                <p class="lead text-muted">Conoce a los líderes que hacen posible nuestra excelencia</p>
            </div>
            <div class="row g-4">
                <div class="col-lg-4 col-md-6">
                    <div class="team-card card border-0 shadow-sm h-100">
                        <div class="card-body text-center p-4">
                            <div class="team-photo mb-3">
                                <div class="bg-primary rounded-circle d-inline-flex align-items-center justify-content-center" style="width: 100px; height: 100px;">
                                    <i class="fas fa-user fa-3x text-white"></i>
                                </div>
                            </div>
                            <h5 class="fw-bold">Ana García</h5>
                            <p class="text-primary fw-semibold">CEO & Fundadora</p>
                            <p class="text-muted">Con más de 20 años en la industria, Ana ha liderado la transformación digital de SkyLine Airlines.</p>
                        </div>
                    </div>
                </div>
                <div class="col-lg-4 col-md-6">
                    <div class="team-card card border-0 shadow-sm h-100">
                        <div class="card-body text-center p-4">
                            <div class="team-photo mb-3">
                                <div class="bg-success rounded-circle d-inline-flex align-items-center justify-content-center" style="width: 100px; height: 100px;">
                                    <i class="fas fa-user fa-3x text-white"></i>
                                </div>
                            </div>
                            <h5 class="fw-bold">Carlos Rodríguez</h5>
                            <p class="text-success fw-semibold">Director de Operaciones</p>
                            <p class="text-muted">Experto en logística aérea, Carlos asegura que cada vuelo opere con la máxima eficiencia y seguridad.</p>
                        </div>
                    </div>
                </div>
                <div class="col-lg-4 col-md-6">
                    <div class="team-card card border-0 shadow-sm h-100">
                        <div class="card-body text-center p-4">
                            <div class="team-photo mb-3">
                                <div class="bg-info rounded-circle d-inline-flex align-items-center justify-content-center" style="width: 100px; height: 100px;">
                                    <i class="fas fa-user fa-3x text-white"></i>
                                </div>
                            </div>
                            <h5 class="fw-bold">María López</h5>
                            <p class="text-info fw-semibold">Directora de Experiencia del Cliente</p>
                            <p class="text-muted">María se dedica a asegurar que cada pasajero tenga una experiencia excepcional desde la reserva hasta el destino.</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Technology Section -->
    <section class="py-5 mb-5">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-lg-6">
                    <h2 class="display-5 fw-bold mb-4">Tecnología de Vanguardia</h2>
                    <p class="lead mb-4">Nuestro sistema de gestión de vuelos utiliza las tecnologías más avanzadas para garantizar una experiencia fluida y eficiente.</p>
                    <div class="row g-3">
                        <div class="col-md-6">
                            <div class="d-flex align-items-center">
                                <i class="fas fa-check-circle text-success fa-2x me-3"></i>
                                <div>
                                    <h6 class="fw-bold mb-1">Sistema en Tiempo Real</h6>
                                    <small class="text-muted">Información actualizada al instante</small>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="d-flex align-items-center">
                                <i class="fas fa-shield-alt text-primary fa-2x me-3"></i>
                                <div>
                                    <h6 class="fw-bold mb-1">Seguridad Avanzada</h6>
                                    <small class="text-muted">Protección de datos de última generación</small>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="d-flex align-items-center">
                                <i class="fas fa-mobile-alt text-info fa-2x me-3"></i>
                                <div>
                                    <h6 class="fw-bold mb-1">Multiplataforma</h6>
                                    <small class="text-muted">Acceso desde cualquier dispositivo</small>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="d-flex align-items-center">
                                <i class="fas fa-cloud text-warning fa-2x me-3"></i>
                                <div>
                                    <h6 class="fw-bold mb-1">Cloud Computing</h6>
                                    <small class="text-muted">Escalabilidad y confiabilidad</small>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-6 text-center">
                    <img src="https://images.unsplash.com/photo-1551434678-e076c223a692?w=500&h=350&fit=crop" 
                         alt="Tecnología" class="img-fluid rounded-4 shadow-lg">
                </div>
            </div>
        </div>
    </section>

    <!-- Contact CTA -->
    <section class="py-5" style="background: var(--gradient); color: white;">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-lg-8">
                    <h3 class="fw-bold mb-3">¿Tienes preguntas sobre nuestros servicios?</h3>
                    <p class="lead mb-0">Nuestro equipo de atención al cliente está disponible 24/7 para ayudarte.</p>
                </div>
                <div class="col-lg-4 text-lg-end">
                    <div class="d-flex flex-column gap-2">
                        <div class="fw-semibold">
                            <i class="fas fa-phone me-2"></i>+1 (800) 123-SKYLINE
                        </div>
                        <div class="fw-semibold">
                            <i class="fas fa-envelope me-2"></i>contacto@skylineairlines.com
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
</div>

<style>
    .stat-card {
        transition: all 0.3s ease;
    }
    
    .stat-card:hover {
        transform: translateY(-10px);
    }
    
    .value-card {
        transition: all 0.3s ease;
        border-radius: 15px;
    }
    
    .value-card:hover {
        transform: translateY(-5px);
        box-shadow: 0 10px 30px rgba(0,0,0,0.1);
    }
    
    .team-card {
        transition: all 0.3s ease;
    }
    
    .team-card:hover {
        transform: translateY(-5px);
    }
</style>

<%@include file= "footer.jsp" %>
