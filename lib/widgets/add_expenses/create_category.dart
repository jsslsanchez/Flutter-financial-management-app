import 'package:calc_app/models/features_model.dart';
import 'package:calc_app/providers/expenses_provider.dart';
import 'package:calc_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';
import 'package:provider/provider.dart';

class CreateCategory extends StatefulWidget {
  final FeaturesModel fModel;

  const CreateCategory({super.key, required this.fModel});

  @override
  State<CreateCategory> createState() => _CreateCategoryState();
}

class _CreateCategoryState extends State<CreateCategory> {
  @override
  Widget build(BuildContext context) {
    final flist = context.watch<ExpensesProvider>().flist;
    final viewInsets = MediaQuery.of(context).viewInsets.bottom;
    Iterable<FeaturesModel> contain;
    contain = flist.where((e) =>
        e.category.toLowerCase() == widget.fModel.category.toLowerCase());

    addCategory() {
      if (contain.isNotEmpty) {
        // Ya existe la categoría
      } else if (widget.fModel.category.isNotEmpty) {
        // Se puede guardar
      } else {
        // Debe dar nombre a la categoría
      }
    }

    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(bottom: viewInsets),
            child: ListTile(
              trailing: const Icon(
                Icons.text_fields_outlined,
                size: 35.0,
              ),
              title: TextFormField(
                textAlign: TextAlign.center,
                textAlignVertical: TextAlignVertical.center,
                initialValue: widget.fModel.category,
                decoration: InputDecoration(
                  hintText: 'Nombra una categoría',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
              ),
            ),
          ),
          ListTile(
            onTap: () => selectColor(),
            trailing: const CircleColor(
              color: Colors.red,
              circleSize: 35.0,
            ),
            title: Container(
              padding: const EdgeInsets.all(18.0),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Theme.of(context).cardColor,
                ),
                borderRadius: BorderRadius.circular(30.0),
              ),
              child: const Center(
                child: Text('Color'),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              addCategory();
            },
            child: const Text('Done'),
          )
        ],
      ),
    );
  }

  selectColor() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            MaterialColorPicker(
              selectedColor: widget.fModel.color.toColor(),
              physics: const NeverScrollableScrollPhysics(),
              circleSize: 50.0,
              onColorChange: (Color color) {
                var hexColor =
                    '#${color.value.toRadixString(16).substring(2, 8)}';
                setState(() {
                  widget.fModel.color = hexColor;
                });
              },
            ),
          ],
        );
      },
    );
  }
}
