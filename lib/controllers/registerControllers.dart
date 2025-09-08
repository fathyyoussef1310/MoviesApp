import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:moviesapproute/core/routes_manager/routesManager.dart';
import '../utils/api_endpoint.dart';

class RegisterController extends GetxController {
  var isLoading = false.obs;

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final phoneController = TextEditingController();

  Future<void> register(int avatarId) async {
    isLoading.value = true;

    final url = Uri.parse(ApiEndpoints.baseUrl + ApiEndpoints.auth.register);

    Map<String, dynamic> body = {
      "name": nameController.text.trim(),
      "email": emailController.text.trim(),
      "password": passwordController.text.trim(),
      "confirmPassword": confirmPasswordController.text.trim(),
      "phone": phoneController.text.trim(),
      "avaterId": avatarId
    };

    print("📤 Sending body: $body");

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(body),
      );

      print("📥 Status Code: ${response.statusCode}");
      print("📥 Response: ${response.body}");

      if (response.statusCode == 201 || response.statusCode == 200) {
        Get.snackbar("Success", "User registered successfully",
            backgroundColor: Colors.green, colorText: Colors.white);
        Get.offAllNamed(RoutesManager.loginScreen);
      } else {
        final res = jsonDecode(response.body);
        Get.snackbar("Error", res["message"].toString(),
            backgroundColor: Colors.red, colorText: Colors.white);
      }
    } catch (e) {
      Get.snackbar("Error", e.toString(),
          backgroundColor: Colors.red, colorText: Colors.white);
    } finally {
      isLoading.value = false;
    }
  }
}
