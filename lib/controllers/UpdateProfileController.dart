import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:moviesapproute/core/colors_manager/colorsManager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../core/routes_manager/routesManager.dart';
import '../utils/api_endpoint.dart';

class UpdateProfileController extends GetxController {
  var isLoading = false.obs;
  var selectedAvatarId = 1.obs;
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  Future<void> updateProfile() async {
    isLoading.value = true;
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? "";
    final url = Uri.parse(ApiEndpoints.baseUrl + ApiEndpoints.auth.UpdateProfile);
    Map<String, dynamic> body = {
      "name": nameController.text.trim(),
      "email": emailController.text.trim(),
      "phone": phoneController.text.trim(),
      "avatarId": selectedAvatarId.value
    };
    try {
      final response = await http.patch(url,
        headers: {"Content-Type": "application/json", "Authorization": "Bearer $token"},
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        Get.snackbar("Success", "User Profile updated successfully",
            backgroundColor: Colors.green, colorText: ColorsManager.white);
        Get.offAllNamed(RoutesManager.Layout);
      } else {
        final res = jsonDecode(response.body);
        Get.snackbar("Error", res["message"].toString(), backgroundColor: Colors.red, colorText: Colors.white);
      }
    } catch (e) {
      Get.snackbar("Error", e.toString(), backgroundColor: Colors.red, colorText: Colors.white);
    } finally {
      isLoading.value = false;
    }
  }
}
