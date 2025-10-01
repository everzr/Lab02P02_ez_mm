/*
 * Servlet de gestión de Detalle Reservacion (adaptado del repo de referencia)
 */
package servlets_sis;

import Entity.ControllerDetalleReservacion;
import Entity.DetalleReservacion;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "servelet_detalle_reservacion", urlPatterns = {"/servelet_detalle_reservacion"})
public class servelet_detalle_reservacion extends HttpServlet {

    ControllerDetalleReservacion cdetalle_reservaciones = new ControllerDetalleReservacion();
    DetalleReservacion detallereservacion = new DetalleReservacion();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String accion = request.getParameter("accion");
        int id = 0;
        if (request.getParameter("id") != null) {
            try { id = Integer.parseInt(request.getParameter("id")); } catch (NumberFormatException ignored) {}
        }

        List<DetalleReservacion> consultaGeneral = this.cdetalle_reservaciones.traerListaDetalleReservaciones();
        if (accion == null) accion = "con";

        switch (accion) {
            case "con":
                request.setAttribute("detalles", consultaGeneral);
                request.getRequestDispatcher("Vistas/view_detalle_reservacion.jsp").forward(request, response);
                break;
            case "mod":
                DetalleReservacion d = this.cdetalle_reservaciones.traerDetalleReservacion(id);
                request.setAttribute("detalle", d);
                request.getRequestDispatcher("Vistas/upd_detalle_reservacion.jsp").forward(request, response);
                break;
            case "del":
                this.cdetalle_reservaciones.eliminarDetalleReservacion(id);
                consultaGeneral = this.cdetalle_reservaciones.traerListaDetalleReservaciones();
                request.setAttribute("detalles", consultaGeneral);
                request.getRequestDispatcher("Vistas/view_detalle_reservacion.jsp").forward(request, response);
                break;
            case "add":
                List<DetalleReservacion> consultaUltimos = this.cdetalle_reservaciones.consultaUltimosDetalleReservacion(5, 1);
                request.setAttribute("detalles", consultaUltimos);
                request.getRequestDispatcher("Vistas/add_detalle_reservacion.jsp").forward(request, response);
                break;
            default:
                request.setAttribute("detalles", consultaGeneral);
                request.getRequestDispatcher("Vistas/view_detalle_reservacion.jsp").forward(request, response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        String asiento = request.getParameter("txtAsiento");
        String clase = request.getParameter("txtClase");
        detallereservacion.setAsiento(asiento != null && !asiento.isEmpty() ? asiento : null);
        detallereservacion.setClase(clase != null && !clase.isEmpty() ? clase : null);

        String btnAgregar = request.getParameter("btnAgregar");
        String btnUpdate = request.getParameter("btnUpdate");

        if (btnAgregar != null && !btnAgregar.isEmpty()) {
            this.cdetalle_reservaciones.crearDetalleReservacion(detallereservacion);
        } else if (btnUpdate != null && !btnUpdate.isEmpty()) {
            int id = 0;
            try { id = Integer.parseInt(request.getParameter("txtid")); } catch (NumberFormatException ignored) {}
            if (id > 0) detallereservacion.setIDDetalle(id);
            this.cdetalle_reservaciones.editarDetalleReservacion(detallereservacion);
        }

        List<DetalleReservacion> consultaUltimos = this.cdetalle_reservaciones.consultaUltimosDetalleReservacion(5, 1);
        request.setAttribute("detalles", consultaUltimos);
        request.getRequestDispatcher("Vistas/add_detalle_reservacion.jsp").forward(request, response);
    }

    @Override
    public String getServletInfo() { return "Servlet de Detalle de Reservación"; }
}
