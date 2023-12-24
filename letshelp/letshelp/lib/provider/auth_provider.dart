import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart';
import 'package:letshelp/models/user-model.dart';
import 'package:letshelp/utils/user_type_enums.dart';
import '../helper/App_Bass.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Auth with ChangeNotifier {
  int genderInitVal = 0;
  String? messageAfterRegister;
  bool isLoading = false;
  String? contactEmail;
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController passwordConfirm = TextEditingController();
  TextEditingController address = TextEditingController(text: " العنوان");

  String? registerErrorMessage;
  String? loginMessagesError;

  TextEditingController acoountName = TextEditingController();

  final GoogleSignIn googleSignIn = GoogleSignIn(scopes: []);

  TextEditingController email_login = TextEditingController();
  TextEditingController password_login = TextEditingController();

  SharedPreferences? _prefs;
  var responseData;
  var url;
  bool isSignedUp = false;
  late Response response;
  String? userNameAfterAuth;
  String? tokenAfterAuth;
  String? failedMessage;
  bool? isAuth;
  String? token;

  UserModel user = UserModel(token: null, name: null, userType: null);

  String? country;
  String? city;
  String? street;
  bool isRegisterLoading = false;
  bool showReSendCodeButton = false;

  /////// complete Profile Vars /////////
  TextEditingController fullNameContoller = TextEditingController();
  TextEditingController emaillController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameContoller = TextEditingController();
  TextEditingController phoneNumberCotroller = TextEditingController();
  TextEditingController genderController = TextEditingController(text: "ذكر");
  TextEditingController cityName = TextEditingController();
  TextEditingController countryName = TextEditingController();
  TextEditingController streetName = TextEditingController();

  String completeProfileMessage = '';

  /////// complete Profile Vars /////////
  Future<void> login() async {
    try {
      final result = await InternetAddress.lookup('$APP_BASE_URL1');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('connected');
        isLoading = true;
        notifyListeners();
        Map<String, dynamic> queryParam = {
          'email': this.email_login.text.trim(),
          'password': this.password_login.text.trim(),
        };

        url = Uri.https(APP_BASE_URL1, 'api/login', queryParam);
        try {
          response =
              await http.post(url, headers: {'Accept': 'Application/json'});
          final responseData = json.decode(response.body);
          print("$responseData");

          if (response.statusCode == 200) {
            if (responseData[0]["success"] == false) {
              isAuth = false;
              isLoading = false;
              loginMessagesError = responseData[0]["messages"]['failedMessage'];
              notifyListeners();
              return;
            } else if (responseData[0]["success"] == true) {
              if (responseData[0]['data'][0]["mustVerifyEmail"] == true) {
                user = UserModel(
                  token: responseData[0]["data"][0]['token']!,
                  name: responseData[0]["data"][0]['name']!,
                  userType: UserType.needVerifyEmail,
                );
                isLoading = false;
                isAuth = false;
                notifyListeners();

                return;
              } else if (responseData[0]['data'][0]["mustCompleteProfile"] ==
                  true) {
                user = UserModel(
                  token: responseData[0]["data"][0]['token']!,
                  name: responseData[0]["data"][0]['name']!,
                  userType: UserType.needCompleteProfile,
                );
                fullNameContoller.text = user.name.toString();
                emaillController.text =
                    responseData[0]["data"][0]['email']!.toString();
                token = user.token!;
                isLoading = false;
                isAuth = null;
                loginMessagesError = "الرجاء اكمال الملف الشخصي";
                notifyListeners();
                return;
              } else if (responseData[0]['data'][0]["mustVerifyEmail"] ==
                  false) {
                user = UserModel(
                  token: responseData[0]["data"][0]['token']!,
                  name: "user",
                  userType: UserType.user,
                );
                final Map<String, dynamic> userJson = user.toJson();
                String encodeUser = json.encode(userJson);
                _prefs = await SharedPreferences.getInstance();
                _prefs!.setString('user', encodeUser);
                _prefs!.setString('token', user.token!);

                email_login.clear();
                password_login.clear();
                isLoading = false;
                isAuth = true;
                notifyListeners();
                return;
              }
            }
          } else if (response.statusCode == 422) {
            loginMessagesError = '';
            final responseJson = json.decode(response.body);
            Map<String, dynamic> errors = responseJson['errors'];
            List values = errors.values.toList();
            for (var messages in values) {
              for (var message in messages) {
                loginMessagesError = loginMessagesError! + "," + message;
              }
            }
            isLoading = false;
            notifyListeners();
          } else {
            isRegisterLoading = false;
            loginMessagesError = "خطأ غير معروف";
            print(loginMessagesError);
            notifyListeners();
          }
        } catch (e) {
          isLoading = false;
          isAuth = false;
          notifyListeners();
          print("exception has been happend ${e}");
        }
      }
    } on SocketException catch (_) {
      isAuth = null;
      loginMessagesError = "الرجاء التحقق من الإتصال";
    }
  }

  Future<bool> resendCode() async {
    try {
      print("the token is : ${user.token}");
      final url = Uri.https(APP_BASE_URL1, '/api/resend-email');
      final response = await http.post(url, headers: {
        "Accept": "application/json",
        "Authorization": "Bearer ${user.token}"
      });
      if (response.statusCode == 200) {
        return true;
      } else {
        print(response.statusCode);
        print(json.decode(response.body));
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<bool> signup() async {
    try {
      final result = await InternetAddress.lookup('$APP_BASE_URL1');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('connected');
        isRegisterLoading = true;
        notifyListeners();

        Map<String, dynamic> queryParam = {
          'name': acoountName.text,
          'email': email.text,
          'user_password': password.text.trim(),
          'user_password_confirm': passwordConfirm.text.trim(),
        };

        try {
          final url = Uri.https(APP_BASE_URL1, '/api/register', queryParam);
          final response =
              await http.post(url, headers: {"Accept": "application/json"});
          responseData = json.decode(response.body);
          if (response.statusCode == 200) {
            if (responseData[0]["success"] == false) {
              registerErrorMessage =
                  responseData[0]['messages']['failedMessage'].toString();
              isRegisterLoading = false;
              notifyListeners();
              return false;
            }
            final responseJson = json.decode(response.body);
            showReSendCodeButton = true;
            isRegisterLoading = false;
            user = UserModel(
                token: responseJson[0]['data'][0]['token'],
                name: "new",
                userType: UserType.needVerifyEmail);
            notifyListeners();
            return true;
          } else if (response.statusCode == 422) {
            registerErrorMessage = '';
            final responseJson = json.decode(response.body);
            Map<String, dynamic> errors = responseJson['errors'];
            List values = errors.values.toList();
            for (var messages in values) {
              for (var message in messages) {
                registerErrorMessage = registerErrorMessage! + "," + message;
              }
            }
            isRegisterLoading = false;
            notifyListeners();
            return false;
          } else {
            isRegisterLoading = false;
            registerErrorMessage = "خطأ غير معروف";
            notifyListeners();
            return false;
          }
        } catch (e) {
          isRegisterLoading = false;
          notifyListeners();
          print(e);
          return false;
        }
      }
    } on SocketException catch (_) {
      print('not connected');
      registerErrorMessage = "تحقق من الاتصال لديك ";
      return false;
    }
    registerErrorMessage = " خطأ غير معروف";
    return false;
  }

  Future<void> loadTokenFromPrefs() async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    token = sh.getString('token');
    if (token != null) {
      final String? encodeUser = sh.getString('user');
      Map<String, dynamic> userMap = json.decode(encodeUser!);
      user = UserModel(
          token: userMap["userAut"]['token'],
          name: userMap["userAut"]["name"],
          userType: UserType.user);
    }

    notifyListeners();
  }

  Future<void> googleLogin(String token) async {
    final queryParam = {"token": "$token"};
    final url = Uri.https(APP_BASE_URL1, '/api/login/google', queryParam);

    try {
      final response = await http.post(url);
      final responseData = json.decode(response.body);

      if (response.statusCode == 200) {
        if (responseData[0]["success"] == true) {
          user = UserModel(
            token: responseData[0]["data"][0]['token']!,
            name: "user",
            userType: UserType.user,
          );
          final Map<String, dynamic> userJson = user.toJson();
          String encodeUser = json.encode(userJson);
          _prefs = await SharedPreferences.getInstance();
          _prefs!.setString('user', encodeUser);
          _prefs!.setString('token', user.token!);
          email_login.clear();
          password_login.clear();
          isLoading = false;
          notifyListeners();
        } else {
          isLoading = false;
          notifyListeners();
        }
      } else {
        print(json.decode(response.body));
        if (responseData[0]["success"] == false) {
          isAuth = false;
          isLoading = false;
          notifyListeners();
        } else {
          print(json.decode(response.body));
        }
      }
    } catch (e) {}
  }

  Future<void> logOut() async {
    try {
      await googleSignIn.signOut();
    } catch (e) {}

    final _prefs = await SharedPreferences.getInstance();
    await _prefs.clear();
    token = null;
    notifyListeners();
  }

  void genderChanger(int val) {
    genderInitVal = val;
    print("the value of gender is : $genderInitVal");
    notifyListeners();
  }

  void signUpFormClean() {
    firstName.clear();
    lastName.clear();
    email.clear();
    phone.clear();
    password.clear();
    passwordConfirm.clear();
    address.clear();
  }

  Future<void> loginAsGuest() async {
    final _prefs = await SharedPreferences.getInstance();
    await _prefs.clear();
    isAuth = false;
    user = UserModel(
      token: "",
      name: "guest",
      userType: UserType.guest,
    );
    notifyListeners();
  }

  void setLocationValues(Map<String, String> info) {
    country = info["country"];
    city = info["city"];
    street = info["street"];
    address.text = "${country}-${city}-${street}";
    notifyListeners();
  }

  Future<bool> completeProfile() async {
    try {
      Map<String, String> body = {
        "user_name": fullNameContoller.text,
        "first_name": firstNameController.text,
        "last_name": lastNameContoller.text,
        "email": emaillController.text,
        "gender": genderController.text == "انثى" ? "1" : "0",
        "country": countryName.text,
        "city": cityName.text,
        "address": streetName.text
      };
      Map<String, String> headers = {
        "Accept": "application/json",
        "Authorization": "Bearer ${user.token}"
      };

      final url = Uri.https(APP_BASE_URL1, '/api/profile/complete');

      final res = await http.post(url, body: body, headers: headers);

      print(json.decode(res.body));

      if (res.statusCode == 200) {
        completeProfileMessage = "تمت العملية بنجاح";
        return true;
      } else {
        completeProfileMessage = "حدث خطأ ما";
        return false;
      }
    } catch (e) {
      completeProfileMessage = "حدث خطأ ما";
      return false;
    }
  }
}
