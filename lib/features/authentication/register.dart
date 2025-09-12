import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moviesapproute/core/colors_manager/colorsManager.dart';
import 'package:moviesapproute/core/image_manager/imagesManager.dart';
import 'package:moviesapproute/core/routes_manager/routesManager.dart';
import 'package:moviesapproute/core/widgets/custom_text_form_fied.dart';
import '../../controllers/registerControllers.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final RegisterController controller = Get.put(RegisterController());

  int selectedIndex = 0;
  final List<String> avatars = [
    ImagesManager.User1,
    ImagesManager.User2,
    ImagesManager.User3,
    ImagesManager.IconGoogle,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.darkBlack,
      appBar: AppBar(
        backgroundColor: ColorsManager.darkBlack,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: ColorsManager.yellow),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text("Register", style: TextStyle(color: ColorsManager.yellow)),
      ),
      body: Obx(() {
        return Stack(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: REdgeInsets.symmetric(horizontal: 10.h),
                child: Column(
                  children: [
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(
                          avatars.length,
                              (index) => GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedIndex = index;
                              });
                            },
                            child: Container(
                              padding: REdgeInsets.all(4.sp),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: selectedIndex == index ? ColorsManager.yellow
                                      : Colors.transparent,
                                  width: 3,
                                ),
                              ),
                              child: CircleAvatar(
                                radius: 70.r,
                                backgroundImage: AssetImage(avatars[index]),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 12.h),
                    CustomTextFormField(
                      hint: 'Name',
                      controller: controller.nameController,
                      prefixIcon: Icons.badge_outlined,
                    ),
                    SizedBox(height: 12.h),
                    CustomTextFormField(
                      hint: 'Email',
                      controller: controller.emailController,
                      prefixIcon: Icons.email,
                    ),
                    SizedBox(height: 12.h),
                    CustomTextFormField(
                      hint: 'Password//Must Be Looks like(TestNum@)',
                      controller: controller.passwordController,
                      prefixIcon: Icons.lock,
                    ),
                    SizedBox(height: 12.h),
                    CustomTextFormField(
                      hint: 'Confirm Password',
                      controller: controller.confirmPasswordController,
                      prefixIcon: Icons.lock,
                    ),
                    SizedBox(height: 12.h),
                    CustomTextFormField(
                      hint: 'Phone',
                      controller: controller.phoneController,
                      prefixIcon: Icons.phone,
                    ),
                    SizedBox(height: 20.h),
                    ElevatedButton(
                      onPressed: () {
                        controller.register(selectedIndex + 1);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorsManager.yellow,
                        padding: REdgeInsets.symmetric(
                          vertical: 16.h,
                          horizontal: 60.w,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),
                      child: Text(
                        "Create Account",
                        style: GoogleFonts.roboto(
                          color: ColorsManager.darkBlack,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already have an account?",
                          style: GoogleFonts.roboto(
                            color: ColorsManager.white,
                            fontSize: 16.sp,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(
                                context, RoutesManager.loginScreen);
                          },
                          child: Text(
                            "Login",
                            style: GoogleFonts.roboto(
                              color: ColorsManager.yellow,
                              fontSize: 18.sp,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            if (controller.isLoading.value)
              const Center(child: CircularProgressIndicator()),
          ],
        );
      }),
    );
  }
}
