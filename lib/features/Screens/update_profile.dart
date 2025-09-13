import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moviesapproute/controllers/UpdateProfileController.dart';
import 'package:moviesapproute/core/routes_manager/routesManager.dart';
import 'package:moviesapproute/core/widgets/custom_text_button.dart';
import 'package:moviesapproute/main_layout/layout_screen.dart';
import '../../core/colors_manager/colorsManager.dart';
import '../../core/image_manager/imagesManager.dart';
import '../../core/widgets/custom_elevated_button.dart';
import '../../core/widgets/custom_text_form_fied.dart';

class UpdateProfile extends StatefulWidget {
  const UpdateProfile({super.key});

  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  final UpdateProfileController updateProfileController =
  Get.put(UpdateProfileController());

  @override
  Widget build(BuildContext context) {
    void _onResetPasswordPressed() {
      Navigator.pushNamed(context, RoutesManager.Profile);
    }

    return Scaffold(
      backgroundColor: ColorsManager.darkBlack,
      appBar: AppBar(
        title: Text(
          "Update Profile",
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
                child: Obx(() { //////بدل setState
                  return Column(
                    children: [
                      SizedBox(height: 20.h),
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: AssetImage(updateProfileController.selectedAvatarId.value == 1 ? ImagesManager.User1 : updateProfileController.selectedAvatarId.value == 2 ? ImagesManager.User2 : ImagesManager.User3,
                        ),
                      ),
                      SizedBox(height: 10.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            onPressed: () => updateProfileController.selectedAvatarId.value = 1,
                            icon: Image.asset(ImagesManager.User1, width: 40),
                          ),
                          IconButton(
                            onPressed: () =>
                            updateProfileController.selectedAvatarId.value = 2,
                            icon: Image.asset(ImagesManager.User2, width: 40),
                          ),
                          IconButton(
                            onPressed: () =>
                            updateProfileController.selectedAvatarId.value = 3,
                            icon: Image.asset(ImagesManager.User3, width: 40),
                          ),
                        ],
                      ),
                    ],
                  );
                }),
              ),
              SizedBox(height: 20.h),
              CustomTextFormField(
                hint: "USERNAME",
                prefixIcon: Icons.person,
                keyboardType: TextInputType.name,
                controller: updateProfileController.nameController,
              ),
              SizedBox(height: 20.h),
              CustomTextFormField(
                hint: "Email",
                prefixIcon: Icons.email,
                keyboardType: TextInputType.emailAddress,
                controller: updateProfileController.emailController,
              ),
              SizedBox(height: 20.h),
              CustomTextFormField(
                hint: "0120000000",
                prefixIcon: Icons.call,
                keyboardType: TextInputType.phone,
                controller: updateProfileController.phoneController,
              ),
              SizedBox(height: 12.h),
              CustomTextButton(
                title: "Reset Password",
                onPressed: () => Get.toNamed(RoutesManager.forgetPass),
                color: ColorsManager.yellow,
              ),
              SizedBox(height: 120.h),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  CustomElevatedButton(
                    title: "Delete Account",
                    onPressed: () {
                      Get.defaultDialog(
                        title: "Confirm",
                        middleText:
                        "Are you sure you want to delete your account?",
                        confirm: ElevatedButton(
                          onPressed: () {
                            Get.offAllNamed(RoutesManager.registerScreen);
                          },
                          child: Text("Yes"),
                        ),
                        cancel: ElevatedButton(
                          onPressed: () => Get.back(),
                          child: Text("No"),
                        ),
                      );
                    },
                    backgroundColor: ColorsManager.red,
                    foregroundColor: ColorsManager.ofwhite,
                  ),
                  SizedBox(height: 12),
                  Obx(() {
                    return CustomElevatedButton(
                      title: updateProfileController.isLoading.value ? "Updating..." : "Update Data",
                      onPressed: () {
                        if (!updateProfileController.isLoading.value)
                        {
                          updateProfileController.updateProfile();
                        }
                      },
                      backgroundColor: ColorsManager.yellow,
                      foregroundColor: ColorsManager.darkBlack,
                    );
                  }),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
