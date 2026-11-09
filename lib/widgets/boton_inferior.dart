// =============================================================================
// boton_inferior.dart  (WIDGET REUTILIZABLE)
// -----------------------------------------------------------------------------
// La franja de abajo con un botón ("Reservar", "Confirmar", "Entendido").
// Se repite en todas las pantallas, así que la hacemos una vez y le pasamos
// por parámetro el texto y qué hacer al pulsar.
//
// Uso:
//   bottomNavigationBar: BotonInferior(
//     texto: 'Reservar',
//     alPulsar: () { ... },
//   ),
// =============================================================================

import 'package:flutter/material.dart';

import '../colores.dart';

class BotonInferior extends StatelessWidget {
  final String texto;

  // VoidCallback = una función que no recibe nada y no devuelve nada.
  // Así cada pantalla decide qué pasa al pulsar el botón.
  final VoidCallback alPulsar;

  // Si es true el botón va relleno de azul; si es false, solo con borde
  // (como el botón "Entendido" del diseño).
  final bool relleno;

  const BotonInferior({
    super.key,
    required this.texto,
    required this.alPulsar,
    this.relleno = true, // valor por defecto si no lo pasamos
  });

  @override
  Widget build(BuildContext context) {
    // Container nos deja poner márgenes, bordes y color a lo que lleva dentro.
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: colorPrincipal)),
      ),
      // SafeArea evita que el botón quede debajo de la barra del móvil.
      child: SafeArea(
        child: Center(
          heightFactor: 1, // que el Center no ocupe toda la altura
          // Operador ternario:  condición ? siEsVerdad : siEsFalso
          child: relleno
              ? ElevatedButton(onPressed: alPulsar, child: Text(texto))
              : OutlinedButton(
                  onPressed: alPulsar,
                  style: OutlinedButton.styleFrom(
                    foregroundColor: colorPrincipal,
                    minimumSize: const Size(140, 44),
                    side: const BorderSide(color: colorPrincipal),
                  ),
                  child: Text(texto),
                ),
        ),
      ),
    );
  }
}
