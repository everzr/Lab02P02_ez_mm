<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@include file="header.jsp"%>

<div class="container-fluid">
    <!-- Breadcrumb -->
    <nav aria-label="breadcrumb" class="breadcrumb-custom">
        <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/index.jsp">Inicio</a></li>
            <li class="breadcrumb-item active" aria-current="page">Mis Reservaciones</li>
        </ol>
    </nav>

    <!-- Header Section -->
    <div class="d-flex justify-content-between align-items-center mb-4">
        <div>
            <h2 class="fw-bold text-dark mb-2">
                <i class="fas fa-ticket-alt text-warning me-2"></i>Mis Reservaciones
            </h2>
            <p class="text-muted mb-0">Gestiona todas tus reservaciones de vuelo de manera fácil y rápida</p>
        </div>
        <a href="${pageContext.request.contextPath}/servelt_reservacion?accion=add" class="btn btn-warning btn-lg text-white">
            <i class="fas fa-plus me-2"></i>Nueva Reservación
        </a>
    </div>

    <!-- Search and Filter Section -->
    <div class="card shadow-sm mb-4">
        <div class="card-body">
            <h5 class="card-title mb-3"><i class="fas fa-search me-2"></i>Buscar Reservaciones</h5>
            <form class="row g-3" method="GET" action="${pageContext.request.contextPath}/servelt_reservacion" accept-charset="UTF-8">
                <input type="hidden" name="accion" value="con">
                <div class="col-md-4">
                    <label class="form-label">Búsqueda rápida</label>
                    <div class="input-group">
                        <span class="input-group-text"><i class="fas fa-search"></i></span>
                        <input type="text" class="form-control" name="q" placeholder="Código (RSV123), pasajero o vuelo" value="${param.q}">
                    </div>
                </div>
                <div class="col-md-3">
                    <label class="form-label">Código de Reservación</label>
                    <div class="input-group">
                        <span class="input-group-text"><i class="fas fa-hashtag"></i></span>
                        <input type="text" class="form-control" name="codigo" placeholder="Ej: RSV123456" value="${param.codigo}">
                    </div>
                </div>
                <div class="col-md-3">
                    <label class="form-label">Pasajero</label>
                    <select class="form-select" name="pasajeroId">
                        <option value="">Todos</option>
                        <c:forEach var="p" items="${pasajeros}">
                            <option value="${p.IDPasajero}" ${param.pasajeroId != null && param.pasajeroId == (p.IDPasajero).toString() ? 'selected' : ''}>${p.nombrePasajero}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="col-md-3">
                    <label class="form-label">Vuelo</label>
                    <select class="form-select" name="vueloId">
                        <option value="">Todos</option>
                        <c:forEach var="v" items="${vuelos}">
                            <option value="${v.IDVuelo}" ${param.vueloId != null && param.vueloId == (v.IDVuelo).toString() ? 'selected' : ''}>${v.numeroVuelo} - ${v.origen} → ${v.destino}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="col-md-2">
                    <label class="form-label">Fecha Desde</label>
                    <input type="date" class="form-control" name="fechaDesde" value="${param.fechaDesde}">
                </div>
                <div class="col-md-2">
                    <label class="form-label">Fecha Hasta</label>
                    <input type="date" class="form-control" name="fechaHasta" value="${param.fechaHasta}">
                </div>
                <div class="col-md-2 d-flex align-items-end">
                    <button type="submit" class="btn btn-warning me-2 text-white">
                        <i class="fas fa-search me-1"></i>Buscar
                    </button>
                    <a href="${pageContext.request.contextPath}/servelt_reservacion" class="btn btn-outline-secondary">
                        <i class="fas fa-times"></i>
                    </a>
                </div>
            </form>
        </div>
    </div>

    <!-- Statistics Cards -->
    <div class="row mb-4">
        <c:set var="total" value="${empty reservaVMs ? 0 : reservaVMs.size()}"/>
        <c:set var="conVuelo" value="0"/>
        <c:set var="pasajerosSet" value="|"/>
        <c:set var="rutasSet" value="|"/>
        <c:forEach var="vmStat" items="${reservaVMs}">
            <c:if test="${vmStat.numeroVuelo != null}">
                <c:set var="conVuelo" value="${conVuelo + 1}"/>
            </c:if>
            <c:if test="${not empty vmStat.nombrePasajero}">
                <c:set var="candP" value="|${vmStat.nombrePasajero}|"/>
                <c:if test="${not fn:contains(pasajerosSet, candP)}">
                    <c:set var="pasajerosSet" value="${pasajerosSet}${candP}"/>
                </c:if>
            </c:if>
            <c:if test="${not empty vmStat.origen and not empty vmStat.destino}">
                <c:set var="candR" value="|${vmStat.origen}-${vmStat.destino}|"/>
                <c:if test="${not fn:contains(rutasSet, candR)}">
                    <c:set var="rutasSet" value="${rutasSet}${candR}"/>
                </c:if>
            </c:if>
        </c:forEach>
    <c:set var="pipesP" value="${fn:length(pasajerosSet) - fn:length(fn:replace(pasajerosSet, '|', ''))}"/>
    <c:set var="pasajerosUnicos" value="${(pipesP - 1) / 2}"/>
    <c:set var="pipesR" value="${fn:length(rutasSet) - fn:length(fn:replace(rutasSet, '|', ''))}"/>
    <c:set var="rutasUnicas" value="${(pipesR - 1) / 2}"/>
        <div class="col-md-3">
            <div class="card bg-warning text-white h-100">
                <div class="card-body text-center">
                    <i class="fas fa-ticket-alt fa-2x mb-2"></i>
                    <h5 class="card-title">Total Reservaciones</h5>
                    <h3 class="mb-0">${total}</h3>
                </div>
            </div>
        </div>
        <div class="col-md-3">
            <div class="card bg-success text-white h-100">
                <div class="card-body text-center">
                    <i class="fas fa-check-circle fa-2x mb-2"></i>
                    <h5 class="card-title">Con Vuelo Asignado</h5>
                    <h3 class="mb-0">${conVuelo}</h3>
                </div>
            </div>
        </div>
        <div class="col-md-3">
            <div class="card bg-info text-white h-100">
                <div class="card-body text-center">
                    <i class="fas fa-users fa-2x mb-2"></i>
                    <h5 class="card-title">Pasajeros Únicos</h5>
                    <h3 class="mb-0">${pasajerosUnicos < 0 ? 0 : pasajerosUnicos}</h3>
                </div>
            </div>
        </div>
        <div class="col-md-3">
            <div class="card bg-primary text-white h-100">
                <div class="card-body text-center">
                    <i class="fas fa-route fa-2x mb-2"></i>
                    <h5 class="card-title">Rutas Distintas</h5>
                    <h3 class="mb-0">${rutasUnicas < 0 ? 0 : rutasUnicas}</h3>
                </div>
            </div>
        </div>
    </div>

    <!-- Reservations Table -->
    <div class="card shadow-sm">
        <div class="card-header bg-light">
            <div class="d-flex justify-content-between align-items-center">
                <h5 class="mb-0"><i class="fas fa-list me-2"></i>Lista de Reservaciones</h5>
                <div class="text-muted small">${empty reservaVMs ? 0 : reservaVMs.size()} registros</div>
            </div>
        </div>
        <div class="card-body p-0">
            <c:if test="${empty reservaVMs}">
                <div class="text-center py-5">
                    <i class="fas fa-ticket-alt fa-4x text-muted mb-3"></i>
                    <h4 class="text-muted mb-3">No tienes reservaciones</h4>
                    <p class="text-muted mb-4">¡Es hora de planear tu próximo viaje! Reserva tu primer vuelo ahora.</p>
                    <div class="d-flex gap-3 justify-content-center">
                        <a href="${pageContext.request.contextPath}/servlet_vuelos" class="btn btn-primary btn-lg">
                            <i class="fas fa-search me-2"></i>Buscar Vuelos
                        </a>
                        <a href="${pageContext.request.contextPath}/servelt_reservacion?accion=add" class="btn btn-warning btn-lg text-white">
                            <i class="fas fa-plus me-2"></i>Nueva Reservación
                        </a>
                    </div>
                </div>
            </c:if>
            
            <c:if test="${not empty reservaVMs}">
                <div class="table-responsive">
                    <table class="table table-hover mb-0">
                        <thead class="table-dark">
                            <tr>
                                <th scope="col">
                                    <input type="checkbox" class="form-check-input" id="selectAllReservations" onchange="toggleSelectAllReservations()">
                                </th>
                                <th scope="col">
                                    <i class="fas fa-hashtag me-1"></i>Código
                                </th>
                                <th scope="col">
                                    <i class="fas fa-calendar me-1"></i>Fecha Reserva
                                </th>
                                <th scope="col">
                                    <i class="fas fa-route me-1"></i>Vuelo
                                </th>
                                <th scope="col">
                                    <i class="fas fa-user me-1"></i>Pasajero
                                </th>
                                <th scope="col">
                                    <i class="fas fa-dollar-sign me-1"></i>Total
                                </th>
                                <th scope="col">
                                    <i class="fas fa-info-circle me-1"></i>Estado
                                </th>
                                <th scope="col">
                                    <i class="fas fa-cogs me-1"></i>Acciones
                                </th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="vm" items="${reservaVMs}" varStatus="status">
                                <tr class="align-middle">
                                    <td>
                                        <input type="checkbox" class="form-check-input reservacion-checkbox" value="${vm.codigo}">
                                    </td>
                                    <td>
                                        <div class="fw-bold text-primary font-monospace">
                                            RSV${vm.codigo}
                                        </div>
                                        <small class="text-muted">#${vm.codigo}</small>
                                    </td>
                                    <td>
                                        <div class="fw-semibold">
                                            <c:choose>
                                                <c:when test="${not empty vm.fecha}">
                                                    <fmt:formatDate value='${vm.fecha}' pattern='dd/MM/yyyy'/>
                                                </c:when>
                                                <c:otherwise>
                                                    <fmt:formatDate value='${vm.reservacion.fechaReservacion}' pattern='dd/MM/yyyy'/>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                        <small class="text-muted">
                                            <i class="fas fa-clock me-1"></i>—
                                        </small>
                                    </td>
                                    <td>
                                        <div class="flight-info">
                                            <div class="fw-bold text-dark">
                                                <i class="fas fa-plane me-1"></i>
                                                ${vm.numeroVuelo != null ? vm.numeroVuelo : 'N/A'}
                                            </div>
                                            <div class="d-flex align-items-center text-muted">
                                                <small>${vm.origen != null ? vm.origen : 'Origen'}</small>
                                                <i class="fas fa-arrow-right mx-1"></i>
                                                <small>${vm.destino != null ? vm.destino : 'Destino'}</small>
                                            </div>
                                        </div>
                                    </td>
                                    <td>
                                        <div class="passenger-info">
                                            <div class="fw-semibold">
                                                ${vm.nombrePasajero != null ? vm.nombrePasajero : 'Sin pasajero'}
                                            </div>
                                            <small class="text-muted">
                                                <i class="fas fa-passport me-1"></i>
                                                <!-- Pasaporte no está en VM directo; se puede ampliar si es necesario -->
                                                —
                                            </small>
                                        </div>
                                    </td>
                                    <td>
                                        <div class="text-center">
                                            <div class="fw-bold text-success fs-5">—</div>
                                            <small class="text-muted">USD</small>
                                        </div>
                                    </td>
                                    <td>
                                        <span class="badge bg-secondary">—</span>
                                    </td>
                                    <td>
                                        <div class="btn-group" role="group">
                                            <a class="btn btn-sm btn-outline-info" 
                                               href="${pageContext.request.contextPath}/servelt_reservacion?accion=view&id=${vm.codigo}" title="Ver detalles">
                                                <i class="fas fa-eye"></i>
                                            </a>
                                            <a href="${pageContext.request.contextPath}/servelt_reservacion?accion=mod&id=${vm.codigo}" 
                                               class="btn btn-sm btn-outline-warning" title="Editar">
                                                <i class="fas fa-edit"></i>
                                            </a>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
                
                <!-- Table Footer -->
                <div class="card-footer bg-light">
                    <div class="d-flex justify-content-between align-items-center">
                        <div>
                            <span class="text-muted">Mostrando ${reservaVMs.size()} reservaciones</span>
                        </div>
                        <div>
                            <button class="btn btn-outline-danger btn-sm me-2" onclick="cancelSelectedReservations()" id="cancelSelectedBtn" style="display: none;">
                                <i class="fas fa-ban me-1"></i>Cancelar Seleccionadas
                            </button>
                            <a href="${pageContext.request.contextPath}/servlet_vuelos" class="btn btn-primary btn-sm me-2">
                                <i class="fas fa-search me-1"></i>Buscar Vuelos
                            </a>
                            <a href="${pageContext.request.contextPath}/servelt_reservacion?accion=add" class="btn btn-warning btn-sm text-white">
                                <i class="fas fa-plus me-1"></i>Nueva Reservación
                            </a>
                        </div>
                    </div>
                </div>
            </c:if>
        </div>
    </div>
