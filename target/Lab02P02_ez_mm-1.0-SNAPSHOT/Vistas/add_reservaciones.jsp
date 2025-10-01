<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="header.jsp"/>
<div class="container py-4">
  <h2 class="mb-3">Nueva Reservación</h2>
  <c:if test="${not empty error}">
    <div class="alert alert-danger d-flex align-items-center" role="alert">
      <i class="fas fa-exclamation-triangle me-2"></i>
      <div>${error}</div>
    </div>
  </c:if>
  <form method="post" action="${pageContext.request.contextPath}/servelt_reservacion">
    <div class="row g-3">
      <div class="col-md-3">
        <label class="form-label">Fecha Reservación</label>
        <jsp:useBean id="now" class="java.util.Date"/>
        <input type="date" class="form-control" value="<fmt:formatDate value='${now}' pattern='yyyy-MM-dd'/>" disabled />
        <div class="form-text">La fecha la asigna el sistema automáticamente.</div>
      </div>
      <div class="col-md-5">
        <label class="form-label">Pasajero</label>
        <input type="text" class="form-control mb-2" placeholder="Buscar pasajero..." oninput="filterSelectOptionsByName(this, 'txtPasajeroId')">
        <select class="form-select" name="txtPasajeroId" required>
          <option value="">Seleccione pasajero</option>
          <c:forEach var="p" items="${pasajeros}">
            <option value="${p.IDPasajero}">${p.nombrePasajero}</option>
          </c:forEach>
        </select>
        <c:if test="${empty pasajeros}">
          <div class="form-text text-danger">No hay pasajeros registrados. Registra uno desde el menú Pasajeros.</div>
        </c:if>
      </div>
      <div class="col-md-4">
        <label class="form-label">Vuelo</label>
        <input type="text" class="form-control mb-2" placeholder="Buscar vuelo..." oninput="filterSelectOptionsByName(this, 'txtVueloId')">
        <select class="form-select" name="txtVueloId" required>
          <option value="">Seleccione vuelo</option>
          <c:forEach var="v" items="${vuelos}">
            <option value="${v.IDVuelo}"
                    data-fecha-salida="<fmt:formatDate value='${v.fechaSalida}' pattern='yyyy-MM-dd'/>"
                    data-hora-salida="<fmt:formatDate value='${v.horaSalida}' pattern='HH:mm'/>">
              ${v.numeroVuelo} - ${v.origen} → ${v.destino}
              (<fmt:formatDate value='${v.fechaSalida}' pattern='dd/MM/yyyy'/> <fmt:formatDate value='${v.horaSalida}' pattern='HH:mm'/> )
            </option>
          </c:forEach>
        </select>
        <c:if test="${empty vuelos}">
          <div class="form-text text-danger">No hay vuelos disponibles. Crea uno desde el menú Vuelos.</div>
        </c:if>
      </div>
      <div class="col-md-3">
        <label class="form-label">Clase</label>
        <select class="form-select" name="txtClase">
          <option value="Economica">Económica</option>
          <option value="Business">Business</option>
          <option value="Primera">Primera</option>
        </select>
      </div>
      <div class="col-md-3">
        <label class="form-label">Asiento</label>
        <input type="text" name="txtAsiento" class="form-control" maxlength="10"/>
      </div>
    </div>
    <!-- Más asientos/clases -->
    <div id="detallesContainer"></div>
    <div class="mt-2">
      <button type="button" class="btn btn-outline-primary btn-sm" onclick="agregarDetalle()">
        <i class="fas fa-plus me-1"></i>Agregar otro asiento
      </button>
    </div>
    <div class="mt-3">
      <a class="btn btn-outline-secondary" href="${pageContext.request.contextPath}/servelt_reservacion?accion=con">Cancelar</a>
      <button class="btn btn-warning text-white" name="btnAgregar" value="1">
        <i class="fas fa-save me-1"></i>Guardar Reservación
      </button>
    </div>
  </form>
  <hr/>
  <h5>Últimas reservaciones</h5>
  <ul class="mb-0">
    <c:forEach var="r" items="${reservaciones}">
      <li>RSV${r.IDReservacion} - ${r.fechaReservacion}</li>
    </c:forEach>
  </ul>
</div>
<script>
  function filterSelectOptionsByName(input, selectName) {
    const term = (input.value || '').toLowerCase();
    const select = document.querySelector("select[name='" + selectName + "']");
    if (!select) return;
    Array.from(select.options).forEach(opt => {
      if (!opt.value) return; // keep placeholder
      const text = (opt.text || '').toLowerCase();
      opt.style.display = text.includes(term) ? '' : 'none';
    });
  }

  function agregarDetalle() {
    const container = document.getElementById('detallesContainer');
    const row = document.createElement('div');
    row.className = 'row g-3 mt-1';
    row.innerHTML = `
      <div class="col-md-3">
        <label class="form-label">Clase</label>
        <select class="form-select" name="txtClase">
          <option value="Economica">Económica</option>
          <option value="Business">Business</option>
          <option value="Primera">Primera</option>
        </select>
      </div>
      <div class="col-md-3">
        <label class="form-label">Asiento</label>
        <div class="input-group">
          <input type="text" name="txtAsiento" class="form-control" maxlength="10"/>
          <button type="button" class="btn btn-outline-danger" title="Quitar" onclick="this.closest('.row').remove()">
            <i class="fas fa-times"></i>
          </button>
        </div>
      </div>
    `;
    container.appendChild(row);
  }
  // Ocultar vuelos ya pasados en el combobox (según fechaSalida)
  (function hidePastFlights(){
    const select = document.querySelector("select[name='txtVueloId']");
    if (!select) return;
    const threshold = new Date(Date.now() + 3 * 60 * 60 * 1000); // ahora + 3 horas
    Array.from(select.options).forEach(opt => {
      const ds = opt.getAttribute('data-fecha-salida');
      const hs = opt.getAttribute('data-hora-salida');
      if (!opt.value || !ds || !hs) return;
      const dep = new Date(ds + 'T' + hs + ':00');
      if (isFinite(dep) && dep < threshold) opt.style.display = 'none';
    });
  })();
</script>
<jsp:include page="footer.jsp"/>
