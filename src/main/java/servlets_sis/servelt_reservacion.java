/*
 * Servlet de gestión de Reservaciones (adaptado del repo de referencia)
 */
package servlets_sis;

import Entity.ControllerReservaciones;
import Controladores.ControladoraPersistencia;
import Entity.DetalleReservacion;
import Entity.Pasajeros;
import Entity.ReservaVM;
import Entity.Reservaciones;
import Entity.Vuelos;
import java.io.IOException;
import java.sql.Date;
import java.time.ZoneId;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.List;
import java.util.Objects;
import java.util.stream.Collectors;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "servelt_reservacion", urlPatterns = {"/servelt_reservacion"})
public class servelt_reservacion extends HttpServlet {

    ControllerReservaciones creservaciones = new ControllerReservaciones();
    ControladoraPersistencia cp = new ControladoraPersistencia();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String accion = request.getParameter("accion");
        int id = 0;
        if (request.getParameter("id") != null) {
            try { id = Integer.parseInt(request.getParameter("id")); } catch (NumberFormatException ignored) {}
        }

    List<Reservaciones> consultaGeneral = this.creservaciones.traerListaReservaciones();
        // Build VMs: tomar 1er detalle y vuelo relacionado si existe
    List<DetalleReservacion> _detalles = cp.traerListaDetalleReservaciones();
    List<Pasajeros> _pasajeros = cp.traerListaPasajeros();
        List<Vuelos> _vuelosAll = cp.traerListaVuelos();
        final List<DetalleReservacion> detalles = (_detalles != null) ? _detalles : new java.util.ArrayList<DetalleReservacion>();
        final List<Pasajeros> pasajeros = (_pasajeros != null) ? _pasajeros : new java.util.ArrayList<Pasajeros>();
        // Para la vista de listado y filtros, usar TODOS los vuelos
        final List<Vuelos> vuelosAll = (_vuelosAll != null) ? _vuelosAll : new java.util.ArrayList<Vuelos>();
        System.out.println("DEBUG Reservas: pasajeros=" + pasajeros.size() + ", vuelosAll=" + vuelosAll.size() + ", detalles=" + detalles.size());
        List<ReservaVM> reservaVMs = consultaGeneral.stream().map(r -> {
            DetalleReservacion d = detalles.stream().filter(x -> x.getIDReservacion() != null && Objects.equals(x.getIDReservacion().getIDReservacion(), r.getIDReservacion())).findFirst().orElse(null);
            Vuelos v = null;
            if (d != null) {
                v = vuelosAll.stream().filter(x -> x.getIDVuelo() != null && d.getIDVuelo() != null && Objects.equals(x.getIDVuelo(), d.getIDVuelo().getIDVuelo())).findFirst().orElse(null);
            }
            Pasajeros p = r.getIDPasajero();
            return new ReservaVM(r, p, v, d);
        }).collect(Collectors.toList());

        // Search params
    String codigo = paramTrim(request, "codigo");
    String q = paramTrim(request, "q");
    String pasajeroId = paramTrim(request, "pasajeroId");
    String vueloId = paramTrim(request, "vueloId");
    String fechaDesde = paramTrim(request, "fechaDesde");
    String fechaHasta = paramTrim(request, "fechaHasta");

