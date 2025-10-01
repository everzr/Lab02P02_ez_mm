<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ include file="header.jsp" %>

<div class="container-fluid">
    <style>
        /* Ensure visibility of dark table headers */
        .table-dark th, .table thead.table-dark th { color: #fff !important; }
        .table thead.table-dark { background-color: #212529 !important; }
    </style>
    <!-- Breadcrumb -->
    <nav aria-label="breadcrumb" class="breadcrumb-custom">
        <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/index.jsp">Inicio</a></li>
            <li class="breadcrumb-item active" aria-current="page">Gestión de Pasajeros</li>
        </ol>
    </nav>

    <!-- Header Section -->
    <div class="d-flex justify-content-between align-items-center mb-4">
        <div>
            <h2 class="fw-bold text-dark mb-2">
                <i class="fas fa-users text-success me-2"></i>Gestión de Pasajeros
            </h2>
            <p class="text-muted mb-0">Administra el registro y la información de todos los pasajeros</p>
        </div>
        <a href="${pageContext.request.contextPath}/servlet_pasajeros?accion=add" class="btn btn-success btn-lg">
            <i class="fas fa-user-plus me-2"></i>Registrar Pasajero
        </a>
    </div>

    <!-- Search and Filter Section -->
    <div class="card shadow-sm mb-4">
        <div class="card-body">
            <c:if test="${not empty error}">
                <div class="alert alert-danger d-flex align-items-center" role="alert">
                    <i class="fas fa-exclamation-triangle me-2"></i>
                    <div>${error}</div>
                </div>
            </c:if>
            <div class="d-flex justify-content-between align-items-center mb-3">
                <h5 class="card-title mb-0"><i class="fas fa-search me-2"></i>Buscar y Filtrar Pasajeros</h5>
                <div class="d-flex gap-2">
                    <c:if test="${not empty param.nombre or not empty requestScope.nacionalidad or not empty param.pasaporte or not empty param.search}">
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
            <c:if test="${not empty param.nombre or not empty param.nacionalidad or not empty param.pasaporte or not empty param.search}">
                <div class="mb-3">
                    <small class="text-muted">Filtros aplicados:</small>
                    <div class="mt-1">
                        <c:if test="${not empty param.nombre}">
                            <span class="badge bg-light text-dark me-2">
                                <i class="fas fa-user me-1"></i>Nombre: ${param.nombre}
                                <button type="button" class="btn-close btn-close-sm ms-1" onclick="removeFilter('nombre')" style="font-size: 0.6em;"></button>
                            </span>
                        </c:if>
                        <c:if test="${not empty requestScope.nacionalidad}">
                            <span class="badge bg-light text-dark me-2">
                                <i class="fas fa-flag me-1"></i>Nacionalidad: ${requestScope.nacionalidadRaw != null ? requestScope.nacionalidadRaw : requestScope.nacionalidad}
                                <button type="button" class="btn-close btn-close-sm ms-1" onclick="removeFilter('nacionalidad')" style="font-size: 0.6em;"></button>
                            </span>
                        </c:if>
                        <c:if test="${not empty param.pasaporte}">
                            <span class="badge bg-light text-dark me-2">
                                <i class="fas fa-passport me-1"></i>Pasaporte: ${param.pasaporte}
                                <button type="button" class="btn-close btn-close-sm ms-1" onclick="removeFilter('pasaporte')" style="font-size: 0.6em;"></button>
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
            
            <form class="row g-3" method="GET" action="${pageContext.request.contextPath}/servlet_pasajeros" id="searchForm" accept-charset="UTF-8">
                <input type="hidden" name="accion" value="con">
                <div class="col-md-4">
                    <label class="form-label">Nombre del Pasajero</label>
                    <div class="input-group">
                        <span class="input-group-text"><i class="fas fa-user"></i></span>
                        <input type="text" class="form-control" name="nombre" placeholder="Buscar por nombre..." value="${param.nombre}">
                    </div>
                </div>
                <div class="col-md-3">
                    <label class="form-label">Nacionalidad</label>
                    <div class="input-group">
                        <span class="input-group-text"><i class="fas fa-flag"></i></span>
                        <select class="form-select" name="nacionalidad">
                            <option value="">Todas las nacionalidades</option>
                            <option value="guatemalteca" ${(requestScope.nacionalidadRaw == 'guatemalteca') or (param.nacionalidad == 'guatemalteca') ? 'selected' : ''}>Guatemalteca</option>
                            <option value="salvadoreña" ${(requestScope.nacionalidadRaw == 'salvadoreña') or (param.nacionalidad == 'salvadoreña') ? 'selected' : ''}>Salvadoreña</option>
                            <option value="hondureña" ${(requestScope.nacionalidadRaw == 'hondureña') or (param.nacionalidad == 'hondureña') ? 'selected' : ''}>Hondureña</option>
                            <option value="nicaragüense" ${(requestScope.nacionalidadRaw == 'nicaragüense') or (param.nacionalidad == 'nicaragüense') ? 'selected' : ''}>Nicaragüense</option>
                            <option value="costarricense" ${(requestScope.nacionalidadRaw == 'costarricense') or (param.nacionalidad == 'costarricense') ? 'selected' : ''}>Costarricense</option>
                            <option value="panameña" ${(requestScope.nacionalidadRaw == 'panameña') or (param.nacionalidad == 'panameña') ? 'selected' : ''}>Panameña</option>
                            <option value="beliceña" ${(requestScope.nacionalidadRaw == 'beliceña') or (param.nacionalidad == 'beliceña') ? 'selected' : ''}>Beliceña</option>
                            <option value="mexicana" ${(requestScope.nacionalidadRaw == 'mexicana') or (param.nacionalidad == 'mexicana') ? 'selected' : ''}>Mexicana</option>
                            <option value="estadounidense" ${(requestScope.nacionalidadRaw == 'estadounidense') or (param.nacionalidad == 'estadounidense') ? 'selected' : ''}>Estadounidense</option>
                            <option value="canadiense" ${(requestScope.nacionalidadRaw == 'canadiense') or (param.nacionalidad == 'canadiense') ? 'selected' : ''}>Canadiense</option>
                            <option value="española" ${(requestScope.nacionalidadRaw == 'española') or (param.nacionalidad == 'española') ? 'selected' : ''}>Española</option>
                            <option value="otra" ${(requestScope.nacionalidadRaw == 'otra') or (param.nacionalidad == 'otra') ? 'selected' : ''}>Otra</option>
                        </select>
                    </div>
                </div>
                <div class="col-md-3">
                    <label class="form-label">Número de Pasaporte</label>
                    <div class="input-group">
                        <span class="input-group-text"><i class="fas fa-passport"></i></span>
                        <input type="text" class="form-control" name="pasaporte" placeholder="Número de pasaporte" value="${param.pasaporte}">
                    </div>
                </div>
                <div class="col-md-2 d-flex align-items-end">
                    <button type="submit" class="btn btn-success w-100">
                        <i class="fas fa-search me-1"></i>Buscar
                    </button>
                </div>
            </form>
            
            <!-- Búsqueda rápida -->
            <div class="row mt-3">
                <div class="col-md-12">
                    <div class="input-group">
                        <span class="input-group-text"><i class="fas fa-search"></i></span>
                        <input type="text" class="form-control" placeholder="Búsqueda rápida: nombre, nacionalidad, pasaporte o ID..." 
                               name="search" value="${param.search}" form="searchForm">
                        <button class="btn btn-outline-success" type="submit" form="searchForm">
                            <i class="fas fa-search"></i>
                        </button>
                    </div>
                    <div class="form-text">
                        <i class="fas fa-info-circle me-1"></i>
                        Busca por nombre, nacionalidad, número de pasaporte o ID del pasajero
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Statistics Cards -->
    <div class="row mb-4">
        <div class="col-md-4">
            <div class="card bg-success text-white h-100">
                <div class="card-body text-center">
                    <i class="fas fa-users fa-2x mb-2"></i>
                    <h5 class="card-title">Total Pasajeros</h5>
                    <h3 class="mb-0">${fn:length(pasajeros)}</h3>
                </div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="card bg-primary text-white h-100">
                <div class="card-body text-center">
                    <i class="fas fa-user-check fa-2x mb-2"></i>
                    <h5 class="card-title">Activos</h5>
                    <h3 class="mb-0">${fn:length(pasajeros)}</h3>
                </div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="card bg-info text-white h-100">
                <div class="card-body text-center">
                    <i class="fas fa-globe fa-2x mb-2"></i>
                    <h5 class="card-title">Nacionalidades</h5>
                    <h3 class="mb-0">
                        <!-- Contador seguro de nacionalidades distintas (sin usar métodos Java en EL) -->
                        <c:set var="_acc" value="|"/>
                        <c:set var="_nacCount" value="0"/>
                        <c:forEach var="p" items="${pasajeros}">
                            <c:if test="${not empty p.nacionalidad}">
                                <c:set var="_cand" value="|${p.nacionalidad}|"/>
                                <c:if test="${not fn:contains(_acc, _cand)}">
                                    <c:set var="_acc" value="${_acc}${_cand}"/>
                                    <c:set var="_nacCount" value="${_nacCount + 1}"/>
                                </c:if>
                            </c:if>
                        </c:forEach>
                        ${_nacCount}
                    </h3>
                </div>
            </div>
        </div>
    </div>

    <!-- Pasajeros Table -->
    <div class="card shadow-sm">
        <div class="card-header bg-light">
            <div class="d-flex justify-content-between align-items-center">
                <h5 class="mb-0"><i class="fas fa-list me-2"></i>Lista de Pasajeros Registrados</h5>
                <a href="${pageContext.request.contextPath}/servlet_pasajeros?accion=add" class="btn btn-success btn-sm">
                    <i class="fas fa-user-plus me-1"></i>Nuevo Pasajero
                </a>
            </div>
        </div>
        <div class="card-body p-0">
            <c:if test="${empty pasajeros}">
                <div class="text-center py-5">
                    <i class="fas fa-user-friends fa-4x text-muted mb-3"></i>
                    <h4 class="text-muted mb-3">No hay pasajeros registrados</h4>
                    <p class="text-muted mb-4">Comienza registrando el primer pasajero en el sistema</p>
                    <a href="${pageContext.request.contextPath}/servlet_pasajeros?accion=add" class="btn btn-success btn-lg">
                        <i class="fas fa-user-plus me-2"></i>Registrar Primer Pasajero
                    </a>
                </div>
            </c:if>
            
            <c:if test="${not empty pasajeros}">
                <div class="table-responsive">
                    <table class="table table-hover mb-0">
                        <thead class="table-dark">
                            <tr>
                                <th scope="col">
                                    <input type="checkbox" class="form-check-input" id="selectAllPassengers" onchange="toggleSelectAllPassengers()">
                                </th>
                                <th scope="col">ID</th>
                                <th scope="col">
                                    <i class="fas fa-user me-1"></i>Pasajero
                                </th>
                                <th scope="col">
                                    <i class="fas fa-flag me-1"></i>Nacionalidad
                                </th>
                                <th scope="col">
                                    <i class="fas fa-passport me-1"></i>Pasaporte
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
                            <c:forEach var="p" items="${pasajeros}" varStatus="status">
                                <tr class="align-middle">
                                    <td>
                                        <input type="checkbox" class="form-check-input pasajero-checkbox" value="${p.IDPasajero}">
                                    </td>
                                    <td>
                                        <span class="badge bg-secondary">#${p.IDPasajero}</span>
                                    </td>
                                    <td>
                                        <div class="d-flex align-items-center">
                                            <div class="flex-shrink-0">
                                                <div class="bg-success rounded-circle d-flex align-items-center justify-content-center" style="width: 45px; height: 45px;">
                                                    <i class="fas fa-user text-white"></i>
                                                </div>
                                            </div>
                                            <div class="flex-grow-1 ms-3">
                                                <h6 class="mb-1 fw-bold">${p.nombrePasajero}</h6>
                                                <small class="text-muted">
                                                    <i class="fas fa-id-card me-1"></i>ID: ${p.IDPasajero}
                                                </small>
                                            </div>
                                        </div>
                                    </td>
                                    <td>
                                        <div class="d-flex align-items-center">
                                            <i class="fas fa-flag me-2 text-primary"></i>
                                            <span class="fw-semibold text-capitalize">
                                                <c:choose>
                                                    <c:when test="${not empty p.nacionalidad}">
                                                        ${p.nacionalidad}
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="text-muted">No especificada</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </span>
                                        </div>
                                    </td>
                                    <td>
                                        <div class="passport-info">
                                            <c:choose>
                                                <c:when test="${not empty p.pasaporte}">
                                                    <span class="fw-bold font-monospace">${p.pasaporte}</span>
                                                    <div>
                                                        <small class="text-success">
                                                            <i class="fas fa-check-circle me-1"></i>Verificado
                                                        </small>
                                                    </div>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="text-muted">No especificado</span>
                                                    <div>
                                                        <small class="text-warning">
                                                            <i class="fas fa-exclamation-triangle me-1"></i>Pendiente
                                                        </small>
                                                    </div>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                    </td>
                                    <td>
                                        <span class="badge bg-success">
                                            <i class="fas fa-check me-1"></i>Activo
                                        </span>
                                    </td>
                                    <td>
                                        <div class="btn-group" role="group">
                                            <a href="${pageContext.request.contextPath}/servlet_pasajeros?accion=mod&id=${p.IDPasajero}" 
                                               class="btn btn-sm btn-outline-warning" title="Editar">
                                                <i class="fas fa-edit"></i>
                                            </a>
                                            <button type="button" class="btn btn-sm btn-outline-danger" 
                                                    onclick="deletePassenger(${p.IDPasajero})" title="Eliminar">
                                                <i class="fas fa-trash"></i>
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
                            <span class="text-muted">Mostrando ${fn:length(pasajeros)} pasajeros registrados</span>
                        </div>
                        <div>
                            <button class="btn btn-outline-danger btn-sm me-2" onclick="deleteSelectedPassengers()" id="deleteSelectedPassengersBtn" style="display: none;">
                                <i class="fas fa-trash me-1"></i>Eliminar Seleccionados
                            </button>
                            <a href="${pageContext.request.contextPath}/servlet_pasajeros?accion=add" class="btn btn-success btn-sm">
                                <i class="fas fa-user-plus me-1"></i>Nuevo Pasajero
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
        document.querySelector('input[name="nombre"]').value = '';
        document.querySelector('select[name="nacionalidad"]').value = '';
        document.querySelector('input[name="pasaporte"]').value = '';
        document.querySelector('input[name="search"]').value = '';
        document.getElementById('searchForm').submit();
    }
    
    // Remover filtro individual
    function removeFilter(filterName) {
        const element = document.querySelector('[name="' + filterName + '"]');
        if (element) {
            element.value = '';
            document.getElementById('searchForm').submit();
        }
    }
    
    // Toggle select all checkboxes
    function toggleSelectAllPassengers() {
        const selectAll = document.getElementById('selectAllPassengers');
        const checkboxes = document.querySelectorAll('.pasajero-checkbox');
        const deleteBtn = document.getElementById('deleteSelectedPassengersBtn');
        
        checkboxes.forEach(checkbox => {
            checkbox.checked = selectAll.checked;
        });
        
        deleteBtn.style.display = selectAll.checked ? 'block' : 'none';
    }
    
    // Show/hide delete button based on individual checkbox selection
    document.addEventListener('change', function(e) {
        if (e.target.classList.contains('pasajero-checkbox')) {
            const checkboxes = document.querySelectorAll('.pasajero-checkbox:checked');
            const deleteBtn = document.getElementById('deleteSelectedPassengersBtn');
            deleteBtn.style.display = checkboxes.length > 0 ? 'block' : 'none';
        }
    });
    
    // Delete single passenger
    function deletePassenger(id) {
        if (confirm('¿Estás seguro de que deseas eliminar este pasajero? Esta acción no se puede deshacer.')) {
            window.location.href = '${pageContext.request.contextPath}/servlet_pasajeros?accion=del&id=' + id;
        }
    }
    
    // Delete selected passengers
    function deleteSelectedPassengers() {
        const selected = document.querySelectorAll('.pasajero-checkbox:checked');
        if (selected.length === 0) {
            alert('Por favor selecciona al menos un pasajero para eliminar.');
            return;
        }
        
        if (confirm('¿Estás seguro de que deseas eliminar ' + selected.length + ' pasajero(s)? Esta acción no se puede deshacer.')) {
            const ids = Array.from(selected).map(cb => cb.value);
            // Implementation for bulk delete
            console.log('Deleting passengers:', ids);
            alert('Funcionalidad de eliminación múltiple en desarrollo.');
        }
    }
    
    // Auto-submit form on Enter key in search fields
    document.addEventListener('DOMContentLoaded', function() {
        const searchInputs = document.querySelectorAll('#searchForm input[type="text"], #searchForm select');
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
                this.placeholder = 'Ejemplo: Juan Pérez, guatemalteca, GT123456...';
            });
            
            searchInput.addEventListener('blur', function() {
                this.placeholder = 'Búsqueda rápida: nombre, nacionalidad, pasaporte o ID...';
            });
        }
    });
</script>

<%@ include file="footer.jsp" %>
