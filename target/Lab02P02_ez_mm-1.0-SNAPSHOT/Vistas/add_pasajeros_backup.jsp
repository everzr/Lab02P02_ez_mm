<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="header.jsp" %>

<div class="container-fluid">
    <!-- Breadcrumb -->
    <nav aria-label="breadcrumb" class="breadcrumb-custom">
        <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="index.jsp">Inicio</a></li>
            <li class="breadcrumb-item"><a href="servlet_pasajeros">Pasajeros</a></li>
            <li class="breadcrumb-item active" aria-current="page">Registrar Pasajero</li>
        </ol>
    </nav>

    <!-- Header Section -->
    <div class="row mb-4">
        <div class="col-md-8">
            <h2 class="fw-bold text-dark mb-2">
                <i class="fas fa-user-plus text-success me-2"></i>Registrar Nuevo Pasajero
            </h2>
            <p class="text-muted mb-0">Complete la información del pasajero para registrarlo en el sistema</p>
        </div>
        <div class="col-md-4 text-end">
            <a href="servlet_pasajeros" class="btn btn-outline-secondary">
                <i class="fas fa-arrow-left me-1"></i>Volver a Pasajeros
            </a>
        </div>
    </div>

    <div class="row">
        <!-- Registration Form -->
        <div class="col-lg-8">
            <div class="card shadow-sm">
                <div class="card-header bg-success text-white">
                    <h5 class="mb-0"><i class="fas fa-user me-2"></i>Información del Pasajero</h5>
                </div>
                <div class="card-body">
                    <form method="post" action="servlet_pasajeros" id="passengerForm">
                        <!-- Personal Information -->
                        <div class="row mb-4">
                            <div class="col-12">
                                <h6 class="text-success mb-3"><i class="fas fa-id-card me-2"></i>Información Personal</h6>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label fw-semibold">Nombre Completo <span class="text-danger">*</span></label>
                                <div class="input-group">
                                    <span class="input-group-text"><i class="fas fa-user"></i></span>
                                    <input type="text" class="form-control" name="txtNombrePasajero" placeholder="Nombre completo del pasajero" required>
                                </div>
                                <div class="form-text">Ingrese el nombre como aparece en el documento oficial</div>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label fw-semibold">Nacionalidad</label>
                                <div class="input-group">
                                    <span class="input-group-text"><i class="fas fa-flag"></i></span>
                                    <select class="form-select" name="txtNacionalidad">
                                        <option value="">Seleccionar nacionalidad</option>
                                        <option value="guatemalteca">Guatemalteca</option>
                                        <option value="salvadoreña">Salvadoreña</option>
                                        <option value="hondureña">Hondureña</option>
                                        <option value="nicaragüense">Nicaragüense</option>
                                        <option value="costarricense">Costarricense</option>
                                        <option value="panameña">Panameña</option>
                                        <option value="beliceña">Beliceña</option>
                                        <option value="mexicana">Mexicana</option>
                                        <option value="estadounidense">Estadounidense</option>
                                        <option value="canadiense">Canadiense</option>
                                        <option value="española">Española</option>
                                        <option value="otra">Otra</option>
                                    </select>
                                </div>
                            </div>
                        </div>

                        <!-- Document Information -->
                        <div class="row mb-4">
                            <div class="col-12">
                                <h6 class="text-success mb-3"><i class="fas fa-passport me-2"></i>Documentación</h6>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label fw-semibold">Número de Pasaporte</label>
                                <div class="input-group">
                                    <span class="input-group-text"><i class="fas fa-passport"></i></span>
                                    <input type="text" class="form-control font-monospace" name="txtPasaporte" 
                                           placeholder="Número de pasaporte" maxlength="50">
                                </div>
                                <div class="form-text">
                                    <i class="fas fa-info-circle me-1"></i>
                                    El número de pasaporte debe ser único en el sistema (opcional)
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
                                        <a href="servlet_pasajeros" class="btn btn-outline-secondary">
                                            <i class="fas fa-times me-1"></i>Cancelar
                                        </a>
                                        <button type="submit" class="btn btn-success" name="btnAgregar" value="1">
                                            <i class="fas fa-user-plus me-1"></i>Registrar Pasajero
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
        
        <!-- Information Panel -->
        <div class="col-lg-4">
            <div class="card shadow-sm">
                <div class="card-header bg-light">
                    <h6 class="mb-0"><i class="fas fa-info-circle me-2"></i>Información Importante</h6>
                </div>
                <div class="card-body">
                    <div class="mb-3">
                        <h6 class="text-success"><i class="fas fa-check-circle me-2"></i>Requisitos</h6>
                        <ul class="list-unstyled mb-0">
                            <li class="mb-2">
                                <i class="fas fa-user text-muted me-2"></i>
                                <small>Nombre completo como aparece en documentos oficiales</small>
                            </li>
                            <li class="mb-2">
                                <i class="fas fa-flag text-muted me-2"></i>
                                <small>Nacionalidad del pasajero (opcional)</small>
                            </li>
                            <li class="mb-2">
                                <i class="fas fa-passport text-muted me-2"></i>
                                <small>Número de pasaporte único (opcional)</small>
                            </li>
                        </ul>
                    </div>
                    
                    <div class="mb-3">
                        <h6 class="text-primary"><i class="fas fa-lightbulb me-2"></i>Consejos</h6>
                        <ul class="list-unstyled mb-0">
                            <li class="mb-2">
                                <i class="fas fa-arrow-right text-muted me-2"></i>
                                <small>Verifique la información antes de enviar</small>
                            </li>
                            <li class="mb-2">
                                <i class="fas fa-arrow-right text-muted me-2"></i>
                                <small>El pasaporte puede agregarse posteriormente</small>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
            
            <!-- Recent Passengers -->
            <c:if test="${not empty pasajeros}">
                <div class="card shadow-sm mt-4">
                    <div class="card-header bg-light">
                        <h6 class="mb-0"><i class="fas fa-clock me-2"></i>Pasajeros Recientes</h6>
                    </div>
                    <div class="card-body">
                        <c:forEach var="p" items="${pasajeros}" varStatus="status">
                            <div class="d-flex align-items-center mb-2">
                                <div class="bg-success rounded-circle d-flex align-items-center justify-content-center me-3" style="width: 30px; height: 30px;">
                                    <i class="fas fa-user text-white small"></i>
                                </div>
                                <div>
                                    <small class="fw-bold d-block">${p.nombrePasajero}</small>
                                    <small class="text-muted">${p.nacionalidad != null ? p.nacionalidad : 'Sin nacionalidad'}</small>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </div>
            </c:if>
        </div>
    </div>
