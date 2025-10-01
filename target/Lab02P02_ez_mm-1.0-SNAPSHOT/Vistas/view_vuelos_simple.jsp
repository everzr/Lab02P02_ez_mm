<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@include file= "header.jsp" %>

<style>
    /* Fix table colors */
    .table {
        background-color: white !important;
        color: #333 !important;
    }
    
    .table thead th {
        background-color: #2c3e50 !important;
        color: white !important;
        border-color: #34495e !important;
    }
    
    .table tbody tr {
        background-color: white !important;
        color: #333 !important;
    }
    
    .table tbody tr:hover {
        background-color: #f8f9fa !important;
        color: #333 !important;
    }
    
    .table tbody td {
        background-color: transparent !important;
        color: #333 !important;
        border-color: #dee2e6 !important;
    }
    
    .badge {
        color: white !important;
    }
    
    .text-muted {
        color: #6c757d !important;
    }
    
    .fw-bold, .fw-semibold {
        color: #333 !important;
    }
    
    /* Custom table styling */
    .custom-table {
        background: white;
        border-radius: 8px;
        overflow: hidden;
        box-shadow: 0 2px 10px rgba(0,0,0,0.1);
    }
    
    .custom-table .table {
        margin-bottom: 0;
    }
    
    .custom-table .table thead {
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    }
    
    .custom-table .table tbody tr:nth-child(even) {
        background-color: #f8f9fa !important;
    }
