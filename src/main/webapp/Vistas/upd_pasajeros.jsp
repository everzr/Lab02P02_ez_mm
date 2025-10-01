<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="header.jsp"/>
<div class="container py-4">
  <h2>Actualizar Pasajero</h2>
  <form method="post" action="servlet_pasajeros">
    <input type="hidden" name="txtid" value="${pasajero.IDPasajero}"/>
    <div class="mb-3"><label class="form-label">Nombre</label><input name="txtNombrePasajero" class="form-control" value="${pasajero.nombrePasajero}"/></div>
    <div class="mb-3"><label class="form-label">Nacionalidad</label><input name="txtNacionalidad" class="form-control" value="${pasajero.nacionalidad}"/></div>
    <div class="mb-3"><label class="form-label">Pasaporte</label><input name="txtPasaporte" class="form-control" value="${pasajero.pasaporte}"/></div>
    <button class="btn btn-primary" name="btnUpdate" value="1">Actualizar</button>
    <a class="btn btn-secondary" href="servlet_pasajeros?accion=con">Cancelar</a>
  </form>
</div>
<jsp:include page="footer.jsp"/>
