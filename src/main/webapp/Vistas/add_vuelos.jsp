<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file= "header.jsp" %>
<h2>Agregar Vuelo</h2>
<form method="post" action="servlet_vuelos">
    <div class="row g-3">
        <div class="col-md-4"><label class="form-label">Número Vuelo</label><input class="form-control" name="txtNumeroVuelo"/></div>
        <div class="col-md-4"><label class="form-label">Aerolínea</label><input class="form-control" name="txtAerolinea"/></div>
        <div class="col-md-4"><label class="form-label">Avión</label><input class="form-control" name="txtAvion"/></div>
        <div class="col-md-3"><label class="form-label">Origen</label><input class="form-control" name="txtOrigen"/></div>
        <div class="col-md-3"><label class="form-label">Destino</label><input class="form-control" name="txtDestino"/></div>
        <div class="col-md-3"><label class="form-label">Fecha Salida</label><input type="date" class="form-control" name="txtFechaSalida"/></div>
        <div class="col-md-3"><label class="form-label">Hora Salida</label><input type="time" class="form-control" name="txtHoraSalida"/></div>
        <div class="col-md-3"><label class="form-label">Fecha Llegada</label><input type="date" class="form-control" name="txtFechaLlegada"/></div>
        <div class="col-md-3"><label class="form-label">Hora Llegada</label><input type="time" class="form-control" name="txtHoraLlegada"/></div>
    </div>
    <div class="mt-3">
        <button class="btn btn-primary" name="btnAgregar" value="1">Guardar</button>
    </div>
}</form>
<%@include file= "footer.jsp" %>
