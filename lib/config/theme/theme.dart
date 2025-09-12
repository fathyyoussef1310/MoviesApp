
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/colors_manager/colorsManager.dart';

abstract class ThemeManager {
  static final ThemeData light = ThemeData(
    scaffoldBackgroundColor: ColorsManager.white,
  );
  static final ThemeData dark = ThemeData(
    scaffoldBackgroundColor: ColorsManager.darkBlack,
    textTheme: TextTheme(
      bodySmall: GoogleFonts.inter(
        color: ColorsManager.ofwhite,
        fontWeight: FontWeight.bold,
        fontSize: 14.sp,
      ),
      titleMedium: GoogleFonts.inter(
        color: ColorsManager.ofwhite,
        fontWeight: FontWeight.w400,
        fontSize: 18.sp
      )
    ),
  );
}
