# Train Away · Skeleton en Flutter

App de reserva de billetes de tren hecha con Flutter y Dart a partir del prototipo de Penpot
(Módulo 2 · Actividad 2 de Desarrollo para Dispositivos Móviles).

Funciona en **Chrome (web)**, **Android** e **iOS** con el mismo código.

## Cómo ejecutarla

```bash
flutter pub get        # descarga las dependencias
flutter run -d chrome  # la abre en Chrome
flutter test           # pasa las pruebas automáticas
```

En VS Code: abre la carpeta, elige el dispositivo abajo a la derecha (Chrome, emulador...) y pulsa **F5**.

## Flujo de pantallas

```
Formulario ──Reservar──▶ Fecha y hora ──Reservar──▶ Resumen ──Confirmar──▶ ¿Seguro? ──Sí──▶ Confirmada
     ▲                                                                                        │
     └──────────────────────────────────── Entendido ─────────────────────────────────────────┘
```

## Estructura de `lib/`

| Carpeta / fichero | Qué contiene |
|---|---|
| `main.dart` | Arranca la app, tema de colores e idioma español |
| `colores.dart` | Colores sacados del diseño de Penpot |
| `models/` | Clases que solo guardan datos: `Estacion`, `Categoria`, `OpcionViaje`, `Reserva` |
| `services/servicio_datos_mock.dart` | Servicio simulado que devuelve estaciones, categorías, opciones y horarios |
| `screens/` | Las 4 pantallas de la app |
| `widgets/` | Piezas que se repiten en varias pantallas (cabecera, menú, botón de abajo, etiqueta) |

## Orden recomendado para leer el código

1. `models/estacion.dart` y `models/reserva.dart` → clases, constructores y null safety.
2. `services/servicio_datos_mock.dart` → listas y métodos que devuelven datos.
3. `main.dart` → `runApp`, `MaterialApp` y `StatelessWidget`.
4. `widgets/boton_inferior.dart` → cómo pasar parámetros y funciones a un widget.
5. `screens/pantalla_formulario.dart` → `StatefulWidget`, `setState` y `Navigator.push`.
6. `screens/pantalla_fecha.dart` → recibir datos de la pantalla anterior.
7. `screens/pantalla_resumen.dart` → `showDialog` y `pushAndRemoveUntil`.
