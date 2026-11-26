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
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../colores.dart';
import '../models/opcion_viaje.dart';
import '../models/reserva_model.dart';
import '../widgets/boton_inferior.dart';
import '../widgets/cabecera_train_away.dart';
import '../widgets/etiqueta.dart';
import '../widgets/menu_lateral.dart';

class PantallaResumen extends StatelessWidget {
  const PantallaResumen({super.key});

  // Muestra el diálogo de confirmación del diseño.
  Future<void> mostrarDialogoConfirmar(BuildContext context) async {
    // showDialog abre una ventanita encima de la pantalla actual.
    final respuesta = await showDialog<bool>(
      context: context,
      builder: (contextoDialogo) {
        return AlertDialog(
          title: const Text('Reserva no anulable', textAlign: TextAlign.center),
          content: const Text(
            'Una vez confirmada no podrá ser anulada. ¿Confirmas la reserva?',
            textAlign: TextAlign.center,
          ),
          actionsAlignment: MainAxisAlignment.spaceEvenly,
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(contextoDialogo, false),
              child: const Text('No'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(contextoDialogo, true),
              child: const Text('Sí'),
            ),
          ],
        );
      },
    );

    // Si se cierra el diálogo con Atrás, el resultado es null.
    if (!context.mounted || respuesta == null) return;
    context.go(respuesta ? '/reserva-confirmada' : '/reservar');
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
    final reserva = context.watch<ReservaModel>().reserva;

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
