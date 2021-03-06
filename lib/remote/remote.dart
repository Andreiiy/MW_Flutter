import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:math_world/models/app_data.dart';
import 'package:math_world/models/user.dart';
import 'package:math_world/remote/responce_from_server.dart';

class Remote {
  final domain = "https://enigmatic-sands-85327.herokuapp.com/api/";
  AppData _appData = AppData();

  //String get authToken => "${_appData.user?.token}";
  String get authToken =>
      "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiIsImtpZCI6IkhTNTEyIn0.eyJpc3MiOiJLbGlrbGFrQXBpIiwiaWF0IjoxNjM4MDE1MzEyLCJ1aWQiOiIwOTNhYWQ2NC05M2I5LTQ5MGYtYjQ3ZC1hMzMyNTEyNDAyNGEiLCJleHAiOjE2MzgxMDE3MTJ9.MVQHM5KRh4sSU5oGtkBxgxluDR1jcdrd5FH5Z4zz47pTJfsm2r-cAl50kcNLUQ1EDMAPn8KLpYfOFptMh66tdw";

  Map<String, String> get headers => {
        //"Content-Type": "application/json",
        //"Accept": "application/json",
        "Authorization": "Bearer $authToken",
      };

  Future<ResponseFromServer> register(String name,String lastName, String password, String country) async {
    var url = Uri.parse("$domain/register");
    print("request  $url");
    //var response = await http.post(url, headers: headers);
    var response = await http.post(url,  body: {'name': name,'last_name': lastName, 'password': password,'country': country});
    if (response.statusCode != 200) {
      throw Exception(
          "Request to $url failed with status ${response.statusCode}: ${response.body}");
    }
    print("response  $url  \n ${json.decode(response.body)}");

    int errorCode = json.decode(response.body)['errorCode'] as int;
    String errorMessage = json.decode(response.body)['errorMessage'] as String;
    if (errorCode == 0)
      return ResponseFromServer(data: json.decode(response.body)['data']);
    else
      return ResponseFromServer(errorCode: errorCode, errorMessage: errorMessage);
  }

  Future<ResponseFromServer> login(String lastName, String password) async {
    var url = Uri.parse("$domain/login");
    print("request  $url");
    var response = await http.post(url, body: {'last_name': lastName,'password': password,});
    if (response.statusCode != 200) {
      throw Exception(
          "Request to $url failed with status ${response.statusCode}: ${response.body}");
    }
    print("response  $url  \n ${json.decode(response.body)}");
    int errorCode = json.decode(response.body)['errorCode'] as int;
    String errorMessage = json.decode(response.body)['errorMessage'] as String;
    if (errorCode == 0)
      return ResponseFromServer(data: json.decode(response.body)['data']);
    else
      return ResponseFromServer(errorCode: errorCode, errorMessage: errorMessage);
  }


}
