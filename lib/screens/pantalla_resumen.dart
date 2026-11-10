// =============================================================================
// pantalla_resumen.dart  (PANTALLA 3 de 4)
// -----------------------------------------------------------------------------
// Muestra todos los datos de la reserva en cajas grises (solo lectura).
// Al pulsar "Confirmar" sale un diálogo "¿Confirmas la reserva?" con
// los botones No / Sí.
//
// Es Stateless (SIN estado): solo muestra datos, no cambia nada al pulsar.
// =============================================================================

import 'package:flutter/material.dart';

import '../colores.dart';
import '../models/opcion_viaje.dart';
import '../models/reserva.dart';
import '../widgets/boton_inferior.dart';
import '../widgets/cabecera_train_away.dart';
import '../widgets/etiqueta.dart';
import '../widgets/menu_lateral.dart';
import 'pantalla_confirmada.dart';

class PantallaResumen extends StatelessWidget {
  final Reserva reserva;

  const PantallaResumen({super.key, required this.reserva});

  // Muestra el diálogo de confirmación del diseño.
  void mostrarDialogoConfirmar(BuildContext context) {
    // showDialog abre una ventanita encima de la pantalla actual.
    showDialog(
      context: context,
      builder: (contextoDialogo) {
        return AlertDialog(
          title: const Text(
            'Vas a confirmar tu reserva',
            textAlign: TextAlign.center,
          ),
          content: const Text(
            'Una vez confirmada no podrá ser anulada. ¿Confirmas la reserva?',
            textAlign: TextAlign.center,
          ),
          actionsAlignment: MainAxisAlignment.spaceEvenly,
          actions: [
            TextButton(
              onPressed: () {
                // Cerramos el diálogo de confirmación.
                Navigator.pop(contextoDialogo);

                // Volvemos a la primera pantalla de reserva.
                Navigator.popUntil(context, (ruta) => ruta.isFirst);
              },
              child: const Text('No'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(contextoDialogo); // cerramos el diálogo
                // "Sí": vamos a la pantalla final y quitamos las anteriores
                // de la pila, para que no se pueda volver atrás a una
                // reserva que ya está confirmada.
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PantallaConfirmada(reserva: reserva),
                  ),
                  (ruta) => false,
                );
              },
              child: const Text('Sí'),
            ),
          ],
        );
      },
    );
  }

  // Función auxiliar que dibuja una caja gris con un texto dentro.
  // La usamos para cada dato del resumen y así no repetimos código.
  Widget cajaGris(String texto) {
    return Container(
      width: double.infinity, // ocupa todo el ancho disponible
      margin: const EdgeInsets.only(bottom: 6),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: colorCampoGris,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        texto,
        style: const TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.bold,
          color: colorPrincipal,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CabeceraTrainAway(),
      endDrawer: const MenuLateral(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Etiqueta('Origen'),
            cajaGris(reserva.origen.nombre),
            const Etiqueta('Destino'),
            cajaGris(reserva.destino.nombre),
            const Etiqueta('Fecha y hora'),
            cajaGris('${reserva.fechaComoTexto()} - ${reserva.hora}'),
            const Etiqueta('Número de pasajeros'),
            cajaGris('${reserva.pasajeros}'),
            const Etiqueta('Categoría'),
            cajaGris(reserva.categoria.nombre),
            const Etiqueta('Opciones de viaje'),
            // Si no marcó ninguna opción lo decimos; si no, una caja por opción.
            if (reserva.opciones.isEmpty) cajaGris('Sin opciones extra'),
            for (OpcionViaje opcion in reserva.opciones)
              cajaGris(opcion.nombre),
            const SizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: BotonInferior(
        texto: 'Confirmar',
        alPulsar: () {
          mostrarDialogoConfirmar(context);
        },
      ),
    );
  }
}
