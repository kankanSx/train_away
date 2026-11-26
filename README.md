# Train Away · Estado, navegación y almacenamiento

(Unidad 3 · Actividad 3 de Desarrollo para Dispositivos Móviles)
Aplicación de reserva de billetes de tren desarrollada con Flutter y Dart a partir del prototipo de Penpot.

La Actividad 3 parte de la aplicación de la Actividad 2. El estado compartido y la navegación con `go_router` ya están incorporados. El almacenamiento local se integrará en la siguiente fase.

## Requisitos y ejecución

Versión utilizada para la comprobación: **Flutter 3.47.9** con **Dart 3.13.7**. El proyecto requiere Dart `^3.13.7`.

```bash
flutter pub get
flutter run -d chrome
```

En VS Code también se puede seleccionar un dispositivo compatible y ejecutar con **F5**. La aplicación se ha **probado en Chrome**.

## Funcionalidad y navegación

1. **Formulario de reserva:** selección de origen, destino, pasajeros, categoría y servicios opcionales.
2. **Fecha y hora:** elección de la fecha en un calendario y del horario de salida.
3. **Resumen:** revisión de los datos seleccionados.
4. **Diálogo de confirmación:** permite confirmar o cancelar la operación.
5. **Reserva confirmada:** muestra los detalles del viaje y permite iniciar una nueva reserva.

Flujo principal:

```text
Formulario → Fecha y hora → Resumen → ¿Confirmar reserva?
                                       ├─ Sí → Reserva confirmada → Entendido → Formulario
                                       └─ No → Formulario (para modificar los datos)
```

La aplicación muestra avisos cuando el origen y el destino coinciden o cuando se intenta continuar sin seleccionar fecha y hora.

### Mapa de rutas

| Ruta | Pantalla |
| --- | --- |
| `/reservar` | Formulario inicial |
| `/reservar/fecha` | Fecha y hora |
| `/reservar/confirmacion` | Resumen |
| `/reserva-confirmada` | Resultado de la confirmación |
| `/mis-reservas` | Mis reservas |
| `/mis-reservas/:id` | Detalle por identificador |

Se usa `push` para avanzar de formulario a fecha y de fecha a resumen. Así, Atrás recupera el paso anterior y el resumen conserva la URL literal del enunciado. Se usa `go` al cambiar de sección, cancelar la confirmación o pasar a la pantalla de resultado.

## Arquitectura del proyecto

| Ruta                                    | Contenido                                                             |
| --------------------------------------- | --------------------------------------------------------------------- |
| `lib/main.dart`                         | Inicio de la aplicación, tema e idioma español                        |
| `lib/colores.dart`                      | Paleta de colores basada en Penpot                                    |
| `lib/models/`                           | Modelos `Estacion`, `Categoria`, `OpcionViaje` y `Reserva`            |
| `lib/services/servicio_datos_mock.dart` | Datos simulados de estaciones, categorías, servicios y horarios       |
| `lib/screens/`                          | Pantallas del flujo y de Mis reservas                                 |
| `lib/widgets/`                          | Componentes reutilizables: cabecera, menú, botón inferior y etiquetas |
| `assets/fonts/Corinthia-Bold.ttf`       | Fuente del logotipo «Train Away»                                      |

La reserva en curso se comparte mediante `ReservaModel` y `provider`. Al cancelar la confirmación, se conservan los datos introducidos. La barra inferior permite cambiar entre **Reservar** y **Mis reservas**. El detalle recibe el identificador por la ruta. La consulta de los datos se incorporará con SQLite. El servicio simulado proporciona las estaciones, categorías, opciones de viaje y horarios. En la fase de persistencia, SQLite guardará las reservas confirmadas para consultarlas en «Mis reservas». El origen y el destino del último trayecto se recordarán con shared_preferences para rellenar el formulario.

## Diseño

La interfaz toma como referencia el prototipo de Penpot. El logotipo utiliza la tipografía **Corinthia Bold**, incorporada como recurso del proyecto, y el resto de controles emplea componentes Flutter.

## Comprobaciones realizadas

En el entorno de desarrollo se han realizado estas verificaciones:

- `flutter pub get`: dependencias resueltas.
- `flutter run -d chrome`: aplicación ejecutada y revisada manualmente en Chrome.
- `dart analyze`: sin incidencias.
- `flutter test`: **4 pruebas superadas**.

Las pruebas automáticas comprueban que se rechazan las estaciones iguales, que se pide elegir fecha y hora antes de continuar y que se conservan las elecciones al pulsar **No** en el diálogo. También comprueban el botón Atrás desde el resumen, la confirmación, el acceso a Mis reservas y la selección de las pestañas. La tipografía del logotipo se revisó manualmente.

## Orden recomendado para leer el código

1. `lib/models/estacion.dart` y `lib/models/reserva.dart`: datos y constructores.
2. `lib/services/servicio_datos_mock.dart`: información simulada.
3. `lib/main.dart`: arranque, `MaterialApp.router` y configuración general.
4. `lib/widgets/boton_inferior.dart`: componente reutilizable.
5. `lib/screens/pantalla_formulario.dart`: estado compartido y navegación.
6. `lib/screens/pantalla_fecha.dart`: selección de fecha y hora.
7. `lib/screens/pantalla_resumen.dart`: diálogo de confirmación y navegación.
8. `lib/screens/pantalla_confirmada.dart`: resultado de la reserva.
