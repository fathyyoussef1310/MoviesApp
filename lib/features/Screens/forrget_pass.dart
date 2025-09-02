import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moviesapproute/core/colors_manager/colorsManager.dart';
import 'package:moviesapproute/core/widgets/custom_elevated_button.dart';
import 'package:moviesapproute/core/widgets/custom_text_form_fied.dart';

import '../../core/image_manager/imagesManager.dart';

class ForrgetPass extends StatelessWidget {
  const ForrgetPass({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.darkBlack,
      appBar: AppBar(
          title: Text("Forget Password",
            style: GoogleFonts.inter(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: ColorsManager.yellow,
          ),),
          centerTitle: true,
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(
          color: ColorsManager.yellow, 
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: REdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(child: Image.asset(ImagesManager.forrgetPassImage)
              ),
              SizedBox(height: 10.h),
              CustomTextFormField(hint: "Email", prefixIcon: Icons.email),
              SizedBox(height: 20.h),
              CustomElevatedButton(
                onPressed: () {},
                title: "Verify Email",
                backgroundColor: ColorsManager.yellow,
                foregroundColor: ColorsManager.darkBlack,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
