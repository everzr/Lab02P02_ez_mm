<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="header.jsp"/>
<div class="container py-4">
  <h2>Actualizar Reservación RSV${reservacion.IDReservacion}</h2>
  <c:if test="${not empty error}">
    <div class="alert alert-danger d-flex align-items-center" role="alert">
      <i class="fas fa-exclamation-triangle me-2"></i>
      <div>${error}</div>
    </div>
  </c:if>
  <form method="post" action="${pageContext.request.contextPath}/servelt_reservacion">
    <input type="hidden" name="txtid" value="${reservacion.IDReservacion}"/>
    <div class="row g-3">
      <div class="col-md-3">
        <label class="form-label">Fecha Reservación</label>
        <input type="date" class="form-control" value="<fmt:formatDate value='${reservacion.fechaReservacion}' pattern='yyyy-MM-dd'/>" disabled />
        <div class="form-text">No editable. Conserva la fecha original.</div>
      </div>
      <div class="col-md-5"><label class="form-label">Pasajero</label>
        <input type="text" class="form-control mb-2" placeholder="Buscar pasajero..." oninput="filterSelectOptions(this, 'select[name=\\'txtPasajeroId\\']')">
        <select class="form-select" name="txtPasajeroId" required>
          <c:forEach var="p" items="${pasajeros}">
            <option value="${p.IDPasajero}" ${reservacion.IDPasajero.IDPasajero == p.IDPasajero ? 'selected' : ''}>${p.nombrePasajero}</option>
          </c:forEach>
        </select>
      </div>
      <div class="col-md-4"><label class="form-label">Vuelo</label>
        <input type="text" class="form-control mb-2" placeholder="Buscar vuelo..." oninput="filterSelectOptions(this, 'select[name=\\'txtVueloId\\']')">
        <select class="form-select" name="txtVueloId">
          <option value="">—</option>
          <c:forEach var="v" items="${vuelos}">
            <option value="${v.IDVuelo}"
                    data-fecha-salida="<fmt:formatDate value='${v.fechaSalida}' pattern='yyyy-MM-dd'/>"
                    data-hora-salida="<fmt:formatDate value='${v.horaSalida}' pattern='HH:mm'/>"
                    ${(vueloSeleccionado != null && vueloSeleccionado.IDVuelo == v.IDVuelo) ? 'selected' : ''}>
              ${v.numeroVuelo} - ${v.origen} → ${v.destino}
              (<fmt:formatDate value='${v.fechaSalida}' pattern='dd/MM/yyyy'/> <fmt:formatDate value='${v.horaSalida}' pattern='HH:mm'/>)
            </option>
          </c:forEach>
        </select>
      </div>
      <div class="col-md-3"><label class="form-label">Clase</label>
        <select class="form-select" name="txtClase">
          <c:set var="selClase" value="${detalle != null ? detalle.clase : ''}"/>
          <option value="Economica" ${selClase == 'Economica' ? 'selected' : ''}>Económica</option>
          <option value="Business" ${selClase == 'Business' ? 'selected' : ''}>Business</option>
          <option value="Primera" ${selClase == 'Primera' ? 'selected' : ''}>Primera</option>
        </select>
      </div>
      <div class="col-md-3"><label class="form-label">Asiento</label><input type="text" name="txtAsiento" class="form-control" maxlength="10" value="${detalle != null ? detalle.asiento : ''}"/></div>
    </div>
    <div id="detallesContainer">
      <c:forEach var="d" items="${reservacion.detalleReservacionCollection}">
        <div class="row g-3 mt-1">
          <div class="col-md-3">
            <label class="form-label">Clase</label>
            <select class="form-select" name="txtClase">
              <option value="Economica" ${d.clase == 'Economica' ? 'selected' : ''}>Económica</option>
              <option value="Business" ${d.clase == 'Business' ? 'selected' : ''}>Business</option>
              <option value="Primera" ${d.clase == 'Primera' ? 'selected' : ''}>Primera</option>
            </select>
          </div>
          <div class="col-md-3">
            <label class="form-label">Asiento</label>
            <div class="input-group">
              <input type="text" name="txtAsiento" class="form-control" maxlength="10" value="${d.asiento}"/>
              <button type="button" class="btn btn-outline-danger" title="Quitar" onclick="this.closest('.row').remove()">
                <i class="fas fa-times"></i>
              </button>
            </div>
          </div>
        </div>
      </c:forEach>
    </div>
    <div class="mt-2">
      <button type="button" class="btn btn-outline-primary btn-sm" onclick="agregarDetalle()">
        <i class="fas fa-plus me-1"></i>Agregar otro asiento
      </button>
    </div>
    <div class="mt-3">
      <a class="btn btn-outline-secondary" href="${pageContext.request.contextPath}/servelt_reservacion?accion=con">Cancelar</a>
      <button class="btn btn-warning text-white" name="btnUpdate" value="1">Actualizar</button>
    </div>
  </form>
</div>
<script>
  function filterSelectOptions(input, selectQuery) {
    const term = (input.value || '').toLowerCase();
    const select = document.querySelector(selectQuery);
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
  // Ocultar vuelos con salida en menos de 3 horas
  (function hidePastFlights(){
    const select = document.querySelector("select[name='txtVueloId']");
    if (!select) return;
    const threshold = new Date(Date.now() + 3 * 60 * 60 * 1000);
    Array.from(select.options).forEach(opt => {
      const ds = opt.getAttribute('data-fecha-salida');
      const hs = opt.getAttribute('data-hora-salida');
      if (!opt.value || !ds || !hs) return;
      const dep = new Date(ds + 'T' + hs + ':00');
      if (isFinite(dep) && dep < threshold && !opt.selected) opt.style.display = 'none';
    });
  })();
</script>
<jsp:include page="footer.jsp"/>
