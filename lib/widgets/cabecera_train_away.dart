// =============================================================================
// cabecera_train_away.dart  (WIDGET REUTILIZABLE)
// -----------------------------------------------------------------------------
// La barra de arriba que se repite en todas las pantallas del diseño:
// el logo "Train Away" a la izquierda y el menú (tres rayas) a la derecha.
//
// La escribimos una sola vez aquí y la usamos en cada pantalla con:
//   appBar: const CabeceraTrainAway(),
// =============================================================================

import 'package:flutter/material.dart';

import '../colores.dart';

// "implements PreferredSizeWidget" es necesario porque el Scaffold necesita
// saber qué altura tiene la barra que le ponemos en "appBar".
class CabeceraTrainAway extends StatelessWidget implements PreferredSizeWidget {
  const CabeceraTrainAway({super.key});

  // Altura estándar de una barra superior.
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      // Línea fina debajo de la barra, como en el diseño.
      shape: const Border(bottom: BorderSide(color: colorPrincipal)),
      // Al ponerlo en false no sale la flecha de "atrás" automática.
      // Para volver atrás el usuario tiene el gesto/botón del sistema.
      automaticallyImplyLeading: false,
      title: const Text(
        'Train Away',
        style: TextStyle(
          color: colorLogo,
          fontSize: 26,
          fontStyle: FontStyle.italic,
          fontFamily: 'serif',
        ),
      ),
      // "actions" son los botones que van a la derecha de la barra.
      actions: [
        // Builder nos da un "context" que está DENTRO del Scaffold.
        // Lo necesitamos para poder abrir el menú lateral (endDrawer).
        Builder(
          builder: (context) {
            return IconButton(
              icon: const Icon(Icons.menu, color: colorPrincipal, size: 30),
              onPressed: () {
                // Abre el menú lateral que definimos en cada pantalla.
                Scaffold.of(context).openEndDrawer();
              },
            );
          },
        ),
      ],
    );
  }
}
