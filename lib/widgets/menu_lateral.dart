// =============================================================================
// menu_lateral.dart  (WIDGET REUTILIZABLE)
// -----------------------------------------------------------------------------
// El menú que se abre al pulsar las tres rayas de la cabecera.
// Un "Drawer" es un panel que sale desde un lado de la pantalla.
// =============================================================================

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../colores.dart';
import '../models/reserva_model.dart';

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
              Scaffold.of(context).closeEndDrawer();
              context.read<ReservaModel>().iniciarNuevaReserva();
              context.go('/reservar');
            },
          ),
          ListTile(
            leading: const Icon(Icons.info_outline),
            title: const Text('Acerca de'),
            onTap: () {
              Scaffold.of(context).closeEndDrawer();
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
