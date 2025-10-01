/*
 * Servlet de gestión de Vuelos (adaptado del repo de referencia)
 */
package servlets_sis;

import Entity.ControllerVuelos;
import Entity.Vuelos;
import java.io.IOException;
import java.sql.Date;
import java.sql.Time;
import java.time.LocalDate;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "servlet_vuelos", urlPatterns = {"/servlet_vuelos"})
public class servlet_vuelos extends HttpServlet {

    ControllerVuelos cvuelos = new ControllerVuelos();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String accion = request.getParameter("accion");
        int id = 0;
        if (request.getParameter("id") != null) {
            try { id = Integer.parseInt(request.getParameter("id")); } catch (NumberFormatException ignored) {}
        }

        List<Vuelos> consultaGeneral = this.cvuelos.traerListaVuelos();
        if (accion == null) accion = "con"; // por defecto mostrar consulta
        
        // Parámetros de búsqueda
        String searchOrigen = request.getParameter("origen");
        String searchDestino = request.getParameter("destino");
        String searchFecha = request.getParameter("fecha");
        String searchTerm = request.getParameter("search");
        
        // Filtrar resultados si hay parámetros de búsqueda
        if (searchOrigen != null || searchDestino != null || searchFecha != null || 
            searchTerm != null) {
            consultaGeneral = filtrarVuelos(consultaGeneral, searchOrigen, searchDestino, 
                                          searchFecha, searchTerm);
        }

