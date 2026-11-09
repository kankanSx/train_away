// =============================================================================
// widget_test.dart
// -----------------------------------------------------------------------------
// Prueba automática: simula un usuario que recorre la app de principio a fin.
// Se ejecuta con:  flutter test
// =============================================================================

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:train_away/main.dart';

void main() {
  testWidgets('Se puede navegar del formulario a la fecha y volver', (
    tester,
  ) async {
    // Arrancamos la app.
    await tester.pumpWidget(const TrainAwayApp());

    // En la primera pantalla tiene que verse "Origen" y el botón "Reservar".
    expect(find.text('Origen'), findsOneWidget);
    expect(find.text('Reservar'), findsOneWidget);

    // Pulsamos "Reservar" y esperamos a que termine la animación.
    await tester.tap(find.text('Reservar'));
    await tester.pumpAndSettle();

    // Ahora estamos en la pantalla de fecha.
    expect(find.text('Fecha del viaje'), findsOneWidget);

    // Si pulsamos "Reservar" sin elegir fecha, sale un aviso.
    await tester.tap(find.text('Reservar'));
    await tester.pump();
    expect(find.text('Elige la fecha y la hora de salida'), findsOneWidget);
  });

  testWidgets('No deja reservar con origen y destino iguales', (tester) async {
    await tester.pumpWidget(const TrainAwayApp());

    // Abrimos el desplegable de destino y elegimos la misma estación que origen.
    await tester.tap(find.text('Estación Sur de Barcelona'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Estación Norte de Madrid').last);
    await tester.pumpAndSettle();

    await tester.tap(find.text('Reservar'));
    await tester.pump();
    expect(
      find.text('El origen y el destino no pueden ser iguales'),
      findsOneWidget,
    );
    // Seguimos en la misma pantalla.
    expect(find.byType(CheckboxListTile), findsNWidgets(3));
  });
}
