import 'package:flutter/material.dart';
import 'package:calc_app/utils/icon_list.dart';

extension ColorExtension on String {
  toColor() {
    String hexColor = replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF$hexColor';
    }
    if (hexColor.length == 8) {
      return Color(int.parse('0x$hexColor'));
    }
  }
}

extension IconExtension on String {
  toIcon() {
    return IconList().iconMap[this];
  }
}