</div>

<script>
    // Form validation
    document.addEventListener('DOMContentLoaded', function() {
        const pasaporteInput = document.querySelector('input[name="txtPasaporte"]');
        
        // Convertir pasaporte a mayúsculas
        if (pasaporteInput) {
            pasaporteInput.addEventListener('input', function() {
                this.value = this.value.toUpperCase();
            });
        }
    });
    
    // Form validation
    document.getElementById('passengerForm').addEventListener('submit', function(e) {
        const nombre = document.querySelector('input[name="txtNombrePasajero"]').value.trim();
        
        if (!nombre) {
            e.preventDefault();
            alert('El nombre del pasajero es obligatorio.');
            return false;
        }
        
        if (nombre.length < 2) {
            e.preventDefault();
            alert('El nombre debe tener al menos 2 caracteres.');
            return false;
        }
    });
</script>

<%@ include file="footer.jsp" %>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label fw-semibold">Fecha de Nacimiento</label>
                                <div class="input-group">
                                    <span class="input-group-text"><i class="fas fa-calendar"></i></span>
                                    <input type="date" class="form-control" name="txtFechaNacimiento" id="fechaNacimientoInput">
                                </div>
                            </div>
                        </div>

                        <!-- Document Information -->
                        <div class="row mb-4">
                            <div class="col-12">
                                <h6 class="text-success mb-3"><i class="fas fa-passport me-2"></i>Documentación</h6>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label fw-semibold">Nacionalidad <span class="text-danger">*</span></label>
                                <div class="input-group">
                                    <span class="input-group-text"><i class="fas fa-flag"></i></span>
                                    <select class="form-select" name="txtNacionalidad" required>
                                        <option value="">Seleccionar nacionalidad</option>
                                        <option value="mexicana">Mexicana</option>
                                        <option value="estadounidense">Estadounidense</option>
                                        <option value="canadiense">Canadiense</option>
                                        <option value="española">Española</option>
                                        <option value="francesa">Francesa</option>
                                        <option value="alemana">Alemana</option>
                                        <option value="italiana">Italiana</option>
                                        <option value="britanica">Británica</option>
                                        <option value="argentina">Argentina</option>
                                        <option value="brasileña">Brasileña</option>
                                        <option value="colombiana">Colombiana</option>
                                        <option value="chilena">Chilena</option>
                                        <option value="otra">Otra</option>
                                    </select>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label fw-semibold">Número de Pasaporte <span class="text-danger">*</span></label>
                                <div class="input-group">
                                    <span class="input-group-text"><i class="fas fa-passport"></i></span>
                                    <input type="text" class="form-control" name="txtPasaporte" placeholder="Ej: ABC123456" required pattern="[A-Z0-9]{6,15}">
                                </div>
                                <div class="form-text">Solo letras mayúsculas y números, 6-15 caracteres</div>
                            </div>
                        </div>

                        <!-- Contact Information -->
                        <div class="row mb-4">
                            <div class="col-12">
                                <h6 class="text-success mb-3"><i class="fas fa-address-book me-2"></i>Información de Contacto</h6>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label fw-semibold">Correo Electrónico</label>
                                <div class="input-group">
                                    <span class="input-group-text"><i class="fas fa-envelope"></i></span>
                                    <input type="email" class="form-control" name="txtEmail" placeholder="correo@ejemplo.com">
                                </div>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label fw-semibold">Teléfono</label>
                                <div class="input-group">
                                    <span class="input-group-text"><i class="fas fa-phone"></i></span>
                                    <input type="tel" class="form-control" name="txtTelefono" placeholder="+52 123 456 7890">
                                </div>
                            </div>
                        </div>

                        <!-- Additional Information -->
                        <div class="row mb-4">
                            <div class="col-12">
                                <h6 class="text-success mb-3"><i class="fas fa-info-circle me-2"></i>Información Adicional</h6>
                            </div>
                            <div class="col-md-4">
                                <label class="form-label fw-semibold">Género</label>
                                <div class="input-group">
                                    <span class="input-group-text"><i class="fas fa-user-friends"></i></span>
                                    <select class="form-select" name="txtGenero">
                                        <option value="">Seleccionar</option>
                                        <option value="masculino">Masculino</option>
                                        <option value="femenino">Femenino</option>
                                        <option value="otro">Otro</option>
                                        <option value="prefiero_no_decir">Prefiero no decir</option>
                                    </select>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <label class="form-label fw-semibold">Estado Civil</label>
                                <div class="input-group">
                                    <span class="input-group-text"><i class="fas fa-heart"></i></span>
                                    <select class="form-select" name="txtEstadoCivil">
                                        <option value="">Seleccionar</option>
                                        <option value="soltero">Soltero(a)</option>
                                        <option value="casado">Casado(a)</option>
                                        <option value="divorciado">Divorciado(a)</option>
                                        <option value="viudo">Viudo(a)</option>
                                    </select>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <label class="form-label fw-semibold">Profesión</label>
                                <div class="input-group">
                                    <span class="input-group-text"><i class="fas fa-briefcase"></i></span>
                                    <input type="text" class="form-control" name="txtProfesion" placeholder="Profesión u ocupación">
                                </div>
                            </div>
                        </div>

                        <!-- Emergency Contact -->
                        <div class="row mb-4">
                            <div class="col-12">
                                <h6 class="text-success mb-3"><i class="fas fa-exclamation-triangle me-2"></i>Contacto de Emergencia</h6>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label fw-semibold">Nombre del Contacto</label>
                                <div class="input-group">
                                    <span class="input-group-text"><i class="fas fa-user-shield"></i></span>
                                    <input type="text" class="form-control" name="txtContactoEmergencia" placeholder="Nombre completo">
                                </div>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label fw-semibold">Teléfono de Emergencia</label>
                                <div class="input-group">
                                    <span class="input-group-text"><i class="fas fa-phone-alt"></i></span>
                                    <input type="tel" class="form-control" name="txtTelefonoEmergencia" placeholder="+52 123 456 7890">
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
                                        <a href="servlet_pasajeros" class="btn btn-outline-secondary">
                                            <i class="fas fa-times me-1"></i>Cancelar
                                        </a>
                                        <button type="button" class="btn btn-outline-success" onclick="previewPassenger()">
                                            <i class="fas fa-eye me-1"></i>Vista Previa
                                        </button>
                                        <button type="submit" class="btn btn-success" name="btnAgregar" value="1">
                                            <i class="fas fa-save me-1"></i>Registrar Pasajero
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <!-- Recent Passengers & Tips -->
        <div class="col-lg-4">
            <!-- Quick Tips -->
            <div class="card shadow-sm mb-4">
                <div class="card-header bg-info text-white">
                    <h6 class="mb-0"><i class="fas fa-lightbulb me-2"></i>Consejos de Registro</h6>
                </div>
                <div class="card-body">
                    <ul class="list-unstyled mb-0">
                        <li class="mb-2"><i class="fas fa-check text-success me-2"></i>Verifique que el nombre coincida con el pasaporte</li>
                        <li class="mb-2"><i class="fas fa-check text-success me-2"></i>El pasaporte debe estar vigente</li>
                        <li class="mb-2"><i class="fas fa-check text-success me-2"></i>Proporcione un contacto de emergencia</li>
                        <li class="mb-0"><i class="fas fa-check text-success me-2"></i>Mantenga actualizada la información</li>
                    </ul>
                </div>
            </div>

            <!-- Recent Passengers -->
            <div class="card shadow-sm">
                <div class="card-header bg-light">
                    <h6 class="mb-0"><i class="fas fa-history me-2"></i>Últimos Registrados</h6>
                </div>
                <div class="card-body">
                    <c:if test="${empty pasajeros}">
                        <p class="text-muted text-center mb-0">No hay pasajeros registrados recientemente</p>
                    </c:if>
                    <c:if test="${not empty pasajeros}">
                        <c:forEach var="p" items="${pasajeros}" begin="0" end="4">
                            <div class="d-flex align-items-center mb-2">
                                <div class="bg-success rounded-circle d-flex align-items-center justify-content-center me-3" style="width: 30px; height: 30px;">
                                    <i class="fas fa-user text-white fa-sm"></i>
                                </div>
                                <div class="flex-grow-1">
                                    <div class="fw-semibold">${p.nombrePasajero}</div>
                                    <small class="text-muted">${p.pasaporte}</small>
                                </div>
                            </div>
                        </c:forEach>
                        <a href="servlet_pasajeros" class="btn btn-outline-success btn-sm w-100 mt-2">
                            <i class="fas fa-eye me-1"></i>Ver Todos
                        </a>
                    </c:if>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Preview Modal -->
