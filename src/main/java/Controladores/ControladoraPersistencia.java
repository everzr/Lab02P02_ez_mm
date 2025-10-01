package Controladores;

import Entity.DetalleReservacion;
import Entity.Pasajeros;
import Entity.Reservaciones;
import Entity.Vuelos;
import Controladores.exceptions.RollbackFailureException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class ControladoraPersistencia {
    public ControladoraPersistencia (){}

    DetalleReservacionJpaController detalle_reservacionJPA = new DetalleReservacionJpaController();
    PasajerosJpaController pasajerosJPA = new PasajerosJpaController();
    ReservacionesJpaController reservacionesJPA = new ReservacionesJpaController();
    VuelosJpaController vuelosJPA = new VuelosJpaController();

    public void crearVuelo(Vuelos vuelo) {
        try { this.vuelosJPA.create(vuelo); } catch (Exception ex) { Logger.getLogger(ControladoraPersistencia.class.getName()).log(Level.SEVERE, null, ex); }
    }
    public void crearPasajero(Pasajeros pasajero) {
        try { this.pasajerosJPA.create(pasajero); } catch (Exception ex) { Logger.getLogger(ControladoraPersistencia.class.getName()).log(Level.SEVERE, null, ex); }
    }
    public void crearReservacion(Reservaciones reservacion) {
        try { this.reservacionesJPA.create(reservacion); } catch (Exception ex) { Logger.getLogger(ControladoraPersistencia.class.getName()).log(Level.SEVERE, null, ex); }
    }
    public void crearDetalleReservacion(DetalleReservacion detalleReservacion) {
        try { this.detalle_reservacionJPA.create(detalleReservacion); } catch (Exception ex) { Logger.getLogger(ControladoraPersistencia.class.getName()).log(Level.SEVERE, null, ex); }
    }

    // Listar todos
    public List<Vuelos> traerListaVuelos() { return this.vuelosJPA.findVuelosEntities(); }
    public List<Pasajeros> traerListaPasajeros() { return this.pasajerosJPA.findPasajerosEntities(); }
    public List<Reservaciones> traerListaReservaciones() { return this.reservacionesJPA.findReservacionesEntities(); }
    public List<DetalleReservacion> traerListaDetalleReservaciones() { return this.detalle_reservacionJPA.findDetalleReservacionEntities(); }

    // Traer por id
    public Vuelos traerVuelo(int id) { return this.vuelosJPA.findVuelos(id); }
    public Pasajeros traerPasajero(int id) { return this.pasajerosJPA.findPasajeros(id); }
    public Reservaciones traerReservacion(int id) { return this.reservacionesJPA.findReservaciones(id); }
    public DetalleReservacion traerDetalleReservacion(int id) { return this.detalle_reservacionJPA.findDetalleReservacion(id); }

    // Editar
    public void editarVuelo(Vuelos vuelo) {
        try { this.vuelosJPA.edit(vuelo); } catch (RollbackFailureException ex) { Logger.getLogger(ControladoraPersistencia.class.getName()).log(Level.SEVERE, null, ex); } catch (Exception ex) { Logger.getLogger(ControladoraPersistencia.class.getName()).log(Level.SEVERE, null, ex); }
    }
    public void editarPasajero(Pasajeros pasajero) {
        try { this.pasajerosJPA.edit(pasajero); } catch (RollbackFailureException ex) { Logger.getLogger(ControladoraPersistencia.class.getName()).log(Level.SEVERE, null, ex); } catch (Exception ex) { Logger.getLogger(ControladoraPersistencia.class.getName()).log(Level.SEVERE, null, ex); }
    }
    public void editarReservacion(Reservaciones reservacion) {
        try { this.reservacionesJPA.edit(reservacion); } catch (RollbackFailureException ex) { Logger.getLogger(ControladoraPersistencia.class.getName()).log(Level.SEVERE, null, ex); } catch (Exception ex) { Logger.getLogger(ControladoraPersistencia.class.getName()).log(Level.SEVERE, null, ex); }
    }
    public void editarDetalleReservacion(DetalleReservacion detalle) {
        try { this.detalle_reservacionJPA.edit(detalle); } catch (RollbackFailureException ex) { Logger.getLogger(ControladoraPersistencia.class.getName()).log(Level.SEVERE, null, ex); } catch (Exception ex) { Logger.getLogger(ControladoraPersistencia.class.getName()).log(Level.SEVERE, null, ex); }
    }

    // Eliminar
    public void eliminarVuelo(int id) {
        try { this.vuelosJPA.destroy(id); } catch (RollbackFailureException ex) { Logger.getLogger(ControladoraPersistencia.class.getName()).log(Level.SEVERE, null, ex); } catch (Exception ex) { Logger.getLogger(ControladoraPersistencia.class.getName()).log(Level.SEVERE, null, ex); }
    }
    public void eliminarPasajero(int id) {
        try { this.pasajerosJPA.destroy(id); } catch (RollbackFailureException ex) { Logger.getLogger(ControladoraPersistencia.class.getName()).log(Level.SEVERE, null, ex); } catch (Exception ex) { Logger.getLogger(ControladoraPersistencia.class.getName()).log(Level.SEVERE, null, ex); }
    }
    public void eliminarReservacion(int id) {
        try { this.reservacionesJPA.destroy(id); } catch (RollbackFailureException ex) { Logger.getLogger(ControladoraPersistencia.class.getName()).log(Level.SEVERE, null, ex); } catch (Exception ex) { Logger.getLogger(ControladoraPersistencia.class.getName()).log(Level.SEVERE, null, ex); }
    }
    public void eliminarDetalleReservacion(int id) {
        try { this.detalle_reservacionJPA.destroy(id); } catch (RollbackFailureException ex) { Logger.getLogger(ControladoraPersistencia.class.getName()).log(Level.SEVERE, null, ex); } catch (Exception ex) { Logger.getLogger(ControladoraPersistencia.class.getName()).log(Level.SEVERE, null, ex); }
    }

    // Consultas de los últimos N registros (por conteo)
    public List<Vuelos> consultaUltimosVuelos(int cantidad) {
        int total = this.vuelosJPA.getVuelosCount() - cantidad; if (total < 0) total = 0; return this.vuelosJPA.findVuelosEntities(cantidad, total);
    }
    public List<Pasajeros> consultaUltimosPasajeros(int cantidad) {
        int total = this.pasajerosJPA.getPasajerosCount() - cantidad; if (total < 0) total = 0; return this.pasajerosJPA.findPasajerosEntities(cantidad, total);
    }
    public List<Reservaciones> consultaUltimasReservaciones(int cantidad) {
        int total = this.reservacionesJPA.getReservacionesCount() - cantidad; if (total < 0) total = 0; return this.reservacionesJPA.findReservacionesEntities(cantidad, total);
    }
    public List<DetalleReservacion> consultaUltimosDetalleReservacion(int cantidad) {
        int total = this.detalle_reservacionJPA.getDetalleReservacionCount() - cantidad; if (total < 0) total = 0; return this.detalle_reservacionJPA.findDetalleReservacionEntities(cantidad, total);
    }
}
