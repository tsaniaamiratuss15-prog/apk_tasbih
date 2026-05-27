import 'dart:convert';
import 'package:http/http.dart'
as http;

class AuthService {

  static const String baseUrl =
      "http://10.0.2.2:8000/api";

  // REGISTER
  static Future<Map<String, dynamic>>
  register({
    required String name,
    required String email,
    required String password,
  }) async {
 
    final response =
        await http.post(

      Uri.parse(
          "$baseUrl/register"),

      headers: {
        "Accept":
        "application/json",
      },

      body: {
        "name": name,
        "email": email,
        "password": password,
      },
    );

    return jsonDecode(
        response.body);
  }

  // LOGIN
  static Future<Map<String, dynamic>>
  login({
    required String email,
    required String password,
  }) async {

    final response =
        await http.post(

      Uri.parse(
          "$baseUrl/login"),

      headers: {
        "Accept":
        "application/json",
      },

      body: {
        "email": email,
        "password": password,
      },
    );

    return jsonDecode(
        response.body);
  }
}