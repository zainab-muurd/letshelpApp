import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:letshelp/models/my-product-req.dart';
import 'package:letshelp/models/profile-model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../helper/App_Bass.dart';
import '../models/order.dart';
import '../models/requestd-item.dart';
import '../widgets/itemavalbl.dart';

class ProfileProvider with ChangeNotifier {
  bool? getProfile = false;
  bool getItems = false;
  bool getOrders = false;
  bool changeRequestStat = false;
  String? successMessage;
  bool isGetRequests = false;
  int? itemIdForUpdate;
  String? _token;
  SharedPreferences? _prefs;
  var responseData;
  var url;
  late Response response;
  ProfileModel? profileModel;
  List<ItemAvalbl> myItems = [];
  List<Order> myOrders = [];
  List<MyProductReq> myRequests = [];
  List<RequestedItem> requestedItem = [];
  String? updateStateMessage;
  bool requestsFilter = true;
  bool getMyRequestedItem = false;
  ScrollController scrollController = ScrollController();
  ScrollController singleChildScroll = ScrollController();

  Future<void> getMyProfile() async {
    getProfile = false;
    _prefs = await SharedPreferences.getInstance();
    _token = _prefs!.getString('userToken');
    url = Uri.https(APP_BASE_URL1, "/api/profile");

    try {
      response = await http.get(url, headers: {
        'Authorization': "Bearer $_token",
        'Accept': 'Accept application/json'
      });

      if (response.statusCode == 200) {
        responseData = jsonDecode(response.body);
        print(responseData);
        profileModel = ProfileModel(
            id: responseData[0]['id'] as int,
            name: responseData[0]['name'],
            registerDate: responseData[0]['register_date'],
            myProducts: responseData[0]['itemsCount'] as int,
            myRequests: responseData[0]['ordersCount'] as int,
            rate: responseData[0]['rate'] as int,
            CompleteOrderRate: responseData[0]['completeOrdersRate'],
            myImage: responseData[0]['image'],
            gender: responseData[0]['gender']);
        getProfile = true;
        notifyListeners();
      } else {
        print("status code ${response.statusCode}");
        print(response.body);
      }
    } catch (e) {
      print("an error happen while getting my profile $e");
    }
  }

  Future<void> getMyItems() async {
    getItems = false;

    _prefs = await SharedPreferences.getInstance();
    _token = _prefs!.getString('userToken');
    url = Uri.https(APP_BASE_URL1, 'api/profile/items');

    try {
      response = await http.get(url, headers: {
        'Authorization': "Bearer $_token",
        'Accept': 'Accept application/json'
      });

      if (response.statusCode == 200) {
        myItems.clear();
        responseData = jsonDecode(response.body);
        print("the items get successfully");
        print(responseData);
        for (var item in responseData) {
          myItems.add(ItemAvalbl(
            id: item['id'],
            name: item['name'],
            Icon: item['icon'],
            category: item['category'],
            isMyItems: true,
          ));
        }
        print("the length of data fetched is :${myItems.length}");
      } else {
        //handle another another status code values
      }
    } catch (e) {
      print("an error has been  happen while get my items $e");
    }
  }

  Future<void> getMyOrder() async {
    getOrders = false;

    try {
      _prefs = await SharedPreferences.getInstance();
      _token = _prefs!.getString('userToken');
      url = Uri.https(APP_BASE_URL1, 'api/profile/orders');
      response = await http.get(url, headers: {
        'Authorization': "Bearer $_token",
        'Accept': 'Accept application/json'
      });

      if (response.statusCode == 200) {
        myOrders.clear();
        responseData = jsonDecode(response.body);
        print("the Orders get successfully");
        print(responseData);
        for (var item in responseData) {
          myOrders.add(Order(
              orderID: item['id'] as int,
              title: item['title'],
              description: item['description'],
              country: item["country"],
              city: item['city'],
              clientName: item['client'],
              clientImage: item['client_image'],
              address: item['address'],
              category: item["category"],
              date: item['date'],
              status: item['status'] as int));
        }
        print("the length of data fetched(orders) is :${myOrders.length}");
        getOrders = true;
        notifyListeners();
      } else {
        //handle others status code values

      }
    } catch (e) {
      print("error has been happen while get my orders $e");
    }
  }

  Future<void> orderStatusUpdate(int orderId) async {
    try {
      _prefs = await SharedPreferences.getInstance();
      _token = _prefs!.getString('userToken');
      url = Uri.https(APP_BASE_URL1, '/api/orders/$orderId/finish');
      response = await http.post(url, headers: {
        'Authorization': "Bearer $_token",
        'Accept': 'Accept application/json'
      });

      if (response.statusCode == 200) {
        responseData = jsonDecode(response.body);
        updateStateMessage = responseData[0]['messages']['successMessage'];
      } else {
        //handle other status code values

      }
    } catch (e) {
      print("an error has been happen while change the  statue of an order $e");
    }
  }

  Future<void> getMyProductsRequests(int itemId) async {
    itemIdForUpdate = itemId;
    isGetRequests = false;
    notifyListeners();

    try {
      _prefs = await SharedPreferences.getInstance();
      _token = _prefs!.getString('userToken');

      url = requestsFilter
          ? Uri.https(APP_BASE_URL1, '/api/profile/items/$itemId/requests')
          : Uri.https(
              APP_BASE_URL1, '/api/profile/items/$itemId/requests/accepted');
      response = await http.get(url, headers: {
        'Authorization': "Bearer $_token",
        'Accept': 'Accept application/json'
      });

      responseData = jsonDecode(response.body);
      if (response.statusCode == 200) {
        myRequests.clear();
        if (responseData.isEmpty) {
          isGetRequests = true;
          notifyListeners();
        }
        for (var request in responseData) {
          myRequests.add(MyProductReq(
              requestId: request['requestId'] as int,
              requestText: request["requestText"],
              requestClient: request["requestClient"],
              requestClientPhone: request["requestClientPhone"],
              requestClientImage: request["requestClientImage"],
              requestStatus: request["requestStatus"] as int));

          isGetRequests = true;
          notifyListeners();
        }
      } else {
        //handle another status code values
        isGetRequests = false;
        notifyListeners();
      }
    } catch (e) {
      print("an error has been happen while  get my products Requests $e");
    }
  }

