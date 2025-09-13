import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../core/routes_manager/routesManager.dart';
import '../utils/api_endpoint.dart';

class ForgetPasswordController  extends GetxController{
  var isLoading=false.obs;
  TextEditingController Newone=TextEditingController();
  TextEditingController oldone=TextEditingController();
  Future<void>ResetPass()async{
    isLoading.value = true;
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token");
    final url = Uri.parse(ApiEndpoints.baseUrl + ApiEndpoints.auth.Forgetpass);
    Map<String,dynamic>body= {
      "oldPassword": oldone.text.trim(),
      "newPassword": Newone.text.trim(),
    };
    print("📤 Sending body: $body");
    try {
      final response = await http.patch(url,
        headers: {"Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
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