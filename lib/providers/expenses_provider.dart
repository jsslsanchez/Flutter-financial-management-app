import 'package:calc_app/models/features_model.dart';
import 'package:calc_app/providers/db_features.dart';
import 'package:flutter/foundation.dart';

class ExpensesProvider extends ChangeNotifier {
  List<FeaturesModel> flist = [];

  Future<void> addNewFeature(String category, String color, String icon) async {
    final newFeature =
        FeaturesModel(category: category, color: color, icon: icon);
    final id = await DBFeatures.db.addNewFeature(newFeature);
    newFeature.id = id;
    flist.add(newFeature);
    notifyListeners();
  }

  Future<void> getAllFeatures() async {
    final response = await DBFeatures.db.getAllFeatures();
    flist = [...response];
    notifyListeners();
  }
}
