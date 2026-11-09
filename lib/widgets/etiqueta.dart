// =============================================================================
// etiqueta.dart  (WIDGET REUTILIZABLE)
// -----------------------------------------------------------------------------
// Texto en negrita que va encima de cada campo: "Origen", "Destino"...
// Es muy pequeño, pero al usarlo muchas veces nos ahorra repetir el estilo.
// =============================================================================

import 'package:flutter/material.dart';

import '../colores.dart';

class Etiqueta extends StatelessWidget {
  final String texto;

  const Etiqueta(this.texto, {super.key}); // uso: Etiqueta('Origen')

  @override
  Widget build(BuildContext context) {
    // Padding = deja un hueco alrededor de su hijo.
    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 6),
      child: Text(
        texto,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: colorPrincipal,
        ),
      ),
    );
  }
}
