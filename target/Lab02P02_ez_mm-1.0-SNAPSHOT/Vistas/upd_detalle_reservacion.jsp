<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="header.jsp"/>
<div class="container py-4">
  <h2>Actualizar Detalle</h2>
  <form method="post" action="servelet_detalle_reservacion">
    <input type="hidden" name="txtid" value="${detalle.IDDetalle}"/>
    <div class="mb-3"><label class="form-label">Asiento</label><input name="txtAsiento" class="form-control" value="${detalle.asiento}"/></div>
    <div class="mb-3"><label class="form-label">Clase</label><input name="txtClase" class="form-control" value="${detalle.clase}"/></div>
    <button class="btn btn-primary" name="btnUpdate" value="1">Actualizar</button>
    <a class="btn btn-secondary" href="servelet_detalle_reservacion?accion=con">Cancelar</a>
  </form>
</div>
<jsp:include page="footer.jsp"/>
