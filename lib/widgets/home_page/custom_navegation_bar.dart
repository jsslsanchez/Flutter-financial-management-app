import 'package:flutter/material.dart';
import 'package:calc_app/providers/ui_provider.dart';
import 'package:provider/provider.dart';

class CustomNavegationBar extends StatelessWidget {
  const CustomNavegationBar({super.key});

  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UIProvider>(context);
    return BottomNavigationBar(
      currentIndex: uiProvider.bnbIndex,
      elevation: 0.0, 
      items: const[
      BottomNavigationBarItem(label: 'Balance', icon: Icon(Icons.account_balance_outlined)),
      BottomNavigationBarItem(label: 'Gráficos' , icon: Icon(Icons.bar_chart_outlined)),
      BottomNavigationBarItem(label: 'Configuration' , icon: Icon(Icons.settings)),
    ]);
  }
}
