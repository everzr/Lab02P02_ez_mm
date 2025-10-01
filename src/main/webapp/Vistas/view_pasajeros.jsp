<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="header.jsp"/>
<div class="container py-4">
  <h2>Pasajeros</h2>
  <a class="btn btn-primary mb-3" href="servlet_pasajeros?accion=add">Agregar pasajero</a>
  <c:if test="${empty pasajeros}">
    <div class="alert alert-info">No hay pasajeros.</div>
  </c:if>
  <c:if test="${not empty pasajeros}">
    <table class="table table-striped">
      <thead><tr><th>ID</th><th>Nombre</th><th>Nacionalidad</th><th>Pasaporte</th><th></th></tr></thead>
      <tbody>
      <c:forEach var="p" items="${pasajeros}">
        <tr>
          <td>${p.IDPasajero}</td>
          <td>${p.nombrePasajero}</td>
          <td>${p.nacionalidad}</td>
          <td>${p.pasaporte}</td>
          <td>
            <a class="btn btn-sm btn-secondary" href="servlet_pasajeros?accion=mod&id=${p.IDPasajero}">Editar</a>
            <a class="btn btn-sm btn-danger" href="servlet_pasajeros?accion=del&id=${p.IDPasajero}">Eliminar</a>
          </td>
        </tr>
      </c:forEach>
      </tbody>
    </table>
  </c:if>
  <a class="btn btn-link" href="index.jsp">Volver</a>
  </div>
<jsp:include page="footer.jsp"/>
