import 'package:calc_app/widgets/add_entries/bs_category.dart';
import 'package:calc_app/widgets/add_entries/bs_num_keyboard.dart';
import 'package:calc_app/widgets/add_entries/comment_box.dart';
import 'package:calc_app/widgets/add_entries/date_picker.dart';
import 'package:calc_app/widgets/add_entries/save_buttom.dart';
import 'package:flutter/material.dart';
import 'package:calc_app/models/combined_model.dart';
import 'package:calc_app/utils/constants.dart';


class AddEntries extends StatelessWidget {
  const AddEntries({super.key});

  @override
  Widget build(BuildContext context) {
    CombinedModel cModel = CombinedModel();
    return Scaffold(
        appBar: AppBar(
          title: const Text('Agregar Gasto'),
          elevation: 0.0,
        ),
        body: Column(
          children: [
            BsNumKeyboard(cModel: cModel),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: Constants.sheetDecoration(
                    Theme.of(context).primaryColorDark),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    DatePicker(cModel: cModel),
                    BsCategory(cModel: cModel),
                    CommentBox(cModel: cModel),
                    Expanded(child: Center(child: SaveButtom(cModel: cModel)))
                  ],
                ),
              ),
            )
          ],
        ));
  }
}
