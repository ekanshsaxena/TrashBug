import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:trashbug/models/user.dart';
import 'package:trashbug/utils/constants/values.dart';

class AuthService {
  String authUrl = baseApiUrl;
  Future login(String username, String password) async {
    Map data = {'username': username, 'password': password};
    var jsonResponse;
    final response = await http.post(Uri.encodeFull(authUrl + "api/token/"),
        body: json.encode(data), headers: {"Content-Type": "application/json"});
    print("response sent");
    print(response.statusCode);
    if (response.statusCode == 200 || response.statusCode == 400) {
      jsonResponse = jsonDecode(response.body);
    }
    if (jsonResponse != null &&
        jsonResponse['refresh'] != null &&
        jsonResponse['access'] != null) {
      User user = User(username: username, pass: password);
      return true;
    } else if (jsonResponse != null && jsonResponse['detail'] != null) {
      throw Exception("Credentials incorrect");
    } else {
      throw Exception("Some error occurred");
    }
  }

  Future signUp(String email, String pass, String name) async {
    Map data = {
      'username': email,
      'password': pass,
      'email': "",
      'first_name': name,
      'last_name': ""
    };
    var jsonResponse;
    final response = await http.post(
        Uri.encodeFull(authUrl + "account/api/register/"),
        body: json.encode(data),
        headers: {"Content-Type": "application/json"});
    print("response sent");
    print(response.statusCode);
    if (response.statusCode == 200) {
      jsonResponse = jsonDecode(response.body);
    } else if (response.statusCode == 400 ||
        response.statusCode == 401 ||
        response.statusCode == 402)
      throw Exception(jsonDecode(response.body)['detail']);
    if (jsonResponse != null &&
        jsonResponse['refresh'] != null &&
        jsonResponse['access'] != null) {
      User user = User(email: email, pass: pass);
      return true;
    } else {
      throw Exception("Some error occurred");
    }
  }
}
