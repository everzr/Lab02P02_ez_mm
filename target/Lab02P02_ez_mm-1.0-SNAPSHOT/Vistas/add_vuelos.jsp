<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file= "header.jsp" %>

<div class="container-fluid">
    <!-- Breadcrumb -->
    <nav aria-label="breadcrumb" class="breadcrumb-custom">
        <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="index.jsp">Inicio</a></li>
            <li class="breadcrumb-item"><a href="servlet_vuelos">Vuelos</a></li>
            <li class="breadcrumb-item active" aria-current="page">Agregar Vuelo</li>
        </ol>
    </nav>

    <!-- Header Section -->
    <div class="row mb-4">
        <div class="col-md-8">
            <h2 class="fw-bold text-dark mb-2">
                <i class="fas fa-plane-departure text-primary me-2"></i>Agregar Nuevo Vuelo
            </h2>
            <p class="text-muted mb-0">Complete la información del vuelo para agregarlo al sistema</p>
        </div>
        <div class="col-md-4 text-end">
            <a href="servlet_vuelos" class="btn btn-outline-secondary">
                <i class="fas fa-arrow-left me-1"></i>Volver a Vuelos
            </a>
        </div>
    </div>

    <!-- Flight Form -->
    <div class="card shadow-sm">
        <div class="card-header bg-primary text-white">
            <h5 class="mb-0"><i class="fas fa-plane me-2"></i>Información del Vuelo</h5>
        </div>
        <div class="card-body">
            <form method="post" action="servlet_vuelos" id="flightForm">
                <!-- Basic Flight Information -->
                <div class="row mb-4">
                    <div class="col-12">
                        <h6 class="text-primary mb-3"><i class="fas fa-info-circle me-2"></i>Información Básica</h6>
                    </div>
                    <div class="col-md-4">
                        <label class="form-label fw-semibold">Número de Vuelo <span class="text-danger">*</span></label>
                        <div class="input-group">
                            <span class="input-group-text"><i class="fas fa-hashtag"></i></span>
                            <input type="text" class="form-control" name="txtNumeroVuelo" placeholder="Ej: SKY123" required>
                        </div>
                        <div class="form-text">Formato: Letras seguidas de números</div>
                    </div>
                    <div class="col-md-4">
                        <label class="form-label fw-semibold">Aerolínea <span class="text-danger">*</span></label>
                        <div class="input-group">
                            <span class="input-group-text"><i class="fas fa-building"></i></span>
                            <select class="form-select" name="txtAerolinea" required>
                                <option value="">Seleccionar aerolínea</option>
                                <option value="SkyLine Airlines">SkyLine Airlines</option>
                                <option value="Avianca">Avianca</option>
                                <option value="Copa Airlines">Copa Airlines</option>
                                <option value="Volaris Costa Rica">Volaris Costa Rica</option>
                                <option value="TAG Airlines">TAG Airlines</option>
                                <option value="Otra">Otra</option>
                            </select>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <label class="form-label fw-semibold">Tipo de Avión <span class="text-danger">*</span></label>
                        <div class="input-group">
                            <span class="input-group-text"><i class="fas fa-plane"></i></span>
                            <select class="form-select" name="txtAvion" required>
                                <option value="">Seleccionar tipo</option>
                                <option value="Boeing 737">Boeing 737</option>
                                <option value="Boeing 787">Boeing 787</option>
                                <option value="Airbus A320">Airbus A320</option>
                                <option value="Airbus A330">Airbus A330</option>
                                <option value="Embraer E190">Embraer E190</option>
                            </select>
                        </div>
                    </div>
                </div>

                <!-- Route Information -->
                <div class="row mb-4">
                    <div class="col-12">
                        <h6 class="text-primary mb-3"><i class="fas fa-route me-2"></i>Información de Ruta</h6>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label fw-semibold">Ciudad de Origen <span class="text-danger">*</span></label>
                        <div class="input-group">
                            <span class="input-group-text"><i class="fas fa-plane-departure"></i></span>
                            <select class="form-select" name="txtOrigen" required>
                                <option value="">Seleccionar origen</option>
                                <option value="Ciudad de Guatemala (GUA)">Ciudad de Guatemala (GUA)</option>
                                <option value="San José (SJO)">San José, Costa Rica (SJO)</option>
                                <option value="Tegucigalpa (TGU)">Tegucigalpa, Honduras (TGU)</option>
                                <option value="San Salvador (SAL)">San Salvador, El Salvador (SAL)</option>
                                <option value="Managua (MGA)">Managua, Nicaragua (MGA)</option>
                                <option value="Ciudad de Panamá (PTY)">Ciudad de Panamá (PTY)</option>
                                <option value="Ciudad de Belice (BZE)">Ciudad de Belice (BZE)</option>
                            </select>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label fw-semibold">Ciudad de Destino <span class="text-danger">*</span></label>
                        <div class="input-group">
                            <span class="input-group-text"><i class="fas fa-plane-arrival"></i></span>
                            <select class="form-select" name="txtDestino" required>
                                <option value="">Seleccionar destino</option>
                                <option value="Ciudad de Guatemala (GUA)">Ciudad de Guatemala (GUA)</option>
                                <option value="San José (SJO)">San José, Costa Rica (SJO)</option>
                                <option value="Tegucigalpa (TGU)">Tegucigalpa, Honduras (TGU)</option>
                                <option value="San Salvador (SAL)">San Salvador, El Salvador (SAL)</option>
                                <option value="Managua (MGA)">Managua, Nicaragua (MGA)</option>
                                <option value="Ciudad de Panamá (PTY)">Ciudad de Panamá (PTY)</option>
                                <option value="Ciudad de Belice (BZE)">Ciudad de Belice (BZE)</option>
                            </select>
                        </div>
                    </div>
                </div>

                <!-- Schedule Information -->
                <div class="row mb-4">
                    <div class="col-12">
                        <h6 class="text-primary mb-3"><i class="fas fa-clock me-2"></i>Horarios</h6>
                    </div>
                    <div class="col-md-3">
                        <label class="form-label fw-semibold">Fecha de Salida <span class="text-danger">*</span></label>
                        <div class="input-group">
                            <span class="input-group-text"><i class="fas fa-calendar"></i></span>
                            <input type="date" class="form-control" name="txtFechaSalida" required id="fechaSalidaInput">
                        </div>
                    </div>
                    <div class="col-md-3">
                        <label class="form-label fw-semibold">Hora de Salida <span class="text-danger">*</span></label>
                        <div class="input-group">
                            <span class="input-group-text"><i class="fas fa-clock"></i></span>
                            <input type="time" class="form-control" name="txtHoraSalida" required>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <label class="form-label fw-semibold">Fecha de Llegada <span class="text-danger">*</span></label>
                        <div class="input-group">
                            <span class="input-group-text"><i class="fas fa-calendar"></i></span>
                            <input type="date" class="form-control" name="txtFechaLlegada" required>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <label class="form-label fw-semibold">Hora de Llegada <span class="text-danger">*</span></label>
                        <div class="input-group">
                            <span class="input-group-text"><i class="fas fa-clock"></i></span>
                            <input type="time" class="form-control" name="txtHoraLlegada" required>
                        </div>
                    </div>
                </div>

                <!-- Form Actions -->
                <div class="row">
                    <div class="col-12">
                        <div class="d-flex justify-content-between align-items-center">
                            <div>
                                <small class="text-muted">Los campos marcados con <span class="text-danger">*</span> son obligatorios</small>
                            </div>
                            <div class="btn-group">
                                <a href="servlet_vuelos" class="btn btn-outline-secondary">
                                    <i class="fas fa-times me-1"></i>Cancelar
                                </a>
                                <button type="submit" class="btn btn-primary" name="btnAgregar" value="1">
                                    <i class="fas fa-save me-1"></i>Guardar Vuelo
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>

