<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="header.jsp"/>
<div class="container py-4">
  <h2>Agregar Pasajero</h2>
  <form method="post" action="servlet_pasajeros">
    <div class="mb-3"><label class="form-label">Nombre</label><input name="txtNombrePasajero" class="form-control"/></div>
    <div class="mb-3"><label class="form-label">Nacionalidad</label><input name="txtNacionalidad" class="form-control"/></div>
    <div class="mb-3"><label class="form-label">Pasaporte</label><input name="txtPasaporte" class="form-control"/></div>
    <button class="btn btn-primary" name="btnAgregar" value="1">Guardar</button>
    <a class="btn btn-secondary" href="servlet_pasajeros?accion=con">Cancelar</a>
  </form>
  <hr/>
  <h5>Últimos registrados</h5>
  <ul>
    <c:forEach var="p" items="${pasajeros}"><li>${p.nombrePasajero} - ${p.pasaporte}</li></c:forEach>
  </ul>
</div>
<jsp:include page="footer.jsp"/>
