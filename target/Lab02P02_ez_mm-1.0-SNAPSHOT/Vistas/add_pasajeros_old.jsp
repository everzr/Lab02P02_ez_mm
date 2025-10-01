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