        // Filters
        if (q != null || codigo != null || pasajeroId != null || vueloId != null || fechaDesde != null || fechaHasta != null) {
            reservaVMs = reservaVMs.stream().filter(vm -> {
                if (q != null) {
                    String ql = q.toLowerCase();
                    String digits = q.replaceAll("\\D", "");
                    boolean byCode = vm.getCodigo() != null && vm.getCodigo().toString().contains(digits.isEmpty() ? q : digits);
                    String nombre = vm.getPasajero() != null && vm.getPasajero().getNombrePasajero() != null ? vm.getPasajero().getNombrePasajero().toLowerCase() : "";
                    String nvuelo = vm.getVuelo() != null && vm.getVuelo().getNumeroVuelo() != null ? vm.getVuelo().getNumeroVuelo().toLowerCase() : "";
                    if (!(byCode || nombre.contains(ql) || nvuelo.contains(ql))) return false;
                }
                if (codigo != null) {
                    String digits = codigo.replaceAll("\\D", "");
                    String needle = digits.isEmpty() ? codigo : digits; // soporta 'RSV123'
                    if (vm.getCodigo() == null || !vm.getCodigo().toString().contains(needle)) return false;
                }
                if (pasajeroId != null) {
                    Integer pid = vm.getReservacion() != null && vm.getReservacion().getIDPasajero() != null ? vm.getReservacion().getIDPasajero().getIDPasajero() : null;
                    if (pid == null || !pid.toString().equals(pasajeroId)) return false;
                }
                if (vueloId != null) {
                    Integer vid = vm.getVuelo() != null ? vm.getVuelo().getIDVuelo() : null;
                    if (vid == null || !vid.toString().equals(vueloId)) return false;
                }
                if (fechaDesde != null) {
                    java.sql.Date fd = java.sql.Date.valueOf(fechaDesde);
                    java.util.Date vf = vm.getReservacion() != null ? vm.getReservacion().getFechaReservacion() : null;
                    if (vf == null || vf.before(fd)) return false;
                }
                if (fechaHasta != null) {
                    java.sql.Date fh = java.sql.Date.valueOf(fechaHasta);
                    java.util.Date vf = vm.getReservacion() != null ? vm.getReservacion().getFechaReservacion() : null;
                    if (vf == null || vf.after(fh)) return false;
                }
                return true;
            }).collect(Collectors.toList());
        }
        if (accion == null) accion = "con";

