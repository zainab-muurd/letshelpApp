import 'dart:convert';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:letshelp/models/single-porduct.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../helper/App_Bass.dart';
import '../models/categories.dart';

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double stat;
  final String image;
  late final bool isStar;
  List<String>? imagesForProduct = [];
  bool isProductRequest = false;
  String? failedMessage;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.stat,
    required this.image,
    required this.isStar,
  });

  void toggleStarStatus() {
    isStar = !isStar;
    notifyListeners();
  }

///////////////////////////////////////////////////////////////////////////////////////////////

  TextEditingController productName = TextEditingController();
  TextEditingController country = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController productDescription = TextEditingController();
  TextEditingController reason = TextEditingController();
  Categories? categoryDropDownValue;
  final sendRequestFormKey = GlobalKey<FormState>();
  final reasonForm = GlobalKey<FormState>();
  var responseData;
  var url;
  late Response response;
  String? _token;
  SharedPreferences? _prefs;
  int current = 0;
  SingleProduct? singleProduct;
  bool getProduct = false;
  int? statusCodeSend;
  final String serverErrorMessage = "حدث خطأ ما ";

  final CarouselController controller = CarouselController();
  indicatorChanger(int index, CarouselPageChangedReason reason) {
    current = index;
    notifyListeners();
  }

  Future<void> addProduct(var image1) async {
    try {
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

      MultipartRequest request = http.MultipartRequest(
        'POST',
        Uri.parse('$APP_BASE_URL/api/items/store'),
      );

      Map<String, String> headers = {
        "Content-type": "multipart/form-data",
        'Authorization': "Bearer $_token",
        "Accept": "application/json"
      };

      request.headers.addAll(headers);
      request.fields.addAll(queryParam);
      request.files.add(
        http.MultipartFile(
          'main_image',
          image1.readAsBytes().asStream(),
          image1.lengthSync(),
          filename: image1.path.split('/').last,
        ),
      );
      request.headers.addAll(headers);
      print("request: " + request.toString());
      var res = await request.send();
      Response response = await http.Response.fromStream(res);
      print(response.body);
      if (response.statusCode != 200) {
        print(response.statusCode);
        print("Errrrrrrrrrrrrrrrrrrrrrrrrrrrrror");
        statusCodeSend = response.statusCode;

        notifyListeners();
        print(response.body);
      }
      statusCodeSend = 200;
      notifyListeners();
    } catch (e) {
      print("an error has been happen while adding new item/product $e ");
    }
  }

  Future<void> getProductById(int id) async {
    getProduct = false;
    singleProduct = null;
    notifyListeners();

    try {
      _prefs = await SharedPreferences.getInstance();
      _token = _prefs!.getString('userToken');

      url = Uri.https(APP_BASE_URL1, '/api/items/$id/show');
      response = await http.get(url, headers: {
        "Accept": "Application/json ",
        "Authorization": "Bearer $_token"
      });

      imagesForProduct!.clear();
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
        getProduct = true;
        notifyListeners();
      } else if (response.statusCode != 200) {
        print("error whit status code ${response.statusCode}");

        notifyListeners();
      }
    } catch (e) {
      singleProduct = null;
      notifyListeners();
      print("an error has been happen while getting single items  $e");
    }
  }

  Future<void> requestForProduct(int id) async {
    isProductRequest = false;
    notifyListeners();
    try {
      _prefs = await SharedPreferences.getInstance();
      _token = _prefs!.getString('userToken');
      Map<String, String> queryParam = {
        'message': this.reason.text,
      };
      url = Uri.https(APP_BASE_URL1, '/api/items/$id/request', queryParam);
      response = await http.post(
        url,
        headers: {'Authorization': "Bearer $_token"},
      );
      print(response.body);
      responseData = json.decode(response.body);
      if (response.statusCode == 200) {
        this.reason.clear();
        isProductRequest = true;
        notifyListeners();
      }

      if (response.statusCode == 422) {
        failedMessage = responseData[0]['messages']["failedMessage"];
        isProductRequest = false;
        this.reason.clear();
        notifyListeners();
      }
    } catch (e) {
      print("an error has been happen while sending order for request $e");
    }
  }

///////////////////////////////////////////////////////////////////////////////////////////////

}
