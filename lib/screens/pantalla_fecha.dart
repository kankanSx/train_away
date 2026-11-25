// =============================================================================
// pantalla_fecha.dart  (PANTALLA 2 de 4)
// -----------------------------------------------------------------------------
// El usuario elige el día en un calendario y la hora de salida.
// La fecha y la hora se guardan en el mismo modelo que usa el formulario.
// =============================================================================

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../colores.dart';
import '../models/reserva_model.dart';
import '../services/servicio_datos_mock.dart';
import '../widgets/boton_inferior.dart';
import '../widgets/cabecera_train_away.dart';
import '../widgets/etiqueta.dart';
import '../widgets/menu_lateral.dart';
import 'pantalla_resumen.dart';

class PantallaFecha extends StatelessWidget {
  const PantallaFecha({super.key});

  void pulsarReservar(BuildContext context) {
    final reserva = context.read<ReservaModel>().reserva;
    // Comprobamos que el usuario haya elegido fecha y hora.
    if (reserva.fecha == null || reserva.hora == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Elige la fecha y la hora de salida')),
      );
      return;
    }

    // Siguiente pantalla: el resumen.
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const PantallaResumen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final reserva = context.watch<ReservaModel>().reserva;
    final horarios = ServicioDatosMock().obtenerHorarios();

    // DateTime.now() = fecha y hora de este momento.
    DateTime hoy = DateTime.now();

    return Scaffold(
      appBar: const CabeceraTrainAway(),
      endDrawer: const MenuLateral(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ---------------- CALENDARIO ----------------
            const Etiqueta('Fecha del viaje'),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: colorPrincipal, width: 2),
                borderRadius: BorderRadius.circular(10),
              ),
              // CalendarDatePicker es un calendario que ya trae Flutter.
              // No hace falta programar la cuadrícula de días a mano.
              child: CalendarDatePicker(
                initialDate: reserva.fecha, // null = ningún día marcado aún
                firstDate: hoy, // no se puede elegir un día pasado
                lastDate: DateTime(
                  hoy.year + 1,
                  hoy.month,
                  hoy.day,
                ), // hasta dentro de un año
                onDateChanged: (dia) {
                  context.read<ReservaModel>().cambiarFecha(dia);
                },
              ),
            ),

            // ---------------- HORA DE SALIDA ----------------
            const Etiqueta('Horario de salida'),
            DropdownButtonFormField<String>(
              initialValue: reserva.hora,
              hint: const Text('Seleccione la hora de salida'),
              decoration: const InputDecoration(border: OutlineInputBorder()),
              items: horarios.map((hora) {
                return DropdownMenuItem(value: hora, child: Text(hora));
              }).toList(),
              onChanged: (nuevaHora) {
                context.read<ReservaModel>().cambiarHora(nuevaHora);
              },
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: BotonInferior(
        texto: 'Reservar',
        alPulsar: () => pulsarReservar(context),
      ),
    );
  }
}
