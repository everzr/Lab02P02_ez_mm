<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="header.jsp" %>

<div class="container-fluid">
    <!-- Breadcrumb -->
    <nav aria-label="breadcrumb" class="breadcrumb-custom">
        <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/index.jsp">Inicio</a></li>
            <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/servlet_pasajeros">Pasajeros</a></li>
            <li class="breadcrumb-item active" aria-current="page">Editar Pasajero</li>
        </ol>
    </nav>

    <!-- Header Section -->
    <div class="row mb-4">
        <div class="col-md-8">
            <h2 class="fw-bold text-dark mb-2">
                <i class="fas fa-user-edit text-success me-2"></i>Editar Pasajero #${pasajero.IDPasajero}
            </h2>
            <p class="text-muted mb-0">Modifica la información del pasajero ${pasajero.nombrePasajero}</p>
        </div>
        <div class="col-md-4 text-end">
            <a href="${pageContext.request.contextPath}/servlet_pasajeros" class="btn btn-outline-secondary">
                <i class="fas fa-arrow-left me-1"></i>Volver a Pasajeros
            </a>
        </div>
    </div>

    <!-- Passenger Form -->
    <div class="card shadow-sm">
        <div class="card-header bg-success text-white">
            <h5 class="mb-0"><i class="fas fa-user me-2"></i>Información del Pasajero</h5>
        </div>
        <div class="card-body">
            <form method="post" action="${pageContext.request.contextPath}/servlet_pasajeros" id="passengerEditForm">
                <input type="hidden" name="txtid" value="${pasajero.IDPasajero}"/>
                
                <!-- Basic Passenger Information -->
                <div class="row mb-4">
                    <div class="col-12">
                        <h6 class="text-success mb-3"><i class="fas fa-info-circle me-2"></i>Información Personal</h6>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label fw-semibold">Nombre Completo <span class="text-danger">*</span></label>
                        <div class="input-group">
                            <span class="input-group-text"><i class="fas fa-user"></i></span>
                            <input type="text" class="form-control" name="txtNombrePasajero" 
                                   value="${pasajero.nombrePasajero}" placeholder="Nombre completo del pasajero" required>
                        </div>
                        <div class="form-text">Ingresa el nombre completo como aparece en el documento oficial</div>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label fw-semibold">Nacionalidad</label>
                        <div class="input-group">
                            <span class="input-group-text"><i class="fas fa-flag"></i></span>
                            <select class="form-select" name="txtNacionalidad">
                                <option value="">Seleccionar nacionalidad</option>
                                <option value="guatemalteca" ${pasajero.nacionalidad == 'guatemalteca' ? 'selected' : ''}>Guatemalteca</option>
                                <option value="salvadoreña" ${pasajero.nacionalidad == 'salvadoreña' ? 'selected' : ''}>Salvadoreña</option>
                                <option value="hondureña" ${pasajero.nacionalidad == 'hondureña' ? 'selected' : ''}>Hondureña</option>
                                <option value="nicaragüense" ${pasajero.nacionalidad == 'nicaragüense' ? 'selected' : ''}>Nicaragüense</option>
                                <option value="costarricense" ${pasajero.nacionalidad == 'costarricense' ? 'selected' : ''}>Costarricense</option>
                                <option value="panameña" ${pasajero.nacionalidad == 'panameña' ? 'selected' : ''}>Panameña</option>
                                <option value="beliceña" ${pasajero.nacionalidad == 'beliceña' ? 'selected' : ''}>Beliceña</option>
                                <option value="mexicana" ${pasajero.nacionalidad == 'mexicana' ? 'selected' : ''}>Mexicana</option>
                                <option value="estadounidense" ${pasajero.nacionalidad == 'estadounidense' ? 'selected' : ''}>Estadounidense</option>
                                <option value="canadiense" ${pasajero.nacionalidad == 'canadiense' ? 'selected' : ''}>Canadiense</option>
                                <option value="española" ${pasajero.nacionalidad == 'española' ? 'selected' : ''}>Española</option>
                                <option value="otra" ${pasajero.nacionalidad == 'otra' ? 'selected' : ''}>Otra</option>
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
                                   value="${pasajero.pasaporte}" placeholder="Número de pasaporte" maxlength="50">
                        </div>
                        <div class="form-text">
                            <i class="fas fa-info-circle me-1"></i>
                            El número de pasaporte debe ser único en el sistema
                        </div>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label fw-semibold">Estado del Pasaporte</label>
                        <div class="input-group">
                            <span class="input-group-text">
                                <c:choose>
                                    <c:when test="${not empty pasajero.pasaporte}">
                                        <i class="fas fa-check-circle text-success"></i>
                                    </c:when>
                                    <c:otherwise>
                                        <i class="fas fa-exclamation-triangle text-warning"></i>
                                    </c:otherwise>
                                </c:choose>
                            </span>
                            <input type="text" class="form-control" readonly 
                                   value="${not empty pasajero.pasaporte ? 'Documentado' : 'Pendiente de documentación'}">
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
                                <a href="${pageContext.request.contextPath}/servlet_pasajeros" class="btn btn-outline-secondary">
                                    <i class="fas fa-times me-1"></i>Cancelar
                                </a>
                                <button type="submit" class="btn btn-success" name="btnUpdate" value="1">
                                    <i class="fas fa-save me-1"></i>Actualizar Pasajero
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
    // Form validation
    document.addEventListener('DOMContentLoaded', function() {
        const pasaporteInput = document.querySelector('input[name="txtPasaporte"]');
        
        // Validar formato de pasaporte (básico)
        if (pasaporteInput) {
            pasaporteInput.addEventListener('input', function() {
                const value = this.value.toUpperCase();
                this.value = value;
                
                // Actualizar indicador visual
                const statusInput = this.closest('.row').querySelector('input[readonly]');
                const statusIcon = this.closest('.row').querySelector('.input-group-text i');
                
                if (value.trim()) {
                    statusInput.value = 'Documentado';
                    statusIcon.className = 'fas fa-check-circle text-success';
                } else {
                    statusInput.value = 'Pendiente de documentación';
                    statusIcon.className = 'fas fa-exclamation-triangle text-warning';
                }
            });
        }
    });
    
    // Form validation
    document.getElementById('passengerEditForm').addEventListener('submit', function(e) {
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