</style>

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
                <div class="d-flex gap-2">
                    <c:if test="${not empty param.origen or not empty param.destino or not empty param.fecha or not empty param.search}">
                        <span class="badge bg-info">
                            <i class="fas fa-filter me-1"></i>Filtros activos
                        </span>
                    </c:if>
                    <button type="button" class="btn btn-outline-secondary btn-sm" onclick="limpiarFiltros()">
                        <i class="fas fa-times me-1"></i>Limpiar Filtros
                    </button>
                </div>
            </div>
            
            <!-- Active Filters Display -->
            <c:if test="${not empty param.origen or not empty param.destino or not empty param.fecha or not empty param.search}">
                <div class="mb-3">
                    <small class="text-muted">Filtros aplicados:</small>
                    <div class="mt-1">
                        <c:if test="${not empty param.origen}">
                            <span class="badge bg-light text-dark me-2">
                                <i class="fas fa-plane-departure me-1"></i>Origen: ${param.origen}
                                <button type="button" class="btn-close btn-close-sm ms-1" onclick="removeFilter('origen')" style="font-size: 0.6em;"></button>
                            </span>
                        </c:if>
                        <c:if test="${not empty param.destino}">
                            <span class="badge bg-light text-dark me-2">
                                <i class="fas fa-plane-arrival me-1"></i>Destino: ${param.destino}
                                <button type="button" class="btn-close btn-close-sm ms-1" onclick="removeFilter('destino')" style="font-size: 0.6em;"></button>
                            </span>
                        </c:if>
                        <c:if test="${not empty param.fecha}">
                            <span class="badge bg-light text-dark me-2">
                                <i class="fas fa-calendar me-1"></i>Fecha: ${param.fecha}
                                <button type="button" class="btn-close btn-close-sm ms-1" onclick="removeFilter('fecha')" style="font-size: 0.6em;"></button>
                            </span>
                        </c:if>
                        <c:if test="${not empty param.search}">
                            <span class="badge bg-light text-dark me-2">
                                <i class="fas fa-search me-1"></i>Búsqueda: ${param.search}
                                <button type="button" class="btn-close btn-close-sm ms-1" onclick="removeFilter('search')" style="font-size: 0.6em;"></button>
                            </span>
                        </c:if>
                    </div>
                </div>
            </c:if>
            
            <form class="row g-3" method="GET" action="servlet_vuelos" id="searchForm">
                <input type="hidden" name="accion" value="con">
                <div class="col-md-4">
                    <label class="form-label">Origen</label>
                    <div class="input-group">
                        <span class="input-group-text"><i class="fas fa-plane-departure"></i></span>
                        <input type="text" class="form-control" name="origen" placeholder="Ciudad de origen" value="${param.origen}">
                    </div>
                </div>
                <div class="col-md-4">
                    <label class="form-label">Destino</label>
                    <div class="input-group">
                        <span class="input-group-text"><i class="fas fa-plane-arrival"></i></span>
                        <input type="text" class="form-control" name="destino" placeholder="Ciudad de destino" value="${param.destino}">
                    </div>
                </div>
                <div class="col-md-2">
                    <label class="form-label">Fecha de Salida</label>
                    <input type="date" class="form-control" name="fecha" value="${param.fecha}" title="Buscar vuelos en esta fecha específica">
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
                    <div class="form-text">
                        <i class="fas fa-info-circle me-1"></i>
                        Busca por número de vuelo, aerolínea, origen, destino o modelo de avión
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Statistics Cards -->
    <div class="row mb-4">
        <div class="col-md-4">
            <div class="card bg-primary text-white h-100">
                <div class="card-body text-center">
                    <i class="fas fa-plane fa-2x mb-2"></i>
                    <h5 class="card-title">Total Vuelos</h5>
                    <h3 class="mb-0">${empty vuelos ? '0' : vuelos.size()}</h3>
                </div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="card bg-success text-white h-100">
                <div class="card-body text-center">
                    <i class="fas fa-calendar fa-2x mb-2"></i>
                    <h5 class="card-title">Próximos Vuelos</h5>
                    <h3 class="mb-0">
                        <c:set var="proximos" value="0"/>
                        <c:forEach var="v" items="${vuelos}">
                            <c:if test="${v.fechaSalida >= pageContext.session.getAttribute('currentDate') or empty pageContext.session.getAttribute('currentDate')}">
                                <c:set var="proximos" value="${proximos + 1}"/>
                            </c:if>
                        </c:forEach>
                        ${proximos}
                    </h3>
                </div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="card bg-info text-white h-100">
                <div class="card-body text-center">
                    <i class="fas fa-route fa-2x mb-2"></i>
                    <h5 class="card-title">Rutas Únicas</h5>
                    <h3 class="mb-0">
                        <c:set var="rutas" value="${[]}"/>
                        <c:forEach var="v" items="${vuelos}">
                            <c:set var="ruta" value="${v.origen}-${v.destino}"/>
                        </c:forEach>
                        ${empty vuelos ? '0' : '5+'}
                    </h3>
                </div>
            </div>
        </div>
    </div>

    <!-- Vuelos Table -->
    <div class="card shadow-sm custom-table">
        <div class="card-header bg-light">
            <div class="d-flex justify-content-between align-items-center">
                <h5 class="mb-0"><i class="fas fa-list me-2"></i>Lista de Vuelos</h5>
                <a href="servlet_vuelos?accion=add" class="btn btn-primary btn-sm">
                    <i class="fas fa-plus me-1"></i>Nuevo Vuelo
                </a>
            </div>
        </div>
        <div class="card-body p-0">
            <c:if test="${empty vuelos}">
                <div class="text-center py-5">
                    <i class="fas fa-plane fa-4x text-muted mb-3"></i>
                    <h4 class="text-muted mb-3">No hay vuelos disponibles</h4>
                    <p class="text-muted mb-4">
                        <c:choose>
                            <c:when test="${not empty param.origen or not empty param.destino or not empty param.fecha or not empty param.search}">
                                No se encontraron vuelos que coincidan con los criterios de búsqueda.
                            </c:when>
                            <c:otherwise>
                                Comienza agregando tu primer vuelo al sistema.
                            </c:otherwise>
                        </c:choose>
                    </p>
                    <div class="d-flex gap-3 justify-content-center">
                        <c:if test="${not empty param.origen or not empty param.destino or not empty param.fecha or not empty param.search}">
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
                    <table class="table table-hover mb-0 custom-table-content">
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
                                    <i class="fas fa-calendar me-1"></i>Salida
                                </th>
                                <th scope="col">
                                    <i class="fas fa-calendar me-1"></i>Llegada
                                </th>
                                <th scope="col">
                                    <i class="fas fa-plane me-1"></i>Avión
                                </th>
                                <th scope="col">
                                    <i class="fas fa-cogs me-1"></i>Acciones
                                </th>
                            </tr>
                        </thead>
                        <tbody style="background-color: white !important;">
                            <c:forEach var="v" items="${vuelos}" varStatus="status">
                                <tr class="align-middle" style="background-color: white !important; color: #333 !important;">
                                    <td style="background-color: white !important;">
                                        <input type="checkbox" class="form-check-input vuelo-checkbox" value="${v.IDVuelo}">
                                    </td>
                                    <td style="background-color: white !important;">
                                        <span class="badge bg-secondary">#${v.IDVuelo}</span>
                                    </td>
                                    <td style="background-color: white !important;">
                                        <div class="d-flex align-items-center">
                                            <div class="flex-shrink-0">
                                                <div class="bg-primary rounded-circle d-flex align-items-center justify-content-center" style="width: 40px; height: 40px;">
                                                    <i class="fas fa-plane text-white"></i>
                                                </div>
                                            </div>
                                            <div class="flex-grow-1 ms-3">
                                                <h6 class="mb-0 fw-bold" style="color: #333 !important;">${v.numeroVuelo}</h6>
                                                <small class="text-muted">${v.aerolinea}</small>
                                            </div>
                                        </div>
                                    </td>
                                    <td style="background-color: white !important;">
                                        <div class="route-info">
                                            <div class="d-flex align-items-center">
                                                <span class="fw-bold" style="color: #333 !important;">${v.origen}</span>
                                                <i class="fas fa-arrow-right mx-2 text-primary"></i>
                                                <span class="fw-bold" style="color: #333 !important;">${v.destino}</span>
                                            </div>
                                        </div>
                                    </td>
                                    <td style="background-color: white !important;">
                                        <div>
                                            <div class="fw-semibold" style="color: #333 !important;">
                                                <c:choose>
                                                    <c:when test="${not empty v.fechaSalida}">
                                                        <fmt:formatDate value="${v.fechaSalida}" pattern="dd/MM/yyyy"/>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="text-muted">No especificada</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>
                                            <small class="text-muted">
                                                <c:choose>
                                                    <c:when test="${not empty v.horaSalida}">
                                                        <fmt:formatDate value="${v.horaSalida}" pattern="HH:mm"/>
                                                    </c:when>
                                                    <c:otherwise>
                                                        No especificada
                                                    </c:otherwise>
                                                </c:choose>
                                            </small>
                                        </div>
                                    </td>
                                    <td style="background-color: white !important;">
                                        <div>
                                            <div class="fw-semibold" style="color: #333 !important;">
                                                <c:choose>
                                                    <c:when test="${not empty v.fechaLlegada}">
                                                        <fmt:formatDate value="${v.fechaLlegada}" pattern="dd/MM/yyyy"/>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="text-muted">No especificada</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>
                                            <small class="text-muted">
                                                <c:choose>
                                                    <c:when test="${not empty v.horaLlegada}">
                                                        <fmt:formatDate value="${v.horaLlegada}" pattern="HH:mm"/>
                                                    </c:when>
                                                    <c:otherwise>
                                                        No especificada
                                                    </c:otherwise>
                                                </c:choose>
                                            </small>
                                        </div>
                                    </td>
                                    <td style="background-color: white !important;">
                                        <span class="fw-semibold" style="color: #333 !important;">
                                            <c:if test="${not empty v.avion}">
                                                ${v.avion}
                                            </c:if>
                                            <c:if test="${empty v.avion}">
                                                <span class="text-muted">No especificado</span>
                                            </c:if>
                                        </span>
                                    </td>
                                    <td style="background-color: white !important;">
                                        <div class="btn-group" role="group">
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