</div>

<!-- Reservation Details Modal -->
<div class="modal fade" id="reservationDetailsModal" tabindex="-1">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header bg-warning text-white">
                <h5 class="modal-title"><i class="fas fa-ticket-alt me-2"></i>Detalles de la Reservación</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body" id="reservationDetailsContent">
                <!-- Content will be loaded dynamically -->
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
                <button type="button" class="btn btn-success" onclick="downloadCurrentTicket()">
                    <i class="fas fa-download me-1"></i>Descargar Boleto
                </button>
                <button type="button" class="btn btn-warning text-white" onclick="editCurrentReservation()">
                    <i class="fas fa-edit me-1"></i>Editar
                </button>
            </div>
        </div>
    </div>
</div>

<script>
    let currentReservationId = null;
    
    // Toggle select all checkboxes
    function toggleSelectAllReservations() {
        const selectAll = document.getElementById('selectAllReservations');
        const checkboxes = document.querySelectorAll('.reservacion-checkbox');
        const cancelBtn = document.getElementById('cancelSelectedBtn');
        
        checkboxes.forEach(checkbox => {
            checkbox.checked = selectAll.checked;
        });
        
        cancelBtn.style.display = selectAll.checked ? 'block' : 'none';
    }
    
    // Show/hide cancel button based on individual checkbox selection
    document.addEventListener('change', function(e) {
        if (e.target.classList.contains('reservacion-checkbox')) {
            const checkboxes = document.querySelectorAll('.reservacion-checkbox:checked');
            const cancelBtn = document.getElementById('cancelSelectedBtn');
            cancelBtn.style.display = checkboxes.length > 0 ? 'block' : 'none';
        }
    });
    
    // View reservation details
    function viewReservation(id) {
        currentReservationId = id;
        $('#reservationDetailsModal').modal('show');
        document.getElementById('reservationDetailsContent').innerHTML = 
            '<div class="text-center p-4"><i class="fas fa-spinner fa-spin fa-2x"></i><br>Cargando detalles...</div>';
        
        // Here you would make an AJAX call to get reservation details
        setTimeout(() => {
            document.getElementById('reservationDetailsContent').innerHTML = `
                <div class="row">
                    <div class="col-md-6">
                        <h6><i class="fas fa-ticket-alt me-2"></i>Información de la Reservación</h6>
                        <div class="bg-light p-3 rounded mb-3">
                            <p><strong>Código:</strong> RSV${id}</p>
                            <p><strong>Estado:</strong> <span class="badge bg-success">Confirmada</span></p>
                            <p><strong>Fecha de reserva:</strong> <span id="fechaReserva"></span></p>
                            <p><strong>Total:</strong> <span class="text-success fw-bold">$450.00 USD</span></p>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <h6><i class="fas fa-plane me-2"></i>Información del Vuelo</h6>
                        <div class="bg-light p-3 rounded mb-3">
                            <p><strong>Vuelo:</strong> SKY${id}23</p>
                            <p><strong>Ruta:</strong> Ciudad A → Ciudad B</p>
                            <p><strong>Fecha:</strong> <span id="fechaVuelo"></span></p>
                            <p><strong>Hora:</strong> 14:30</p>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-12">
                        <h6><i class="fas fa-user me-2"></i>Información del Pasajero</h6>
                        <div class="bg-light p-3 rounded">
                            <p><strong>Nombre:</strong> Nombre del Pasajero</p>
                            <p><strong>Pasaporte:</strong> ABC123456</p>
                            <p><strong>Nacionalidad:</strong> Mexicana</p>
                        </div>
                    </div>
                </div>
            `;
            // Set current dates
            setTimeout(() => {
                const fechaReserva = document.getElementById('fechaReserva');
                const fechaVuelo = document.getElementById('fechaVuelo');
                const currentDate = new Date().toLocaleDateString();
                if (fechaReserva) fechaReserva.textContent = currentDate;
                if (fechaVuelo) fechaVuelo.textContent = currentDate;
            }, 100);
        }, 1000);
    }
    
    // Download ticket
    function downloadTicket(id) {
        alert('Descargando boleto para la reservación #' + id + '...');
        // Implementation for ticket download
    }
    
    // Download current ticket
    function downloadCurrentTicket() {
        if (currentReservationId) {
            downloadTicket(currentReservationId);
        }
    }
    
    // Edit current reservation
    function editCurrentReservation() {
        if (currentReservationId) {
            window.location.href = 'servelt_reservacion?accion=mod&id=' + currentReservationId;
        }
    }
    
    // Cancel single reservation
    function cancelReservation(id) {
        if (confirm('¿Estás seguro de que deseas cancelar esta reservación? Esta acción puede tener cargos por cancelación.')) {
            // Implementation for cancellation
            alert('Reservación #' + id + ' cancelada exitosamente.');
        }
    }
    
    // Cancel selected reservations
    function cancelSelectedReservations() {
        const selected = document.querySelectorAll('.reservacion-checkbox:checked');
        if (selected.length === 0) {
            alert('Por favor selecciona al menos una reservación para cancelar.');
            return;
        }
        
        if (confirm('¿Estás seguro de que deseas cancelar ' + selected.length + ' reservación(es)? Esta acción puede tener cargos por cancelación.')) {
            const ids = Array.from(selected).map(cb => cb.value);
            // Implementation for bulk cancellation
            console.log('Canceling reservations:', ids);
        }
    }
    
    // Export reservations
    function exportReservations(format) {
        alert('Exportando reservaciones en formato ' + format + '...');
        // Implementation for data export
    }
    
    // Print reservations list
    function printReservations() {
        window.print();
    }
</script>

<%@include file="footer.jsp"%>
