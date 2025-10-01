@echo off
echo ====================================
echo    COMPILACION SISTEMA SKYLINE
echo ====================================
echo.

echo Eliminando archivos compilados antiguos...
if exist "target" rmdir /s /q "target"
echo.

echo Verificando dependencias...
echo Las siguientes dependencias deben estar disponibles:
echo - Maven (mvn command)
echo - Java JDK 8 o superior
echo.

echo Intentando compilar con Maven...
call mvn clean compile
if %ERRORLEVEL% EQU 0 (
    echo.
    echo ====================================
    echo     COMPILACION EXITOSA
    echo ====================================
    echo El proyecto se ha compilado correctamente.
    echo Las nuevas clases estan disponibles en target/classes
    echo.
    echo Para desplegar:
    echo 1. Copia el contenido de src/main/webapp al servidor
    echo 2. Copia las clases de target/classes al servidor
    echo 3. Reinicia el servidor de aplicaciones
) else (
    echo.
    echo ====================================
    echo      ERROR DE COMPILACION
    echo ====================================
    echo Maven no esta disponible o hay errores.
    echo.
    echo SOLUCION ALTERNATIVA:
    echo 1. Abre el proyecto en NetBeans/Eclipse
    echo 2. Ejecuta "Build Project" o "Clean and Build"
    echo 3. O copia manualmente las clases .java a tu IDE
)

echo.
echo Presiona cualquier tecla para continuar...
pause >nul