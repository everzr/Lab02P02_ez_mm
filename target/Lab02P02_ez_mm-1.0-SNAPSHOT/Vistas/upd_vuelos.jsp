<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@include file= "header.jsp" %>

<div class="container-fluid">
    <!-- Breadcrumb -->
    <nav aria-label="breadcrumb" class="breadcrumb-custom">
        <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="index.jsp">Inicio</a></li>
            <li class="breadcrumb-item"><a href="servlet_vuelos">Vuelos</a></li>
            <li class="breadcrumb-item active" aria-current="page">Editar Vuelo</li>
        </ol>
    </nav>

    <!-- Header Section -->
    <div class="row mb-4">
        <div class="col-md-8">
            <h2 class="fw-bold text-dark mb-2">
                <i class="fas fa-edit text-warning me-2"></i>Editar Vuelo #${vuelo.IDVuelo}
            </h2>
            <p class="text-muted mb-0">Modifica la información del vuelo ${vuelo.numeroVuelo}</p>
        </div>
        <div class="col-md-4 text-end">
            <a href="servlet_vuelos" class="btn btn-outline-secondary">
                <i class="fas fa-arrow-left me-1"></i>Volver a Vuelos
            </a>
        </div>
    </div>

    <!-- Flight Form -->
    <div class="card shadow-sm">
        <div class="card-header bg-warning text-dark">
            <h5 class="mb-0"><i class="fas fa-plane me-2"></i>Información del Vuelo</h5>
        </div>
        <div class="card-body">
            <form method="post" action="servlet_vuelos" id="flightEditForm">
                <input type="hidden" name="txtid" value="${vuelo.IDVuelo}"/>
                
                <!-- Basic Flight Information -->
                <div class="row mb-4">
                    <div class="col-12">
                        <h6 class="text-warning mb-3"><i class="fas fa-info-circle me-2"></i>Información Básica</h6>
                    </div>
                    <div class="col-md-4">
                        <label class="form-label fw-semibold">Número de Vuelo <span class="text-danger">*</span></label>
                        <div class="input-group">
                            <span class="input-group-text"><i class="fas fa-hashtag"></i></span>
                            <input type="text" class="form-control" name="txtNumeroVuelo" 
                                   value="${vuelo.numeroVuelo}" placeholder="Ej: SKY123" required>
                        </div>
                        <div class="form-text">Formato: Letras seguidas de números</div>
                    </div>
                    <div class="col-md-4">
                        <label class="form-label fw-semibold">Aerolínea <span class="text-danger">*</span></label>
                        <div class="input-group">
                            <span class="input-group-text"><i class="fas fa-building"></i></span>
                            <input type="text" class="form-control" name="txtAerolinea" 
                                   value="${vuelo.aerolinea}" placeholder="Nombre de la aerolínea" required>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <label class="form-label fw-semibold">Tipo de Avión <span class="text-danger">*</span></label>
                        <div class="input-group">
                            <span class="input-group-text"><i class="fas fa-plane"></i></span>
                            <input type="text" class="form-control" name="txtAvion" 
                                   value="${vuelo.avion}" placeholder="Modelo del avión" required>
                        </div>
                    </div>
                </div>

                <!-- Route Information -->
                <div class="row mb-4">
                    <div class="col-12">
                        <h6 class="text-warning mb-3"><i class="fas fa-route me-2"></i>Información de Ruta</h6>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label fw-semibold">Ciudad de Origen <span class="text-danger">*</span></label>
                        <div class="input-group">
                            <span class="input-group-text"><i class="fas fa-plane-departure"></i></span>
                            <input type="text" class="form-control" name="txtOrigen" 
                                   value="${vuelo.origen}" placeholder="Ciudad de origen" required>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label fw-semibold">Ciudad de Destino <span class="text-danger">*</span></label>
                        <div class="input-group">
                            <span class="input-group-text"><i class="fas fa-plane-arrival"></i></span>
                            <input type="text" class="form-control" name="txtDestino" 
                                   value="${vuelo.destino}" placeholder="Ciudad de destino" required>
                        </div>
                    </div>
                </div>

                <!-- Schedule Information -->
                <div class="row mb-4">
                    <div class="col-12">
                        <h6 class="text-warning mb-3"><i class="fas fa-clock me-2"></i>Horarios</h6>
                    </div>
                    <div class="col-md-3">
                        <label class="form-label fw-semibold">Fecha de Salida <span class="text-danger">*</span></label>
                        <div class="input-group">
                            <span class="input-group-text"><i class="fas fa-calendar"></i></span>
                            <c:choose>
                                <c:when test="${not empty vuelo.fechaSalida}">
                                    <input type="date" class="form-control" name="txtFechaSalida" 
                                           value="<fmt:formatDate value='${vuelo.fechaSalida}' pattern='yyyy-MM-dd'/>" required>
                                </c:when>
                                <c:otherwise>
                                    <input type="date" class="form-control" name="txtFechaSalida" required>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <label class="form-label fw-semibold">Hora de Salida <span class="text-danger">*</span></label>
                        <div class="input-group">
                            <span class="input-group-text"><i class="fas fa-clock"></i></span>
                            <c:choose>
                                <c:when test="${not empty vuelo.horaSalida}">
                                    <input type="time" class="form-control" name="txtHoraSalida" 
                                           value="<fmt:formatDate value='${vuelo.horaSalida}' pattern='HH:mm'/>" required>
                                </c:when>
                                <c:otherwise>
                                    <input type="time" class="form-control" name="txtHoraSalida" required>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <label class="form-label fw-semibold">Fecha de Llegada <span class="text-danger">*</span></label>
                        <div class="input-group">
                            <span class="input-group-text"><i class="fas fa-calendar"></i></span>
                            <c:choose>
                                <c:when test="${not empty vuelo.fechaLlegada}">
                                    <input type="date" class="form-control" name="txtFechaLlegada" 
                                           value="<fmt:formatDate value='${vuelo.fechaLlegada}' pattern='yyyy-MM-dd'/>" required>
                                </c:when>
                                <c:otherwise>
                                    <input type="date" class="form-control" name="txtFechaLlegada" required>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <label class="form-label fw-semibold">Hora de Llegada <span class="text-danger">*</span></label>
                        <div class="input-group">
                            <span class="input-group-text"><i class="fas fa-clock"></i></span>
                            <c:choose>
                                <c:when test="${not empty vuelo.horaLlegada}">
                                    <input type="time" class="form-control" name="txtHoraLlegada" 
                                           value="<fmt:formatDate value='${vuelo.horaLlegada}' pattern='HH:mm'/>" required>
                                </c:when>
                                <c:otherwise>
                                    <input type="time" class="form-control" name="txtHoraLlegada" required>
                                </c:otherwise>
                            </c:choose>
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
                                <button type="submit" class="btn btn-warning" name="btnUpdate" value="1">
                                    <i class="fas fa-save me-1"></i>Actualizar Vuelo
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
        // Auto-set arrival date to same as departure date when departure date changes
        document.querySelector('input[name="txtFechaSalida"]').addEventListener('change', function() {
            const fechaLlegada = document.querySelector('input[name="txtFechaLlegada"]');
            if (new Date(fechaLlegada.value) < new Date(this.value)) {
                fechaLlegada.value = this.value;
            }
        });
    });
    
    // Form validation
    document.getElementById('flightEditForm').addEventListener('submit', function(e) {
        const origen = document.querySelector('input[name="txtOrigen"]').value.trim();
        const destino = document.querySelector('input[name="txtDestino"]').value.trim();
        
        if (origen === destino && origen !== '') {
            e.preventDefault();
            alert('El origen y destino no pueden ser iguales. Por favor ingresa ciudades diferentes.');
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
