import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moviesapproute/core/colors_manager/colorsManager.dart';
import 'package:moviesapproute/core/image_manager/imagesManager.dart';
import 'package:moviesapproute/core/routes_manager/routesManager.dart';
import '../../controllers/loginControllers.dart';
import '../../core/widgets/custom_text_form_fied.dart';
class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final LoginController loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.darkBlack,
      body: SingleChildScrollView(
        child: Padding(
          padding: REdgeInsets.symmetric(horizontal: 10.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 60.h),
              Image.asset(ImagesManager.MovieIcon),
              SizedBox(height: 60.h),
              CustomTextFormField(
                controller: loginController.emailController,
                prefixIcon: Icons.email,
                hint: 'Email',
              ),
              SizedBox(height: 20.h),

              CustomTextFormField(
                controller: loginController.passwordController,
                prefixIcon: Icons.lock,
                hint: 'Password',
              ),
              SizedBox(height: 10.h),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, RoutesManager.forgetPass);
                  },
                  child: Text(
                    "Forget Password?",
                    style: GoogleFonts.roboto(
                      color: ColorsManager.yellow,
                      fontSize: 14.sp,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.h),

              // Login button with loading indicator
              Obx(() => ElevatedButton(
                onPressed: loginController.isLoading.value ? null : () {
                  loginController.loginWithEmail();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorsManager.yellow,
                  padding: EdgeInsets.symmetric(
                      vertical: 16.h, horizontal: 100.w),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                child: loginController.isLoading.value
                    ? const CircularProgressIndicator(
                  color: Colors.black,
                )
                    : Text(
                  "Login",
                  style: TextStyle(
                    color: ColorsManager.darkBlack,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )),
              SizedBox(height: 20.h),

              // Register link
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account?",
                    style: GoogleFonts.roboto(
                        color: ColorsManager.white, fontSize: 14.sp),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(
                          context, RoutesManager.registerScreen);
                    },
                    child: Text(
                      "Create One",
                      style: GoogleFonts.roboto(
                        color: ColorsManager.yellow,
                        fontSize: 14.sp,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.h),

              Row(
                children: [
                  Expanded(
                    child: Divider(
                      color: ColorsManager.yellow,
                      thickness: 1,
                      endIndent: 7.w,
                    ),
                  ),
                  Text(
                    "OR",
                    style: TextStyle(
                        color: ColorsManager.yellow, fontSize: 16.sp),
                  ),
                  Expanded(
                    child: Divider(
                      color: ColorsManager.yellow,
                      thickness: 1,
                      indent: 10.w,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.h),

              ElevatedButton(
                onPressed: () {
                  // TODO: Google Sign-in Logic
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorsManager.yellow,
                  padding:
                  EdgeInsets.symmetric(vertical: 16.h, horizontal: 40.w),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      ImagesManager.IconGoogle,
                      height: 24.h,
                      width: 24.w,
                    ),
                    SizedBox(width: 10.w),
                    Text(
                      "Login with Google",
                      style: TextStyle(
                        color: ColorsManager.darkBlack,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.h),

              // Language Switch
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      // TODO: change to English
                    },
                    child: CircleAvatar(
                      radius: 20,
                      backgroundImage: AssetImage(ImagesManager.EG),
                    ),
                  ),
                  SizedBox(width: 16),
                  InkWell(
                    onTap: () {
                      // TODO: change to Arabic
                    },
                    child: CircleAvatar(
                      radius: 20,
                      backgroundImage: AssetImage(ImagesManager.AR),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
