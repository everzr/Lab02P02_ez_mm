/*
 * Servlet de gestión de Reservaciones (adaptado del repo de referencia)
 */
package servlets_sis;

import Entity.ControllerReservaciones;
import Entity.Reservaciones;
import java.io.IOException;
import java.sql.Date;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "servelt_reservacion", urlPatterns = {"/servelt_reservacion"})
public class servelt_reservacion extends HttpServlet {

    ControllerReservaciones creservaciones = new ControllerReservaciones();
    Reservaciones reservacion = new Reservaciones();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String accion = request.getParameter("accion");
        int id = 0;
        if (request.getParameter("id") != null) {
            try { id = Integer.parseInt(request.getParameter("id")); } catch (NumberFormatException ignored) {}
        }

        List<Reservaciones> consultaGeneral = this.creservaciones.traerListaReservaciones();
        if (accion == null) accion = "con";

        switch (accion) {
            case "con":
                request.setAttribute("reservaciones", consultaGeneral);
                request.getRequestDispatcher("Vistas/view_reservaciones.jsp").forward(request, response);
                break;
            case "mod":
                Reservaciones r = this.creservaciones.traerReservacion(id);
                request.setAttribute("reservacion", r);
                request.getRequestDispatcher("Vistas/upd_reservaciones.jsp").forward(request, response);
                break;
            case "del":
                this.creservaciones.eliminarReservacion(id);
                consultaGeneral = this.creservaciones.traerListaReservaciones();
                request.setAttribute("reservaciones", consultaGeneral);
                request.getRequestDispatcher("Vistas/view_reservaciones.jsp").forward(request, response);
                break;
            case "add":
                List<Reservaciones> consultaUltimos = this.creservaciones.consultaUltimasReservaciones(5, 1);
                request.setAttribute("reservaciones", consultaUltimos);
                request.getRequestDispatcher("Vistas/add_reservaciones.jsp").forward(request, response);
                break;
            default:
                request.setAttribute("reservaciones", consultaGeneral);
                request.getRequestDispatcher("Vistas/view_reservaciones.jsp").forward(request, response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        String fechaReservacionStr = paramTrim(request, "txtFechaReservacion");
        DateTimeFormatter fFecha = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        Date fechaReservacion = null;
        if (fechaReservacionStr != null && !fechaReservacionStr.isEmpty()) {
            LocalDate ld = LocalDate.parse(fechaReservacionStr, fFecha);
            fechaReservacion = Date.valueOf(ld);
        }
        if (fechaReservacion != null) reservacion.setFechaReservacion(fechaReservacion);

        String btnAgregar = request.getParameter("btnAgregar");
        String btnUpdate = request.getParameter("btnUpdate");
        if (btnAgregar != null && !btnAgregar.isEmpty()) {
            this.creservaciones.crearReservacion(reservacion);
        } else if (btnUpdate != null && !btnUpdate.isEmpty()) {
            int id = 0;
            try { id = Integer.parseInt(request.getParameter("txtid")); } catch (NumberFormatException ignored) {}
            if (id > 0) reservacion.setIDReservacion(id);
            this.creservaciones.editarReservacion(reservacion);
        }

        List<Reservaciones> consultaUltimos = this.creservaciones.consultaUltimasReservaciones(5, 1);
        request.setAttribute("reservaciones", consultaUltimos);
        request.getRequestDispatcher("Vistas/add_reservaciones.jsp").forward(request, response);
    }

    @Override
    public String getServletInfo() { return "Servlet de Reservaciones"; }

    private static String paramTrim(HttpServletRequest req, String name) {
        String v = req.getParameter(name);
        return v == null ? null : v.trim();
    }
}
