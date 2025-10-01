package Entity;

import Controladores.ControladoraPersistencia;
import java.util.List;

public class ControllerPasajeros {
    private final ControladoraPersistencia cont_persis;
    public ControllerPasajeros() { this.cont_persis = new ControladoraPersistencia(); }
    public void crearPasajero(Pasajeros pasajero) { this.cont_persis.crearPasajero(pasajero); }
    public List<Pasajeros> traerListaPasajeros() { return this.cont_persis.traerListaPasajeros(); }
    public Pasajeros traerPasajero(int id) { return this.cont_persis.traerPasajero(id); }
    public List<Pasajeros> consultaUltimosPasajeros(int maxResults, int firstResult) { return this.cont_persis.consultaUltimosPasajeros(maxResults); }
    public void editarPasajero(Pasajeros pasajero) { this.cont_persis.editarPasajero(pasajero); }
    public void eliminarPasajero(int id) { this.cont_persis.eliminarPasajero(id); }
}
