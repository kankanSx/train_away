// =============================================================================
// estacion.dart  (MODELO)
// -----------------------------------------------------------------------------
// Un "modelo" es una clase que solo guarda datos. No dibuja nada en pantalla.
// Esta representa una estación de tren, por ejemplo "Estación Norte de Madrid".
// =============================================================================

class Estacion {
  // Atributos. "final" significa que, una vez creada la estación, no cambian.
  final int id;
  final String nombre;

  // Constructor. Las llaves {} hacen que los parámetros vayan con nombre:
  //   Estacion(id: 1, nombre: 'Madrid')
  // "required" obliga a pasarlos siempre.
  const Estacion({required this.id, required this.nombre});
}