        switch (accion) {
            case "con":
                request.setAttribute("reservaciones", consultaGeneral);
                request.setAttribute("reservaVMs", reservaVMs);
                request.setAttribute("pasajeros", pasajeros);
                request.setAttribute("vuelos", vuelosAll);
                request.getRequestDispatcher("Vistas/view_reservaciones.jsp").forward(request, response);
                break;
            case "view":
                final int vid = id;
                Reservaciones rv = this.creservaciones.traerReservacion(vid);
                List<DetalleReservacion> detsView = detalles.stream()
                    .filter(d -> d.getIDReservacion() != null && Objects.equals(d.getIDReservacion().getIDReservacion(), vid))
                    .collect(Collectors.toList());
                request.setAttribute("reservacion", rv);
                request.setAttribute("detalles", detsView);
                request.getRequestDispatcher("Vistas/view_reservacion.jsp").forward(request, response);
                break;
            case "mod":
                Reservaciones r = this.creservaciones.traerReservacion(id);
                // Buscar primer detalle asociado y vuelo
                final int fId = id;
                DetalleReservacion dsel = cp.traerListaDetalleReservaciones().stream()
                        .filter(d -> d.getIDReservacion() != null && d.getIDReservacion().getIDReservacion().equals(fId))
                        .findFirst().orElse(null);
                Vuelos vsel = dsel != null ? cp.traerVuelo(dsel.getIDVuelo() != null ? dsel.getIDVuelo().getIDVuelo() : 0) : null;
                request.setAttribute("reservacion", r);
                request.setAttribute("detalle", dsel);
                // Vuelos disponibles (>=3h) + incluir seleccionado si no cumple la regla
                List<Vuelos> todos = cp.traerListaVuelos();
                List<Vuelos> vs = new java.util.ArrayList<>();
                if (todos != null) {
                    for (Vuelos vx : todos) if (isFlightAvailable(vx)) vs.add(vx);
                    if (vsel != null && vsel.getIDVuelo() != null && vs.stream().noneMatch(x -> x.getIDVuelo().equals(vsel.getIDVuelo()))) {
                        vs.add(vsel);
                    }
                }
                request.setAttribute("vuelos", vs);
                request.setAttribute("pasajeros", cp.traerListaPasajeros());
                request.setAttribute("vueloSeleccionado", vsel);
                request.getRequestDispatcher("Vistas/upd_reservaciones.jsp").forward(request, response);
                break;
            case "del":
                // Prohibido eliminar por integridad referencial: redirigir a vista
                response.sendRedirect("servelt_reservacion?accion=con");
                return;
            case "add":
                List<Reservaciones> consultaUltimos = this.creservaciones.consultaUltimasReservaciones(5, 1);
                request.setAttribute(
                    "reservaciones", consultaUltimos
                );
                request.setAttribute("pasajeros", pasajeros);
                request.setAttribute("vuelos", vuelosAll);
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

        // Fecha controlada por el servidor (hoy), no editable por el usuario
        Date fechaReservacion = new Date(System.currentTimeMillis());
        Reservaciones reservacion = new Reservaciones();
        reservacion.setFechaReservacion(fechaReservacion);

        // Datos de pasajero y vuelo para crear/editar detalle
    String pasajeroIdStr = paramTrim(request, "txtPasajeroId");
    String vueloIdStr = paramTrim(request, "txtVueloId");
    String[] clases = request.getParameterValues("txtClase");
    String[] asientos = request.getParameterValues("txtAsiento");
        Pasajeros pasajero = null;
        Vuelos vuelo = null;
        if (pasajeroIdStr != null && !pasajeroIdStr.isEmpty()) {
            try { pasajero = cp.traerPasajero(Integer.parseInt(pasajeroIdStr)); } catch (NumberFormatException ignored) {}
        }
        if (vueloIdStr != null && !vueloIdStr.isEmpty()) {
            try { vuelo = cp.traerVuelo(Integer.parseInt(vueloIdStr)); } catch (NumberFormatException ignored) {}
        }
        if (pasajero != null) reservacion.setIDPasajero(pasajero);

        String btnAgregar = request.getParameter("btnAgregar");
        String btnUpdate = request.getParameter("btnUpdate");
    if (btnAgregar != null && !btnAgregar.isEmpty()) {
            // Validación básica
            if (pasajero == null) {
                setFormErrorAndForward(request, response, "Debes seleccionar un pasajero.", reservacion);
                return;
            }
            if (vuelo == null) {
                setFormErrorAndForward(request, response, "Debes seleccionar un vuelo.", reservacion);
                return;
            }
            // Validar disponibilidad del vuelo (>= 3 horas desde ahora)
            if (!isFlightAvailable(vuelo)) {
                setFormErrorAndForward(request, response, "No puedes reservar un vuelo que sale en menos de 3 horas.", reservacion);
                return;
            }
            // Validar y crear múltiples detalles
            java.util.List<String> pendientes = collectNonEmpty(asientos);
            if (pendientes.isEmpty()) {
                setFormErrorAndForward(request, response, "Agrega al menos un asiento para la reservación.", reservacion);
                return;
            }
            // Comprobar duplicados locales
            java.util.Set<String> local = new java.util.HashSet<>();
            for (String a : pendientes) {
                String key = vuelo.getIDVuelo() + "|" + a.trim().toUpperCase();
                if (!local.add(key)) {
                    setFormErrorAndForward(request, response, "Hay asientos repetidos en el formulario (" + a + ").", reservacion);
                    return;
                }
            }
            // Comprobar ocupación en BD
            for (String a : pendientes) {
                if (isSeatTaken(vuelo.getIDVuelo(), a, null)) {
                    setFormErrorAndForward(request, response, "Asiento ocupado: " + a + ".", reservacion);
                    return;
                }
            }
            // Crear reservación primero
            this.creservaciones.crearReservacion(reservacion);
            if (reservacion.getIDReservacion() == null) {
                setFormErrorAndForward(request, response, "No se pudo guardar la reservación. Inténtalo nuevamente.", reservacion);
                return;
            }
            // Crear detalles
            for (int i = 0; i < pendientes.size(); i++) {
                String a = pendientes.get(i);
                String c = (clases != null && i < clases.length) ? clases[i] : null;
                DetalleReservacion d = new DetalleReservacion();
                d.setIDReservacion(reservacion);
                d.setIDVuelo(vuelo);
                if (c != null) d.setClase(c);
                d.setAsiento(a != null ? a.trim().toUpperCase() : null);
                cp.crearDetalleReservacion(d);
            }
            response.sendRedirect("servelt_reservacion?accion=con");
            return;
        } else if (btnUpdate != null && !btnUpdate.isEmpty()) {
        int idUpdate = 0;
        try { idUpdate = Integer.parseInt(request.getParameter("txtid")); } catch (NumberFormatException ignored) {}
        if (idUpdate > 0) reservacion.setIDReservacion(idUpdate);
            // Conservar la fecha original de la reservación
            Reservaciones existenteRes = (idUpdate > 0) ? this.creservaciones.traerReservacion(idUpdate) : null;
            if (existenteRes != null && existenteRes.getFechaReservacion() != null) {
                reservacion.setFechaReservacion(new Date(existenteRes.getFechaReservacion().getTime()));
            }
            final int fIdUpdate = idUpdate;
            if (pasajero == null) {
                setFormErrorAndForwardUpdate(request, response, "Debes seleccionar un pasajero.", reservacion);
                return;
            }
            if (vuelo == null) {
                setFormErrorAndForwardUpdate(request, response, "Debes seleccionar un vuelo.", reservacion);
                return;
            }
            if (!isFlightAvailable(vuelo)) {
                setFormErrorAndForwardUpdate(request, response, "No puedes reservar un vuelo que sale en menos de 3 horas.", reservacion);
                return;
            }
            // Validar primero sin tocar la BD
            java.util.List<String> pendientesUp = collectNonEmpty(asientos);
            if (pendientesUp.isEmpty()) {
                setFormErrorAndForwardUpdate(request, response, "Agrega al menos un asiento para la reservación.", reservacion);
                return;
            }
            java.util.Set<String> local = new java.util.HashSet<>();
            for (String a : pendientesUp) {
                String key = vuelo.getIDVuelo() + "|" + a.trim().toUpperCase();
                if (!local.add(key)) {
                    setFormErrorAndForwardUpdate(request, response, "Hay asientos repetidos en el formulario (" + a + ").", reservacion);
                    return;
                }
            }
            for (String a : pendientesUp) {
                if (isSeatTaken(vuelo.getIDVuelo(), a, fIdUpdate)) {
                    setFormErrorAndForwardUpdate(request, response, "Asiento ocupado: " + a + ".", reservacion);
                    return;
                }
            }
            // Si todo OK: persistir cambios. Primero actualizar reservación (conservando fecha original)
            this.creservaciones.editarReservacion(reservacion);
            // Limpiar detalles actuales y crear nuevos
            cp.traerListaDetalleReservaciones().stream()
                .filter(d -> d.getIDReservacion() != null && d.getIDReservacion().getIDReservacion().equals(fIdUpdate))
                .forEach(d -> cp.eliminarDetalleReservacion(d.getIDDetalle()));
            for (int i = 0; i < pendientesUp.size(); i++) {
                String a = pendientesUp.get(i);
                String c = (clases != null && i < clases.length) ? clases[i] : null;
                DetalleReservacion d = new DetalleReservacion();
                d.setIDReservacion(reservacion);
                d.setIDVuelo(vuelo);
                if (c != null) d.setClase(c);
                d.setAsiento(a != null ? a.trim().toUpperCase() : null);
                cp.crearDetalleReservacion(d);
            }
            response.sendRedirect("servelt_reservacion?accion=con");
            return;
        }

        List<Reservaciones> consultaUltimos = this.creservaciones.consultaUltimasReservaciones(5, 1);
        request.setAttribute("reservaciones", consultaUltimos);
        request.setAttribute("pasajeros", cp.traerListaPasajeros());
        // aplicar filtro de vuelos futuros también en edición
        List<Vuelos> vuelosFuturos = new java.util.ArrayList<Vuelos>();
        List<Vuelos> allV = cp.traerListaVuelos();
        if (allV != null) {
            for (Vuelos vx : allV) if (isFlightAvailable(vx)) vuelosFuturos.add(vx);
        }
        request.setAttribute("vuelos", vuelosFuturos);
        request.getRequestDispatcher("Vistas/add_reservaciones.jsp").forward(request, response);
    }

