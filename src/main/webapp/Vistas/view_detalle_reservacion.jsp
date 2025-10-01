<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="header.jsp"/>
<div class="container py-4">
  <h2>Detalle de Reservación</h2>
  <a class="btn btn-primary mb-3" href="servelet_detalle_reservacion?accion=add">Agregar detalle</a>
  <c:if test="${empty detalles}"><div class="alert alert-info">No hay detalles.</div></c:if>
  <c:if test="${not empty detalles}">
    <table class="table table-striped"><thead><tr><th>ID</th><th>Asiento</th><th>Clase</th><th></th></tr></thead><tbody>
    <c:forEach var="d" items="${detalles}">
      <tr>
        <td>${d.IDDetalle}</td>
        <td>${d.asiento}</td>
        <td>${d.clase}</td>
        <td>
          <a class="btn btn-sm btn-secondary" href="servelet_detalle_reservacion?accion=mod&id=${d.IDDetalle}">Editar</a>
          <a class="btn btn-sm btn-danger" href="servelet_detalle_reservacion?accion=del&id=${d.IDDetalle}">Eliminar</a>
        </td>
      </tr>
    </c:forEach>
    </tbody></table>
  </c:if>
  <a class="btn btn-link" href="index.jsp">Volver</a>
</div>
<jsp:include page="footer.jsp"/>
