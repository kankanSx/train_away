// =============================================================================
// opcion_viaje.dart  (MODELO)
// -----------------------------------------------------------------------------
// Extras que se pueden añadir al viaje: equipaje, restaurante, coche cama.
// En la pantalla del formulario cada opción será una casilla (checkbox).
// =============================================================================

class OpcionViaje {
  final int id;
  final String nombre;

  const OpcionViaje({required this.id, required this.nombre});
}
