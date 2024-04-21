import 'package:flutter/material.dart';
import 'package:text_to_picture_app/common/theme/app_colors.dart';

enum Fonts {
  maruburi('마루부리'),
  chosunGu('조선굴림'),
  kopubBatang('KoPub바탕'),
  kopubDotum('KoPub돋움'),
  okja('온글잎 매일옥자체'),
  pretendard('프리텐다드'),
  ridiBatang('리디바탕');

  final String displayName;

  const Fonts(this.displayName);
}

enum FontSizes {
  small('작게', 12),
  medium('보통', 14),
  large('크게', 16);

  final String displayName;
  final double fontSize;

  const FontSizes(this.displayName, this.fontSize);
}

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

  static const TextStyle textStyle24 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle textStyle30 = TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.bold,
    color: AppColor.textColor,
  );
}
