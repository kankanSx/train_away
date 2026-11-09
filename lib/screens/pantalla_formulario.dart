// =============================================================================
// pantalla_formulario.dart  (PANTALLA 1 de 4)
// -----------------------------------------------------------------------------
// Primera pantalla del diseño: el usuario elige origen, destino, número de
// pasajeros, categoría y opciones de viaje. Al pulsar "Reservar" pasamos a la
// pantalla de fecha y hora.
//
// Es un StatefulWidget (CON estado) porque lo que se ve cambia cuando el
// usuario elige algo en un desplegable o marca una casilla.
// =============================================================================

import 'package:flutter/material.dart';

import '../models/categoria.dart';
import '../models/estacion.dart';
import '../models/opcion_viaje.dart';
import '../models/reserva.dart';
import '../services/servicio_datos_mock.dart';
import '../widgets/boton_inferior.dart';
import '../widgets/cabecera_train_away.dart';
import '../widgets/etiqueta.dart';
import '../widgets/menu_lateral.dart';
import 'pantalla_fecha.dart';

// Un StatefulWidget siempre va en DOS clases:
//   1. El widget en sí (esta), que casi no tiene nada.
//   2. Su clase "State" (la de abajo), donde están los datos y el build().
class PantallaFormulario extends StatefulWidget {
  const PantallaFormulario({super.key});

  @override
  State<PantallaFormulario> createState() => _PantallaFormularioState();
}

// El "_" delante del nombre hace que la clase sea privada de este fichero.
class _PantallaFormularioState extends State<PantallaFormulario> {
  // Pedimos los datos al servicio simulado.
  final ServicioDatosMock servicio = ServicioDatosMock();

  // Listas que se mostrarán en los desplegables y casillas.
  // "late" = las rellenamos un poco más tarde, en initState().
  late List<Estacion> estaciones;
  late List<Categoria> categorias;
  late List<OpcionViaje> opciones;

  // Lo que el usuario ha elegido. Son el "estado" de la pantalla.
  late Estacion origenElegido;
  late Estacion destinoElegido;
  late Categoria categoriaElegida;
  int pasajerosElegidos = 1;
  List<OpcionViaje> opcionesMarcadas = []; // al principio ninguna marcada

  // initState() se ejecuta UNA vez, cuando la pantalla se crea.
  // Es el sitio para cargar los datos iniciales.
  @override
  void initState() {
    super.initState();
    estaciones = servicio.obtenerEstaciones();
    categorias = servicio.obtenerCategorias();
    opciones = servicio.obtenerOpcionesViaje();

    // Valores que aparecen elegidos al abrir la pantalla (como en Penpot).
    origenElegido = estaciones[0];
    destinoElegido = estaciones[1];
    categoriaElegida = categorias[0];
  }

  // Se ejecuta al pulsar el botón "Reservar".
  void pulsarReservar() {
    // Evento básico: comprobamos que origen y destino no sean el mismo.
    if (origenElegido.id == destinoElegido.id) {
      // SnackBar = mensaje que aparece un momento abajo de la pantalla.
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('El origen y el destino no pueden ser iguales'),
        ),
      );
      return; // salimos de la función y no navegamos
    }

    // Creamos la reserva con lo elegido en esta pantalla.
    Reserva reserva = Reserva(
      origen: origenElegido,
      destino: destinoElegido,
      pasajeros: pasajerosElegidos,
      categoria: categoriaElegida,
      opciones: opcionesMarcadas,
    );

    // NAVEGACIÓN: Navigator.push "apila" una pantalla nueva encima de esta.
    // Le pasamos la reserva por el constructor de la siguiente pantalla.
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PantallaFecha(reserva: reserva)),
    );
  }

  @override
  Widget build(BuildContext context) {
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
              initialValue: origenElegido,
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
                // setState() avisa a Flutter de que algo ha cambiado y que
                // tiene que volver a llamar a build() para redibujar.
                setState(() {
                  origenElegido = nuevaEstacion!;
                });
              },
            ),

            // ---------------- DESTINO ----------------
            const Etiqueta('Destino'),
            DropdownButtonFormField<Estacion>(
              initialValue: destinoElegido,
              decoration: const InputDecoration(border: OutlineInputBorder()),
              items: estaciones.map((estacion) {
                return DropdownMenuItem(
                  value: estacion,
                  child: Text(estacion.nombre),
                );
              }).toList(),
              onChanged: (nuevaEstacion) {
                setState(() {
                  destinoElegido = nuevaEstacion!;
                });
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
                        initialValue: pasajerosElegidos,
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
                          setState(() {
                            pasajerosElegidos = nuevoNumero!;
                          });
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
                        initialValue: categoriaElegida,
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
                          setState(() {
                            categoriaElegida = nuevaCategoria!;
                          });
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
                value: opcionesMarcadas.contains(opcion),
                controlAffinity:
                    ListTileControlAffinity.leading, // casilla a la izquierda
                contentPadding: EdgeInsets.zero,
                dense: true,
                onChanged: (marcada) {
                  setState(() {
                    if (marcada == true) {
                      opcionesMarcadas.add(opcion);
                    } else {
                      opcionesMarcadas.remove(opcion);
                    }
                  });
                },
              ),
          ],
        ),
      ),
      bottomNavigationBar: BotonInferior(
        texto: 'Reservar',
        alPulsar: pulsarReservar, // le pasamos la función (sin paréntesis)
      ),
    );
  }
}
