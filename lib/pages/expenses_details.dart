import 'package:calc_app/providers/expenses_provider.dart';
import 'package:flutter/material.dart';
import 'package:calc_app/utils/constants.dart';
import 'package:calc_app/utils/math_operations.dart';
import 'package:calc_app/utils/utils.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

class ExpensesDetails extends StatefulWidget {
  const ExpensesDetails({super.key});

  @override
  State<ExpensesDetails> createState() => _ExpensesDetailsState();
}

class _ExpensesDetailsState extends State<ExpensesDetails> {
  final _scrollController = ScrollController();
  double _offset = 0;

  final Logger _logger = Logger();

  void _listener() {
    setState(() {
      _offset = _scrollController.offset / 100;
      _logger.d(_offset);
    });
  }

  @override
  void initState() {
    _scrollController.addListener(_listener);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_listener);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final exProvider = context.watch<ExpensesProvider>();
    final clist = exProvider.allItemsList;
    //final formatter = NumberFormat("#,##0.00", "de_DE");
    double totalExp = 0.0;

    totalExp = clist.map((e) => e.amount).fold(0.0, (a, b) => a + b);
    if (_offset > 0.85) _offset = 0.85;

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColorDark,
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverAppBar(
            expandedHeight: 125.0,
            title: const Text('Detalle Gastos'),
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Align(
                  alignment: Alignment(_offset, 1),
                  child: Text(getAmountFormat(totalExp))),
              centerTitle: true,
              background: const Align(
                alignment: AlignmentDirectional.bottomCenter,
                child: Text('Total'),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.only(top: 15.0),
              height: 30.0,
              color: Theme.of(context).scaffoldBackgroundColor,
              child: Container(
                decoration: Constants.sheetDecoration(
                    Theme.of(context).primaryColorDark),
              ),
            ),
          ),
          SliverList(
              delegate: SliverChildBuilderDelegate(
            (context, i) {
              var item = clist[i];
              return ListTile(
                leading: Stack(
                  alignment: AlignmentDirectional.center,
                  children: [
                    const Icon(
                      Icons.calendar_today,
                      size: 40.0,
                    ),
                    Positioned(
                      top: 16,
                      child: Text(item.day.toString()),
                    )
                  ],
                ),
                title: Row(
                  children: [
                    Text(item.category),
                    const SizedBox(
                      width: 10.0,
                    ),
                    Icon(
                      item.icon.toIcon(),
                      color: item.color.toColor(),
                      size: 22.0,
                    ),
                  ],
                ),
                subtitle: Text(item.comment),
                trailing: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(getAmountFormat(item.amount),
                        style: const TextStyle(
                            fontSize: 14.0, fontWeight: FontWeight.bold)),
                    Text(
                        '${(100 * item.amount / totalExp).toStringAsFixed(2)}%',
                        style: const TextStyle(fontSize: 13.0)),
                  ],
                ),
              );
            },
            childCount: clist.length,
          ))
        ],
      ),
    );
  }
}
