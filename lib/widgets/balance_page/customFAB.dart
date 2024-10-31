import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';


class CustomFAB extends StatelessWidget {
  const CustomFAB({super.key});
  
  get childButtons => null;

  @override
  Widget build (BuildContext context) { 
    List<SpeedDialChild> childbuttons = [];

    childButtons.add(SpeedDialChild( 
      backgroundColor: Colors.red, 
      child: const Icon(Icons.remove), 
      label: "Gasto",
      onTap: () {})); // Speedblalchild
    
    childButtons.add(SpeedDialChild(
      backgroundColor: Colors.green, 
      child: const Icon(Icons.add),
      label: 'Ingreso',
      onTap: () {})); 
    return SpeedDial(
      icon: Icons.add, activeIcon: Icons.close, children: childButtons);
    }
}