<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@include file="header.jsp"%>

<div class="container-fluid">
    <!-- Breadcrumb -->
    <nav aria-label="breadcrumb" class="breadcrumb-custom">
        <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="index.jsp">Inicio</a></li>
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
        <a href="servelt_reservacion?accion=add" class="btn btn-warning btn-lg text-white">
            <i class="fas fa-plus me-2"></i>Nueva Reservación
        </a>
    </div>

    <!-- Search and Filter Section -->
    <div class="card shadow-sm mb-4">
        <div class="card-body">
            <h5 class="card-title mb-3"><i class="fas fa-search me-2"></i>Buscar Reservaciones</h5>
            <form class="row g-3" method="GET" action="servelt_reservacion">
                <input type="hidden" name="accion" value="con">
                <div class="col-md-3">
                    <label class="form-label">Código de Reservación</label>
                    <div class="input-group">
                        <span class="input-group-text"><i class="fas fa-hashtag"></i></span>
                        <input type="text" class="form-control" name="codigo" placeholder="Ej: RSV123456" value="${param.codigo}">
                    </div>
                </div>
                <div class="col-md-3">
                    <label class="form-label">Estado</label>
                    <select class="form-select" name="estado">
                        <option value="">Todos los estados</option>
                        <option value="confirmada" ${param.estado == 'confirmada' ? 'selected' : ''}>Confirmada</option>
                        <option value="pendiente" ${param.estado == 'pendiente' ? 'selected' : ''}>Pendiente</option>
                        <option value="cancelada" ${param.estado == 'cancelada' ? 'selected' : ''}>Cancelada</option>
                        <option value="completada" ${param.estado == 'completada' ? 'selected' : ''}>Completada</option>
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
                    <a href="servelt_reservacion" class="btn btn-outline-secondary">
                        <i class="fas fa-times"></i>
                    </a>
                </div>
            </form>
        </div>
    </div>

    <!-- Statistics Cards -->
    <div class="row mb-4">
        <div class="col-md-3">
            <div class="card bg-warning text-white h-100">
                <div class="card-body text-center">
                    <i class="fas fa-ticket-alt fa-2x mb-2"></i>
                    <h5 class="card-title">Total Reservaciones</h5>
                    <h3 class="mb-0">${empty reservaciones ? '0' : reservaciones.size()}</h3>
                </div>
            </div>
        </div>
        <div class="col-md-3">
            <div class="card bg-success text-white h-100">
                <div class="card-body text-center">
                    <i class="fas fa-check-circle fa-2x mb-2"></i>
                    <h5 class="card-title">Confirmadas</h5>
                    <h3 class="mb-0">
                        <c:set var="confirmadas" value="0"/>
                        <c:forEach var="r" items="${reservaciones}">
                            <c:if test="${r.estado == 'confirmada' or empty r.estado}">
                                <c:set var="confirmadas" value="${confirmadas + 1}"/>
                            </c:if>
                        </c:forEach>
                        ${confirmadas}
                    </h3>
                </div>
            </div>
        </div>
        <div class="col-md-3">
            <div class="card bg-info text-white h-100">
                <div class="card-body text-center">
                    <i class="fas fa-clock fa-2x mb-2"></i>
                    <h5 class="card-title">Pendientes</h5>
                    <h3 class="mb-0">2</h3>
                </div>
            </div>
        </div>
        <div class="col-md-3">
            <div class="card bg-primary text-white h-100">
                <div class="card-body text-center">
                    <i class="fas fa-plane-departure fa-2x mb-2"></i>
                    <h5 class="card-title">Próximos Vuelos</h5>
                    <h3 class="mb-0">5</h3>
                </div>
            </div>
        </div>
    </div>

    <!-- Reservations Table -->
    <div class="card shadow-sm">
        <div class="card-header bg-light">
            <div class="d-flex justify-content-between align-items-center">
                <h5 class="mb-0"><i class="fas fa-list me-2"></i>Lista de Reservaciones</h5>
                <div class="btn-group" role="group">
                    <button type="button" class="btn btn-outline-warning btn-sm" onclick="exportReservations('excel')">
                        <i class="fas fa-file-excel me-1"></i>Excel
                    </button>
                    <button type="button" class="btn btn-outline-warning btn-sm" onclick="exportReservations('pdf')">
                        <i class="fas fa-file-pdf me-1"></i>PDF
                    </button>
                    <button type="button" class="btn btn-outline-warning btn-sm" onclick="printReservations()">
                        <i class="fas fa-print me-1"></i>Imprimir
                    </button>
                </div>
            </div>
        </div>
        <div class="card-body p-0">
            <c:if test="${empty reservaciones}">
                <div class="text-center py-5">
                    <i class="fas fa-ticket-alt fa-4x text-muted mb-3"></i>
                    <h4 class="text-muted mb-3">No tienes reservaciones</h4>
                    <p class="text-muted mb-4">¡Es hora de planear tu próximo viaje! Reserva tu primer vuelo ahora.</p>
                    <div class="d-flex gap-3 justify-content-center">
                        <a href="servlet_vuelos" class="btn btn-primary btn-lg">
                            <i class="fas fa-search me-2"></i>Buscar Vuelos
                        </a>
                        <a href="servelt_reservacion?accion=add" class="btn btn-warning btn-lg text-white">
                            <i class="fas fa-plus me-2"></i>Nueva Reservación
                        </a>
                    </div>
                </div>
            </c:if>
            
            <c:if test="${not empty reservaciones}">
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
                            <c:forEach var="r" items="${reservaciones}" varStatus="status">
                                <tr class="align-middle">
                                    <td>
                                        <input type="checkbox" class="form-check-input reservacion-checkbox" value="${r.IDReservacion}">
                                    </td>
                                    <td>
                                        <div class="fw-bold text-primary font-monospace">
                                            RSV${r.IDReservacion}
                                        </div>
                                        <small class="text-muted">#${r.IDReservacion}</small>
                                    </td>
                                    <td>
                                        <div class="fw-semibold">${r.fechaReservacion}</div>
                                        <small class="text-muted">
                                            <i class="fas fa-clock me-1"></i>${r.horaReservacion != null ? r.horaReservacion : '00:00'}
                                        </small>
                                    </td>
                                    <td>
                                        <div class="flight-info">
                                            <div class="fw-bold text-dark">
                                                <i class="fas fa-plane me-1"></i>
                                                ${r.vuelo != null ? r.vuelo.numeroVuelo : 'N/A'}
                                            </div>
                                            <div class="d-flex align-items-center text-muted">
                                                <small>${r.vuelo != null ? r.vuelo.origen : 'Origen'}</small>
                                                <i class="fas fa-arrow-right mx-1"></i>
                                                <small>${r.vuelo != null ? r.vuelo.destino : 'Destino'}</small>
                                            </div>
                                        </div>
                                    </td>
                                    <td>
                                        <div class="passenger-info">
                                            <div class="fw-semibold">
                                                ${r.pasajero != null ? r.pasajero.nombrePasajero : 'Pasajero no disponible'}
                                            </div>
                                            <small class="text-muted">
                                                <i class="fas fa-passport me-1"></i>
                                                ${r.pasajero != null ? r.pasajero.pasaporte : 'N/A'}
                                            </small>
                                        </div>
                                    </td>
                                    <td>
                                        <div class="text-center">
                                            <div class="fw-bold text-success fs-5">$${r.total != null ? r.total : '0.00'}</div>
                                            <small class="text-muted">USD</small>
                                        </div>
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${r.estado == 'confirmada' or empty r.estado}">
                                                <span class="badge bg-success">
                                                    <i class="fas fa-check me-1"></i>Confirmada
                                                </span>
                                            </c:when>
                                            <c:when test="${r.estado == 'pendiente'}">
                                                <span class="badge bg-warning">
                                                    <i class="fas fa-clock me-1"></i>Pendiente
                                                </span>
                                            </c:when>
                                            <c:when test="${r.estado == 'cancelada'}">
                                                <span class="badge bg-danger">
                                                    <i class="fas fa-times me-1"></i>Cancelada
                                                </span>
                                            </c:when>
                                            <c:when test="${r.estado == 'completada'}">
                                                <span class="badge bg-info">
                                                    <i class="fas fa-flag-checkered me-1"></i>Completada
                                                </span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge bg-secondary">Sin estado</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <div class="btn-group" role="group">
                                            <button type="button" class="btn btn-sm btn-outline-info" 
                                                    onclick="viewReservation(${r.IDReservacion})" title="Ver detalles">
                                                <i class="fas fa-eye"></i>
                                            </button>
                                            <a href="servelt_reservacion?accion=mod&id=${r.IDReservacion}" 
                                               class="btn btn-sm btn-outline-warning" title="Editar">
                                                <i class="fas fa-edit"></i>
                                            </a>
                                            <button type="button" class="btn btn-sm btn-outline-success" 
                                                    onclick="downloadTicket(${r.IDReservacion})" title="Descargar boleto">
                                                <i class="fas fa-download"></i>
                                            </button>
                                            <button type="button" class="btn btn-sm btn-outline-danger" 
                                                    onclick="cancelReservation(${r.IDReservacion})" title="Cancelar">
                                                <i class="fas fa-ban"></i>
                                            </button>
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
                            <span class="text-muted">Mostrando ${reservaciones.size()} reservaciones</span>
                        </div>
                        <div>
                            <button class="btn btn-outline-danger btn-sm me-2" onclick="cancelSelectedReservations()" id="cancelSelectedBtn" style="display: none;">
                                <i class="fas fa-ban me-1"></i>Cancelar Seleccionadas
                            </button>
                            <a href="servlet_vuelos" class="btn btn-primary btn-sm me-2">
                                <i class="fas fa-search me-1"></i>Buscar Vuelos
                            </a>
                            <a href="servelt_reservacion?accion=add" class="btn btn-warning btn-sm text-white">
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
