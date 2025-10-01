<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="header.jsp"/>
<div class="container-fluid">
  <!-- Breadcrumb -->
  <nav aria-label="breadcrumb" class="breadcrumb-custom">
    <ol class="breadcrumb">
      <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/index.jsp">Inicio</a></li>
      <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/servelt_reservacion">Reservaciones</a></li>
      <li class="breadcrumb-item active" aria-current="page">Detalle de Reservación</li>
    </ol>
  </nav>

  <!-- Header -->
  <div class="d-flex justify-content-between align-items-center mb-4">
    <div>
      <h2 class="fw-bold text-dark mb-1">
        <i class="fas fa-eye text-warning me-2"></i>Reservación RSV${reservacion.IDReservacion}
      </h2>
      <p class="text-muted mb-0">Fecha de reserva: <strong>
        <fmt:formatDate value='${reservacion.fechaReservacion}' pattern='yyyy-MM-dd'/>
      </strong></p>
    </div>
    <div>
      <a href="${pageContext.request.contextPath}/servelt_reservacion" class="btn btn-outline-secondary">
        <i class="fas fa-arrow-left me-1"></i>Volver
      </a>
    </div>
  </div>

  <div class="row">
    <!-- Pasajero -->
    <div class="col-lg-4">
      <div class="card shadow-sm mb-4">
        <div class="card-header bg-light"><h6 class="mb-0"><i class="fas fa-user me-2"></i>Pasajero</h6></div>
        <div class="card-body">
          <p class="mb-1"><strong>Nombre:</strong> ${reservacion.IDPasajero != null ? reservacion.IDPasajero.nombrePasajero : '—'}</p>
          <p class="mb-0"><strong>Pasaporte:</strong> ${reservacion.IDPasajero != null ? reservacion.IDPasajero.pasaporte : '—'}</p>
        </div>
      </div>
    </div>

    <!-- Vuelo principal (del primer detalle si existe) -->
    <div class="col-lg-8">
      <div class="card shadow-sm mb-4">
        <div class="card-header bg-light"><h6 class="mb-0"><i class="fas fa-plane me-2"></i>Vuelo</h6></div>
        <div class="card-body">
          <c:set var="det0" value="${empty detalles ? null : detalles[0]}"/>
          <c:set var="v0" value="${det0 != null ? det0.IDVuelo : null}"/>
          <div class="row">
            <div class="col-md-4">
              <p class="mb-1"><strong>Número:</strong> ${v0 != null ? v0.numeroVuelo : '—'}</p>
              <p class="mb-0"><strong>Aerolínea:</strong> ${v0 != null ? v0.aerolinea : '—'}</p>
            </div>
            <div class="col-md-4">
              <p class="mb-1"><strong>Origen:</strong> ${v0 != null ? v0.origen : '—'}</p>
              <p class="mb-0"><strong>Destino:</strong> ${v0 != null ? v0.destino : '—'}</p>
            </div>
            <div class="col-md-4">
              <p class="mb-1"><strong>Salida:</strong> <fmt:formatDate value='${v0 != null ? v0.fechaSalida : null}' pattern='yyyy-MM-dd'/></p>
              <p class="mb-0"><strong>Llegada:</strong> <fmt:formatDate value='${v0 != null ? v0.fechaLlegada : null}' pattern='yyyy-MM-dd'/></p>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>

  <!-- Detalles (Asientos y Clases) -->
  <div class="card shadow-sm">
    <div class="card-header bg-light d-flex justify-content-between align-items-center">
      <h6 class="mb-0"><i class="fas fa-chair me-2"></i>Boletos (Asientos)</h6>
      <span class="text-muted">${empty detalles ? 0 : detalles.size()} asiento(s)</span>
    </div>
    <div class="card-body p-0">
      <c:if test="${empty detalles}">
        <div class="text-center py-4 text-muted">No hay asientos registrados para esta reservación.</div>
      </c:if>
      <c:if test="${not empty detalles}">
        <div class="table-responsive">
          <table class="table table-hover mb-0">
            <thead class="table-dark">
              <tr>
                <th>Asiento</th>
                <th>Clase</th>
                <th>Vuelo</th>
                <th>Ruta</th>
              </tr>
            </thead>
            <tbody>
              <c:forEach var="d" items="${detalles}">
                <tr>
                  <td class="fw-bold">${d.asiento}</td>
                  <td>${d.clase}</td>
                  <td>${d.IDVuelo != null ? d.IDVuelo.numeroVuelo : '—'}</td>
                  <td>
                    <c:choose>
                      <c:when test="${d.IDVuelo != null}">
                        ${d.IDVuelo.origen} → ${d.IDVuelo.destino}
                      </c:when>
                      <c:otherwise>—</c:otherwise>
                    </c:choose>
                  </td>
                </tr>
              </c:forEach>
            </tbody>
          </table>
        </div>
      </c:if>
    </div>
    <div class="card-footer bg-light d-flex justify-content-end">
      <a href="${pageContext.request.contextPath}/servelt_reservacion" class="btn btn-outline-secondary">
        <i class="fas fa-arrow-left me-1"></i>Volver a Reservaciones
      </a>
    </div>
  </div>
</div>
<jsp:include page="footer.jsp"/>