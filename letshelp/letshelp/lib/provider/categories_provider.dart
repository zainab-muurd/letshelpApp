import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:letshelp/helper/App_Bass.dart';
import 'package:letshelp/models/categories.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class CategoriesProvider with ChangeNotifier {
  final List<Categories> loadedItems = [];
  bool isCategories = false;
  String? listValue;
  String hintList = " اختر الفئة";
  String addProhintList = " اختر الفئة";

  Future<void> getCategories() async {
    loadedItems.clear();

    final _prefs = await SharedPreferences.getInstance();
    String? _tokan = _prefs.getString("userToken");
    try {
      final url = Uri.parse(APP_BASE_URL + '/api/categories');
      final response = await http.get(
        url,
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer $_tokan"
        },
      );
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        for (var unit in responseData) {
          loadedItems.add(Categories(
              id: unit['id'] as int, icon: unit['icon'], name: unit['name']));
        }
        loadedItems.insert(0, Categories(id: 0, name: "الكل", icon: null));
        notifyListeners();
      } else {
        print("${response.statusCode}");
        notifyListeners();
      }
    } catch (e) {
      print("error was happen while get categories $e ");
      notifyListeners();
    }
  }

  int changeCatValue(val) {
    listValue = val;
    // listValue = val ;
    var result = loadedItems.where((element) => element.name == val).toList();
    print(result[0].id);
    notifyListeners();
    return result[0].id as int;
  }

  void changeHint(value) {
    addProhintList = value.name;
    notifyListeners();
  }
}