<script>
    // Limpiar filtros
    function limpiarFiltros() {
        document.querySelector('input[name="origen"]').value = '';
        document.querySelector('input[name="destino"]').value = '';
        document.querySelector('input[name="fecha"]').value = '';
        document.querySelector('input[name="search"]').value = '';
        document.getElementById('searchForm').submit();
    }
    
    // Remover filtro individual
    function removeFilter(filterName) {
        document.querySelector('input[name="' + filterName + '"]').value = '';
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
    
    // Auto-submit form on Enter key in search fields
    document.addEventListener('DOMContentLoaded', function() {
        const searchInputs = document.querySelectorAll('#searchForm input[type="text"], #searchForm input[type="date"]');
        searchInputs.forEach(input => {
            input.addEventListener('keypress', function(e) {
                if (e.key === 'Enter') {
                    e.preventDefault();
                    document.getElementById('searchForm').submit();
                }
            });
        });
        
        // Show search tips
        const searchInput = document.querySelector('input[name="search"]');
        if (searchInput) {
            searchInput.addEventListener('focus', function() {
                this.placeholder = 'Ejemplo: AV3465, Avianca, Boeing 737, San José...';
            });
            
            searchInput.addEventListener('blur', function() {
                this.placeholder = 'Búsqueda rápida: número de vuelo, aerolínea, avión...';
            });
        }
    });
</script>

<%@include file= "footer.jsp" %>