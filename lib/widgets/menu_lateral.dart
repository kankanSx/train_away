// =============================================================================
// menu_lateral.dart  (WIDGET REUTILIZABLE)
// -----------------------------------------------------------------------------
// El menú que se abre al pulsar las tres rayas de la cabecera.
// Un "Drawer" es un panel que sale desde un lado de la pantalla.
// =============================================================================

import 'package:flutter/material.dart';

import '../colores.dart';
import '../screens/pantalla_formulario.dart';

class MenuLateral extends StatelessWidget {
  const MenuLateral({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      // ListView = lista de elementos que se puede desplazar.
      child: ListView(
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: colorPrincipal),
            child: Text(
              'Train Away',
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
          ),
          // ListTile = una fila típica de menú: icono + texto.
          ListTile(
            leading: const Icon(Icons.train),
            title: const Text('Nueva reserva'),
            onTap: () {
              // Vamos al formulario y BORRAMOS todas las pantallas anteriores,
              // así el botón "atrás" no vuelve a una reserva a medias.
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => const PantallaFormulario(),
                ),
                (ruta) => false, // false = no conservar ninguna pantalla
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.info_outline),
            title: const Text('Acerca de'),
            onTap: () {
              Navigator.pop(context); // cierra el menú
              // Diálogo ya hecho por Flutter con el nombre de la app.
              showAboutDialog(
                context: context,
                applicationName: 'Train Away',
                applicationVersion: '1.0.0 (Skeleton)',
              );
            },
          ),
        ],
      ),
    );
  }
}
