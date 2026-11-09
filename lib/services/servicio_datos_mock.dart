// =============================================================================
// servicio_datos_mock.dart  (SERVICIO SIMULADO)
// -----------------------------------------------------------------------------
// Un "servicio" es la clase que se encarga de conseguir los datos.
// En una app real los leería de una base de datos o de internet.
// En esta fase (Skeleton) es un "mock": un objeto falso que devuelve datos
// escritos directamente aquí, tal y como pide el enunciado.
//
// La ventaja: las pantallas solo hablan con este servicio. El día que haya
// una base de datos de verdad, cambiamos SOLO este fichero y las pantallas
// siguen funcionando igual.
// =============================================================================

import '../models/categoria.dart';
import '../models/estacion.dart';
import '../models/opcion_viaje.dart';

class ServicioDatosMock {
  // Devuelve la lista de estaciones disponibles.
  List<Estacion> obtenerEstaciones() {
    return const [
      Estacion(id: 1, nombre: 'Estación Norte de Madrid'),
      Estacion(id: 2, nombre: 'Estación Sur de Barcelona'),
      Estacion(id: 3, nombre: 'Estación Central de Valencia'),
      Estacion(id: 4, nombre: 'Estación de Sevilla'),
    ];
  }

  // Devuelve las categorías (clases) de billete.
  List<Categoria> obtenerCategorias() {
    return const [
      Categoria(id: 1, nombre: '1º Clase'),
      Categoria(id: 2, nombre: '2º Clase'),
      Categoria(id: 3, nombre: 'Turista'),
    ];
  }

  // Devuelve las opciones extra del viaje.
  List<OpcionViaje> obtenerOpcionesViaje() {
    return const [
      OpcionViaje(id: 1, nombre: 'Con equipaje'),
      OpcionViaje(id: 2, nombre: 'Con servicio de restaurante'),
      OpcionViaje(id: 3, nombre: 'Coche cama'),
    ];
  }

  // Devuelve las horas de salida de los trenes.
  List<String> obtenerHorarios() {
    return const ['07:00', '10:30', '13:45', '16:00', '19:15'];
  }
}
