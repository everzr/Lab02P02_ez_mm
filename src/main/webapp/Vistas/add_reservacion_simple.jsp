<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@include file= "header.jsp" %>

<div class="container-fluid">
    <!-- Breadcrumb -->
    <nav aria-label="breadcrumb" class="breadcrumb-custom">
        <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="index.jsp">Inicio</a></li>
            <li class="breadcrumb-item"><a href="servlet_reservaciones?accion=con">Reservaciones</a></li>
            <li class="breadcrumb-item active" aria-current="page">Nueva Reservación</li>
        </ol>
    </nav>

    <div class="row justify-content-center">
        <div class="col-lg-8">
            <!-- Header -->
            <div class="text-center mb-4">
                <div class="bg-primary rounded-circle d-inline-flex align-items-center justify-content-center mb-3" 
                     style="width: 80px; height: 80px;">
                    <i class="fas fa-ticket-alt fa-2x text-white"></i>
                </div>
                <h2 class="fw-bold text-dark mb-2">Nueva Reservación</h2>
                <p class="text-muted mb-0">Crea una nueva reservación de manera rápida y sencilla</p>
            </div>

            <!-- Main Form Card -->
            <div class="card shadow-lg border-0">
                <div class="card-header bg-primary text-white">
                    <h5 class="mb-0"><i class="fas fa-calendar-plus me-2"></i>Información de la Reservación</h5>
                </div>
                <form action="servlet_reservaciones" method="POST" id="reservationForm">
                    <input type="hidden" name="accion" value="add">
                    
                    <div class="card-body p-4">
                        <!-- Step 1: Fecha de Reservación -->
                        <div class="step-section mb-4" id="step1">
                            <div class="d-flex align-items-center mb-3">
                                <div class="bg-primary rounded-circle d-flex align-items-center justify-content-center me-3" 
                                     style="width: 35px; height: 35px;">
                                    <span class="text-white fw-bold">1</span>
                                </div>
                                <h6 class="mb-0 text-primary fw-bold">Selecciona la Fecha de tu Viaje</h6>
                            </div>
                            
                            <div class="row">
                                <div class="col-md-6">
                                    <label for="fechaReservacion" class="form-label fw-semibold">
                                        <i class="fas fa-calendar text-primary me-2"></i>Fecha de Reservación*
                                    </label>
                                    <input type="date" class="form-control form-control-lg" 
                                           id="fechaReservacion" name="fechaReservacion" required
                                           min="<%= new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date()) %>">
                                    <div class="form-text">Selecciona la fecha para tu vuelo</div>
                                </div>
                                <div class="col-md-6">
                                    <div class="bg-light rounded p-3 h-100 d-flex align-items-center">
                                        <div>
                                            <i class="fas fa-info-circle text-info me-2"></i>
                                            <small class="text-muted">
                                                <strong>Tip:</strong> Puedes reservar vuelos hasta 365 días por adelantado.
                                                Los precios pueden variar según la fecha seleccionada.
                                            </small>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Available Flights Section (Hidden initially) -->
                        <div class="step-section" id="step2" style="display: none;">
                            <div class="d-flex align-items-center mb-3">
                                <div class="bg-success rounded-circle d-flex align-items-center justify-content-center me-3" 
                                     style="width: 35px; height: 35px;">
                                    <span class="text-white fw-bold">2</span>
                                </div>
                                <h6 class="mb-0 text-success fw-bold">Vuelos Disponibles</h6>
                            </div>
                            
                            <div id="availableFlights">
                                <!-- Flights will be loaded here via JavaScript -->
                            </div>
                        </div>

                        <!-- Passenger Information (Hidden initially) -->
                        <div class="step-section" id="step3" style="display: none;">
                            <div class="d-flex align-items-center mb-3">
                                <div class="bg-warning rounded-circle d-flex align-items-center justify-content-center me-3" 
                                     style="width: 35px; height: 35px;">
                                    <span class="text-white fw-bold">3</span>
                                </div>
                                <h6 class="mb-0 text-warning fw-bold">Información del Pasajero</h6>
                            </div>
                            
                            <div class="row">
                                <div class="col-md-6">
                                    <label class="form-label fw-semibold">
                                        <i class="fas fa-user text-warning me-2"></i>Pasajero
                                    </label>
                                    <select class="form-select form-select-lg" name="idPasajero" id="pasajeroSelect">
                                        <option value="">Selecciona un pasajero...</option>
                                        <c:forEach var="p" items="${pasajeros}">
                                            <option value="${p.IDPasajero}">${p.nombres} ${p.apellidos} - ${p.documento}</option>
                                        </c:forEach>
                                    </select>
                                    <div class="form-text">
                                        ¿No encuentras el pasajero? 
                                        <a href="servlet_pasajeros?accion=add" target="_blank" class="text-primary">
                                            Registrar nuevo pasajero
                                        </a>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label fw-semibold">
                                        <i class="fas fa-tags text-warning me-2"></i>Tipo de Reservación
                                    </label>
                                    <select class="form-select form-select-lg" name="tipoReservacion" id="tipoReservacion">
                                        <option value="ECONOMICA">Económica</option>
                                        <option value="PREMIUM">Premium</option>
                                        <option value="BUSINESS">Business</option>
                                        <option value="FIRST_CLASS">Primera Clase</option>
                                    </select>
                                </div>
                            </div>
                        </div>

                        <!-- Hidden Fields -->
                        <input type="hidden" name="idVuelo" id="selectedFlightId">
                        <input type="hidden" name="estado" value="CONFIRMADA">
                    </div>

                    <!-- Form Actions -->
                    <div class="card-footer bg-light">
                        <div class="d-flex justify-content-between">
                            <a href="servlet_reservaciones?accion=con" class="btn btn-outline-secondary btn-lg">
                                <i class="fas fa-arrow-left me-2"></i>Cancelar
                            </a>
                            <div>
                                <button type="button" class="btn btn-primary btn-lg me-2" id="searchFlightsBtn" onclick="searchFlights()">
                                    <i class="fas fa-search me-2"></i>Buscar Vuelos
                                </button>
                                <button type="submit" class="btn btn-success btn-lg" id="submitBtn" style="display: none;">
                                    <i class="fas fa-check me-2"></i>Crear Reservación
                                </button>
                            </div>
                        </div>
                    </div>
                </form>
            </div>

            <!-- Quick Actions -->
            <div class="text-center mt-4">
                <div class="row">
                    <div class="col-md-4">
                        <a href="servlet_vuelos?accion=con" class="text-decoration-none">
                            <div class="bg-light rounded p-3 h-100 hover-card">
                                <i class="fas fa-plane-departure fa-2x text-primary mb-2"></i>
                                <h6 class="mb-0">Ver Vuelos</h6>
                                <small class="text-muted">Consultar vuelos disponibles</small>
                            </div>
                        </a>
                    </div>
                    <div class="col-md-4">
                        <a href="servlet_pasajeros?accion=add" class="text-decoration-none">
                            <div class="bg-light rounded p-3 h-100 hover-card">
                                <i class="fas fa-user-plus fa-2x text-success mb-2"></i>
                                <h6 class="mb-0">Nuevo Pasajero</h6>
                                <small class="text-muted">Registrar pasajero</small>
                            </div>
                        </a>
                    </div>
                    <div class="col-md-4">
                        <a href="servlet_reservaciones?accion=con" class="text-decoration-none">
                            <div class="bg-light rounded p-3 h-100 hover-card">
                                <i class="fas fa-list fa-2x text-info mb-2"></i>
                                <h6 class="mb-0">Mis Reservaciones</h6>
                                <small class="text-muted">Ver reservaciones existentes</small>
                            </div>
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<style>
.hover-card {
    transition: all 0.3s ease;
    cursor: pointer;
}

