package Entity;

import Controladores.PasajerosJpaController;
import Controladores.exceptions.NonexistentEntityException;
import Controladores.exceptions.RollbackFailureException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class ControllerPasajeros {
    private final PasajerosJpaController pasajerosJPA;
    
    public ControllerPasajeros() { 
        this.pasajerosJPA = new PasajerosJpaController(); 
    }
    
    public void crearPasajero(Pasajeros pasajero) { 
        try {
            this.pasajerosJPA.create(pasajero);
        } catch (Exception ex) {
            Logger.getLogger(ControllerPasajeros.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    public List<Pasajeros> traerListaPasajeros() { 
        try {
            List<Pasajeros> pasajeros = this.pasajerosJPA.findPasajerosEntities();
            System.out.println("DEBUG ControllerPasajeros: Lista obtenida con " + 
                             (pasajeros != null ? pasajeros.size() + " pasajeros" : "null"));
            if (pasajeros != null && !pasajeros.isEmpty()) {
                System.out.println("DEBUG: Primer pasajero: " + pasajeros.get(0).getNombrePasajero());
            }
            return pasajeros;
        } catch (Exception e) {
            System.err.println("ERROR en traerListaPasajeros: " + e.getMessage());
            e.printStackTrace();
            return null;
        }
    }
    
    public Pasajeros traerPasajero(int id) { 
        return this.pasajerosJPA.findPasajeros(id); 
    }
    
    public List<Pasajeros> consultaUltimosPasajeros(int maxResults, int firstResult) { 
        try {
            System.out.println("DEBUG consultaUltimosPasajeros: solicitando " + maxResults + " pasajeros");
            
            // Obtener el total de pasajeros
            int totalCount = this.pasajerosJPA.getPasajerosCount();
            System.out.println("DEBUG: Total de pasajeros en BD: " + totalCount);
            
            if (totalCount == 0) {
                System.out.println("DEBUG: No hay pasajeros en la BD");
                return new java.util.ArrayList<>();
            }
            
            // Si hay menos pasajeros que el máximo solicitado, obtener todos
            if (totalCount <= maxResults) {
                List<Pasajeros> todosPasajeros = this.pasajerosJPA.findPasajerosEntities();
                System.out.println("DEBUG: Retornando todos los pasajeros: " + todosPasajeros.size());
                return todosPasajeros;
            }
            
            // Calcular el punto de inicio para obtener los últimos registros
            int startResult = totalCount - maxResults;
            List<Pasajeros> ultimos = this.pasajerosJPA.findPasajerosEntities(maxResults, startResult);
            System.out.println("DEBUG: Retornando últimos " + ultimos.size() + " pasajeros");
            return ultimos;
            
        } catch (Exception e) {
            System.err.println("ERROR en consultaUltimosPasajeros: " + e.getMessage());
            e.printStackTrace();
            return new java.util.ArrayList<>();
        }
    }
    
    public void editarPasajero(Pasajeros pasajero) { 
        try {
            this.pasajerosJPA.edit(pasajero);
        } catch (NonexistentEntityException | RollbackFailureException ex) {
            Logger.getLogger(ControllerPasajeros.class.getName()).log(Level.SEVERE, null, ex);
        } catch (Exception ex) {
            Logger.getLogger(ControllerPasajeros.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    public void eliminarPasajero(int id) { 
        try {
            this.pasajerosJPA.destroy(id);
        } catch (NonexistentEntityException | RollbackFailureException ex) {
            Logger.getLogger(ControllerPasajeros.class.getName()).log(Level.SEVERE, null, ex);
        } catch (Exception ex) {
            Logger.getLogger(ControllerPasajeros.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    public int getPasajerosCount() {
        return this.pasajerosJPA.getPasajerosCount();
    }
}
