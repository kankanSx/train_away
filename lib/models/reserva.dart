// =============================================================================
// reserva.dart  (MODELO)
// -----------------------------------------------------------------------------
// Guarda todos los datos que el usuario va eligiendo mientras pasa por las
// pantallas. Creamos UNA reserva en la primera pantalla y la vamos pasando
// de pantalla en pantalla, rellenando lo que falta.
//
//   Formulario  ->  rellena origen, destino, pasajeros, categoría y opciones
//   Fecha       ->  rellena fecha y hora
//   Resumen     ->  solo la lee para mostrarla
// =============================================================================

import 'categoria.dart';
import 'estacion.dart';
import 'opcion_viaje.dart';

class Reserva {
  // Aquí NO usamos "final" porque los datos se van rellenando poco a poco.
  // El símbolo "?" significa que el valor puede ser null (vacío) al principio.
  // Es el "null safety" de Dart: el compilador te obliga a comprobarlo.
  Estacion origen;
  Estacion destino;
  int pasajeros;
  Categoria categoria;
  List<OpcionViaje> opciones;
  DateTime? fecha; // todavía no elegida en la primera pantalla
  String? hora; // todavía no elegida en la primera pantalla

  Reserva({
    required this.origen,
    required this.destino,
    required this.pasajeros,
    required this.categoria,
    required this.opciones,
    this.fecha,
    this.hora,
  });

  // Devuelve la fecha como texto "23/10/2026".
  // padLeft(2, '0') añade un 0 delante si hace falta: 5 -> "05".
  String fechaComoTexto() {
    if (fecha == null) {
      return '-';
    }
    // El "!" le dice a Dart: "ya he comprobado que no es null, confía en mí".
    String dia = fecha!.day.toString().padLeft(2, '0');
    String mes = fecha!.month.toString().padLeft(2, '0');
    String anio = fecha!.year.toString();
    return '$dia/$mes/$anio'; // el $ mete una variable dentro de un texto
  }
}
