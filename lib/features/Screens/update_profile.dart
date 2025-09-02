import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moviesapproute/core/routes_manager/routesManager.dart';
import 'package:moviesapproute/core/widgets/custom_text_button.dart';

import '../../core/colors_manager/colorsManager.dart';
import '../../core/image_manager/imagesManager.dart';
import '../../core/widgets/custom_elevated_button.dart';
import '../../core/widgets/custom_text_form_fied.dart';

class UpdateProfile extends StatelessWidget {
  const UpdateProfile({super.key});

  @override
  Widget build(BuildContext context) {
    void _onResetPasswordPressed() {
      Navigator.pushNamed(context, RoutesManager.forgetPass);
    }

    return Scaffold(
      backgroundColor: ColorsManager.darkBlack,
      appBar: AppBar(
        title: Text(
          "Pick Avatar",
          style: GoogleFonts.inter(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: ColorsManager.yellow,
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: true,
        elevation: 0,
        backgroundColor: ColorsManager.darkBlack,
      ),
      body: Padding(
        padding: REdgeInsets.symmetric(horizontal: 10.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  padding: REdgeInsets.all(45),
                  child: Image.asset(ImagesManager.User3),
                ),
              ),
              CustomTextFormField(
                hint: "USERNAME",
                prefixIcon: Icons.person,
                keyboardType: TextInputType.name,
              ),
              SizedBox(height: 20.h),
              CustomTextFormField(
                hint: "0120000000",
                prefixIcon: Icons.call,
                keyboardType: TextInputType.name,
              ),
              SizedBox(height: 12.h),
              CustomTextButton(
                title: "Reset Password",
                onPressed: _onResetPasswordPressed,
                color: ColorsManager.yellow,
              ),
              SizedBox(height: 220.h),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  CustomElevatedButton(
                    title: "Delete Account",
                    onPressed: () {},
                    backgroundColor: ColorsManager.red,
                    foregroundColor: ColorsManager.ofwhite,
                  ),
                  SizedBox(height: 12),
                  CustomElevatedButton(
                    title: "Update Data",
                    onPressed: () {},
                    backgroundColor: ColorsManager.yellow,
                    foregroundColor: ColorsManager.darkBlack,
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
