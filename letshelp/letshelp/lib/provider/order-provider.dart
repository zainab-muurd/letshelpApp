import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:letshelp/models/order.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../helper/App_Bass.dart';

class OrderProvider with ChangeNotifier {
  List<Order> allOrder = [];
  var responseData;
  var url;
  late Response response;
  String? _token;
  SharedPreferences? _prefs;
  bool isOrdersGet = false;
  bool responseOrder = false;
  String? filedMessage;

  TextEditingController messageForOrderResponse = TextEditingController();
  final messageForm = GlobalKey<FormState>();
  int? orderResponseCode;
  int? statusCodeAddOrder;
  TextEditingController productName = TextEditingController();
  TextEditingController country = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController productDescription = TextEditingController();
  TextEditingController reason = TextEditingController();
  final addOrderForm = GlobalKey<FormState>();

  Future<void> getAllOrders({int? orderId}) async {


    String apiPath = "/api/orders";
    if (orderId != null) {
      print("object");
      apiPath = "/api/orders/$orderId/show";
    } else {
      apiPath = "/api/orders";
    }
    isOrdersGet = false;
    notifyListeners();
    allOrder.clear();

    try{
      final _prefs = await SharedPreferences.getInstance();
      final _token = _prefs.get("userToken");
      final header = {
        "Accept": "application/json",
        "Authorization": "Bearer $_token",
      };
      url = Uri.https(APP_BASE_URL1, apiPath);
      response = await http.get(url, headers: header);
      print("Orders Status Code is : ${response.statusCode}");
      print("Orders Response is : ${response.body}");
      if (response.statusCode == 200) {
        responseData = jsonDecode(response.body);
        for (var order in responseData) {
          print("the single order is : $order");
          allOrder.add(Order(
              orderID: order['id'] as int,
              title: order['title'],
              description: order['description'],
              country: order["country"],
              city: order['city'],
              clientName: order['client'],
              clientImage: order['client_image'],
              address: order['address'],
              category: order["category"],
              date: order['date']));
        }
        isOrdersGet = true;
        notifyListeners();
      }
      else {
        print("the status code of  get all order is ${response.statusCode}");
      }
    }catch (e){
      print("an error has been happen while getting all orders $e ");
    }




  }

  Future<void> orderResponse(int orderId) async {
    responseOrder = false;
    notifyListeners();
    _prefs = await SharedPreferences.getInstance();
    Map<String, String> para = {'message': '${messageForOrderResponse.text}'};
    _token = _prefs!.getString('userToken');
    url = Uri.https(APP_BASE_URL1, "/api/orders/$orderId/response-order", para);

    try{
      response = await http.post(url, headers: {
        'Authorization': "Bearer $_token",
        'Accept': 'Accept application/json'
      });
      orderResponseCode = response.statusCode;
      if (response.statusCode == 200) {
        print("the task of order response has been end");
        responseOrder = true;
        messageForOrderResponse.clear();
        notifyListeners();
      }
      else {
        print(" there are an error in response order  task");
        print(response.statusCode);
        print(response.body);
        responseData = jsonDecode(response.body);
        print(responseData);
        filedMessage = responseData[0]['messages']['failedMessage'];
        responseOrder = true;
        notifyListeners();
      }

    }catch(e){
      print ("an error has been happen while getting order response $e");

    }



  }

  Future<void> addOrder() async {
    _prefs = await SharedPreferences.getInstance();
    _token = _prefs!.getString('userToken');
    Map<String, String> queryParam = {
      'title': this.productName.text,
      'description': this.productDescription.text,
      'category_id': "1",
      'country': this.country.text,
      'city': this.city.text,
      'address': this.address.text
    };
    url = Uri.https(APP_BASE_URL1, '/api/orders/store', queryParam);

    Map<String, String> headers = {
      'Authorization': "Bearer $_token",
      "Accept": "application/json"
    };

    try{
    response = await http.post(url, headers: headers);

    if (response.statusCode != 200) {
      print(response.statusCode);
      print("Errrrrrrrrrrrrrrrrrrrrrrrrrrrrror in add order");
      statusCodeAddOrder = response.statusCode;
      print(responseData);
      filedMessage = responseData[0]['messages']['failedMessage'];
      notifyListeners();
      responseData = jsonDecode(response.body);
      print(responseData);
    }
    if (response.statusCode == 200) {
      statusCodeAddOrder = 200;

      notifyListeners();
      cleanOrderForm();
      var responseData = jsonDecode(response.body);
      print(" response of add order  body Json is :  $responseData");
    }

    }catch(e){
    print("an error has been happen while adding order  $e");

    }


  }

  void cleanOrderForm() {
    productName.clear();
    country.clear();
    city.clear();
    address.clear();
    productDescription.clear();
    reason.clear();
    notifyListeners();
  }
}
