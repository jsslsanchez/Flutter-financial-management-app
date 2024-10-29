import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;
  final VoidCallback onPressed;

  const ActionButton({
    super.key,
    required this.label,
    required this.icon,
    required this.color,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor:
              const Color.fromRGBO(0, 0, 0, 0), // Fondo transparente
          foregroundColor: color, // Color del texto e ícono
          shape: RoundedRectangleBorder(
            side: BorderSide(color: color.withOpacity(0.3)), // Borde sutil
            borderRadius: BorderRadius.circular(30.0),
          ),
          padding: const EdgeInsets.symmetric(vertical: 15.0),
          elevation: 0, // Sin sombra
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 24.0, color: color),
            const SizedBox(width: 8.0),
            Text(
              label,
              style: TextStyle(
                fontSize: 16.0,
                color: color, // Color del texto
              ),
            ),
          ],
        ),
      ),
    );
  }
}
