import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';

import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:letshelp/models/single-message.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../helper/App_Bass.dart';
import '../models/message-person.dart';

class MessagesProvider with ChangeNotifier {
  var responseData;
  var url;
  late Response response;
  String? _token;
  SharedPreferences? _prefs;
  bool isLoading = true;
  bool isMessageChose = false;
  bool isFirsTime = false;
  int? messageId;
  String? name;
  String? image;
  ScrollController scrollController = ScrollController();
  ScrollController singleChildScroll = ScrollController();

  List<MessagePerson> messagePerson = [];
  List<SingleMessage> singleMessage = [];
  TextEditingController messageTosend = TextEditingController();
  Timer? timerFotSingleConversation;
  bool? isTimerOn = false;

  Future<void> getAllMessages() async {
    isLoading = true;
    singleMessage.clear();
    isMessageChose = false;
    notifyListeners();

    try {
      _prefs = await SharedPreferences.getInstance();
      _token = _prefs!.getString('userToken');
      url = Uri.https(APP_BASE_URL1, 'api/messages');
      response = await http.get(url, headers: {
        'Accept': 'Application/json',
        'Authorization': "Bearer $_token"
      });

      if (response.statusCode == 200) {
        print(response.body);
        responseData = json.decode(response.body);
        print("json data : ${responseData}");

        messagePerson.clear();
        for (Map<String, dynamic> item in responseData) {
          print(" item is : $item");
          messagePerson.add(MessagePerson(
              name: item['name'],
              imageUrl: item['image'],
              id: int.parse(item['id'])));
        }
        print(" pessssons are :   $messagePerson");
        isLoading = false;
        isFirsTime = true;
        notifyListeners();
      }
    } catch (e) {
      print("an  error has been happen while getting all messages $e ");
    }
  }

  Future<void> getConversationById(int id) async {
    isMessageChose = false;
    isFirsTime = false;
    isTimerOn = false;
    notifyListeners();
    try {
      _prefs = await SharedPreferences.getInstance();
      Map<String, dynamic> queryParams = {"user_id": '$id'};
      _token = _prefs!.getString('userToken');
      url = Uri.https(APP_BASE_URL1, 'api/messages/show', queryParams);
      response = await http.get(url, headers: {
        'Accept': 'Application/json',
        'Authorization': "Bearer $_token"
      });
      responseData = jsonDecode(response.body);
      if (response.statusCode == 200) {
        print(response.body);
        singleMessage.clear();
        for (Map<String, dynamic> item in responseData) {
          singleMessage.add(SingleMessage(
              message: item['message'],
              id: int.parse(item['id']),
              isSender: item['isSender']));
        }
        isMessageChose = true;
        isTimerOn = true;
        notifyListeners();
        timerFotSingleConversation =
            Timer.periodic(Duration(seconds: 5), (t) async {
          isTimerOn = true;
          url = Uri.https(APP_BASE_URL1, 'api/messages/latest', queryParams);
          response = await http.get(url, headers: {
            'Accept': 'Application/json',
            'Authorization': "Bearer $_token"
          });
          if (response.statusCode == 200) {
            responseData = jsonDecode(response.body);
            if (responseData[0]["success"] == true) {
              for (Map<String, dynamic> item in responseData[0]["data"]) {
                print(" item is : $item");
                singleMessage.add(SingleMessage(
                    message: item['message'],
                    id: item['id'],
                    isSender: item['isSender']));
                notifyListeners();
              }
            }
          }
        });
      } else {
        //handle another status code  values
      }
    } catch (e) {
      print("an error has been happen while getting conversation by id : $e");
    }
  }

  Future<void> sendMessage() async {
    try {
      _prefs = await SharedPreferences.getInstance();
      Map<String, dynamic> queryParams = {
        "user_id": '$messageId',
        "message": '${messageTosend.text}'
      };

      _token = _prefs!.getString('userToken');
      url = Uri.https(APP_BASE_URL1, 'api/messages/store', queryParams);
      response = await http.post(url, headers: {
        'Accept': 'Application/json',
        'Authorization': "Bearer $_token"
      });
      responseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        if (responseData[0]["success"] = true) {
          print("the message has bess saved successfully");
          singleMessage.add(SingleMessage(
              message: messageTosend.text, id: messageId, isSender: true));
          print("the number of message ${singleMessage.length}");
          messageTosend.text = '';
          notifyListeners();
        }
      } else {
        print(response.statusCode);
        print(response.body);
      }
    } catch (e) {
      print("an  error has been  happen while  send message  $e");
    }
  }

  void scrollDown() {
    scrollController.animateTo(
      scrollController.position.maxScrollExtent,
      curve: Curves.easeOut,
      duration: const Duration(seconds: 2),
    );
    singleChildScroll.animateTo(
      singleChildScroll.position.maxScrollExtent,
      curve: Curves.easeOut,
      duration: const Duration(milliseconds: 0),
    );
  }

  Future<bool> editBackButton() async {
    if (isTimerOn == true) {
      print("timer off now");
      isTimerOn = false;
      timerFotSingleConversation!.cancel();
      notifyListeners();
      return true;
    } else
      return true;
  }
}
