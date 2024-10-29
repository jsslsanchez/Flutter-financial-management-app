import 'package:calc_app/utils/constants.dart';
import 'package:calc_app/widgets/add_expenses/bs_num_keyboard.dart';
import 'package:flutter/material.dart';

class AddExpenses extends StatelessWidget {
  const AddExpenses({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Agregar Gasto'),
          elevation: 0.0,
        ),
        body: Column(
          children: [
            const BsNumKeyboard(),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: Constants.sheetDecoration(
                    Theme.of(context).primaryColorDark),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Fecha: 05/09/2024'),
                    Text('Seleccionar Categoría'),
                    Text('Agregar Comentario (opcional)'),
                    Expanded(child: Center(child: Text('Botón Done'))),
                  ],
                ),
              ),
            )
          ],
        ));
  }
}