<script>
    // Add event listeners for form validation
    document.addEventListener('DOMContentLoaded', function() {
        // Set minimum date to today
        const today = new Date().toISOString().split('T')[0];
        document.getElementById('fechaSalidaInput').setAttribute('min', today);
        document.querySelector('input[name="txtFechaLlegada"]').setAttribute('min', today);
        
        // Auto-set arrival date to same as departure date when departure date changes
        document.querySelector('input[name="txtFechaSalida"]').addEventListener('change', function() {
            const fechaLlegada = document.querySelector('input[name="txtFechaLlegada"]');
            if (!fechaLlegada.value) {
                fechaLlegada.value = this.value;
            }
        });
        
        // Prevent selecting same origin and destination
        const origenSelect = document.querySelector('select[name="txtOrigen"]');
        const destinoSelect = document.querySelector('select[name="txtDestino"]');
        
        function updateDestinationOptions() {
            const selectedOrigen = origenSelect.value;
            Array.from(destinoSelect.options).forEach(option => {
                if (option.value === selectedOrigen && option.value !== '') {
                    option.style.display = 'none';
                } else {
                    option.style.display = 'block';
                }
            });
        }
        
        origenSelect.addEventListener('change', updateDestinationOptions);
    });
    
    // Form validation
    document.getElementById('flightForm').addEventListener('submit', function(e) {
        const origen = document.querySelector('select[name="txtOrigen"]').value;
        const destino = document.querySelector('select[name="txtDestino"]').value;
        
        if (origen === destino && origen !== '') {
            e.preventDefault();
            alert('El origen y destino no pueden ser iguales. Por favor selecciona ciudades diferentes.');
            return false;
        }
        
        const fechaSalida = document.querySelector('input[name="txtFechaSalida"]').value;
        const fechaLlegada = document.querySelector('input[name="txtFechaLlegada"]').value;
        
        if (fechaLlegada < fechaSalida) {
            e.preventDefault();
            alert('La fecha de llegada no puede ser anterior a la fecha de salida.');
            return false;
        }
    });
</script>

<%@include file= "footer.jsp" %>
