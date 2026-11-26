import 'package:flutter/foundation.dart';

import '../services/servicio_datos_mock.dart';
import 'categoria.dart';
import 'estacion.dart';
import 'opcion_viaje.dart';
import 'reserva.dart';

/// Reúne las elecciones del usuario durante el proceso de reserva.
class ReservaModel extends ChangeNotifier {
  Reserva _reserva = _reservaInicial();

  static Reserva _reservaInicial() {
    final servicio = ServicioDatosMock();
    final estaciones = servicio.obtenerEstaciones();
    return Reserva(
      origen: estaciones[0],
      destino: estaciones[1],
      pasajeros: 1,
      categoria: servicio.obtenerCategorias()[0],
      opciones: [],
    );
  }

  // Las pantallas reciben una copia. Para cambiar la reserva compartida
  // usan los métodos del modelo, que avisan con notifyListeners().
  Reserva get reserva => Reserva(
    origen: _reserva.origen,
    destino: _reserva.destino,
    pasajeros: _reserva.pasajeros,
    categoria: _reserva.categoria,
    opciones: List.unmodifiable(_reserva.opciones),
    fecha: _reserva.fecha,
    hora: _reserva.hora,
  );

  void cambiarOrigen(Estacion origen) {
    _reserva.origen = origen;
    notifyListeners();
  }

  void cambiarDestino(Estacion destino) {
    _reserva.destino = destino;
    notifyListeners();
  }

  void cambiarPasajeros(int pasajeros) {
    _reserva.pasajeros = pasajeros;
    notifyListeners();
  }

  void cambiarCategoria(Categoria categoria) {
    _reserva.categoria = categoria;
    notifyListeners();
  }

  void cambiarFecha(DateTime fecha) {
    _reserva.fecha = fecha;
    notifyListeners();
  }

  void cambiarHora(String? hora) {
    _reserva.hora = hora;
    notifyListeners();
  }

  void cambiarOpcion(OpcionViaje opcion, bool marcada) {
    if (marcada) {
      if (!_reserva.opciones.contains(opcion)) {
        _reserva.opciones.add(opcion);
      }
    } else {
      _reserva.opciones.remove(opcion);
    }
    notifyListeners();
  }

  // Volver atrás conserva las elecciones. Empezar otra reserva las reinicia.
  void iniciarNuevaReserva() {
    _reserva = _reservaInicial();
    notifyListeners();
  }
}
