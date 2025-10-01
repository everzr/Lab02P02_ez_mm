package Entity;

import Controladores.ControladoraPersistencia;
import java.util.List;

public class ControllerVuelos {
    private final ControladoraPersistencia cont_persis;
    public ControllerVuelos() { this.cont_persis = new ControladoraPersistencia(); }
    public void crearVuelo(Vuelos vuelo) { this.cont_persis.crearVuelo(vuelo); }
    public List<Vuelos> traerListaVuelos() { return this.cont_persis.traerListaVuelos(); }
    public Vuelos traerVuelo(int id) { return this.cont_persis.traerVuelo(id); }
    public List<Vuelos> consultaUltimosVuelos(int maxResults, int firstResult) { return this.cont_persis.consultaUltimosVuelos(maxResults); }
    public void editarVuelo(Vuelos vuelo) { this.cont_persis.editarVuelo(vuelo); }
    public void eliminarVuelo(int id) { this.cont_persis.eliminarVuelo(id); }
}
