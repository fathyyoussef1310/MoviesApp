import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moviesapproute/core/colors_manager/colorsManager.dart';
import 'package:moviesapproute/core/image_manager/imagesManager.dart';
import 'package:moviesapproute/core/routes_manager/routesManager.dart';
import '../../core/widgets/custom_text_form_fied.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

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
              SizedBox(height: 40.h,),
              Image.asset(ImagesManager.MovieIcon),
              SizedBox(height: 60.h,),
              CustomTextFormField(
                prefixIcon: Icons.email,
                hint: 'Email',
              ),
              SizedBox(height: 22.4.h,),
              CustomTextFormField(
                prefixIcon: Icons.lock,
                hint: 'Password',
              ),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context , RoutesManager.forgetPass);
                  },
                  child: Text(
                    "Forget Password ?",
                    style: GoogleFonts.roboto(
                      color: ColorsManager.yellow,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30.h,),
              ElevatedButton(
                onPressed: (){
                  ///HomeScreen
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorsManager.yellow,
                  padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 100.w),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                child: Text("Login", style: TextStyle(color: ColorsManager.darkBlack, fontWeight: FontWeight.bold,),),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have one ?",style: GoogleFonts.roboto(color: ColorsManager.white,fontSize: 12.sp,fontWeight: FontWeight.w500),),
                  TextButton(onPressed: (){
                    Navigator.pushNamed(context, RoutesManager.registerScreen);
                  }, child:Text("Create One",style: GoogleFonts.roboto(color: ColorsManager.yellow),))
                ],
              ),
              SizedBox(height: 20.h,),
              Row(
                children: [
                  Expanded(child: Divider(color: ColorsManager.yellow, thickness: 1, endIndent: 7.w,)),
                  Text("OR", style: TextStyle(color: ColorsManager.yellow,fontSize: 16.sp),),
                  Expanded(child: Divider(color: ColorsManager.yellow, thickness: 1, indent: 10.w,)),
                ],
              ),
              SizedBox(height: 20.h,),
              ElevatedButton(
                onPressed: (){
                  ///HomeScreen
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorsManager.yellow,
                  padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 40.w),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(ImagesManager.IconGoogle, height: 24.h, width: 24.w,),
                    SizedBox(width: 10.w,),
                    Text("Login with Google", style: TextStyle(color: ColorsManager.darkBlack, fontWeight: FontWeight.bold,),),
                  ],
                ),
              ),
              SizedBox(height: 20.h,),
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
