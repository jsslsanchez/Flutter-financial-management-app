import 'package:flutter/material.dart';
import 'package:calc_app/models/features_model.dart';
import 'package:calc_app/providers/expenses_provider.dart';
import 'package:calc_app/utils/constants.dart';
import 'package:calc_app/utils/icon_list.dart';
import 'package:calc_app/utils/utils.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class CreateCategory extends StatefulWidget {
  final FeaturesModel fModel;
  const CreateCategory({super.key, required this.fModel});

  @override
  State<CreateCategory> createState() => _CreateCategoryState();
}

class _CreateCategoryState extends State<CreateCategory> {
  bool hasData = false;
  String stcCategory = "";
  @override
  void initState() {
    if (widget.fModel.id != null) {
      hasData = true;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final fList = context.watch<ExpensesProvider>().flist;
    final exProvider = context.read<ExpensesProvider>();
    final viewInsets = MediaQuery.of(context).viewInsets.bottom;
    Iterable<FeaturesModel> contain;
    contain = fList.where((e) =>
        e.category.toLowerCase() == widget.fModel.category.toLowerCase());
    addCategory() {
      if (contain.isNotEmpty) {
        //Ya existe la categoría
        Fluttertoast.showToast(
            msg: 'Ya existe la categoría',
            backgroundColor: Colors.red,
            fontSize: 20.0,
            gravity: ToastGravity.CENTER);
      } else if (widget.fModel.category.isNotEmpty) {
        exProvider.addNewFeature(widget.fModel);
        Fluttertoast.showToast(
            msg: 'Categoría creada con exito',
            backgroundColor: Colors.green,
            fontSize: 20.0,
            gravity: ToastGravity.CENTER);
        Navigator.pop(context);
      } else {
        Fluttertoast.showToast(
            msg: 'No olvides nombrar una categoría',
            backgroundColor: Colors.red,
            fontSize: 20.0,
            gravity: ToastGravity.CENTER);
      }
    }

    editCategory() {
      if (widget.fModel.category.toLowerCase() == stcCategory.toLowerCase()) {
        //Puede editar
        exProvider.updateFeatures(widget.fModel);
        Fluttertoast.showToast(
            msg: 'Categoría editada',
            backgroundColor: Colors.green,
            fontSize: 20.0,
            gravity: ToastGravity.CENTER);
        Navigator.pop(context);
      } else if (contain.isNotEmpty) {
        //Ya existe la categoria
        Fluttertoast.showToast(
            msg: 'Ya existe la categoria',
            backgroundColor: Colors.red,
            fontSize: 20.0,
            gravity: ToastGravity.CENTER);
      } else if (widget.fModel.category.isNotEmpty) {
        exProvider.updateFeatures(widget.fModel);
        Fluttertoast.showToast(
            msg: 'Categoría editada',
            backgroundColor: Colors.green,
            fontSize: 20.0,
            gravity: ToastGravity.CENTER);
        Navigator.pop(context);
        //Procede a editar cambios
      } else {
        //Debe dar nombre a la categoria
        Fluttertoast.showToast(
            msg: 'No olvides nombrar una categoria',
            backgroundColor: Colors.red,
            fontSize: 20.0,
            gravity: ToastGravity.CENTER);
      }
    }

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
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
                              borderRadius: BorderRadius.circular(30.0))),
                      onChanged: (value) {
                        setState(() {
                          widget.fModel.category = value;
                        });
                      }),
                )),
            ListTile(
              onTap: () => selectColor(),
              trailing: CircleColor(
                color: widget.fModel.color.toColor(),
                circleSize: 35.0,
              ),
              title: Container(
                  padding: const EdgeInsets.all(18.0),
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Theme.of(context).cardColor,
                      ),
                      borderRadius: BorderRadius.circular(30.0)),
                  child: const Center(
                    child: Text('Color'),
                  )),
            ),
            ListTile(
              onTap: () => selectIcon(),
              trailing: Icon(
                widget.fModel.icon.toIcon(),
                size: 35.0,
              ),
              title: Container(
                  padding: const EdgeInsets.all(18.0),
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Theme.of(context).cardColor,
                      ),
                      borderRadius: BorderRadius.circular(30.0)),
                  child: const Center(
                    child: Text('Icono'),
                  )),
            ),
            Row(
              children: [
                Expanded(
                    child: GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Constants.customButton(
                            Colors.transparent, Colors.red, 'Cancelar'))),
                Expanded(
                  child: GestureDetector(
                      onTap: () => {(hasData) ? editCategory() : addCategory()},
                      child: Constants.customButton(
                          Colors.green, Colors.transparent, 'Aceptar')),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  selectColor() {
    showModalBottomSheet(
        shape: Constants.bottomSheet(),
        isDismissible: false,
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
              GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Constants.customButton(
                      Colors.green, Colors.transparent, 'Listo'))
            ],
          );
        });
  }

  selectIcon() {
    final iconList = IconList().iconMap;
    showModalBottomSheet(
        shape: Constants.bottomSheet(),
        isDismissible: false,
        context: context,
        builder: (context) {
          return SizedBox(
              child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 5),
                  itemCount: iconList.length,
                  itemBuilder: (context, i) {
                    var key = iconList.keys.elementAt(i);
                    return GestureDetector(
                      child: Icon(
                        key.toIcon(),
                        size: 30.0,
                        color: Theme.of(context).dividerColor,
                      ),
                      onTap: () {
                        setState(() {
                          widget.fModel.icon = key;
                          Navigator.pop(context);
                        });
                      },
                    );
                  }));
        });
  }
}
