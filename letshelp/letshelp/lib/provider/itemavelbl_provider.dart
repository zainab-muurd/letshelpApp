import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:letshelp/helper/App_Bass.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/itemavalbl.dart';

class ItemAvailableProvider with ChangeNotifier {
  int? cateId;

  List<ItemAvalbl>? items = [];

  // List<AvilbaleItemsModel> get items{
  //   return[..._items];
  // }

  Future<void> getitemsavailable() async {


    try{
      final _prefs = await SharedPreferences.getInstance();
      String? _token = _prefs.getString('userToken');
      if (cateId == null) {
        items!.clear();
        final url = Uri.parse(APP_BASE_URL + '/api/items');

        final response = await http.get(
          url,
          headers: {
            "Accept": "application/json",
            "Authorization": "Bearer $_token"
          },
        );

        if (response.statusCode != 200) {
          print("Error fetching data");
        }
        items!.clear();
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
        notifyListeners();
      }
      else {
        final url = Uri.parse(APP_BASE_URL + '/api/items?category_id=$cateId');

        final response = await http.get(
          url,
          headers: {"Content-Type": "application/json"},
        );

        if (response.statusCode != 200) {
          print("Error fetching data");
        }
        print(cateId);
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
        notifyListeners();
      }


    }catch(e){
      print ( "an error has been happen while get Available items : $e  ");

    }

  }
}
