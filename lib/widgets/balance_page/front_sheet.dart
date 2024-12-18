import 'package:flutter/material.dart';
import 'package:calc_app/utils/constants.dart';
import 'package:calc_app/providers/expenses_provider.dart';
import 'package:calc_app/providers/entries_provider.dart';
import 'package:calc_app/widgets/balance_page/flayer_categories.dart';
import 'package:calc_app/widgets/balance_page/flayer_skin.dart';
import 'package:provider/provider.dart';

class FrontSheet extends StatelessWidget {
  const FrontSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final eList = context.watch<ExpensesProvider>().eList;
    final iList = context.watch<EntriesProvider>().eList; // Lista de ingresos
    bool hasData = eList.isNotEmpty || iList.isNotEmpty;

    return Container(
        decoration: Constants.sheetBoxDecoration(
            Theme.of(context).scaffoldBackgroundColor),
        child: (hasData)
            ? ListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                    const FlayerSkin(
                        myTitle: "Categoría de gastos",
                        myWidget: FlayerCategories()),

                    // Nuevo FlayerSkin para la categoría de ingresos
                    const FlayerSkin(
                        myTitle: "Categoría de ingresos",
                        myWidget: FlayerCategories()),

                    const FlayerSkin(
                        myTitle: "Frecuencia de gastos",
                        myWidget: SizedBox(height: 150.0)),
                    const FlayerSkin(
                        myTitle: "Movimientos",
                        myWidget: SizedBox(height: 150.0)),
                    const FlayerSkin(
                        myTitle: "Balance General",
                        myWidget: SizedBox(height: 150.0))
                  ])
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(50),
                    child: Image.asset('assets/empty.png'),
                  ),
                  const Text(
                    'No tienes datos este mes, agrega aquí',
                    maxLines: 1,
                    style: TextStyle(fontSize: 15.0, letterSpacing: 1.3),
                  )
                ],
              ));
  }
}
