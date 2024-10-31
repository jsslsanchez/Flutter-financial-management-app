import 'package:flutter/material.dart';
import 'package:calc_app/pages/balance_page.dart';
import 'package:calc_app/pages/charts_page.dart';
import 'package:calc_app/providers/ui_provider.dart';
import 'package:calc_app/providers/expenses_provider.dart';
import 'package:calc_app/widgets/home_page/custom_navigation_bar.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      bottomNavigationBar: CustomNavigationBar(),
      body: _HomePage(),
    );
  }
}

class _HomePage extends StatelessWidget {
  const _HomePage();

  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UIProvider>(context);
    final exProvider = Provider.of<ExpensesProvider>(context, listen: false);
    final DateTime date = DateTime.now();

    final currentIndex = uiProvider.bnbIndex;
    final currentMonth = uiProvider.selectedMonth + 1;

    switch (currentIndex) {
      case 0:
        exProvider.getExpenseByDate(currentMonth, date.year);
        exProvider.getAllFeatures();
        exProvider.getAllFeatures();
        return const BalancePage();
      case 1:
        return const ChartsPage();
    }
    return const BalancePage();
  }
}