    @Override
    public String getServletInfo() { return "Servlet de Reservaciones"; }

    private static String paramTrim(HttpServletRequest req, String name) {
        String v = req.getParameter(name);
        if (v == null) return null;
        String t = v.trim();
        return t.isEmpty() ? null : t;
    }

    private boolean isSeatTaken(Integer vueloId, String asiento, Integer excludeReservacionId) {
        try {
            Controladores.DetalleReservacionJpaController dj = new Controladores.DetalleReservacionJpaController();
            return dj.existsByVueloAndAsiento(vueloId, asiento, excludeReservacionId);
        } catch (Exception e) {
            // Fallback seguro
            List<DetalleReservacion> all = cp.traerListaDetalleReservaciones();
            if (all == null) return false;
            final String seat = asiento != null ? asiento.trim().toUpperCase() : null;
            return all.stream().anyMatch(d -> {
                Integer vid = (d.getIDVuelo() != null ? d.getIDVuelo().getIDVuelo() : null);
                Integer rid = (d.getIDReservacion() != null ? d.getIDReservacion().getIDReservacion() : null);
                String as = d.getAsiento() != null ? d.getAsiento().trim().toUpperCase() : null;
                if (vid == null || as == null || seat == null) return false;
                if (!vid.equals(vueloId)) return false;
                if (excludeReservacionId != null && excludeReservacionId.equals(rid)) return false;
                return seat.equals(as);
            });
        }
    }

