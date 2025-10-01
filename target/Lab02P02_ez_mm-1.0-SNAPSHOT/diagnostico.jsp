<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="Entity.Vuelos"%>
<%@page import="java.lang.reflect.Method"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Diagnóstico del Sistema - SkyLine Airlines</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { font-family: 'Courier New', monospace; }
        .status-ok { color: #28a745; }
        .status-error { color: #dc3545; }
        .status-warning { color: #ffc107; }
    </style>
</head>
<body>
    <div class="container mt-5">
        <h1 class="mb-4">🔧 Diagnóstico del Sistema SkyLine Airlines</h1>
        
        <div class="alert alert-info">
            <h4>Estado del Sistema</h4>
            <p>Esta página verifica si las clases Java están correctamente compiladas y disponibles.</p>
        </div>
        
        <!-- Test 1: Clase Vuelos disponible -->
        <div class="card mb-3">
            <div class="card-header">
                <h5>Test 1: Disponibilidad de la clase Entity.Vuelos</h5>
            </div>
            <div class="card-body">
                <%
                try {
                    Class<?> vuelosClass = Class.forName("Entity.Vuelos");
                    out.println("<span class='status-ok'>✅ ÉXITO:</span> La clase Entity.Vuelos está disponible<br>");
                    out.println("<strong>Ruta de la clase:</strong> " + vuelosClass.getProtectionDomain().getCodeSource().getLocation());
                } catch (ClassNotFoundException e) {
                    out.println("<span class='status-error'>❌ ERROR:</span> La clase Entity.Vuelos NO está disponible<br>");
                    out.println("<strong>Error:</strong> " + e.getMessage());
                }
                %>
            </div>
        </div>
        
        <!-- Test 2: Métodos de la clase Vuelos -->
        <div class="card mb-3">
            <div class="card-header">
                <h5>Test 2: Métodos disponibles en Entity.Vuelos</h5>
            </div>
            <div class="card-body">
                <%
                try {
                    Class<?> vuelosClass = Class.forName("Entity.Vuelos");
                    Method[] methods = vuelosClass.getDeclaredMethods();
                    
                    boolean hasGetEstado = false;
                    boolean hasSetEstado = false;
                    boolean hasGetCapacidad = false;
                    boolean hasGetPrecio = false;
                    boolean hasGetDuracion = false;
                    
                    out.println("<strong>Métodos encontrados:</strong><br>");
                    out.println("<div style='max-height: 200px; overflow-y: auto; font-size: 12px;'>");
                    for (Method method : methods) {
                        out.println("• " + method.getName() + "<br>");
                        if (method.getName().equals("getEstado")) hasGetEstado = true;
                        if (method.getName().equals("setEstado")) hasSetEstado = true;
                        if (method.getName().equals("getCapacidad")) hasGetCapacidad = true;
                        if (method.getName().equals("getPrecio")) hasGetPrecio = true;
                        if (method.getName().equals("getDuracion")) hasGetDuracion = true;
                    }
                    out.println("</div><br>");
                    
                    out.println("<strong>Verificación de métodos críticos:</strong><br>");
                    out.println((hasGetEstado ? "<span class='status-ok'>✅</span>" : "<span class='status-error'>❌</span>") + " getEstado()<br>");
                    out.println((hasSetEstado ? "<span class='status-ok'>✅</span>" : "<span class='status-error'>❌</span>") + " setEstado()<br>");
                    out.println((hasGetCapacidad ? "<span class='status-ok'>✅</span>" : "<span class='status-error'>❌</span>") + " getCapacidad()<br>");
                    out.println((hasGetPrecio ? "<span class='status-ok'>✅</span>" : "<span class='status-error'>❌</span>") + " getPrecio()<br>");
                    out.println((hasGetDuracion ? "<span class='status-ok'>✅</span>" : "<span class='status-error'>❌</span>") + " getDuracion()<br>");
                    
                } catch (Exception e) {
                    out.println("<span class='status-error'>❌ ERROR:</span> No se pudieron obtener los métodos<br>");
                    out.println("<strong>Error:</strong> " + e.getMessage());
                }
                %>
            </div>
        </div>
        
        <!-- Test 3: Crear instancia y probar getEstado -->
        <div class="card mb-3">
            <div class="card-header">
                <h5>Test 3: Prueba de la propiedad 'estado'</h5>
            </div>
            <div class="card-body">
                <%
                try {
                    Vuelos vuelo = new Vuelos();
                    vuelo.setEstado("activo");
                    String estado = vuelo.getEstado();
                    
                    out.println("<span class='status-ok'>✅ ÉXITO:</span> La propiedad 'estado' funciona correctamente<br>");
                    out.println("<strong>Valor establecido:</strong> 'activo'<br>");
                    out.println("<strong>Valor obtenido:</strong> '" + estado + "'<br>");
                    
                } catch (NoSuchMethodError e) {
                    out.println("<span class='status-error'>❌ ERROR:</span> Los métodos getEstado/setEstado no están disponibles<br>");
                    out.println("<strong>Causa:</strong> La clase no está actualizada en el servidor<br>");
                    out.println("<strong>Solución:</strong> Recompilar y redesplegar el proyecto");
                } catch (Exception e) {
                    out.println("<span class='status-error'>❌ ERROR:</span> Error general<br>");
                    out.println("<strong>Error:</strong> " + e.getMessage());
                }
                %>
            </div>
        </div>
        
        <!-- Información del sistema -->
        <div class="card mb-3">
            <div class="card-header">
                <h5>Información del Sistema</h5>
            </div>
            <div class="card-body">
                <strong>Servidor:</strong> <%= application.getServerInfo() %><br>
                <strong>Versión JSP:</strong> <%= application.getMajorVersion() %>.<%= application.getMinorVersion() %><br>
                <strong>Java Runtime:</strong> <%= System.getProperty("java.version") %><br>
                <strong>Sistema Operativo:</strong> <%= System.getProperty("os.name") %><br>
                <strong>Directorio de trabajo:</strong> <%= System.getProperty("user.dir") %><br>
                <strong>Fecha/Hora actual:</strong> <%= new java.util.Date() %>
            </div>
        </div>
        
        <!-- Soluciones -->
        <div class="alert alert-warning">
            <h4>💡 Soluciones si hay errores:</h4>
            <ol>
                <li><strong>NetBeans/Eclipse:</strong> Click derecho en el proyecto → "Clean and Build"</li>
                <li><strong>Línea de comandos:</strong> Ejecuta <code>compilar.bat</code> en la carpeta del proyecto</li>
                <li><strong>Manual:</strong> Copia las clases .java actualizadas y reinicia el servidor</li>
                <li><strong>Servidor:</strong> Reinicia completamente el servidor de aplicaciones</li>
            </ol>
        </div>
        
        <div class="text-center mt-4">
            <a href="index.jsp" class="btn btn-primary">🏠 Volver al Inicio</a>
            <a href="servlet_vuelos" class="btn btn-success">✈️ Probar Vuelos</a>
            <button onclick="location.reload()" class="btn btn-secondary">🔄 Actualizar Diagnóstico</button>
        </div>
    </div>
</body>
</html>