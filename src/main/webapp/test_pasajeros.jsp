<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="Entity.ControllerPasajeros"%>
<%@page import="Entity.Pasajeros"%>
<%@page import="java.util.List"%>

<!DOCTYPE html>
<html>
<head>
    <title>Test de Conexión de Pasajeros</title>
</head>
<body>
    <h1>Test de Conexión de Pasajeros</h1>
    
    <%
        try {
            ControllerPasajeros controller = new ControllerPasajeros();
            out.println("<p>Controller creado exitosamente</p>");
            
            List<Pasajeros> pasajeros = controller.traerListaPasajeros();
            out.println("<p>Lista obtenida: " + (pasajeros != null ? "Sí" : "No") + "</p>");
            
            if (pasajeros != null) {
                out.println("<p>Número de pasajeros: " + pasajeros.size() + "</p>");
                
                if (!pasajeros.isEmpty()) {
                    out.println("<h2>Pasajeros encontrados:</h2>");
                    out.println("<ul>");
                    for (Pasajeros p : pasajeros) {
                        out.println("<li>ID: " + p.getIDPasajero() + 
                                   ", Nombre: " + p.getNombrePasajero() + 
                                   ", Nacionalidad: " + p.getNacionalidad() + 
                                   ", Pasaporte: " + p.getPasaporte() + "</li>");
                    }
                    out.println("</ul>");
                } else {
                    out.println("<p>No hay pasajeros en la base de datos</p>");
                }
            }
            
        } catch (Exception e) {
            out.println("<p>Error: " + e.getMessage() + "</p>");
            e.printStackTrace();
        }
    %>
    
    <hr>
    <h2>Agregar Pasajero de Prueba</h2>
    
    <%
        String action = request.getParameter("action");
        if ("add".equals(action)) {
            try {
                ControllerPasajeros controller = new ControllerPasajeros();
                
                Pasajeros nuevoPasajero = new Pasajeros();
                nuevoPasajero.setNombrePasajero("Juan Pérez Test");
                nuevoPasajero.setNacionalidad("guatemalteca");
                nuevoPasajero.setPasaporte("GT123456");
                
                controller.crearPasajero(nuevoPasajero);
                out.println("<p style='color: green;'>Pasajero agregado exitosamente!</p>");
                
                // Refresh para mostrar la lista actualizada
                response.sendRedirect("test_pasajeros.jsp");
                
            } catch (Exception e) {
                out.println("<p style='color: red;'>Error al agregar: " + e.getMessage() + "</p>");
                e.printStackTrace();
            }
        }
    %>
    
    <form method="post">
        <input type="hidden" name="action" value="add">
        <button type="submit">Agregar Pasajero de Prueba</button>
    </form>
    
    <p><a href="servlet_pasajeros">Ir al Sistema de Pasajeros</a></p>
</body>
</html>