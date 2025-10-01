# 🔧 SOLUCIÓN AL ERROR "Property 'estado' not found"

## 📋 PROBLEMA

```
javax.el.PropertyNotFoundException: The class 'Entity.Vuelos' does not have the property 'estado'.
```

## 🎯 CAUSA

El servidor está usando una versión compilada antigua de la clase `Entity.Vuelos` que no incluye los nuevos campos (`estado`, `capacidad`, `precio`, `duracion`).

---

## ✅ SOLUCIONES (EN ORDEN DE PREFERENCIA)

### 🥇 **SOLUCIÓN 1: Recompilar con NetBeans/Eclipse/IntelliJ**

#### Si usas **NetBeans**:

1. Abre el proyecto en NetBeans
2. Click derecho en el proyecto → **"Clean and Build"**
3. Espera a que termine la compilación
4. **Run** el proyecto

#### Si usas **Eclipse**:

1. Abre el proyecto en Eclipse
2. Click derecho en el proyecto → **"Project" → "Clean"**
3. Selecciona el proyecto y click **"Clean"**
4. Luego **"Project" → "Build Project"**
5. **Run** el proyecto

#### Si usas **IntelliJ IDEA**:

1. Abre el proyecto en IntelliJ
2. **"Build" → "Rebuild Project"**
3. **Run** el proyecto

---

### 🥈 **SOLUCIÓN 2: Línea de comandos con Maven**

1. Abre **PowerShell** o **Command Prompt**
2. Navega a la carpeta del proyecto:
   ```cmd
   cd "C:\Users\monza\OneDrive\Documentos\Lab02P02_ez_mm"
   ```
3. Ejecuta el script de compilación:
   ```cmd
   compilar.bat
   ```
4. Si Maven está instalado, ejecuta:
   ```cmd
   mvn clean compile package
   ```

---

### 🥉 **SOLUCIÓN 3: Manual (Si las anteriores fallan)**

1. **Detén el servidor** (Payara/GlassFish)
2. **Elimina la carpeta target** completamente
3. **Copia manualmente** los archivos:
   - Copia `src/main/java/Entity/Vuelos.java` actualizado
   - Asegúrate de que tenga los nuevos campos
4. **Reinicia el servidor**
5. **Redesplegar** la aplicación

---

## 🔍 **VERIFICACIÓN**

### **Paso 1: Ejecutar diagnóstico**

Accede a: `http://localhost:8080/tu-app/diagnostico.jsp`

Esta página te dirá exactamente qué está funcionando y qué no.

### **Paso 2: Verificar campos en Entity.Vuelos**

Asegúrate de que `src/main/java/Entity/Vuelos.java` contenga:

```java
@Column(name = "Estado", length = 50)
private String estado;

@Column(name = "Capacidad")
private Integer capacidad;

@Column(name = "Precio")
private Double precio;

@Column(name = "Duracion")
private Integer duracion;

// Y sus getters/setters correspondientes
public String getEstado() { return estado; }
public void setEstado(String estado) { this.estado = estado; }
// ... etc
```

---

## 🚀 **DESPUÉS DE LA SOLUCIÓN**

1. ✅ Accede a `http://localhost:8080/tu-app/servlet_vuelos`
2. ✅ Verifica que no hay errores
3. ✅ Las estadísticas deberían funcionar correctamente
4. ✅ Los estados de vuelos se mostrarán con colores

---

## 🆘 **SI NADA FUNCIONA**

### **Opción de emergencia: Vista temporal sin 'estado'**

He modificado temporalmente `view_vuelos.jsp` para que funcione sin la propiedad `estado`. La página debería cargar, pero sin las funcionalidades avanzadas de estado.

### **Para restaurar funcionalidad completa:**

Una vez solucionado el problema de compilación, puedes restaurar las funcionalidades comentadas en `view_vuelos.jsp`.

---

## 📞 **CONTACTO DE EMERGENCIA**

Si ninguna solución funciona:

1. Comparte la salida de `diagnostico.jsp`
2. Indica qué IDE estás usando
3. Confirma la versión de Java y el servidor de aplicaciones

---

_Instrucciones creadas: Octubre 2025_
_Estado: Solución temporal aplicada_
