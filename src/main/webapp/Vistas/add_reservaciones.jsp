<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="header.jsp"/>
<div class="container py-4">
  <h2>Agregar Reservación</h2>
  <form method="post" action="servelt_reservacion">
    <div class="mb-3"><label class="form-label">Fecha Reservación</label><input type="date" name="txtFechaReservacion" class="form-control"/></div>
    <button class="btn btn-primary" name="btnAgregar" value="1">Guardar</button>
    <a class="btn btn-secondary" href="servelt_reservacion?accion=con">Cancelar</a>
  </form>
  <hr/>
  <h5>Últimas reservaciones</h5>
  <ul>
    <c:forEach var="r" items="${reservaciones}"><li>${r.IDReservacion} - ${r.fechaReservacion}</li></c:forEach>
  </ul>
</div>
<jsp:include page="footer.jsp"/>
