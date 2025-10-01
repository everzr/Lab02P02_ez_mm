package Entity;

import Controladores.ControladoraPersistencia;
import java.util.List;

public class ControllerReservaciones {
    private final ControladoraPersistencia cont_persis;
    public ControllerReservaciones() { this.cont_persis = new ControladoraPersistencia(); }
    public void crearReservacion(Reservaciones reservacion) { this.cont_persis.crearReservacion(reservacion); }
    public List<Reservaciones> traerListaReservaciones() { return this.cont_persis.traerListaReservaciones(); }
    public Reservaciones traerReservacion(int id) { return this.cont_persis.traerReservacion(id); }
    public List<Reservaciones> consultaUltimasReservaciones(int maxResults, int firstResult) { return this.cont_persis.consultaUltimasReservaciones(maxResults); }
    public void editarReservacion(Reservaciones reservacion) { this.cont_persis.editarReservacion(reservacion); }
    public void eliminarReservacion(int id) { this.cont_persis.eliminarReservacion(id); }
}
