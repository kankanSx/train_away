import 'package:flutter/material.dart';

import '../widgets/cabecera_train_away.dart';
import '../widgets/menu_lateral.dart';

class PantallaMisReservas extends StatelessWidget {
  final String? id;

  const PantallaMisReservas({super.key, this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CabeceraTrainAway(),
      endDrawer: const MenuLateral(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Text(
            id == null
                ? 'Todavía no tienes reservas guardadas.'
                : 'No hay datos disponibles para la reserva $id.',
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
