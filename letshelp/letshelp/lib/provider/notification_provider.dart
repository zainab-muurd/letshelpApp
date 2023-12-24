import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:letshelp/helper/App_Bass.dart';
import 'package:http/http.dart' as http;
import 'package:letshelp/models/single-porduct.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/notification_model.dart';

class NotificationProv with ChangeNotifier {
  List<NotificationModel> notifications = [];

  bool gettingNotifications = false;
  bool reOrderNotifications = false;
  List<String>? imagesForProduct = [];

  Future<void> getAllNotifications() async {
    try {
      notifyListeners();
      SharedPreferences sp = await SharedPreferences.getInstance();
      final token = sp.get('userToken');

      final url = Uri.https(APP_BASE_URL1, "/api/notifications");

      final response = await http.get(
        url,
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer $token"
        },
      );

      if (response.statusCode == 200) {
        notifications.clear();

        final jsonData = jsonDecode(response.body);
        print(jsonData);
        if (jsonData.length != 0) {
          for (var json in jsonData) {
            notifications.add(NotificationModel.FromJson(json));
          }

          gettingNotifications = true;
          reOrderNotifications = false;
          notifyListeners();
        } else {
          gettingNotifications = true;
          reOrderNotifications = true;
          notifyListeners();
        }
      } else {
        gettingNotifications = false;
        reOrderNotifications = true;
        notifyListeners();
      }
    } catch (e) {
      print("an error has been happen while getting all notifications $e ");
    }
  }

  Future<SingleProduct?> type5Notification(int id) async {
    try {
      final SingleProduct? singleProduct;
      print("get notification item");
      final _prefs = await SharedPreferences.getInstance();
      final _token = _prefs.getString("userToken");

      final url = Uri.https(APP_BASE_URL1, '/api/items/$id/show');

      final response = await http.get(
        url,
        headers: {
          "Accept": "Application/json ",
          "Authorization": "Bearer $_token"
        },
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        if (responseData[0]["images"].length != 0) {
          for (var url in responseData[0]["images"]) {
            imagesForProduct!.add(url['path']);
          }
        }

        singleProduct = SingleProduct(
            id: responseData[0]['id'] as int,
            title: responseData[0]['title'],
            description: responseData[0]['description'],
            mainImage: responseData[0]['mainImage'],
            clientName: responseData[0]['clientName'],
            clientImage: responseData[0]['clientImage'],
            category: responseData[0]['cateagory'],
            country: responseData[0]['country'],
            city: responseData[0]['city'],
            address: responseData[0]['address'],
            images: imagesForProduct);
        return singleProduct;
      }

      if (response.statusCode == 204) {
        singleProduct = null;
        return singleProduct;
      }
    } catch (e) {
      print("an error has been happen while getting notification type 5   $e");
    }
    return null;
  }
}
