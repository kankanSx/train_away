// =============================================================================
// pantalla_confirmada.dart  (PANTALLA 4 de 4)
// -----------------------------------------------------------------------------
// Mensaje final "¡Reserva confirmada!" con los detalles del viaje.
// El botón "Entendido" vuelve al formulario para empezar otra reserva.
// =============================================================================

import 'package:flutter/material.dart';

import '../colores.dart';
import '../models/opcion_viaje.dart';
import '../models/reserva.dart';
import '../widgets/boton_inferior.dart';
import '../widgets/cabecera_train_away.dart';
import '../widgets/menu_lateral.dart';
import 'pantalla_formulario.dart';

class PantallaConfirmada extends StatelessWidget {
  final Reserva reserva;

  const PantallaConfirmada({super.key, required this.reserva});

  @override
  Widget build(BuildContext context) {
    // Estilo de texto que usamos varias veces en esta pantalla.
    const TextStyle estiloTexto = TextStyle(
      fontWeight: FontWeight.bold,
      color: colorPrincipal,
      fontSize: 15,
    );

    return Scaffold(
      appBar: const CabeceraTrainAway(),
      endDrawer: const MenuLateral(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const Icon(
              Icons.check_circle_outline,
              color: colorPrincipal,
              size: 40,
            ),
            const SizedBox(height: 16),
            const Text('¡Reserva confirmada!', style: estiloTexto),
            const SizedBox(height: 8),
            const Text(
              'Tu reserva se ha realizado correctamente.',
              style: estiloTexto,
            ),
            const SizedBox(height: 32),

            // Bloque de detalles, alineado a la izquierda.
            // Align coloca a su hijo en una posición concreta del espacio.
            Align(
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Detalles de tu viaje:', style: estiloTexto),
                  Text('Origen: ${reserva.origen.nombre}', style: estiloTexto),
                  Text(
                    'Destino: ${reserva.destino.nombre}',
                    style: estiloTexto,
                  ),
                  Text(
                    'Fecha de salida: ${reserva.fechaComoTexto()}',
                    style: estiloTexto,
                  ),
                  Text('Hora de salida: ${reserva.hora} h', style: estiloTexto),
                  Text(
                    'Número de pasajeros: ${reserva.pasajeros}',
                    style: estiloTexto,
                  ),
                  Text(
                    'Categoría: ${reserva.categoria.nombre}',
                    style: estiloTexto,
                  ),
                  const SizedBox(height: 16),
                  const Text('Servicios incluidos:', style: estiloTexto),
                  if (reserva.opciones.isEmpty)
                    const Text('· Ninguno', style: estiloTexto),
                  for (OpcionViaje opcion in reserva.opciones)
                    Text('· ${opcion.nombre}', style: estiloTexto),
                ],
              ),
            ),

            const SizedBox(height: 32),
            const Text(
              'Gracias por confiar en Train Away.',
              style: estiloTexto,
            ),
            const SizedBox(height: 8),
            const Text('¡Te deseamos un excelente viaje!', style: estiloTexto),
          ],
        ),
      ),
      bottomNavigationBar: BotonInferior(
        texto: 'Entendido',
        relleno: false, // en el diseño este botón solo tiene borde
        alPulsar: () {
          // Volvemos al formulario vacío para hacer otra reserva.
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const PantallaFormulario()),
            (ruta) => false,
          );
        },
      ),
    );
  }
}
