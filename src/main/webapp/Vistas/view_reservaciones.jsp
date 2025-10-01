<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="header.jsp"/>
<div class="container py-4">
  <h2>Reservaciones</h2>
  <a class="btn btn-primary mb-3" href="servelt_reservacion?accion=add">Agregar reservación</a>
  <c:if test="${empty reservaciones}"><div class="alert alert-info">No hay reservaciones.</div></c:if>
  <c:if test="${not empty reservaciones}">
    <table class="table table-striped"><thead><tr><th>ID</th><th>Fecha</th><th></th></tr></thead><tbody>
    <c:forEach var="r" items="${reservaciones}">
      <tr>
        <td>${r.IDReservacion}</td>
        <td>${r.fechaReservacion}</td>
        <td>
          <a class="btn btn-sm btn-secondary" href="servelt_reservacion?accion=mod&id=${r.IDReservacion}">Editar</a>
          <a class="btn btn-sm btn-danger" href="servelt_reservacion?accion=del&id=${r.IDReservacion}">Eliminar</a>
        </td>
      </tr>
    </c:forEach>
    </tbody></table>
  </c:if>
  <a class="btn btn-link" href="index.jsp">Volver</a>
</div>
<jsp:include page="footer.jsp"/>
