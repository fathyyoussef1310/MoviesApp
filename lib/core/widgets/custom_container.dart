import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../colors_manager/colorsManager.dart';

class CustomContainer extends StatelessWidget {
  const CustomContainer({super.key, required this.Title, required this.icon});
  final String Title;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return                         Container(
        padding: REdgeInsets.symmetric(horizontal: 25, vertical: 8),
        decoration: BoxDecoration(
          color: ColorsManager.gray,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: ColorsManager.yellow,
              size: 25,
            ),
            SizedBox(width:12.w),
            Text(
              Title,
              style: GoogleFonts.inter(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: ColorsManager.white,
              ),
            ),
          ],
        )
    );
  }
}