<div class="modal fade" id="previewModal" tabindex="-1">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header bg-success text-white">
                <h5 class="modal-title"><i class="fas fa-eye me-2"></i>Vista Previa del Registro</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body" id="previewContent">
                <!-- Preview content will be generated here -->
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
                <button type="button" class="btn btn-success" onclick="submitForm()">
                    <i class="fas fa-save me-1"></i>Confirmar y Registrar
                </button>
            </div>
        </div>
    </div>
</div>

<script>
    // Set maximum date for birth date (today)
    document.addEventListener('DOMContentLoaded', function() {
        const today = new Date().toISOString().split('T')[0];
        document.getElementById('fechaNacimientoInput').setAttribute('max', today);
    });
    
    // Passport formatting
    document.querySelector('input[name="txtPasaporte"]').addEventListener('input', function() {
        this.value = this.value.toUpperCase().replace(/[^A-Z0-9]/g, '');
    });
    
    // Phone formatting
    function formatPhone(input) {
        let value = input.value.replace(/\D/g, '');
        if (value.length >= 10) {
            value = '+52 ' + value.substring(0, 3) + ' ' + value.substring(3, 6) + ' ' + value.substring(6, 10);
        }
        input.value = value;
    }
    
    document.querySelector('input[name="txtTelefono"]').addEventListener('input', function() {
        formatPhone(this);
    });
    
    document.querySelector('input[name="txtTelefonoEmergencia"]').addEventListener('input', function() {
        formatPhone(this);
    });
    
    // Preview passenger information
    function previewPassenger() {
        const form = document.getElementById('passengerForm');
        const formData = new FormData(form);
        
        let previewHTML = '<div class="row">';
        
        // Personal Information
        previewHTML += '<div class="col-md-6"><h6 class="text-success">Información Personal</h6>';
        previewHTML += '<div class="bg-light p-3 rounded mb-3">';
        previewHTML += '<p><strong>Nombre:</strong> ' + (formData.get('txtNombrePasajero') || 'No especificado') + '</p>';
        previewHTML += '<p><strong>Fecha de Nacimiento:</strong> ' + (formData.get('txtFechaNacimiento') || 'No especificado') + '</p>';
        previewHTML += '<p><strong>Género:</strong> ' + (formData.get('txtGenero') || 'No especificado') + '</p>';
        previewHTML += '<p><strong>Estado Civil:</strong> ' + (formData.get('txtEstadoCivil') || 'No especificado') + '</p>';
        previewHTML += '</div></div>';
        
        // Documentation
        previewHTML += '<div class="col-md-6"><h6 class="text-success">Documentación</h6>';
        previewHTML += '<div class="bg-light p-3 rounded mb-3">';
        previewHTML += '<p><strong>Nacionalidad:</strong> ' + (formData.get('txtNacionalidad') || 'No especificado') + '</p>';
        previewHTML += '<p><strong>Pasaporte:</strong> ' + (formData.get('txtPasaporte') || 'No especificado') + '</p>';
        previewHTML += '</div></div>';
        
        // Contact Information
        previewHTML += '<div class="col-md-6"><h6 class="text-success">Contacto</h6>';
        previewHTML += '<div class="bg-light p-3 rounded mb-3">';
        previewHTML += '<p><strong>Email:</strong> ' + (formData.get('txtEmail') || 'No especificado') + '</p>';
        previewHTML += '<p><strong>Teléfono:</strong> ' + (formData.get('txtTelefono') || 'No especificado') + '</p>';
        previewHTML += '<p><strong>Profesión:</strong> ' + (formData.get('txtProfesion') || 'No especificado') + '</p>';
        previewHTML += '</div></div>';
        
        // Emergency Contact
        previewHTML += '<div class="col-md-6"><h6 class="text-success">Contacto de Emergencia</h6>';
        previewHTML += '<div class="bg-light p-3 rounded mb-3">';
        previewHTML += '<p><strong>Nombre:</strong> ' + (formData.get('txtContactoEmergencia') || 'No especificado') + '</p>';
        previewHTML += '<p><strong>Teléfono:</strong> ' + (formData.get('txtTelefonoEmergencia') || 'No especificado') + '</p>';
        previewHTML += '</div></div>';
        
        previewHTML += '</div>';
        
        document.getElementById('previewContent').innerHTML = previewHTML;
        $('#previewModal').modal('show');
    }
    
    // Submit form from modal
    function submitForm() {
        document.getElementById('passengerForm').submit();
    }
    
    // Form validation
    document.getElementById('passengerForm').addEventListener('submit', function(e) {
        const pasaporte = document.querySelector('input[name="txtPasaporte"]').value;
        if (pasaporte.length < 6) {
            e.preventDefault();
            alert('El número de pasaporte debe tener al menos 6 caracteres.');
            return false;
        }
        
        const email = document.querySelector('input[name="txtEmail"]').value;
        if (email && !email.includes('@')) {
            e.preventDefault();
            alert('Por favor ingrese un correo electrónico válido.');
            return false;
        }
    });
</script>

<%@include page="footer.jsp"%>
