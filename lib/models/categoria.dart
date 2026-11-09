// =============================================================================
// categoria.dart  (MODELO)
// -----------------------------------------------------------------------------
// Categoría o clase del billete: "1º Clase", "Turista"...
// Tiene la misma forma que Estacion: un id y un nombre.
// =============================================================================

class Categoria {
  final int id;
  final String nombre;

  const Categoria({required this.id, required this.nombre});
}
