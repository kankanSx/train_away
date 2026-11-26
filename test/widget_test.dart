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
  final reservar = find.widgetWithText(ElevatedButton, 'Reservar');
  testWidgets('Se puede navegar del formulario a la fecha y volver', (
    tester,
  ) async {
    // Arrancamos la app.
    await tester.pumpWidget(const TrainAwayApp());

    // En la primera pantalla tiene que verse "Origen" y el botón "Reservar".
    expect(find.text('Origen'), findsOneWidget);
    expect(reservar, findsOneWidget);

    // Pulsamos "Reservar" y esperamos a que termine la animación.
    await tester.tap(reservar);
    await tester.pumpAndSettle();

    // Ahora estamos en la pantalla de fecha.
    expect(find.text('Fecha del viaje'), findsOneWidget);

    // Si pulsamos "Reservar" sin elegir fecha, sale un aviso.
    await tester.tap(reservar);
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

    await tester.tap(reservar);
    await tester.pump();
    expect(
      find.text('El origen y el destino no pueden ser iguales'),
      findsOneWidget,
    );
    // Seguimos en la misma pantalla.
    expect(find.byType(CheckboxListTile), findsNWidgets(3));
  });

  testWidgets('Cancelar y confirmar una reserva', (tester) async {
    await tester.pumpWidget(const TrainAwayApp());
    await tester.tap(find.text('Con equipaje'));
    await tester.pump();
    await tester.tap(reservar);
    await tester.pumpAndSettle();

    final hoy = DateTime.now().day.toString();
    await tester.tap(
      find.descendant(
        of: find.byType(CalendarDatePicker),
        matching: find.text(hoy),
      ),
    );
    final horario = find.byType(DropdownButtonFormField<String>);
    await tester.ensureVisible(horario);
    await tester.tap(horario);
    await tester.pumpAndSettle();
    await tester.tap(find.text('10:30').last);
    await tester.pumpAndSettle();

    await tester.tap(reservar);
    await tester.pumpAndSettle();
    await tester.binding.handlePopRoute();
    await tester.pumpAndSettle();
    expect(find.text('Fecha del viaje'), findsOneWidget);

    await tester.tap(reservar);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Confirmar'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('No'));
    await tester.pumpAndSettle();

    final equipaje = find.widgetWithText(CheckboxListTile, 'Con equipaje');
    expect(tester.widget<CheckboxListTile>(equipaje).value, isTrue);
    await tester.tap(reservar);
    await tester.pumpAndSettle();
    expect(find.text('10:30'), findsOneWidget);

    await tester.tap(reservar);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Confirmar'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Sí'));
    await tester.pumpAndSettle();
    expect(find.text('¡Reserva confirmada!'), findsOneWidget);

    final consultar = find.text('Consultar mis reservas');
    await tester.ensureVisible(consultar);
    await tester.tap(consultar);
    await tester.pumpAndSettle();
    expect(find.textContaining('reservas guardadas'), findsOneWidget);
  });

  testWidgets('Cambiar entre Reservar y Mis reservas', (tester) async {
    await tester.pumpWidget(const TrainAwayApp());
    await tester.pumpAndSettle();

    final barra = find.byType(NavigationBar);
    expect(tester.widget<NavigationBar>(barra).selectedIndex, 0);

    await tester.tap(find.text('Mis reservas'));
    await tester.pumpAndSettle();
    expect(tester.widget<NavigationBar>(barra).selectedIndex, 1);
    expect(find.textContaining('reservas guardadas'), findsOneWidget);

    await tester.tap(find.text('Reservar'));
    await tester.pumpAndSettle();
    expect(tester.widget<NavigationBar>(barra).selectedIndex, 0);
    expect(find.text('Origen'), findsOneWidget);
  });
}
