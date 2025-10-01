<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="header.jsp"/>
<div class="container py-4">
  <h2>Actualizar Reservación</h2>
  <form method="post" action="servelt_reservacion">
    <input type="hidden" name="txtid" value="${reservacion.IDReservacion}"/>
    <div class="mb-3"><label class="form-label">Fecha Reservación</label><input type="date" name="txtFechaReservacion" class="form-control" value="${reservacion.fechaReservacion}"/></div>
    <button class="btn btn-primary" name="btnUpdate" value="1">Actualizar</button>
    <a class="btn btn-secondary" href="servelt_reservacion?accion=con">Cancelar</a>
  </form>
</div>
<jsp:include page="footer.jsp"/>
