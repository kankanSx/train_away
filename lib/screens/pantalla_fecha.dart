// =============================================================================
// pantalla_fecha.dart  (PANTALLA 2 de 4)
// -----------------------------------------------------------------------------
// El usuario elige el día en un calendario y la hora de salida.
// Recibe la reserva de la pantalla anterior, le añade fecha y hora y la pasa
// a la pantalla de resumen.
// =============================================================================

import 'package:flutter/material.dart';

import '../colores.dart';
import '../models/reserva.dart';
import '../services/servicio_datos_mock.dart';
import '../widgets/boton_inferior.dart';
import '../widgets/cabecera_train_away.dart';
import '../widgets/etiqueta.dart';
import '../widgets/menu_lateral.dart';
import 'pantalla_resumen.dart';

class PantallaFecha extends StatefulWidget {
  // La reserva que nos llega desde la pantalla del formulario.
  final Reserva reserva;

  const PantallaFecha({super.key, required this.reserva});

  @override
  State<PantallaFecha> createState() => _PantallaFechaState();
}

class _PantallaFechaState extends State<PantallaFecha> {
  final ServicioDatosMock servicio = ServicioDatosMock();
  late List<String> horarios;

  // Al principio no hay nada elegido, por eso pueden ser null ("?").
  DateTime? fechaElegida;
  String? horaElegida;

  @override
  void initState() {
    super.initState();
    horarios = servicio.obtenerHorarios();
  }

  void pulsarReservar() {
    // Comprobamos que el usuario haya elegido fecha y hora.
    if (fechaElegida == null || horaElegida == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Elige la fecha y la hora de salida')),
      );
      return;
    }

    // Guardamos lo elegido dentro de la reserva.
    // "widget.reserva" = la reserva que recibió el StatefulWidget de arriba.
    widget.reserva.fecha = fechaElegida;
    widget.reserva.hora = horaElegida;

    // Siguiente pantalla: el resumen.
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PantallaResumen(reserva: widget.reserva),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
                initialDate: fechaElegida, // null = ningún día marcado aún
                firstDate: hoy, // no se puede elegir un día pasado
                lastDate: DateTime(
                  hoy.year + 1,
                  hoy.month,
                  hoy.day,
                ), // hasta dentro de un año
                onDateChanged: (dia) {
                  setState(() {
                    fechaElegida = dia;
                  });
                },
              ),
            ),

            // ---------------- HORA DE SALIDA ----------------
            const Etiqueta('Horario de salida'),
            DropdownButtonFormField<String>(
              initialValue: horaElegida,
              hint: const Text('Seleccione la hora de salida'),
              decoration: const InputDecoration(border: OutlineInputBorder()),
              items: horarios.map((hora) {
                return DropdownMenuItem(value: hora, child: Text(hora));
              }).toList(),
              onChanged: (nuevaHora) {
                setState(() {
                  horaElegida = nuevaHora;
                });
              },
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: BotonInferior(
        texto: 'Reservar',
        alPulsar: pulsarReservar,
      ),
    );
  }
}