        switch (accion) {
            case "con":
                request.setAttribute("vuelos", consultaGeneral);
                request.getRequestDispatcher("Vistas/view_vuelos_simple.jsp").forward(request, response);
                break;
            case "mod":
                Vuelos v = this.cvuelos.traerVuelo(id);
                request.setAttribute("vuelo", v);
                request.getRequestDispatcher("Vistas/upd_vuelos.jsp").forward(request, response);
                break;
            case "del":
                this.cvuelos.eliminarVuelo(id);
                consultaGeneral = this.cvuelos.traerListaVuelos();
                request.setAttribute("vuelos", consultaGeneral);
                request.getRequestDispatcher("Vistas/view_vuelos_simple.jsp").forward(request, response);
                break;
            case "add":
                List<Vuelos> consultaUltimos = this.cvuelos.consultaUltimosVuelos(5, 1);
                request.setAttribute("vuelos", consultaUltimos);
                request.getRequestDispatcher("Vistas/add_vuelos.jsp").forward(request, response);
                break;
            default:
                request.setAttribute("vuelos", consultaGeneral);
                request.getRequestDispatcher("Vistas/view_vuelos_simple.jsp").forward(request, response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        String numeroVuelo = request.getParameter("txtNumeroVuelo");
        String aerolinea = request.getParameter("txtAerolinea");
        String origen = request.getParameter("txtOrigen");
        String destino = request.getParameter("txtDestino");
        String fechaSalidaStr = paramTrim(request, "txtFechaSalida");    // yyyy-MM-dd
        String horaSalidaStr = paramTrim(request, "txtHoraSalida");      // HH:mm or HH:mm:ss
        String fechaLlegadaStr = paramTrim(request, "txtFechaLlegada");  // yyyy-MM-dd
        String horaLlegadaStr = paramTrim(request, "txtHoraLlegada");    // HH:mm or HH:mm:ss
        String avion = request.getParameter("txtAvion");

        // Formatos
        DateTimeFormatter fFecha = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        DateTimeFormatter fHora = DateTimeFormatter.ofPattern(horaSalidaStr != null && horaSalidaStr.length() == 8 ? "HH:mm:ss" : "HH:mm");

        // Parseo fechas/horas (utilizando java.sql.* que extiende java.util.Date)
        Date fechaSalida = null;
        Date fechaLlegada = null;
        Time horaSalida = null;
        Time horaLlegada = null;
        if (fechaSalidaStr != null && !fechaSalidaStr.isEmpty()) {
            LocalDate ld = LocalDate.parse(fechaSalidaStr, fFecha);
            fechaSalida = Date.valueOf(ld);
        }
        if (fechaLlegadaStr != null && !fechaLlegadaStr.isEmpty()) {
            LocalDate ld = LocalDate.parse(fechaLlegadaStr, fFecha);
            fechaLlegada = Date.valueOf(ld);
        }
        if (horaSalidaStr != null && !horaSalidaStr.isEmpty()) {
            LocalTime lt = LocalTime.parse(horaSalidaStr, fHora);
            horaSalida = Time.valueOf(lt);
        }
        if (horaLlegadaStr != null && !horaLlegadaStr.isEmpty()) {
            LocalTime lt = LocalTime.parse(horaLlegadaStr, fHora);
            horaLlegada = Time.valueOf(lt);
        }

    // Poblar entidad (por request)
    Vuelos vuelo = new Vuelos();
    vuelo.setNumeroVuelo(nullIfEmpty(numeroVuelo));
    vuelo.setAerolinea(nullIfEmpty(aerolinea));
    vuelo.setOrigen(nullIfEmpty(origen));
    vuelo.setDestino(nullIfEmpty(destino));
    if (fechaSalida != null) vuelo.setFechaSalida(fechaSalida);
    if (horaSalida != null) vuelo.setHoraSalida(horaSalida);
    if (fechaLlegada != null) vuelo.setFechaLlegada(fechaLlegada);
    if (horaLlegada != null) vuelo.setHoraLlegada(horaLlegada);
    vuelo.setAvion(nullIfEmpty(avion));

        String btnAgregar = request.getParameter("btnAgregar");
        String btnUpdate = request.getParameter("btnUpdate");

        if (btnAgregar != null && !btnAgregar.isEmpty()) {
            this.cvuelos.crearVuelo(vuelo);
            // Redirect to the simple view after successful creation
            response.sendRedirect("servlet_vuelos?accion=con");
            return;
        } else if (btnUpdate != null && !btnUpdate.isEmpty()) {
            int id = 0;
            try { id = Integer.parseInt(request.getParameter("txtid")); } catch (NumberFormatException ignored) {}
            if (id > 0) vuelo.setIDVuelo(id);
            this.cvuelos.editarVuelo(vuelo);
            // Redirect to the simple view after successful update
            response.sendRedirect("servlet_vuelos?accion=con");
            return;
        }

        List<Vuelos> consultaUltimos = this.cvuelos.consultaUltimosVuelos(5, 1);
        request.setAttribute("vuelos", consultaUltimos);
        request.getRequestDispatcher("Vistas/add_vuelos.jsp").forward(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Servlet de Vuelos";
    }

    private static String paramTrim(HttpServletRequest req, String name) {
        String v = req.getParameter(name);
        return v == null ? null : v.trim();
    }

    private static String nullIfEmpty(String v) {
        return (v == null || v.trim().isEmpty()) ? null : v.trim();
    }
    
    /**
     * Método auxiliar para comparar fechas sin considerar la hora
     */
    private boolean compararFechas(java.util.Date fechaVuelo, String fechaBusqueda) {
        if (fechaVuelo == null || fechaBusqueda == null || fechaBusqueda.trim().isEmpty()) {
            return false;
        }
        
        try {
            // Convertir la fecha de búsqueda de String (yyyy-MM-dd) a LocalDate
            LocalDate fechaBusquedaLocal = LocalDate.parse(fechaBusqueda.trim());
            
            // Convertir la fecha del vuelo a LocalDate para comparar solo la fecha (sin hora)
            LocalDate fechaVueloLocal = fechaVuelo.toInstant()
                .atZone(java.time.ZoneId.systemDefault())
                .toLocalDate();
            
            return fechaBusquedaLocal.equals(fechaVueloLocal);
        } catch (Exception e) {
            System.err.println("Error comparando fechas: " + fechaBusqueda + " - " + e.getMessage());
            return false;
        }
    }
    
    private List<Vuelos> filtrarVuelos(List<Vuelos> vuelos, String origen, String destino, 
                                      String fecha, String searchTerm) {
        if (vuelos == null) return vuelos;
        
        return vuelos.stream()
            .filter(v -> {
                // Filtro por origen
                if (origen != null && !origen.trim().isEmpty()) {
                    if (v.getOrigen() == null || 
                        !v.getOrigen().toLowerCase().contains(origen.toLowerCase())) {
                        return false;
                    }
                }
                
                // Filtro por destino
                if (destino != null && !destino.trim().isEmpty()) {
                    if (v.getDestino() == null || 
                        !v.getDestino().toLowerCase().contains(destino.toLowerCase())) {
                        return false;
                    }
                }
                
                // Filtro por fecha
                if (fecha != null && !fecha.trim().isEmpty()) {
                    if (!compararFechas(v.getFechaSalida(), fecha)) {
                        return false;
                    }
                }
                
                // Búsqueda general
                if (searchTerm != null && !searchTerm.trim().isEmpty()) {
                    String term = searchTerm.toLowerCase();
                    return (v.getNumeroVuelo() != null && v.getNumeroVuelo().toLowerCase().contains(term)) ||
                           (v.getAerolinea() != null && v.getAerolinea().toLowerCase().contains(term)) ||
                           (v.getOrigen() != null && v.getOrigen().toLowerCase().contains(term)) ||
                           (v.getDestino() != null && v.getDestino().toLowerCase().contains(term)) ||
                           (v.getAvion() != null && v.getAvion().toLowerCase().contains(term));
                }
                
                return true;
            })
            .collect(java.util.stream.Collectors.toList());
    }
}
