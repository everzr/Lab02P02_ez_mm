/*
 * Servlet de gestión de Pasajeros (adaptado del repo de referencia)
 */
package servlets_sis;

import Entity.ControllerPasajeros;
import Entity.Pasajeros;
import Controladores.ControladoraPersistencia;
import Entity.Reservaciones;
import java.io.IOException;
import java.text.Normalizer;
import java.util.List;
import java.util.stream.Collectors;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "servlet_pasajeros", urlPatterns = {"/servlet_pasajeros"})
public class servlet_pasajeros extends HttpServlet {

    ControllerPasajeros cpasajeros = new ControllerPasajeros();
    ControladoraPersistencia cp = new ControladoraPersistencia();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Ensure UTF-8 for responses and attempt to handle GET params with accents (ñ, á, é, ...)
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        String accion = request.getParameter("accion");
        int id = 0;
        if (request.getParameter("id") != null) {
            try { id = Integer.parseInt(request.getParameter("id")); } catch (NumberFormatException ignored) {}
        }

        // Debug: log de la acción
        System.out.println("DEBUG: Acción recibida: " + accion);
        
        List<Pasajeros> consultaGeneral = this.cpasajeros.traerListaPasajeros();
        if (consultaGeneral == null) {
            consultaGeneral = new java.util.ArrayList<>();
        }
        System.out.println("DEBUG: Número de pasajeros encontrados: " + (consultaGeneral != null ? consultaGeneral.size() : "null"));
        
        if (accion == null) accion = "con";
        
        // Parámetros de búsqueda
    String searchNombre = ensureUtf8Param(request.getParameter("nombre"));
    String searchNacionalidad = ensureUtf8Param(request.getParameter("nacionalidad"));
    String searchPasaporte = ensureUtf8Param(request.getParameter("pasaporte"));
    String searchTerm = ensureUtf8Param(request.getParameter("search"));

    // Expose normalized values for the JSP to preserve filters (works even if param was mojibake)
        if (searchNombre != null) request.setAttribute("nombre", searchNombre);
        if (searchNacionalidad != null) {
            request.setAttribute("nacionalidad", normalizeForSearch(searchNacionalidad)); // normalized for server-side use if needed
            request.setAttribute("nacionalidadRaw", searchNacionalidad); // original value for UI (with accents)
        }
        if (searchPasaporte != null) request.setAttribute("pasaporte", searchPasaporte);
        if (searchTerm != null) request.setAttribute("search", searchTerm);
        
