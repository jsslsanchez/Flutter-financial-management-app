import 'package:flutter/material.dart';
import 'package:calc_app/models/combined_model.dart';
import 'package:calc_app/providers/expenses_provider.dart';
import 'package:calc_app/providers/ui_provider.dart';
import 'package:calc_app/utils/constants.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class SaveButtom extends StatelessWidget {
  final CombinedModel cModel;
  const SaveButtom({super.key, required this.cModel});

  @override
  Widget build(BuildContext context) {
    final exProvider = context.read<ExpensesProvider>();
    final uiProvider = context.read<UIProvider>();

    return GestureDetector(
        onTap: () {
          if (cModel.amount != 0.00 && cModel.link != null) {
            exProvider.addNewExpense(cModel);
            Fluttertoast.showToast(
                msg: 'Gasto agregado', backgroundColor: Colors.green);
            uiProvider.bnbIndex = 0;
            Navigator.pop(context);
          } else if (cModel.amount == 0.0) {
            Fluttertoast.showToast(
                msg: 'No olvides agregar un gasto',
                backgroundColor: Colors.red);
          } else {
            Fluttertoast.showToast(
                msg: 'No olvides seleccionar una categoria',
                backgroundColor: Colors.red);
          }
        },
        child: SizedBox(
          height: 70.0,
          width: 150.0,
          child: Constants.customButton(Colors.green, Colors.white, 'GUARDAR'),
        ));
  }
}
