import 'package:calc_app/utils/constants.dart';
import 'package:flutter/material.dart';

class BackSheet extends StatelessWidget {
  const BackSheet({super.key});

  @override
  Widget build(BuildContext context) {
    headers(String name, String amount, Color customColor) {
      return Column(children: [
        Padding(
          padding: const EdgeInsets.only(top: 13.0, bottom: 5.0),
          child: Text(name,
              style: const TextStyle(
                fontSize: 18.0,
                letterSpacing: 1.5,
              )),
        ),
        Text(amount,
            style: TextStyle(
              fontSize: 20.0,
              letterSpacing: 1.5,
              color: customColor,
            ))
      ]);
    }

    return Container(
      height: 800.0,
      decoration: Constants.sheetDecoration(Theme.of(context).primaryColorDark),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          headers('Ingresos', '\$70.000.00', Colors.green),
          const VerticalDivider(
            thickness: 2.0,
          ),
          headers('Gastos', '\$20.000.00', Colors.red),
        ],
      ),
    );
  }
}
