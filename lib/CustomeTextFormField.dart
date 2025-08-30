import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moviesapproute/core/colorsManager.dart';
class CustomTextFormField extends StatelessWidget {
  final String? label;
  final String? hint;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final TextInputType keyboardType;
  const CustomTextFormField({super.key, required this.label, this.hint, this.prefixIcon, this.suffixIcon, this.keyboardType = TextInputType.text,});
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: GoogleFonts.roboto(color: ColorsManager.white,fontSize: 16,fontWeight: FontWeight.w500),
        hintText: hint,
        prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
        suffixIcon: suffixIcon != null ? Icon(suffixIcon) : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(17.r),
        ),
      ),
    );
  }
}