.hover-card:hover {
    background-color: #f8f9fa !important;
    transform: translateY(-2px);
    box-shadow: 0 4px 8px rgba(0,0,0,0.1);
}

.step-section {
    padding: 1.5rem;
    margin-bottom: 1rem;
    border: 2px solid #e9ecef;
    border-radius: 0.5rem;
    transition: all 0.3s ease;
}

.step-section.active {
    border-color: #0d6efd;
    background-color: #f8f9ff;
}

.flight-option {
    border: 2px solid #e9ecef;
    border-radius: 0.5rem;
    padding: 1rem;
    margin-bottom: 1rem;
    cursor: pointer;
    transition: all 0.3s ease;
}

.flight-option:hover {
    border-color: #0d6efd;
    background-color: #f8f9ff;
}

.flight-option.selected {
    border-color: #198754;
    background-color: #f8fff9;
}

.loading-spinner {
    text-align: center;
    padding: 2rem;
}
</style>

<script>
let selectedFlight = null;

// Search for flights based on selected date
function searchFlights() {
    const fechaReservacion = document.getElementById('fechaReservacion').value;
    
    if (!fechaReservacion) {
        alert('Por favor selecciona una fecha para la reservación.');
        return;
    }
    
    // Show loading
    document.getElementById('step2').style.display = 'block';
    document.getElementById('step2').classList.add('active');
    document.getElementById('availableFlights').innerHTML = `
        <div class="loading-spinner">
            <i class="fas fa-spinner fa-spin fa-2x text-primary"></i>
            <p class="mt-2">Buscando vuelos disponibles para ${fechaReservacion}...</p>
        </div>
    `;
    
    // Simulate API call - In real implementation, this would be an AJAX call
    setTimeout(() => {
        loadAvailableFlights(fechaReservacion);
    }, 2000);
}

