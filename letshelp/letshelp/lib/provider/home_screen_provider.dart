import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../helper/App_Bass.dart';
import '../widgets/itemavalbl.dart';

class HomeScreenProvider with ChangeNotifier {
  int cateId = 0;
  List<ItemAvalbl>? items = [];
  TextEditingController country = TextEditingController();
  TextEditingController productName = TextEditingController();
  int? categoryForFilter;
  bool? isCategoryChose;
  bool? isDateChose;
  String? date;
  int? catId;
  bool isFirstTime = true;
  var url;
  Map<String, dynamic>? para;
  bool gettingItems = true;

  Future<void> getitemsavailable({int? page}) async {
    gettingItems = true;
    notifyListeners();
    SharedPreferences _prefs = await SharedPreferences.getInstance();

    try {
      final String? _token = await _prefs.getString("token");

      if (cateId == 0) {
        if (isFirstTime == true) {
          items!.clear();
        }
        final url = Uri.parse(APP_BASE_URL + '/api/items?page=$page');
        final response = await http.get(
          url,
          headers: {
            "Accept": "application/json",
            "Authorization": "Bearer $_token"
          },
        );
        if (response.statusCode != 200) {
          return;
        }

        if (cateId != 0) {
          items!.clear();
          isFirstTime = false;
        }

        // if (page == 1) {
        //   items!.clear();
        // }

        final responseData = json.decode(response.body);

        for (var item in responseData) {
          items!.add(ItemAvalbl(
            id: item['id'],
            name: item['name'],
            Icon: item['icon'],
            category: item['category'],
          ));
        }
        gettingItems = false;
        notifyListeners();
      } else {
        final url = Uri.parse(APP_BASE_URL + '/api/items?category_id=$cateId');

        final response = await http.get(
          url,
          headers: {
            "Accept": "application/json",
            "Authorization": "Bearer $_token"
          },
        );

        if (response.statusCode != 200) {
          print("Error fetching data");
          gettingItems = false;
          notifyListeners();
        }

        print("Response is ${response.body}");
        final responseData = json.decode(response.body);
        for (var item in responseData) {
          items!.add(ItemAvalbl(
            id: item['id'],
            name: item['name'],
            Icon: item['icon'],
            category: item['category'],
          ));
        }
        print("data fetched successfully");
        gettingItems = false;
        notifyListeners();
      }
    } catch (e) {
      gettingItems = false;
      notifyListeners();
    }
  }

  Future<void> filterProduct() async {
    try {
      if (isDateChose == true) {
        para = {'category_id ': categoryForFilter};
      }

      url = Uri.https(APP_BASE_URL1, '/api/items', para);
      final response = await http.post(
        url,
        headers: {"Accept": "application/json"},
      );
      if (response.statusCode == 200) {
        print("Response is ${response.body}");
        items!.clear();
        final responseData = json.decode(response.body);
        print(responseData);
        for (var item in responseData) {
          items!.add(ItemAvalbl(
            id: item['id'],
            name: item['name'],
            Icon: item['icon'],
            category: item['category'],
          ));
        }
        print("data fetched  from search  successfully");
        notifyListeners();
      } else {
        print("data fetched  from search  successfully");
        print(response.statusCode);
        notifyListeners();
      }
    } catch (e) {
      print("an error has been happen do filtering  $e   ");
    }
  }
}
