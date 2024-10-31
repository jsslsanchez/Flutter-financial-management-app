import 'package:calc_app/utils/constants.dart';
import 'package:flutter/material.dart';

class FrontSheet extends StatelessWidget {
  const FrontSheet({super.key});

  @override
  Widget build(BuildContext context) {
    var list = List.generate(
        10,
        (i) => Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
                height: 150.0,
                decoration: Constants.sheetDecoration(
                    Theme.of(context).primaryColorDark))));
    return Container(
      decoration:
          Constants.sheetDecoration(Theme.of(context).scaffoldBackgroundColor),
      child: ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: list,
      ),
    );
  }
}
