package Entity;

import Controladores.ControladoraPersistencia;
import java.util.List;

public class ControllerDetalleReservacion {
    private final ControladoraPersistencia cont_persis;
    public ControllerDetalleReservacion() { this.cont_persis = new ControladoraPersistencia(); }
    public void crearDetalleReservacion(DetalleReservacion detalleReservacion) { this.cont_persis.crearDetalleReservacion(detalleReservacion); }
    public List<DetalleReservacion> traerListaDetalleReservaciones() { return this.cont_persis.traerListaDetalleReservaciones(); }
    public DetalleReservacion traerDetalleReservacion(int id) { return this.cont_persis.traerDetalleReservacion(id); }
    public List<DetalleReservacion> consultaUltimosDetalleReservacion(int maxResults, int firstResult) { return this.cont_persis.consultaUltimosDetalleReservacion(maxResults); }
    public void editarDetalleReservacion(DetalleReservacion detalleReservacion) { this.cont_persis.editarDetalleReservacion(detalleReservacion); }
    public void eliminarDetalleReservacion(int id) { this.cont_persis.eliminarDetalleReservacion(id); }
}
