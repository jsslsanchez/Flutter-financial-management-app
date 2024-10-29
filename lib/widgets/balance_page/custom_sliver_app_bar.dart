import 'package:flutter/material.dart';

class CustomSliverAppBar extends StatelessWidget {
  const CustomSliverAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return const SliverAppBar(
      elevation: 0.0,
      expandedHeight: 120.0,
      // backgroundColor: Colors.blue,
      flexibleSpace: FlexibleSpaceBar(
        background: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '\$ 50,000.00',
              style: TextStyle(color: Colors.green, fontSize: 30.0),
            ),
            Text(
              'Balance',
              style: TextStyle(fontSize: 14.0),
            ),
          ],
        ),
      ),
    );
  }
}