<%-- 
    Footer include
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
        </div> <!-- Closing container from header -->
        
        <!-- Modern Footer -->
        <footer class="mt-5" style="background: var(--gradient); color: white;">
            <div class="container py-5">
                <div class="row">
                    <div class="col-lg-4 mb-4">
                        <h4 class="fw-bold mb-3">
                            <i class="fas fa-plane-departure me-2"></i>SkyLine Airlines
                        </h4>
                        <p class="mb-3">Conectamos el mundo con experiencias de vuelo excepcionales. Tu viaje comienza con nosotros.</p>
                        <div class="d-flex gap-3">
                            <a href="#" class="text-white fs-4"><i class="fab fa-facebook"></i></a>
                            <a href="#" class="text-white fs-4"><i class="fab fa-twitter"></i></a>
                            <a href="#" class="text-white fs-4"><i class="fab fa-instagram"></i></a>
                            <a href="#" class="text-white fs-4"><i class="fab fa-linkedin"></i></a>
                        </div>
                    </div>
                    
                    <div class="col-lg-2 col-md-6 mb-4">
                        <h5 class="fw-semibold mb-3">Servicios</h5>
                        <ul class="list-unstyled">
                            <li class="mb-2"><a href="servlet_vuelos" class="text-white text-decoration-none"><i class="fas fa-chevron-right me-2"></i>Buscar Vuelos</a></li>
                            <li class="mb-2"><a href="servlet_pasajeros?accion=add" class="text-white text-decoration-none"><i class="fas fa-chevron-right me-2"></i>Registro</a></li>
                            <li class="mb-2"><a href="servelt_reservacion" class="text-white text-decoration-none"><i class="fas fa-chevron-right me-2"></i>Reservaciones</a></li>
                            <li class="mb-2"><a href="servelet_detalle_reservacion" class="text-white text-decoration-none"><i class="fas fa-chevron-right me-2"></i>Check-in</a></li>
                        </ul>
                    </div>
                    
                    <div class="col-lg-3 col-md-6 mb-4">
                        <h5 class="fw-semibold mb-3">Acceso Rápido</h5>
                        <div class="d-grid gap-2">
                            <a href="servlet_vuelos?accion=add" class="btn btn-outline-light btn-sm">
                                <i class="fas fa-plus me-1"></i>Nuevo Vuelo
                            </a>
                            <a href="servlet_pasajeros?accion=add" class="btn btn-outline-light btn-sm">
                                <i class="fas fa-user-plus me-1"></i>Registrar Pasajero
                            </a>
                            <a href="servelt_reservacion?accion=add" class="btn btn-outline-light btn-sm">
                                <i class="fas fa-ticket-alt me-1"></i>Nueva Reservación
                            </a>
                        </div>
                    </div>
                    
                    <div class="col-lg-3 mb-4">
                        <h5 class="fw-semibold mb-3">Contacto</h5>
                        <div class="mb-2">
                            <i class="fas fa-phone me-2"></i>
                            <strong>Reservas:</strong> +1 (800) 123-4567
                        </div>
                        <div class="mb-2">
                            <i class="fas fa-headset me-2"></i>
                            <strong>Soporte:</strong> 24/7 disponible
                        </div>
                        <div class="mb-2">
                            <i class="fas fa-envelope me-2"></i>
                            <strong>Email:</strong> info@skylineairlines.com
                        </div>
                        <div class="mb-2">
                            <i class="fas fa-map-marker-alt me-2"></i>
                            <strong>Oficinas:</strong> Ciudad Principal
                        </div>
                    </div>
                </div>
                
                <hr class="my-4" style="border-color: rgba(255,255,255,0.2);">
                
                <div class="row align-items-center">
                    <div class="col-md-6">
                        <p class="mb-0">&copy; 2025 SkyLine Airlines. Todos los derechos reservados.</p>
                    </div>
                    <div class="col-md-6 text-md-end">
                        <a href="#" class="text-white text-decoration-none me-3">Términos y Condiciones</a>
                        <a href="#" class="text-white text-decoration-none me-3">Privacidad</a>
                        <a href="Vistas/acerca.jsp" class="text-white text-decoration-none">Acerca de</a>
                    </div>
                </div>
            </div>
        </footer>
        
        <!-- JavaScript para funcionalidades interactivas -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
        <script>
            // Búsqueda global
            document.getElementById('globalSearch').addEventListener('keypress', function(e) {
                if (e.key === 'Enter') {
                    const searchTerm = this.value.trim();
                    if (searchTerm) {
                        // Redirigir a búsqueda de vuelos si contiene términos relacionados
                        if (searchTerm.toLowerCase().includes('vuelo') || searchTerm.toLowerCase().includes('destino')) {
                            window.location.href = 'servlet_vuelos?search=' + encodeURIComponent(searchTerm);
                        } else if (searchTerm.toLowerCase().includes('pasajero') || searchTerm.toLowerCase().includes('registro')) {
                            window.location.href = 'servlet_pasajeros?search=' + encodeURIComponent(searchTerm);
                        } else if (searchTerm.toLowerCase().includes('reserva')) {
                            window.location.href = 'servelt_reservacion?search=' + encodeURIComponent(searchTerm);
                        } else {
                            // Búsqueda general en vuelos
                            window.location.href = 'servlet_vuelos?search=' + encodeURIComponent(searchTerm);
                        }
                    }
                }
            });
            
            // Scroll to top function
            function scrollToTop() {
                window.scrollTo({
                    top: 0,
                    behavior: 'smooth'
                });
            }
            
            // Show/hide quick actions based on scroll
            let lastScrollTop = 0;
            window.addEventListener('scroll', function() {
                const quickActions = document.querySelector('.quick-actions');
                const scrollTop = window.pageYOffset || document.documentElement.scrollTop;
                
                if (scrollTop > 300) {
                    quickActions.style.opacity = '1';
                } else {
                    quickActions.style.opacity = '0.7';
                }
                
                lastScrollTop = scrollTop;
            });
            
            // Flight search modal function
            function showFlightSearch() {
                // Esta función se puede expandir para mostrar un modal de búsqueda
                window.location.href = 'servlet_vuelos';
            }
            
            // Smooth scroll for anchor links
            document.querySelectorAll('a[href^="#"]').forEach(anchor => {
                anchor.addEventListener('click', function (e) {
                    e.preventDefault();
                    const target = document.querySelector(this.getAttribute('href'));
                    if (target) {
                        target.scrollIntoView({
                            behavior: 'smooth',
                            block: 'start'
                        });
                    }
                });
            });
        </script>
    </body>
</html>
                <div class="text-center">
                    <p class="mb-0">&copy; 2025 AeroReservas. Todos los derechos reservados.</p>
                </div>
            </div>
        </footer>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
