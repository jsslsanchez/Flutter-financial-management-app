import 'package:calc_app/widgets/action_buttom.dart';
import 'package:flutter/material.dart';
import 'amount_display.dart';
import 'num_pad.dart';

class BsNumKeyboard extends StatefulWidget {
  const BsNumKeyboard({super.key});

  @override
  State<BsNumKeyboard> createState() => _BsNumKeyboardState();
}

class _BsNumKeyboardState extends State<BsNumKeyboard> {
  String amount = '0.00';

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _showNumPad,
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: [
            const Text('Cantidad Ingresada'),
            AmountDisplay(amount: amount),
          ],
        ),
      ),
    );
  }

  void _showNumPad() {
    showModalBottomSheet(
      barrierColor: Colors.transparent,
      enableDrag: false,
      isScrollControlled: true,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(30.0)),
      ),
      context: context,
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            NumPad(onValueSelected: _updateAmount),
            Padding(
              padding: const EdgeInsets.only(top: 0.0, bottom: 35.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: ActionButton(
                          label: 'Cancelar',
                          icon: Icons.cancel,
                          color: Colors.red,
                          onPressed: () {
                            setState(() {
                              amount = '0.00'; // Reinicia el amount a 0.00
                            });
                            Navigator.pop(
                                context); // Pasar el valor 0.00 al cerrar
                          },
                        ),
                      ),
                      const SizedBox(width: 8.0),
                      Expanded(
                        child: ActionButton(
                          label: 'Limpiar',
                          icon: Icons.cleaning_services_rounded,
                          color: Colors.orange,
                          onPressed: () {
                            setState(() {
                              amount = '0.00'; // Reinicia el amount a 0.00
                            });
                          },
                        ),
                      ),
                      const SizedBox(width: 8.0),
                      Expanded(
                        child: ActionButton(
                          label: 'Aceptar',
                          icon: Icons.check,
                          color: Colors.green,
                          onPressed: () {
                            Navigator.pop(context, amount);
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  void _updateAmount(String input) {
    setState(() {
      if (input == 'delete') {
        if (amount.length > 1) {
          amount = amount.substring(0, amount.length - 1);
        } else {
          amount = '0.00';
        }
      } else {
        if (amount == '0.00') {
          amount = input == '.' ? '0.' : input;
        } else {
          // Evitar múltiples puntos decimales
          if (input == '.' && amount.contains('.')) return;
          amount += input;
        }
        // Limitar a dos decimales
        final parts = amount.split('.');
        if (parts.length > 1) {
          final decimalPart = parts[1];
          if (decimalPart.length > 2) {
            amount = '${parts[0]}.${decimalPart.substring(0, 2)}';
          }
        }
        // Limitar a 14 enteros
        if (parts[0].length > 14) {
          amount =
              '${parts[0].substring(0, 14)}.${parts.length > 1 ? parts[1] : '00'}';
        }
      }
    });
  }
}
