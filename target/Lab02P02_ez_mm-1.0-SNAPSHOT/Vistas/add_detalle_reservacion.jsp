<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="header.jsp"/>
<div class="container py-4">
  <h2>Agregar Detalle</h2>
  <form method="post" action="servelet_detalle_reservacion">
    <div class="mb-3"><label class="form-label">Asiento</label><input name="txtAsiento" class="form-control"/></div>
    <div class="mb-3"><label class="form-label">Clase</label><input name="txtClase" class="form-control"/></div>
    <button class="btn btn-primary" name="btnAgregar" value="1">Guardar</button>
    <a class="btn btn-secondary" href="servelet_detalle_reservacion?accion=con">Cancelar</a>
  </form>
  <hr/>
  <h5>Últimos detalles</h5>
  <ul>
    <c:forEach var="d" items="${detalles}"><li>${d.IDDetalle} - ${d.asiento} - ${d.clase}</li></c:forEach>
  </ul>
</div>
<jsp:include page="footer.jsp"/>
