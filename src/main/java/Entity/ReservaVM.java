package Entity;

import java.util.Date;

/**
 * View model para mostrar Reservación junto con un Pasajero y un Vuelo (primer detalle).
 */
public class ReservaVM {
    private final Reservaciones reservacion;
    private final Pasajeros pasajero;
    private final Vuelos vuelo;
    private final DetalleReservacion detalle;

    public ReservaVM(Reservaciones r, Pasajeros p, Vuelos v, DetalleReservacion d) {
        this.reservacion = r;
        this.pasajero = p;
        this.vuelo = v;
        this.detalle = d;
    }

    public Reservaciones getReservacion() { return reservacion; }
    public Pasajeros getPasajero() { return pasajero; }
    public Vuelos getVuelo() { return vuelo; }
    public DetalleReservacion getDetalle() { return detalle; }

    public Integer getCodigo() { return reservacion != null ? reservacion.getIDReservacion() : null; }
    public Date getFecha() { return reservacion != null ? reservacion.getFechaReservacion() : null; }
    public String getNombrePasajero() { return pasajero != null ? pasajero.getNombrePasajero() : null; }
    public String getNumeroVuelo() { return vuelo != null ? vuelo.getNumeroVuelo() : null; }
    public String getOrigen() { return vuelo != null ? vuelo.getOrigen() : null; }
    public String getDestino() { return vuelo != null ? vuelo.getDestino() : null; }
    public String getClase() { return detalle != null ? detalle.getClase() : null; }
    public String getAsiento() { return detalle != null ? detalle.getAsiento() : null; }
}
