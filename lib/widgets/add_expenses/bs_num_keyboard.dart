import 'package:calc_app/models/combined_model.dart';
import 'package:calc_app/widgets/action_buttom.dart';
import 'package:flutter/material.dart';
import 'amount_display.dart';
import 'num_pad.dart';

class BsNumKeyboard extends StatefulWidget {
  final CombinedModel cModel;
  const BsNumKeyboard({super.key, required this.cModel});

  @override
  State<BsNumKeyboard> createState() => _BsNumKeyboardState();
}

class _BsNumKeyboardState extends State<BsNumKeyboard> {
  String amount = '0.00';

  @override
  void initState() {
    amount =
        widget.cModel.amount.toStringAsFixed(2); // cModel.amount inicializado
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _showNumPad,
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: [
            const Text('Cantidad Ingresada'),
            AmountDisplay(amount: amount), // Muestra la cantidad ingresada
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
            NumPad(onValueSelected: _updateAmount), // Muestra el NumPad
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
                              amount = '0.00'; // Reinicia el valor a 0.00
                              widget.cModel.amount =
                                  double.tryParse(amount) ?? 0.00;
                            });
                            Navigator.pop(context);
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
                              amount = '0.00'; // Limpia el valor ingresado
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
                            Navigator.pop(
                                context, amount); // Acepta el valor actual
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
          amount = amount.substring(
              0, amount.length - 1); // Elimina el último carácter
        } else {
          amount = '0.00'; // Si solo queda un dígito, reinicia el valor
        }
      } else {
        if (amount == '0.00') {
          amount = input == '.' ? '0.' : input; // Maneja el primer input
        } else {
          // Evita múltiples puntos decimales
          if (input == '.' && amount.contains('.')) return;
          amount += input; // Añade el valor ingresado
        }

        // Limita a dos decimales
        final parts = amount.split('.');
        if (parts.length > 1) {
          final decimalPart = parts[1];
          if (decimalPart.length > 2) {
            amount =
                '${parts[0]}.${decimalPart.substring(0, 2)}'; // Limita los decimales
          }
        }

        // Limita a 14 dígitos enteros
        if (parts[0].length > 14) {
          amount =
              '${parts[0].substring(0, 14)}.${parts.length > 1 ? parts[1] : '00'}';
        }
      }

      // Asigna el valor actualizado al CombinedModel
      widget.cModel.amount = double.tryParse(amount) ?? 0.00;
    });
  }
}
