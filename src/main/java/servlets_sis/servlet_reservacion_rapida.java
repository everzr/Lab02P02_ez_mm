/*
 * Servlet para la página de reservación rápida
 */
package servlets_sis;

import Entity.ControllerPasajeros;
import Entity.ControllerVuelos;
import Entity.Pasajeros;
import Entity.Vuelos;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "servlet_reservacion_rapida", urlPatterns = {"/servlet_reservacion_rapida"})
public class servlet_reservacion_rapida extends HttpServlet {

    ControllerPasajeros cpasajeros = new ControllerPasajeros();
    ControllerVuelos cvuelos = new ControllerVuelos();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Obtener lista de pasajeros para el select
        List<Pasajeros> pasajeros = this.cpasajeros.traerListaPasajeros();
        request.setAttribute("pasajeros", pasajeros);
        
        // Obtener lista de vuelos para mostrar disponibles
        List<Vuelos> vuelos = this.cvuelos.traerListaVuelos();
        request.setAttribute("vuelos", vuelos);
        
        // Enviar a la vista de reservación rápida
        request.getRequestDispatcher("Vistas/add_reservacion_simple.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Este método manejará la creación de la reservación
        // Por ahora redirige de vuelta al GET
        doGet(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Servlet para reservación rápida";
    }
}