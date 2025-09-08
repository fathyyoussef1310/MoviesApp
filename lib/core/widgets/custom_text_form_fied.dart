import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../colors_manager/colorsManager.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    this.label,
    this.hint,
    this.prefixIcon,
    this.suffixIcon,
    this.keyboardType = TextInputType.text,
    this.maxLines = 1,
    this.controller,
    this.validator,
  });

  final String? label;
  final String? hint;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final TextInputType keyboardType;
  final int maxLines;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      keyboardType: keyboardType,
      style: Theme.of(context).textTheme.bodySmall?.copyWith(
        fontSize: 16.sp,
        fontWeight: FontWeight.w500,
        color: ColorsManager.ofwhite,
      ),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: label != null
            ? TextStyle(
          color: ColorsManager.ofwhite,
          fontSize: 16.sp,
          fontWeight: FontWeight.w500,
        )
            : null,
        filled: true,
        fillColor: Colors.grey[800],
        hintText: hint,
        hintStyle: TextStyle(
          color: ColorsManager.ofwhite.withOpacity(0.7),
        ),
        prefixIcon: prefixIcon != null
            ? Icon(prefixIcon, color: ColorsManager.ofwhite)
            : null,
        suffixIcon: suffixIcon != null
            ? Icon(suffixIcon, color: ColorsManager.ofwhite)
            : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
