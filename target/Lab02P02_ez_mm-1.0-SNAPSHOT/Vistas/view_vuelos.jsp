<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@include file= "header.jsp" %>

<div class="container-fluid">
    <!-- Breadcrumb -->
    <nav aria-label="breadcrumb" class="breadcrumb-custom">
        <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="index.jsp">Inicio</a></li>
            <li class="breadcrumb-item active" aria-current="page">Gestión de Vuelos</li>
        </ol>
    </nav>

    <!-- Header Section -->
    <div class="d-flex justify-content-between align-items-center mb-4">
        <div>
            <h2 class="fw-bold text-dark mb-2">
                <i class="fas fa-plane-departure text-primary me-2"></i>Gestión de Vuelos
            </h2>
            <p class="text-muted mb-0">Administra vuelos, horarios y destinos de manera eficiente</p>
        </div>
        <a href="servlet_vuelos?accion=add" class="btn btn-primary btn-lg">
            <i class="fas fa-plus me-2"></i>Nuevo Vuelo
        </a>
    </div>

    <!-- Search and Filter Section -->
    <div class="card shadow-sm mb-4">
        <div class="card-body">
            <div class="d-flex justify-content-between align-items-center mb-3">
                <h5 class="card-title mb-0"><i class="fas fa-search me-2"></i>Buscar y Filtrar Vuelos</h5>
                <button type="button" class="btn btn-outline-secondary btn-sm" onclick="limpiarFiltros()">
                    <i class="fas fa-times me-1"></i>Limpiar Filtros
                </button>
            </div>
            <form class="row g-3" method="GET" action="servlet_vuelos" id="searchForm">
                <input type="hidden" name="accion" value="con">
                <div class="col-md-3">
                    <label class="form-label">Origen</label>
                    <div class="input-group">
                        <span class="input-group-text"><i class="fas fa-plane-departure"></i></span>
                        <input type="text" class="form-control" name="origen" placeholder="Ciudad de origen" value="${param.origen}">
                    </div>
                </div>
                <div class="col-md-3">
                    <label class="form-label">Destino</label>
                    <div class="input-group">
                        <span class="input-group-text"><i class="fas fa-plane-arrival"></i></span>
                        <input type="text" class="form-control" name="destino" placeholder="Ciudad de destino" value="${param.destino}">
                    </div>
                </div>
                <div class="col-md-2">
                    <label class="form-label">Fecha</label>
                    <input type="date" class="form-control" name="fecha" value="${param.fecha}">
                </div>
                <div class="col-md-2">
                    <label class="form-label">Estado</label>
                    <select class="form-select" name="estado">
                        <option value="">Todos</option>
                        <option value="activo" ${param.estado == 'activo' ? 'selected' : ''}>Activo</option>
                        <option value="cancelado" ${param.estado == 'cancelado' ? 'selected' : ''}>Cancelado</option>
                        <option value="retrasado" ${param.estado == 'retrasado' ? 'selected' : ''}>Retrasado</option>
                        <option value="programado" ${param.estado == 'programado' ? 'selected' : ''}>Programado</option>
                    </select>
                </div>
                <div class="col-md-2 d-flex align-items-end">
                    <button type="submit" class="btn btn-primary me-2 w-100">
                        <i class="fas fa-search me-1"></i>Buscar
                    </button>
                </div>
            </form>
            
            <!-- Búsqueda rápida -->
            <div class="row mt-3">
                <div class="col-md-12">
                    <div class="input-group">
                        <span class="input-group-text"><i class="fas fa-search"></i></span>
                        <input type="text" class="form-control" placeholder="Búsqueda rápida: número de vuelo, aerolínea, avión..." 
                               name="search" value="${param.search}" form="searchForm">
                        <button class="btn btn-outline-primary" type="submit" form="searchForm">
                            <i class="fas fa-search"></i>
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Statistics Cards -->
    <div class="row mb-4">
        <div class="col-md-3">
            <div class="card bg-primary text-white h-100">
                <div class="card-body text-center">
                    <i class="fas fa-plane fa-2x mb-2"></i>
                    <h5 class="card-title">Total Vuelos</h5>
                    <h3 class="mb-0">${empty vuelos ? '0' : vuelos.size()}</h3>
                </div>
            </div>
        </div>
        <div class="col-md-3">
            <div class="card bg-success text-white h-100">
                <div class="card-body text-center">
                    <i class="fas fa-check-circle fa-2x mb-2"></i>
                    <h5 class="card-title">Vuelos Activos</h5>
                    <h3 class="mb-0">
                        <!-- Temporalmente deshabilitado hasta recompilación -->
                        ${empty vuelos ? '0' : vuelos.size()}
                    </h3>
                </div>
            </div>
        </div>
        <div class="col-md-3">
            <div class="card bg-warning text-white h-100">
                <div class="card-body text-center">
                    <i class="fas fa-clock fa-2x mb-2"></i>
                    <h5 class="card-title">Programados</h5>
                    <h3 class="mb-0">
                        <!-- Temporalmente deshabilitado hasta recompilación -->
                        0
                    </h3>
                </div>
            </div>
        </div>
        <div class="col-md-3">
            <div class="card bg-danger text-white h-100">
                <div class="card-body text-center">
                    <i class="fas fa-times-circle fa-2x mb-2"></i>
                    <h5 class="card-title">Cancelados</h5>
                    <h3 class="mb-0">
                        <!-- Temporalmente deshabilitado hasta recompilación -->
                        0
                    </h3>
                </div>
            </div>
        </div>
    </div>

    <!-- Vuelos Table -->
    <div class="card shadow-sm">
        <div class="card-header bg-light">
            <div class="d-flex justify-content-between align-items-center">
                <h5 class="mb-0"><i class="fas fa-list me-2"></i>Lista de Vuelos</h5>
                <div class="btn-group" role="group">
                    <button type="button" class="btn btn-outline-primary btn-sm" onclick="exportData('excel')">
                        <i class="fas fa-file-excel me-1"></i>Excel
                    </button>
                    <button type="button" class="btn btn-outline-primary btn-sm" onclick="exportData('pdf')">
                        <i class="fas fa-file-pdf me-1"></i>PDF
                    </button>
                </div>
            </div>
        </div>
        <div class="card-body p-0">
            <c:if test="${empty vuelos}">
                <div class="text-center py-5">
                    <i class="fas fa-plane fa-4x text-muted mb-3"></i>
                    <h4 class="text-muted mb-3">No hay vuelos disponibles</h4>
                    <p class="text-muted mb-4">
                        <c:choose>
                            <c:when test="${not empty param.origen or not empty param.destino or not empty param.fecha or not empty param.estado or not empty param.search}">
                                No se encontraron vuelos que coincidan con los criterios de búsqueda.
                            </c:when>
                            <c:otherwise>
                                Comienza agregando tu primer vuelo al sistema.
                            </c:otherwise>
                        </c:choose>
                    </p>
                    <div class="d-flex gap-3 justify-content-center">
                        <c:if test="${not empty param.origen or not empty param.destino or not empty param.fecha or not empty param.estado or not empty param.search}">
                            <button class="btn btn-outline-secondary" onclick="limpiarFiltros()">
                                <i class="fas fa-times me-2"></i>Limpiar Búsqueda
                            </button>
                        </c:if>
                        <a href="servlet_vuelos?accion=add" class="btn btn-primary btn-lg">
                            <i class="fas fa-plus me-2"></i>Agregar Vuelo
                        </a>
                    </div>
                </div>
            </c:if>
            
            <c:if test="${not empty vuelos}">
                <div class="table-responsive">
                    <table class="table table-hover mb-0">
                        <thead class="table-dark">
                            <tr>
                                <th scope="col">
                                    <input type="checkbox" class="form-check-input" id="selectAll" onchange="toggleSelectAll()">
                                </th>
                                <th scope="col">ID</th>
                                <th scope="col">
                                    <i class="fas fa-plane-departure me-1"></i>Vuelo
                                </th>
                                <th scope="col">
                                    <i class="fas fa-route me-1"></i>Ruta
                                </th>
                                <th scope="col">
                                    <i class="fas fa-calendar me-1"></i>Fecha/Hora
                                </th>
                                <th scope="col">
                                    <i class="fas fa-users me-1"></i>Capacidad
                                </th>
                                <th scope="col">
                                    <i class="fas fa-dollar-sign me-1"></i>Precio
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
                            <c:forEach var="v" items="${vuelos}" varStatus="status">
                                <tr class="align-middle">
                                    <td>
                                        <input type="checkbox" class="form-check-input vuelo-checkbox" value="${v.IDVuelo}">
                                    </td>
                                    <td>
                                        <span class="badge bg-secondary">#${v.IDVuelo}</span>
                                    </td>
                                    <td>
                                        <div class="d-flex align-items-center">
                                            <div class="flex-shrink-0">
                                                <div class="bg-primary rounded-circle d-flex align-items-center justify-content-center" style="width: 40px; height: 40px;">
                                                    <i class="fas fa-plane text-white"></i>
                                                </div>
                                            </div>
                                            <div class="flex-grow-1 ms-3">
                                                <h6 class="mb-0 fw-bold">${v.numeroVuelo}</h6>
                                                <small class="text-muted">${v.aerolinea}</small>
                                            </div>
                                        </div>
                                    </td>
                                    <td>
                                        <div class="route-info">
                                            <div class="d-flex align-items-center">
                                                <span class="fw-bold">${v.origen}</span>
                                                <i class="fas fa-arrow-right mx-2 text-primary"></i>
                                                <span class="fw-bold">${v.destino}</span>
                                            </div>
                                            <small class="text-muted">
                                                <c:if test="${not empty v.duracion}">
                                                    ${v.duracion} min
                                                </c:if>
                                                <c:if test="${empty v.duracion}">
                                                    Duración no especificada
                                                </c:if>
                                            </small>
                                        </div>
                                    </td>
                                    <td>
                                        <div>
                                            <div class="fw-semibold">${v.fechaSalida}</div>
                                            <small class="text-muted">${v.horaSalida}</small>
                                        </div>
                                    </td>
                                    <td>
                                        <div class="text-center">
                                            <div class="fw-bold">
                                                <c:if test="${not empty v.capacidad}">
                                                    ${v.capacidad}
                                                </c:if>
                                                <c:if test="${empty v.capacidad}">
                                                    N/A
                                                </c:if>
                                            </div>
                                            <small class="text-muted">pasajeros</small>
                                        </div>
                                    </td>
                                    <td>
                                        <div class="text-center">
                                            <c:if test="${not empty v.precio}">
                                                <div class="fw-bold text-success">$${v.precio}</div>
                                                <small class="text-muted">USD</small>
                                            </c:if>
                                            <c:if test="${empty v.precio}">
                                                <span class="text-muted">No especificado</span>
                                            </c:if>
                                        </div>
                                    </td>
                                    <td>
                                        <!-- Temporalmente deshabilitado hasta recompilación -->
                                        <span class="badge bg-success">
                                            <i class="fas fa-check me-1"></i>Activo
                                        </span>
                                    </td>
                                    <td>
                                        <div class="btn-group" role="group">
                                            <button type="button" class="btn btn-sm btn-outline-primary" 
                                                    onclick="viewFlight(${v.IDVuelo})" title="Ver detalles">
                                                <i class="fas fa-eye"></i>
                                            </button>
                                            <a href="servlet_vuelos?accion=mod&id=${v.IDVuelo}" 
                                               class="btn btn-sm btn-outline-warning" title="Editar">
                                                <i class="fas fa-edit"></i>
                                            </a>
                                            <button type="button" class="btn btn-sm btn-outline-danger" 
                                                    onclick="deleteFlight(${v.IDVuelo})" title="Eliminar">
                                                <i class="fas fa-trash"></i>
                                            </button>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
                
                <!-- Pagination -->
                <div class="card-footer bg-light">
                    <div class="d-flex justify-content-between align-items-center">
                        <div>
                            <span class="text-muted">Mostrando ${vuelos.size()} vuelos</span>
                        </div>
                        <div>
                            <button class="btn btn-outline-danger btn-sm me-2" onclick="deleteSelected()" id="deleteSelectedBtn" style="display: none;">
                                <i class="fas fa-trash me-1"></i>Eliminar Seleccionados
                            </button>
                            <a href="servlet_vuelos?accion=add" class="btn btn-primary btn-sm">
                                <i class="fas fa-plus me-1"></i>Nuevo Vuelo
                            </a>
                        </div>
                    </div>
                </div>
            </c:if>
        </div>
    </div>