// Load available flights (simulated data)
function loadAvailableFlights(fecha) {
    // In real implementation, this would fetch from servlet
    const flightsHtml = `
        <div class="row">
            <div class="col-12">
                <p class="text-muted mb-3">Vuelos disponibles para ${fecha}:</p>
            </div>
            
            <!-- Flight Option 1 -->
            <div class="col-md-6 mb-3">
                <div class="flight-option" onclick="selectFlight(1, 'AA101', 'Guatemala - Miami')">
                    <div class="d-flex justify-content-between align-items-start">
                        <div>
                            <h6 class="fw-bold mb-1">AA101</h6>
                            <p class="text-muted mb-1">American Airlines</p>
                            <div class="d-flex align-items-center">
                                <span class="fw-semibold">Guatemala</span>
                                <i class="fas fa-arrow-right mx-2 text-primary"></i>
                                <span class="fw-semibold">Miami</span>
                            </div>
                            <small class="text-muted">08:30 - 12:45</small>
                        </div>
                        <div class="text-end">
                            <div class="badge bg-success">Disponible</div>
                            <div class="mt-1">
                                <small class="text-muted">Boeing 737</small>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Flight Option 2 -->
            <div class="col-md-6 mb-3">
                <div class="flight-option" onclick="selectFlight(2, 'UA205', 'Guatemala - México')">
                    <div class="d-flex justify-content-between align-items-start">
                        <div>
                            <h6 class="fw-bold mb-1">UA205</h6>
                            <p class="text-muted mb-1">United Airlines</p>
                            <div class="d-flex align-items-center">
                                <span class="fw-semibold">Guatemala</span>
                                <i class="fas fa-arrow-right mx-2 text-primary"></i>
                                <span class="fw-semibold">México</span>
                            </div>
                            <small class="text-muted">14:20 - 16:30</small>
                        </div>
                        <div class="text-end">
                            <div class="badge bg-success">Disponible</div>
                            <div class="mt-1">
                                <small class="text-muted">Airbus A320</small>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Flight Option 3 -->
            <div class="col-md-6 mb-3">
                <div class="flight-option" onclick="selectFlight(3, 'DL308', 'Guatemala - Los Angeles')">
                    <div class="d-flex justify-content-between align-items-start">
                        <div>
                            <h6 class="fw-bold mb-1">DL308</h6>
                            <p class="text-muted mb-1">Delta Airlines</p>
                            <div class="d-flex align-items-center">
                                <span class="fw-semibold">Guatemala</span>
                                <i class="fas fa-arrow-right mx-2 text-primary"></i>
                                <span class="fw-semibold">Los Angeles</span>
                            </div>
                            <small class="text-muted">18:15 - 21:45</small>
                        </div>
                        <div class="text-end">
                            <div class="badge bg-warning">Pocos asientos</div>
                            <div class="mt-1">
                                <small class="text-muted">Boeing 757</small>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Flight Option 4 -->
            <div class="col-md-6 mb-3">
                <div class="flight-option" onclick="selectFlight(4, 'AV401', 'Guatemala - Madrid')">
                    <div class="d-flex justify-content-between align-items-start">
                        <div>
                            <h6 class="fw-bold mb-1">AV401</h6>
                            <p class="text-muted mb-1">Avianca</p>
                            <div class="d-flex align-items-center">
                                <span class="fw-semibold">Guatemala</span>
                                <i class="fas fa-arrow-right mx-2 text-primary"></i>
                                <span class="fw-semibold">Madrid</span>
                            </div>
                            <small class="text-muted">22:30 - 16:20+1</small>
                        </div>
                        <div class="text-end">
                            <div class="badge bg-success">Disponible</div>
                            <div class="mt-1">
                                <small class="text-muted">Airbus A330</small>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        
        <div class="text-center mt-3">
            <small class="text-muted">
                <i class="fas fa-info-circle me-1"></i>
                Selecciona un vuelo para continuar con la reservación
            </small>
        </div>
    `;
    
    document.getElementById('availableFlights').innerHTML = flightsHtml;
}

