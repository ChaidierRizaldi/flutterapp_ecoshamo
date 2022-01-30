// @dart=2.7
// ignore_for_file: unused_local_variable, missing_return, unused_import

import 'dart:convert';

import 'package:flutterapp_ecoshamo/models/user_model.dart';
import 'package:http/http.dart' as http;

class AuthService {
  String baseurl = 'https://shamo-backend.co.id';

  Future<UserModel> register({
    String name,
    String username,
    String email,
    String password,
  }) async {
    var url = '$baseurl/register';
    var headers = {'Content-Type': 'application/json'};
    var body = jsonEncode({
      'name': name,
      'username': username,
      'email': email,
      'password': password,
    });

    var response = await http.post(
      url,
      headers: headers,
      body: body,
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      UserModel user = UserModel.fromJson(data['user']);
      user.token = 'Bearer ' + data['access_token'];

      return user;
    } else {
      throw Exception('Gagal Register');
    }
  }
}
