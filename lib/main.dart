// =============================================================================
// main.dart
// -----------------------------------------------------------------------------
// Punto de entrada de la aplicación Train Away.
// Aquí solo hacemos dos cosas:
//   1. Arrancar la app con runApp().
//   2. Configurar el MaterialApp: colores, idioma y cuál es la primera pantalla.
// =============================================================================

import 'package:flutter/material.dart';
// Este paquete trae los textos de Flutter traducidos (por ejemplo los nombres
// de los meses del calendario). Sin él, el calendario saldría en inglés.
import 'package:flutter_localizations/flutter_localizations.dart';

import 'colores.dart';
import 'screens/pantalla_formulario.dart';

// main() es la primera función que se ejecuta en cualquier programa Dart.
void main() {
  // runApp() recibe el widget raíz y lo dibuja en pantalla.
  runApp(const TrainAwayApp());
}

// Widget raíz de la app. Es "Stateless" (sin estado) porque no cambia nunca:
// solo configura el aspecto general y la primera pantalla.
class TrainAwayApp extends StatelessWidget {
  const TrainAwayApp({super.key});

  // build() describe qué hay que dibujar. Flutter lo llama cuando lo necesita.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Train Away',
      debugShowCheckedModeBanner: false, // quita la etiqueta "DEBUG"
      // Tema: colores y estilo común para toda la app.
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: colorPrincipal),
        scaffoldBackgroundColor: Colors.white,
        // Todos los ElevatedButton de la app tendrán este estilo.
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: colorPrincipal,
            foregroundColor: Colors.white,
            minimumSize: const Size(140, 44),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ),

      // Idioma: español de España.
      locale: const Locale('es', 'ES'),
      supportedLocales: const [Locale('es', 'ES')],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],

      // Primera pantalla que se muestra al abrir la app.
      home: const PantallaFormulario(),
    );
  }
}