// Select a flight
function selectFlight(id, flightNumber, route) {
    // Remove previous selections
    document.querySelectorAll('.flight-option').forEach(option => {
        option.classList.remove('selected');
    });
    
    // Select current flight
    event.currentTarget.classList.add('selected');
    selectedFlight = { id, flightNumber, route };
    document.getElementById('selectedFlightId').value = id;
    
    // Show passenger information section
    document.getElementById('step3').style.display = 'block';
    document.getElementById('step3').classList.add('active');
    
    // Show submit button
    document.getElementById('submitBtn').style.display = 'inline-block';
    document.getElementById('searchFlightsBtn').textContent = 'Cambiar Vuelo';
    document.getElementById('searchFlightsBtn').innerHTML = '<i class="fas fa-exchange-alt me-2"></i>Cambiar Vuelo';
    
    // Scroll to passenger section
    document.getElementById('step3').scrollIntoView({ behavior: 'smooth' });
}

// Form validation
document.getElementById('reservationForm').addEventListener('submit', function(e) {
    if (!selectedFlight) {
        e.preventDefault();
        alert('Por favor selecciona un vuelo antes de continuar.');
        return;
    }
    
    const pasajero = document.getElementById('pasajeroSelect').value;
    if (!pasajero) {
        e.preventDefault();
        alert('Por favor selecciona un pasajero para la reservación.');
        return;
    }
    
    // Show success message
    const submitBtn = document.getElementById('submitBtn');
    submitBtn.innerHTML = '<i class="fas fa-spinner fa-spin me-2"></i>Creando Reservación...';
    submitBtn.disabled = true;
});

// Set minimum date to today
document.addEventListener('DOMContentLoaded', function() {
    const fechaInput = document.getElementById('fechaReservacion');
    const today = new Date().toISOString().split('T')[0];
    fechaInput.min = today;
    
    // Set focus to date input
    fechaInput.focus();
});
</script>

<%@include file= "footer.jsp" %>