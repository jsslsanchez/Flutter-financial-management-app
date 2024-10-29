import 'package:flutter/material.dart';
import 'package:calc_app/models/combined_model.dart';
import 'package:calc_app/models/features_model.dart';
import 'package:calc_app/providers/expenses_provider.dart';
import 'package:calc_app/utils/constants.dart';
import 'package:calc_app/utils/utils.dart';
import 'package:calc_app/widgets/add_expenses/admin_category.dart';
import 'package:calc_app/widgets/add_expenses/category_list.dart';
import 'package:calc_app/widgets/add_expenses/create_category.dart';
import 'package:provider/provider.dart';

class BsCategory extends StatefulWidget {
  final CombinedModel cModel;
  const BsCategory({super.key, required this.cModel});

  @override
  State<BsCategory> createState() => _BsCategoryState();
}

class _BsCategoryState extends State<BsCategory> {
  var catList = CategoryList().catList;
  final FeaturesModel fModel = FeaturesModel();
  @override
  void initState() {
    var exProvider = context.read<ExpensesProvider>();
    if (exProvider.flist.isEmpty) {
      for (FeaturesModel feature in catList) {
        exProvider.addNewFeature(feature);
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final featureList = context.watch<ExpensesProvider>().flist;
    bool hasData = false;

    if (widget.cModel.category != 'Selecciona Categoría') {
      hasData = true;
    }
    return GestureDetector(
      onTap: () {
        categorySelected(featureList);
      },
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Row(
          children: [
            const Icon(Icons.category_outlined, size: 35.0),
            const SizedBox(width: 12.0),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                    border: Border.all(
                        width: 1.7,
                        color: (hasData)
                            ? widget.cModel.color.toColor()
                            : Theme.of(context).dividerColor),
                    borderRadius: BorderRadius.circular(30.0)),
                child: Center(
                  child: Text(widget.cModel.category),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  categorySelected(List<FeaturesModel> flist) {
    void itemSelected(String category, String color, int link) {
      setState(() {
        widget.cModel.link = link;
        widget.cModel.category = category;
        widget.cModel.color = color;
        Navigator.pop(context);
      });
    }

    var widgets = [
      ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: flist.length,
          itemBuilder: (_, i) {
            var item = flist[i];
            return ListTile(
              leading: Icon(
                item.icon.toIcon(),
                color: item.color.toColor(),
                size: 35.0,
              ),
              title: Text(item.category),
              trailing: const Icon(
                Icons.arrow_forward_ios,
                size: 20.0,
              ),
              onTap: () {
                itemSelected(item.category, item.color, item.id!);
              },
            );
          }),
      const Divider(
        thickness: 2.0,
      ),
      ListTile(
          leading: const Icon(Icons.create_new_folder_outlined, size: 35.0),
          title: const Text('Crear nueva Categoría'),
          trailing: const Icon(Icons.arrow_forward_ios, size: 20.0),
          onTap: () {
            Navigator.pop(context);
            createNewCategory();
          }),
      ListTile(
        leading: const Icon(Icons.edit_outlined, size: 35.0),
        title: const Text('Administrar Categoría'),
        trailing: const Icon(Icons.arrow_forward_ios, size: 20.0),
        onTap: () {
          Navigator.pop(context);
          adminCategory();
        },
      )
    ];
    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(25.0))),
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return SizedBox(
            height: MediaQuery.of(context).size.height / 1.6,
            child: ListView(
              children: widgets,
            ),
          );
        });
  }

  createNewCategory() {
    var features = FeaturesModel(
        id: fModel.id,
        category: fModel.category,
        color: fModel.color,
        icon: fModel.icon);
    showModalBottomSheet(
        shape: Constants.bottomSheet(),
        isScrollControlled: true,
        isDismissible: false,
        context: context,
        builder: (context) => CreateCategory(
              fModel: features,
            ));
  }

  adminCategory() {
    showModalBottomSheet(
        shape: Constants.bottomSheet(),
        isDismissible: false,
        context: context,
        builder: (context) => const AdminCategory());
  }
}
