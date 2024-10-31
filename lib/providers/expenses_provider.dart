import 'package:calc_app/models/combined_model.dart';
import 'package:calc_app/models/expenses_model.dart';
import 'package:calc_app/models/features_model.dart';
import 'package:calc_app/providers/db_expenses.dart';
import 'package:calc_app/providers/db_features.dart';
import 'package:flutter/foundation.dart';

class ExpensesProvider extends ChangeNotifier {
  List<FeaturesModel> flist = [];
  List<ExpensesModel> eList = [];
  List<CombinedModel> cList = [];

  addNewFeature(FeaturesModel newFeature) async {
    final id = await DBFeatures.db.addNewFeature(newFeature);
    newFeature.id = id;
    flist.add(newFeature);
    notifyListeners();
  }

  addNewExpense(CombinedModel cModel) async {
    var expenses = ExpensesModel(
        link: cModel.link,
        year: cModel.year,
        month: cModel.month,
        day: cModel.day,
        comment: cModel.comment,
        expense: cModel.amount);
    final id = await DbExpenses.db.addExpense(expenses);
    expenses.id = id;
    eList.add(expenses);
    notifyListeners();
  }

  getAllFeatures() async {
    final response = await DBFeatures.db.getAllFeatures();
    flist = [...response];
    notifyListeners();
  }

  getExpensesByDate(int month, int year) async {
    final response = await DbExpenses.db.getExpenseByDate(month, year);
    eList = [...response];
    notifyListeners();
  }

  updateFeatures(FeaturesModel features) async {
    await DBFeatures.db.updateFeatures(features);
    getAllFeatures();
  }

  updateExpense(CombinedModel cModel) async {
    var expenses = ExpensesModel(
        id: cModel.id,
        link: cModel.link,
        year: cModel.year,
        month: cModel.month,
        day: cModel.day,
        comment: cModel.comment,
        expense: cModel.amount);
    await DbExpenses.db.updateExpenses(expenses);
    notifyListeners();
  }
}