</div>

<!-- Flight Details Modal -->
<div class="modal fade" id="flightDetailsModal" tabindex="-1">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header bg-primary text-white">
                <h5 class="modal-title"><i class="fas fa-plane me-2"></i>Detalles del Vuelo</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body" id="flightDetailsContent">
                <!-- Content will be loaded dynamically -->
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
                <button type="button" class="btn btn-warning" onclick="editCurrentFlight()">
                    <i class="fas fa-edit me-1"></i>Editar
                </button>
            </div>
        </div>
    </div>
</div>

<script>
    let currentFlightId = null;
    
    // Limpiar filtros
    function limpiarFiltros() {
        document.querySelector('input[name="origen"]').value = '';
        document.querySelector('input[name="destino"]').value = '';
        document.querySelector('input[name="fecha"]').value = '';
        document.querySelector('select[name="estado"]').value = '';
        document.querySelector('input[name="search"]').value = '';
        document.getElementById('searchForm').submit();
    }
    
    // Toggle select all checkboxes
    function toggleSelectAll() {
        const selectAll = document.getElementById('selectAll');
        const checkboxes = document.querySelectorAll('.vuelo-checkbox');
        const deleteBtn = document.getElementById('deleteSelectedBtn');
        
        checkboxes.forEach(checkbox => {
            checkbox.checked = selectAll.checked;
        });
        
        deleteBtn.style.display = selectAll.checked ? 'block' : 'none';
    }
    
    // Show/hide delete button based on individual checkbox selection
    document.addEventListener('change', function(e) {
        if (e.target.classList.contains('vuelo-checkbox')) {
            const checkboxes = document.querySelectorAll('.vuelo-checkbox:checked');
            const deleteBtn = document.getElementById('deleteSelectedBtn');
            deleteBtn.style.display = checkboxes.length > 0 ? 'block' : 'none';
        }
    });
    
    // View flight details
    function viewFlight(id) {
        currentFlightId = id;
        $('#flightDetailsModal').modal('show');
        document.getElementById('flightDetailsContent').innerHTML = 
            '<div class="text-center p-4"><i class="fas fa-spinner fa-spin fa-2x"></i><br>Cargando detalles...</div>';
        
        // Here you would make an AJAX call to get flight details
        setTimeout(() => {
            document.getElementById('flightDetailsContent').innerHTML = `
                <div class="row">
                    <div class="col-md-6">
                        <h6 class="text-primary">Información del Vuelo</h6>
                        <div class="bg-light p-3 rounded mb-3">
                            <p><strong>ID:</strong> ${id}</p>
                            <p><strong>Estado:</strong> <span class="badge bg-success">Activo</span></p>
                            <p><strong>Fecha de creación:</strong> <span id="fechaCreacion"></span></p>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <h6 class="text-primary">Detalles Técnicos</h6>
                        <div class="bg-light p-3 rounded mb-3">
                            <p><strong>Tipo de avión:</strong> Información no disponible</p>
                            <p><strong>Capacidad:</strong> Información no disponible</p>
                            <p><strong>Duración estimada:</strong> Información no disponible</p>
                        </div>
                    </div>
                </div>
            `;
            // Set current date
            const fechaElement = document.getElementById('fechaCreacion');
            if (fechaElement) {
                fechaElement.textContent = new Date().toLocaleDateString();
            }
        }, 1000);
    }
    
    // Edit current flight
    function editCurrentFlight() {
        if (currentFlightId) {
            window.location.href = 'servlet_vuelos?accion=mod&id=' + currentFlightId;
        }
    }
    
    // Delete single flight
    function deleteFlight(id) {
        if (confirm('¿Estás seguro de que deseas eliminar este vuelo? Esta acción no se puede deshacer.')) {
            window.location.href = 'servlet_vuelos?accion=del&id=' + id;
        }
    }
    
    // Delete selected flights
    function deleteSelected() {
        const selected = document.querySelectorAll('.vuelo-checkbox:checked');
        if (selected.length === 0) {
            alert('Por favor selecciona al menos un vuelo para eliminar.');
            return;
        }
        
        if (confirm('¿Estás seguro de que deseas eliminar ' + selected.length + ' vuelo(s)? Esta acción no se puede deshacer.')) {
            const ids = Array.from(selected).map(cb => cb.value);
            // Implementation for bulk delete
            console.log('Deleting flights:', ids);
            alert('Funcionalidad de eliminación múltiple en desarrollo.');
        }
    }
    
    // Export data
    function exportData(format) {
        alert('Exportando datos en formato ' + format + '...');
        // Implementation for data export
    }
</script>

<%@include file= "footer.jsp" %>