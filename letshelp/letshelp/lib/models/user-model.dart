import 'package:letshelp/utils/user_type_enums.dart';

class UserModel {
  String? token;
  String? name;
  UserType? userType;

  UserModel({this.token, this.name, this.userType}) {}

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        token: json[0]["data"][0]['token'],
        name: json[0]["data"][0]['name'],
      );

  Map<String, dynamic> toJson() => {
        'userAut': {
          'token': '${this.token}',
          'name': '${this.name}',
          'userType': "${this.userType}"
        }
      };
}
