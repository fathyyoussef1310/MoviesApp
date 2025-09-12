import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../utils/api_endpoint.dart';
import '../features/home/home_screen.dart';

class LoginController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  // Loading state
  var isLoading = false.obs;

  // Login function
  Future<void> loginWithEmail() async {
    var headers = {'Content-Type': 'application/json'};

    try {
      isLoading.value = true;

      var url = Uri.parse(ApiEndpoints.baseUrl + ApiEndpoints.auth.login);

      Map<String, dynamic> body = {
        'email': emailController.text.trim(),
        'password': passwordController.text
      };

      http.Response response =
      await http.post(url, body: jsonEncode(body), headers: headers);

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);

        if (json['data'] != null) {
          var token = json['data'];

          final SharedPreferences prefs = await _prefs;
          await prefs.setString('token', token);

          emailController.clear();
          passwordController.clear();

          Get.snackbar("Success", "Login successful",
              backgroundColor: Colors.green, colorText: Colors.white,
              snackPosition: SnackPosition.BOTTOM);

          Get.offAll(() => HomeScreen());
        } else {
          Get.snackbar(
            "Login Failed",
            json['message'] ?? "Invalid credentials",
            backgroundColor: Colors.red,
            colorText: Colors.white,
            snackPosition: SnackPosition.BOTTOM,
          );
        }
      } else {
        Get.snackbar(
          "Error",
          jsonDecode(response.body)["message"] ?? "Unknown error occurred",
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (error) {
      Get.snackbar(
        "Exception",
        error.toString(),
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }
}