        // Filtrar resultados si hay parámetros de búsqueda
        if (searchNombre != null || searchNacionalidad != null || searchPasaporte != null || 
            searchTerm != null) {
            consultaGeneral = filtrarPasajeros(consultaGeneral, searchNombre, searchNacionalidad, 
                                             searchPasaporte, searchTerm);
            System.out.println("DEBUG: Después del filtrado: " + (consultaGeneral != null ? consultaGeneral.size() : "null"));
        }

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
                if (hasReservationsForPassenger(id)) {
                    request.setAttribute("error", "No se puede eliminar el pasajero porque tiene reservaciones asociadas.");
                    List<Pasajeros> refreshed = this.cpasajeros.traerListaPasajeros();
                    request.setAttribute("pasajeros", refreshed);
                    request.getRequestDispatcher("Vistas/view_pasajeros.jsp").forward(request, response);
                } else {
                    this.cpasajeros.eliminarPasajero(id);
                    List<Pasajeros> refreshed = this.cpasajeros.traerListaPasajeros();
                    request.setAttribute("pasajeros", refreshed);
                    request.getRequestDispatcher("Vistas/view_pasajeros.jsp").forward(request, response);
                }
                return;
            case "add":
                List<Pasajeros> consultaUltimos = this.cpasajeros.consultaUltimosPasajeros(5, 0);
                System.out.println("DEBUG: Pasajeros recientes obtenidos: " + 
                                  (consultaUltimos != null ? consultaUltimos.size() : "null"));
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
            response.sendRedirect("servlet_pasajeros?accion=con");
            return;
        } else if (btnUpdate != null && !btnUpdate.isEmpty()) {
            int id = 0;
            try { id = Integer.parseInt(request.getParameter("txtid")); } catch (NumberFormatException ignored) {}
            if (id > 0) pasajero.setIDPasajero(id);
            this.cpasajeros.editarPasajero(pasajero);
            response.sendRedirect("servlet_pasajeros?accion=con");
            return;
        }

        List<Pasajeros> consultaUltimos = this.cpasajeros.consultaUltimosPasajeros(5, 0);
        request.setAttribute("pasajeros", consultaUltimos);
        request.getRequestDispatcher("Vistas/add_pasajeros.jsp").forward(request, response);
    }

    @Override
    public String getServletInfo() { 
        return "Servlet de Pasajeros"; 
    }

    private static String nullIfEmpty(String v) { 
        return (v == null || v.trim().isEmpty()) ? null : v.trim(); 
    }
    
    // Best-effort fix for incorrectly decoded GET params (common with ñ/á/é when server isn't set to UTF-8)
    private static String ensureUtf8Param(String s) {
        if (s == null) return null;
        // Detect typical mojibake markers like 'Ã', 'Â'
        if (s.indexOf('Ã') >= 0 || s.indexOf('Â') >= 0) {
            try {
                byte[] bytes = s.getBytes("ISO-8859-1");
                return new String(bytes, java.nio.charset.StandardCharsets.UTF_8);
            } catch (Exception ignored) { /* fallthrough */ }
        }
        return s;
    }
    
    /**
     * Método para filtrar pasajeros según los criterios de búsqueda
     */
    private List<Pasajeros> filtrarPasajeros(List<Pasajeros> pasajeros, String nombre, String nacionalidad, 
                                           String pasaporte, String searchTerm) {
        if (pasajeros == null) return pasajeros;
        // Normalize search inputs to be case- and accent-insensitive
        final String nNombre = normalizeForSearch(nombre);
        final String nNacionalidad = normalizeForSearch(nacionalidad);
        final String nPasaporte = normalizeForSearch(pasaporte);
        final String nTerm = normalizeForSearch(searchTerm);

        return pasajeros.stream()
            .filter(p -> {
                final String pNombre = normalizeForSearch(p.getNombrePasajero());
                final String pNacionalidad = normalizeForSearch(p.getNacionalidad());
                final String pPasaporte = normalizeForSearch(p.getPasaporte());
                final String pId = p.getIDPasajero() != null ? p.getIDPasajero().toString().toLowerCase() : null;
                // Filtro por nombre
                if (nNombre != null && !nNombre.isEmpty()) {
                    if (pNombre == null || !pNombre.contains(nNombre)) {
                        return false;
                    }
                }
                
                // Filtro por nacionalidad
                if (nNacionalidad != null && !nNacionalidad.isEmpty()) {
                    if (pNacionalidad == null || !pNacionalidad.contains(nNacionalidad)) {
                        return false;
                    }
                }
                
                // Filtro por pasaporte
                if (nPasaporte != null && !nPasaporte.isEmpty()) {
                    if (pPasaporte == null || !pPasaporte.contains(nPasaporte)) {
                        return false;
                    }
                }
                
                // Búsqueda general
                if (nTerm != null && !nTerm.isEmpty()) {
                    return (pNombre != null && pNombre.contains(nTerm)) ||
                           (pNacionalidad != null && pNacionalidad.contains(nTerm)) ||
                           (pPasaporte != null && pPasaporte.contains(nTerm)) ||
                           (pId != null && pId.contains(nTerm));
                }
                
                return true;
            })
            .collect(Collectors.toList());
    }

    private static String normalizeForSearch(String s) {
        if (s == null) return null;
        String trimmed = s.trim();
        if (trimmed.isEmpty()) return null;
        String lower = trimmed.toLowerCase();
        // Remove diacritics (á -> a, ñ -> n, etc.)
        String normalized = Normalizer.normalize(lower, Normalizer.Form.NFD).replaceAll("\\p{M}", "");
        return normalized;
    }

    private boolean hasReservationsForPassenger(int pasajeroId) {
        try {
            List<Reservaciones> rs = cp.traerListaReservaciones();
            if (rs == null) return false;
            for (Reservaciones r : rs) {
                if (r != null && r.getIDPasajero() != null && r.getIDPasajero().getIDPasajero() != null && r.getIDPasajero().getIDPasajero() == pasajeroId) {
                    return true;
                }
            }
            return false;
        } catch (Exception e) { return false; }
    }
}