    private static java.util.List<String> collectNonEmpty(String[] arr) {
        java.util.List<String> list = new java.util.ArrayList<>();
        if (arr != null) {
            for (String s : arr) if (s != null && !s.trim().isEmpty()) list.add(normalizeSeat(s));
        }
        return list;
    }

    private static String normalizeSeat(String s) {
        return s == null ? null : s.trim().toUpperCase();
    }

    private void setFormErrorAndForward(HttpServletRequest request, HttpServletResponse response, String msg, Reservaciones reservacion) throws ServletException, IOException {
        request.setAttribute("error", msg);
        request.setAttribute("reservaciones", this.creservaciones.consultaUltimasReservaciones(5, 1));
        request.setAttribute("pasajeros", cp.traerListaPasajeros());
        // filtrar vuelos disponibles (>= 3 horas)
        List<Vuelos> vuelos = cp.traerListaVuelos();
        List<Vuelos> disponibles = new java.util.ArrayList<>();
        if (vuelos != null) for (Vuelos vx : vuelos) if (isFlightAvailable(vx)) disponibles.add(vx);
        request.setAttribute("vuelos", disponibles);
        request.getRequestDispatcher("Vistas/add_reservaciones.jsp").forward(request, response);
    }

    private void setFormErrorAndForwardUpdate(HttpServletRequest request, HttpServletResponse response, String msg, Reservaciones reservacion) throws ServletException, IOException {
        request.setAttribute("error", msg);
        // Recargar desde BD el estado actual para no perder info en la vista
        int id = 0; try { id = Integer.parseInt(paramTrim(request, "txtid")); } catch (Exception ignored) {}
        Reservaciones actual = id > 0 ? this.creservaciones.traerReservacion(id) : reservacion;
        request.setAttribute("reservacion", actual);
        // Cargar detalles actuales y vuelo seleccionado (si cualquier detalle trae vuelo)
        java.util.List<DetalleReservacion> dets = cp.traerListaDetalleReservaciones();
        java.util.List<DetalleReservacion> detsRes = new java.util.ArrayList<>();
        if (dets != null && actual != null && actual.getIDReservacion() != null) {
            for (DetalleReservacion d : dets) {
                if (d.getIDReservacion() != null && actual.getIDReservacion().equals(d.getIDReservacion().getIDReservacion())) detsRes.add(d);
            }
        }
        request.setAttribute("detalles", detsRes);
        Vuelos vsel = (detsRes.isEmpty() ? null : detsRes.get(0).getIDVuelo());
        request.setAttribute("vueloSeleccionado", vsel);
        request.setAttribute("pasajeros", cp.traerListaPasajeros());
        request.setAttribute("vuelos", cp.traerListaVuelos());
        request.getRequestDispatcher("Vistas/upd_reservaciones.jsp").forward(request, response);
    }

    private boolean isFlightAvailable(Vuelos v) {
        try {
            if (v == null) return false;
            java.util.Date f = v.getFechaSalida();
            java.util.Date h = v.getHoraSalida();
            if (f == null || h == null) return false;
            ZoneId zone = ZoneId.systemDefault();
            LocalDate ld = f.toInstant().atZone(zone).toLocalDate();
            LocalTime lt = h.toInstant().atZone(zone).toLocalTime();
            LocalDateTime dep = LocalDateTime.of(ld, lt);
            LocalDateTime min = LocalDateTime.now().plusHours(3);
            return !dep.isBefore(min);
        } catch (Exception e) { return false; }
    }
}
