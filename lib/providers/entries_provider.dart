import 'dart:convert';

import 'package:calc_app/models/entries_model.dart';
import 'package:calc_app/providers/db_entries.dart';
import 'package:flutter/foundation.dart';
import 'package:calc_app/models/combined_model.dart';
import 'package:calc_app/models/features_model.dart';
import 'package:calc_app/providers/db_features.dart';

class EntriesProvider extends ChangeNotifier {
  List<FeaturesModel> flist = [];
  List<EntriesModel> eList = [];
  List<CombinedModel> cList = [];

  //---------------------Insert Functions -----------------------------

  addNewFeature(FeaturesModel newFeature) async {
    final id = await DbFeatures.db.addNewFeature(newFeature);
    newFeature.id = id;
    flist.add(newFeature);
    notifyListeners();
  }

  addNewEntrie(CombinedModel cModel) async {
    var entrieses = EntriesModel(
        link: cModel.link,
        year: cModel.year,
        month: cModel.month,
        day: cModel.day,
        comment: cModel.comment,
        entrie: cModel.amount);
    final id = await DbEntries.db.addEntrie(entrieses);
    entrieses.id = id;
    eList.add(entrieses);
    notifyListeners();
  }

  //--------------------------Read Functions----------------------------

  getAllFeatures() async {
    final response = await DbFeatures.db.getAllFeatures();
    flist = [...response];
    notifyListeners();
  }

  getEntrieByDate(int month, int year) async {
    final response = await DbEntries.db.getEntrieByDate(month, year);
    eList = [...response];
    notifyListeners();
  }

  //------------------------Edit Functions --------------------

  updateFeatures(FeaturesModel features) async {
    await DbFeatures.db.updateFeatures(features);
    getAllFeatures();
  }

  updateEntrie(CombinedModel cModel) async {
    var entrieses = EntriesModel(
        id: cModel.id,
        link: cModel.link,
        year: cModel.year,
        month: cModel.month,
        day: cModel.day,
        comment: cModel.comment,
        entrie: cModel.amount);
    await DbEntries.db.updateEntries(entrieses);
    notifyListeners();
  }

  //------------------------Delete Functions---------------------------

  deleteEntrie(int id) async {
    await DbEntries.db.deleteEntries(id);
    notifyListeners();
  }

  //-----------------------Getters to combined List---------------------

  List<CombinedModel> get allItemsList {
    List<CombinedModel> cModel = [];

    for (var x in eList) {
      for (var y in flist) {
        if (x.link == y.id) {
          cModel.add(CombinedModel(
              category: y.category,
              color: y.color,
              icon: y.icon,
              id: x.id,
              amount: x.entrie,
              comment: x.comment,
              year: x.year,
              month: x.month,
              day: x.day));
        }
      }
    }
    return cList = [...cModel];
  }

  List<CombinedModel> get groupItemList {
    List<CombinedModel> cModel = [];

    for (var x in eList) {
      for (var y in flist) {
        if (x.link == y.id) {
          double amount = eList
              .where((e) => e.link == y.id)
              .fold(0.0, (a, b) => a + b.entrie);
          cModel.add(CombinedModel(
            category: y.category,
            color: y.color,
            icon: y.icon,
            amount: amount,
          ));
        }
      }
    }
    var encode = cModel.map((e) => jsonEncode(e));
    var unique = encode.toSet();
    var result = unique.map((e) => jsonDecode(e));
    cModel = result.map((e) => CombinedModel.fromJson(e)).toList();

    return cList = [...cModel];
  }
}
