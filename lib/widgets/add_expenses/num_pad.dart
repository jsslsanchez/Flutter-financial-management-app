import 'package:flutter/material.dart';
import 'num_pad_table.dart';

class NumPad extends StatelessWidget {
  final Function(String) onValueSelected;

  const NumPad({super.key, required this.onValueSelected});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250.0,
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          var constraintsHeight = constraints.biggest.height / 5;
          return Padding(
            padding: const EdgeInsets.only(top: 25.0),
            child: Column(
              children: [
                NumPadTable(
                  constraintsHeight: constraintsHeight,
                  onInput: (value) => _handleInput(value),
                  onDelete: () => _handleDelete(),
                  onDecimal: () => _handleInput('.'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _handleInput(String input) {
    onValueSelected(input);
  }

  void _handleDelete() {
    onValueSelected('delete');
  }
}