  Future<void> itemAccept(int requestId) async {
    try {
      _prefs = await SharedPreferences.getInstance();
      _token = _prefs!.getString('userToken');
      url = Uri.https(
          APP_BASE_URL1, '/api/profile/items/requests/$requestId/accept');

      response = await http.post(url, headers: {
        'Authorization': "Bearer $_token",
        'Accept': 'Accept application/json'
      });
      responseData = jsonDecode(response.body);
      if (response.statusCode == 200) {
        successMessage = responseData[0]['messages']['successMessage'];
        changeRequestStat = true;
        notifyListeners();
      }
    } catch (e) {
      print("an error has been happen while accepting item $e ");
    }
  }

  Future<void> iteReject(int requestId) async {
    try {
      _prefs = await SharedPreferences.getInstance();
      _token = _prefs!.getString('userToken');
      url = Uri.https(
          APP_BASE_URL1, '/api/profile/items/requests/$requestId/reject');
      response = await http.post(url, headers: {
        'Authorization': "Bearer $_token",
        'Accept': 'Accept application/json'
      });
      responseData = jsonDecode(response.body);
      if (response.statusCode == 200) {
        print(" the item Reject with response : $responseData");
        successMessage = responseData[0]['messages']['successMessage'];
        changeRequestStat = true;
        notifyListeners();
      }
    } catch (e) {
      print("an error has been happen while rejecting  item $e");
    }
  }

  Future<void> itemCancel(int requestId) async {
    try {
      _prefs = await SharedPreferences.getInstance();
      _token = _prefs!.getString('userToken');
      url = Uri.https(
          APP_BASE_URL1, '/api/profile/items/requests/$requestId/cancel');
      response = await http.post(url, headers: {
        'Authorization': "Bearer $_token",
        'Accept': 'Accept application/json'
      });
      responseData = jsonDecode(response.body);
      if (response.statusCode == 200) {
        print(" the item cancel with response :  $responseData");
        successMessage = responseData[0]['messages']['successMessage'];
        changeRequestStat = true;
        notifyListeners();
      }
    } catch (e) {
      print("an error has been happen while cancel  item $e");
    }
  }

  Future<void> itemFinish(int requestId) async {
    try {
      _prefs = await SharedPreferences.getInstance();
      _token = _prefs!.getString('userToken');
      url = Uri.https(
          APP_BASE_URL1, '/api/profile/items/requests/$requestId/finish');
      response = await http.post(url, headers: {
        'Authorization': "Bearer $_token",
        'Accept': 'Accept application/json'
      });
      responseData = jsonDecode(response.body);
      if (response.statusCode == 200) {
        print(" the item finish with response :  $responseData");
        successMessage = responseData[0]['messages']['successMessage'];
        changeRequestStat = true;
        notifyListeners();
      }
    } catch (e) {
      print("an error has been happen while finish  item $e");
    }
  }

  Future<void> myRequestedItem() async {
    getMyRequestedItem = false;
    notifyListeners();
    try {
      _prefs = await SharedPreferences.getInstance();
      _token = _prefs!.getString('userToken');

      url = Uri.https(APP_BASE_URL1, '/api/profile/requested-items');
      response = await http.get(url, headers: {
        'Authorization': "Bearer $_token",
        'Accept': 'Accept application/json'
      });
      if (response.statusCode == 200) {
        requestedItem.clear();
        responseData = jsonDecode(response.body);
        print("the items get successfully");
        print(responseData);
        for (var item in responseData) {
          requestedItem.add(RequestedItem(
              requestClientPhone: item['requestClientPhone'],
              requestClientImage: item['requestClientImage'],
              requestText: item['requestText'],
              requestId: item['requestId'],
              requestItemClientId: item['requestItemClientId'],
              requestItemClientName: item['requestItemClientName'],
              requestItemImage: item['requestItemImage'],
              requestItemName: item['requestItemName'],
              requestStatus: item['requestStatus']));
          print("${item['requestStatus'] as int}");
        }

        print(
            "the length of data fetched is in requested items :${requestedItem.length}");
        getMyRequestedItem = true;
        notifyListeners();
        print("$responseData");
      } else {
        //handle another status code values

      }
    } catch (e) {
      print("an error has been happen while finish  item $e");
    }
  }

  Future<int> finishRequestedItem(
      String userId, int requestedId, double rate) async {
    try {
      _prefs = await SharedPreferences.getInstance();
      _token = _prefs!.getString('userToken');
      Map<String, dynamic> para = {
        "user_id": "$userId",
        "request_id": "$requestedId",
        "rate": "$rate"
      };

      url = Uri.https(
          APP_BASE_URL1, '/api/profile/requested-items/recived', para);
      response = await http.post(url, headers: {
        'Authorization': "Bearer $_token",
        'Accept': 'Accept application/json'
      });
      responseData = jsonDecode(response.body);
      if (response.statusCode == 200) {
        print("تم انهاء الطلب والتقيم ");
      }
      return response.statusCode;
    } catch (e) {
      print("an erro has been happen while finish requested item $e");
      return 0;
    }
  }
}
