import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moviesapproute/core/colors_manager/colorsManager.dart';
import 'package:moviesapproute/core/image_manager/imagesManager.dart';
import '../../core/routes_manager/routesManager.dart';
import '../../core/widgets/custom_text_form_fied.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  int selectedIndex =
      0; //// Looks More usability than original one in Ui ////هتبدا من اول افتار عادي يعني ////
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
      body: SingleChildScrollView(
        child: Padding(
          padding: REdgeInsets.symmetric(horizontal: 10.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
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
                            color: selectedIndex == index
                                ? ColorsManager.yellow
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
              SizedBox(height: 3.sp),
              Text(
                "Avatar",
                style: TextStyle(color: Colors.white, fontSize: 20.sp),
              ),
              SizedBox(height: 12.h),
              CustomTextFormField(
                hint: 'Name',
                prefixIcon: Icons.badge_outlined,
              ),
              SizedBox(height: 12.h),
              CustomTextFormField(
                hint: 'Email',
                prefixIcon: Icons.email,
              ),
              SizedBox(height: 12.h),
              CustomTextFormField(
                hint: 'Password',
                prefixIcon: Icons.lock,
                suffixIcon: Icons.visibility_off,
              ),
              SizedBox(height: 12.h),
              CustomTextFormField(
                hint: 'Confirm Password',
                prefixIcon: Icons.lock,
                suffixIcon: Icons.visibility_off,
              ),
              SizedBox(height: 12.h),
              CustomTextFormField(
                hint: 'Phone',
                prefixIcon: Icons.phone,
              ),
              SizedBox(height: 12.h),
              ElevatedButton(
                onPressed: () {
                  ///HomeScreen
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
                    "Don't have one ?",
                    style: GoogleFonts.roboto(
                      color: ColorsManager.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, RoutesManager.loginScreen);
                    },
                    child: Text(
                      "Login",
                      style: GoogleFonts.roboto(
                        color: ColorsManager.yellow,
                        fontWeight: FontWeight.w500,
                        fontSize: 20.sp,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      // change to English
                    },
                    child: CircleAvatar(
                      radius: 20,
                      backgroundImage: AssetImage(ImagesManager.EG),
                    ),
                  ),
                  SizedBox(width: 16),
                  InkWell(
                    onTap: () {
                      // change to Arabic
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
