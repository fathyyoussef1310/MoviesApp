import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moviesapproute/controllers/ForgetpasswordController.dart';

import '../../core/colors_manager/colorsManager.dart';
import '../../core/image_manager/imagesManager.dart';
import '../../core/widgets/custom_elevated_button.dart';
import '../../core/widgets/custom_text_form_fied.dart';

class ForgetPassword extends StatefulWidget {
  ForgetPassword({super.key});
  final ForgetPasswordController forgetPasswordController =
  Get.put(ForgetPasswordController());

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.darkBlack,
      appBar: AppBar(
        title: Text("Reset Password",
            style: GoogleFonts.inter(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: ColorsManager.yellow)),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: ColorsManager.yellow),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: REdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(child: Image.asset(ImagesManager.forrgetPassImage)),
              SizedBox(height: 20.h),
              CustomTextFormField(
                controller: widget.forgetPasswordController.oldone,
                hint: "Old Password",
                prefixIcon: Icons.lock_outline,
              ),
              SizedBox(height: 20.h),
              CustomTextFormField(
                controller: widget.forgetPasswordController.Newone,
                hint: "New Password",
                prefixIcon: Icons.lock,
              ),
              SizedBox(height: 20.h),
              CustomTextFormField(
                controller:
                widget.forgetPasswordController.Newone,
                hint: "Confirm Password",
                prefixIcon: Icons.lock,
              ),
              SizedBox(height: 20.h),
              Obx(
                    () => CustomElevatedButton(
                  onPressed: widget.forgetPasswordController.isLoading.value
                      ? null
                      : () async {
                    await widget.forgetPasswordController.ResetPass();
                  },
                  title: widget.forgetPasswordController.isLoading.value
                      ? "Loading..."
                      : "Reset Password",
                  backgroundColor: ColorsManager.yellow,
                  foregroundColor: ColorsManager.darkBlack,
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
