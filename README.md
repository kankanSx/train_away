# Train Away · Skeleton en Flutter

(Unidad 2 · Actividad 2 de Desarrollo para Dispositivos Móviles)
Aplicación de reserva de billetes de tren desarrollada con Flutter y Dart a partir del prototipo de Penpot.

Es una **simulación funcional**: permite completar el proceso de reserva, pero no realiza compras ni guarda reservas en una base de datos.

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

## Arquitectura del proyecto

| Ruta                                    | Contenido                                                             |
| --------------------------------------- | --------------------------------------------------------------------- |
| `lib/main.dart`                         | Inicio de la aplicación, tema e idioma español                        |
| `lib/colores.dart`                      | Paleta de colores basada en Penpot                                    |
| `lib/models/`                           | Modelos `Estacion`, `Categoria`, `OpcionViaje` y `Reserva`            |
| `lib/services/servicio_datos_mock.dart` | Datos simulados de estaciones, categorías, servicios y horarios       |
| `lib/screens/`                          | Cuatro pantallas del flujo de reserva                                 |
| `lib/widgets/`                          | Componentes reutilizables: cabecera, menú, botón inferior y etiquetas |
| `assets/fonts/Corinthia-Bold.ttf`       | Fuente del logotipo «Train Away»                                      |

La información se transfiere entre pantallas mediante el objeto `Reserva` y la navegación se gestiona con `Navigator`. El servicio Mock no accede a una base de datos ni a un servidor externo.

## Diseño

La interfaz toma como referencia el prototipo de Penpot. El logotipo utiliza la tipografía **Corinthia Bold**, incorporada como recurso del proyecto, y el resto de controles emplea componentes Flutter.

## Comprobaciones realizadas

En el entorno de desarrollo se han realizado estas verificaciones:

- `flutter pub get`: dependencias resueltas.
- `flutter run -d chrome`: aplicación ejecutada y revisada manualmente en Chrome.
- `dart analyze`: sin incidencias.
- `flutter test`: **2 pruebas superadas**.

Las pruebas automáticas comprueban la validación de estaciones iguales y el aviso al intentar continuar sin fecha y hora. La navegación del botón **No** y la tipografía del logotipo se han revisado manualmente.

## Orden recomendado para leer el código

1. `lib/models/estacion.dart` y `lib/models/reserva.dart`: datos y constructores.
2. `lib/services/servicio_datos_mock.dart`: información simulada.
3. `lib/main.dart`: arranque, `MaterialApp` y configuración general.
4. `lib/widgets/boton_inferior.dart`: componente reutilizable.
5. `lib/screens/pantalla_formulario.dart`: estado local y navegación.
6. `lib/screens/pantalla_fecha.dart`: selección de fecha y hora.
7. `lib/screens/pantalla_resumen.dart`: diálogo de confirmación y navegación.
8. `lib/screens/pantalla_confirmada.dart`: resultado de la reserva.
