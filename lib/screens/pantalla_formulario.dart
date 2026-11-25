// =============================================================================
// pantalla_formulario.dart  (PANTALLA 1 de 4)
// -----------------------------------------------------------------------------
// Primera pantalla del diseño: el usuario elige origen, destino, número de
// pasajeros, categoría y opciones de viaje. Al pulsar "Reservar" pasamos a la
// pantalla de fecha y hora.
//
// Las elecciones se guardan en el modelo compartido.
// =============================================================================

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/categoria.dart';
import '../models/estacion.dart';
import '../models/opcion_viaje.dart';
import '../models/reserva_model.dart';
import '../services/servicio_datos_mock.dart';
import '../widgets/boton_inferior.dart';
import '../widgets/cabecera_train_away.dart';
import '../widgets/etiqueta.dart';
import '../widgets/menu_lateral.dart';
import 'pantalla_fecha.dart';

class PantallaFormulario extends StatelessWidget {
  const PantallaFormulario({super.key});

  // Se ejecuta al pulsar el botón "Reservar".
  void pulsarReservar(BuildContext context) {
    final reserva = context.read<ReservaModel>().reserva;
    // Evento básico: comprobamos que origen y destino no sean el mismo.
    if (reserva.origen.id == reserva.destino.id) {
      // SnackBar = mensaje que aparece un momento abajo de la pantalla.
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('El origen y el destino no pueden ser iguales'),
        ),
      );
      return; // salimos de la función y no navegamos
    }

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const PantallaFecha()),
    );
  }

  @override
  Widget build(BuildContext context) {
    // watch actualiza el formulario cada vez que cambia una elección.
    final reserva = context.watch<ReservaModel>().reserva;
    final servicio = ServicioDatosMock();
    final estaciones = servicio.obtenerEstaciones();
    final categorias = servicio.obtenerCategorias();
    final opciones = servicio.obtenerOpcionesViaje();

    // Scaffold = el "esqueleto" de una pantalla: barra arriba, cuerpo y abajo.
    return Scaffold(
      appBar: const CabeceraTrainAway(),
      endDrawer: const MenuLateral(), // menú que sale por la derecha
      // SingleChildScrollView permite hacer scroll si no cabe en pantallas
      // pequeñas (o en la ventana de Chrome).
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        // Column = pone sus hijos uno debajo de otro.
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start, // alineados a la izquierda
          children: [
            // ---------------- ORIGEN ----------------
            const Etiqueta('Origen'),
            DropdownButtonFormField<Estacion>(
              initialValue: reserva.origen,
              decoration: const InputDecoration(border: OutlineInputBorder()),
              // Convertimos cada Estacion de la lista en una opción del menú.
              items: estaciones.map((estacion) {
                return DropdownMenuItem(
                  value: estacion,
                  child: Text(estacion.nombre),
                );
              }).toList(),
              // onChanged se llama cuando el usuario elige otra opción.
              onChanged: (nuevaEstacion) {
                if (nuevaEstacion != null) {
                  context.read<ReservaModel>().cambiarOrigen(nuevaEstacion);
                }
              },
            ),

            // ---------------- DESTINO ----------------
            const Etiqueta('Destino'),
            DropdownButtonFormField<Estacion>(
              initialValue: reserva.destino,
              decoration: const InputDecoration(border: OutlineInputBorder()),
              items: estaciones.map((estacion) {
                return DropdownMenuItem(
                  value: estacion,
                  child: Text(estacion.nombre),
                );
              }).toList(),
              onChanged: (nuevaEstacion) {
                if (nuevaEstacion != null) {
                  context.read<ReservaModel>().cambiarDestino(nuevaEstacion);
                }
              },
            ),

            // -------- PASAJEROS Y CATEGORÍA (en la misma fila) --------
            // Row = pone sus hijos uno al lado del otro.
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Expanded hace que cada columna ocupe la mitad del ancho.
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Etiqueta('Pasajeros'),
                      DropdownButtonFormField<int>(
                        initialValue: reserva.pasajeros,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                        // Bucle "for" dentro de una lista: crea opciones del 1 al 6.
                        items: [
                          for (int numero = 1; numero <= 6; numero++)
                            DropdownMenuItem(
                              value: numero,
                              child: Text('$numero'),
                            ),
                        ],
                        onChanged: (nuevoNumero) {
                          if (nuevoNumero != null) {
                            context.read<ReservaModel>().cambiarPasajeros(
                              nuevoNumero,
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16), // hueco entre las dos columnas
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Etiqueta('Categoría'),
                      DropdownButtonFormField<Categoria>(
                        initialValue: reserva.categoria,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                        items: categorias.map((categoria) {
                          return DropdownMenuItem(
                            value: categoria,
                            child: Text(categoria.nombre),
                          );
                        }).toList(),
                        onChanged: (nuevaCategoria) {
                          if (nuevaCategoria != null) {
                            context.read<ReservaModel>().cambiarCategoria(
                              nuevaCategoria,
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // ---------------- OPCIONES DE VIAJE ----------------
            const SizedBox(height: 16),
            const Etiqueta('Opciones de viaje'),
            // Por cada opción creamos una casilla (CheckboxListTile).
            for (OpcionViaje opcion in opciones)
              CheckboxListTile(
                title: Text(opcion.nombre),
                // ¿Está marcada? Sí, si está dentro de la lista de marcadas.
                value: reserva.opciones.contains(opcion),
                controlAffinity:
                    ListTileControlAffinity.leading, // casilla a la izquierda
                contentPadding: EdgeInsets.zero,
                dense: true,
                onChanged: (marcada) {
                  context.read<ReservaModel>().cambiarOpcion(
                    opcion,
                    marcada == true,
                  );
                },
              ),
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
