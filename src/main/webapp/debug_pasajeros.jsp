<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="Entity.ControllerPasajeros"%>
<%@page import="Entity.Pasajeros"%>
<%@page import="java.util.List"%>

<!DOCTYPE html>
<html>
<head>
    <title>Debug Pasajeros</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; }
        .error { color: red; }
        .success { color: green; }
        .info { color: blue; }
    </style>
</head>
<body>
    <h1>Debug Sistema de Pasajeros</h1>
    
    <h2>1. Test de Conexión</h2>
    <%
        try {
            out.println("<div class='info'>Iniciando test de conexión...</div>");
            
            ControllerPasajeros controller = new ControllerPasajeros();
            out.println("<div class='success'>✓ Controller creado exitosamente</div>");
            
            List<Pasajeros> pasajeros = controller.traerListaPasajeros();
            out.println("<div class='success'>✓ Lista obtenida de la base de datos</div>");
            
            if (pasajeros != null) {
                out.println("<div class='info'>Número de pasajeros encontrados: " + pasajeros.size() + "</div>");
                
                if (pasajeros.size() > 0) {
                    out.println("<h3>Pasajeros en la base de datos:</h3>");
                    out.println("<table border='1' cellpadding='5'>");
                    out.println("<tr><th>ID</th><th>Nombre</th><th>Nacionalidad</th><th>Pasaporte</th></tr>");
                    
                    for (Pasajeros p : pasajeros) {
                        out.println("<tr>");
                        out.println("<td>" + p.getIDPasajero() + "</td>");
                        out.println("<td>" + (p.getNombrePasajero() != null ? p.getNombrePasajero() : "NULL") + "</td>");
                        out.println("<td>" + (p.getNacionalidad() != null ? p.getNacionalidad() : "NULL") + "</td>");
                        out.println("<td>" + (p.getPasaporte() != null ? p.getPasaporte() : "NULL") + "</td>");
                        out.println("</tr>");
                    }
                    out.println("</table>");
                } else {
                    out.println("<div class='info'>La base de datos está vacía</div>");
                }
            } else {
                out.println("<div class='error'>La lista de pasajeros es NULL</div>");
            }
            
        } catch (Exception e) {
            out.println("<div class='error'>ERROR: " + e.getClass().getSimpleName() + " - " + e.getMessage() + "</div>");
            out.println("<pre>");
            e.printStackTrace(new java.io.PrintWriter(out));
            out.println("</pre>");
        }
    %>
    
    <hr>
    <h2>2. Test de Inserción</h2>
    
    <%
        String action = request.getParameter("action");
        if ("insert".equals(action)) {
            try {
                ControllerPasajeros controller = new ControllerPasajeros();
                
                Pasajeros testPasajero = new Pasajeros();
                testPasajero.setNombrePasajero("Carlos Méndez Test");
                testPasajero.setNacionalidad("guatemalteca");
                testPasajero.setPasaporte("GT789123");
                
                controller.crearPasajero(testPasajero);
                out.println("<div class='success'>✓ Pasajero insertado exitosamente!</div>");
                
                // Mostrar lista actualizada
                List<Pasajeros> pasajerosActualizados = controller.traerListaPasajeros();
                out.println("<div class='info'>Total de pasajeros después de inserción: " + pasajerosActualizados.size() + "</div>");
                
            } catch (Exception e) {
                out.println("<div class='error'>ERROR al insertar: " + e.getMessage() + "</div>");
                e.printStackTrace(new java.io.PrintWriter(out));
            }
        }
    %>
    
    <form method="post">
        <input type="hidden" name="action" value="insert">
        <button type="submit" style="padding: 10px 20px; background: #28a745; color: white; border: none; border-radius: 5px;">
            Insertar Pasajero de Prueba
        </button>
    </form>
    
    <hr>
    <h2>3. Enlaces de Prueba</h2>
    <ul>
        <li><a href="servlet_pasajeros">Sistema de Pasajeros Normal</a></li>
        <li><a href="servlet_pasajeros?accion=add">Agregar Pasajero</a></li>
        <li><a href="servlet_pasajeros?accion=con">Ver Lista de Pasajeros</a></li>
    </ul>
    
    <hr>
    <small>Última actualización: <%= new java.util.Date() %></small>
</body>
</html>