import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'models/reserva_model.dart';
import 'screens/pantalla_confirmada.dart';
import 'screens/pantalla_fecha.dart';
import 'screens/pantalla_formulario.dart';
import 'screens/pantalla_mis_reservas.dart';
import 'screens/pantalla_resumen.dart';

GoRouter crearRouter() {
  return GoRouter(
    initialLocation: '/reservar',
    routes: [
      GoRoute(path: '/', redirect: (context, estado) => '/reservar'),
      ShellRoute(
        builder: (context, estado, pantalla) {
          // La URL indica qué pestaña debe aparecer seleccionada.
          final ruta = estado.uri.path;
          final enMisReservas =
              ruta == '/mis-reservas' || ruta.startsWith('/mis-reservas/');

          return Scaffold(
            body: pantalla,
            bottomNavigationBar: NavigationBar(
              height: 64,
              selectedIndex: enMisReservas ? 1 : 0,
              onDestinationSelected: (indice) {
                final destino = indice == 0 ? '/reservar' : '/mis-reservas';
                if (ruta == destino) return;
                if (ruta == '/reserva-confirmada') {
                  context.read<ReservaModel>().iniciarNuevaReserva();
                }
                context.go(destino);
              },
              destinations: const [
                NavigationDestination(
                  icon: Icon(Icons.train_outlined),
                  label: 'Reservar',
                ),
                NavigationDestination(
                  icon: Icon(Icons.list_alt_outlined),
                  label: 'Mis reservas',
                ),
              ],
            ),
          );
        },
        routes: [
          GoRoute(
            path: '/reservar',
            builder: (context, estado) => const PantallaFormulario(),
            routes: [
              GoRoute(
                path: 'fecha',
                builder: (context, estado) => const PantallaFecha(),
              ),
              // Se apila desde fecha con push para mantener ambas pantallas
              // en la pila y respetar la URL que indica el enunciado.
              GoRoute(
                path: 'confirmacion',
                redirect: _comprobarFechaYHora,
                builder: (context, estado) => const PantallaResumen(),
              ),
            ],
          ),
          GoRoute(
            path: '/reserva-confirmada',
            redirect: _comprobarFechaYHora,
            builder: (context, estado) => const PantallaConfirmada(),
          ),
          GoRoute(
            path: '/mis-reservas',
            builder: (context, estado) => const PantallaMisReservas(),
            routes: [
              GoRoute(
                path: ':id',
                builder: (context, estado) =>
                    PantallaMisReservas(id: estado.pathParameters['id']),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}

// Si se abre la URL directamente, puede que todavía falten datos del viaje.
String? _comprobarFechaYHora(BuildContext context, GoRouterState estado) {
  final reserva = context.read<ReservaModel>().reserva;
  if (reserva.fecha == null || reserva.hora == null) {
    return '/reservar';
  }
  return null;
}
