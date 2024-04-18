import 'package:flutter/material.dart';
import 'package:text_to_picture_app/common/theme/app_colors.dart';

class AppTextStyles {
  static const String fontFamily = 'maruburi';

  static const TextStyle textStyle12 = TextStyle(
    fontSize: 12,
  );

  static const TextStyle textStyle14 = TextStyle(
    fontSize: 14,
  );

  static const TextStyle textStyle18 = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle textStyle30 = TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.bold,
    color: AppColor.textColor,
  );
}
