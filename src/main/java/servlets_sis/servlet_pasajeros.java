/*
 * Servlet de gestión de Pasajeros (adaptado del repo de referencia)
 */
package servlets_sis;

import Entity.ControllerPasajeros;
import Entity.Pasajeros;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "servlet_pasajeros", urlPatterns = {"/servlet_pasajeros"})
public class servlet_pasajeros extends HttpServlet {

    ControllerPasajeros cpasajeros = new ControllerPasajeros();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String accion = request.getParameter("accion");
        int id = 0;
        if (request.getParameter("id") != null) {
            try { id = Integer.parseInt(request.getParameter("id")); } catch (NumberFormatException ignored) {}
        }

        List<Pasajeros> consultaGeneral = this.cpasajeros.traerListaPasajeros();
        if (accion == null) accion = "con";

        switch (accion) {
            case "con":
                request.setAttribute("pasajeros", consultaGeneral);
                request.getRequestDispatcher("Vistas/view_pasajeros.jsp").forward(request, response);
                break;
            case "mod":
                Pasajeros p = this.cpasajeros.traerPasajero(id);
                request.setAttribute("pasajero", p);
                request.getRequestDispatcher("Vistas/upd_pasajeros.jsp").forward(request, response);
                break;
            case "del":
                this.cpasajeros.eliminarPasajero(id);
                consultaGeneral = this.cpasajeros.traerListaPasajeros();
                request.setAttribute("pasajeros", consultaGeneral);
                request.getRequestDispatcher("Vistas/view_pasajeros.jsp").forward(request, response);
                break;
            case "add":
                List<Pasajeros> consultaUltimos = this.cpasajeros.consultaUltimosPasajeros(5, 1);
                request.setAttribute("pasajeros", consultaUltimos);
                request.getRequestDispatcher("Vistas/add_pasajeros.jsp").forward(request, response);
                break;
            default:
                request.setAttribute("pasajeros", consultaGeneral);
                request.getRequestDispatcher("Vistas/view_pasajeros.jsp").forward(request, response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        String nombre = request.getParameter("txtNombrePasajero");
        String nacionalidad = request.getParameter("txtNacionalidad");
        String pasaporte = request.getParameter("txtPasaporte");

    // Poblar entidad por request
    Pasajeros pasajero = new Pasajeros();
    pasajero.setNombrePasajero(nullIfEmpty(nombre));
    pasajero.setNacionalidad(nullIfEmpty(nacionalidad));
    pasajero.setPasaporte(nullIfEmpty(pasaporte));

        String btnAgregar = request.getParameter("btnAgregar");
        String btnUpdate = request.getParameter("btnUpdate");

        if (btnAgregar != null && !btnAgregar.isEmpty()) {
            this.cpasajeros.crearPasajero(pasajero);
        } else if (btnUpdate != null && !btnUpdate.isEmpty()) {
            int id = 0;
            try { id = Integer.parseInt(request.getParameter("txtid")); } catch (NumberFormatException ignored) {}
            if (id > 0) pasajero.setIDPasajero(id);
            this.cpasajeros.editarPasajero(pasajero);
        }

        List<Pasajeros> consultaUltimos = this.cpasajeros.consultaUltimosPasajeros(5, 1);
        request.setAttribute("pasajeros", consultaUltimos);
        request.getRequestDispatcher("Vistas/add_pasajeros.jsp").forward(request, response);
    }

    @Override
    public String getServletInfo() { return "Servlet de Pasajeros"; }

    private static String nullIfEmpty(String v) { return (v == null || v.trim().isEmpty()) ? null : v.trim(); }
}
