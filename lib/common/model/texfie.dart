import 'dart:ui';

import 'package:hive/hive.dart';
import 'package:text_to_picture_app/common/theme/app_colors.dart';
import 'package:text_to_picture_app/common/theme/text_styles.dart';

part 'texfie.g.dart';

@HiveType(typeId: 1)
class TexFie extends HiveObject {
  @HiveField(0)
  String contents;

  @HiveField(1)
  String? title;

  @HiveField(2)
  String? author;

  @HiveField(3)
  String? backgroundImageUrl;

  @HiveField(4, defaultValue: AppColor.bgGreyColor)
  Color? backgoundColor;

  @HiveField(5, defaultValue: Fonts.maruburi)
  Fonts? font;

  @HiveField(6, defaultValue: 14)
  int? fontSize;

  @HiveField(7)
  String texFieUrl;

  TexFie({
    required this.contents,
    this.title,
    this.author,
    this.backgroundImageUrl,
    this.backgoundColor,
    this.font,
    this.fontSize,
    required this.texFieUrl,
  });

  TexFie copyWith({
    String? contents,
    String? title,
    String? author,
    String? backgroundImageUrl,
    Color? backgoundColor,
    Fonts? font,
    int? fontSize,
    String? texFieUrl,
  }) {
    return TexFie(
      contents: contents ?? this.contents,
      title: title ?? this.title,
      author: author ?? this.author,
      backgroundImageUrl: backgroundImageUrl ?? this.backgroundImageUrl,
      backgoundColor: backgoundColor ?? this.backgoundColor,
      font: font ?? this.font,
      fontSize: fontSize ?? this.fontSize,
      texFieUrl: texFieUrl ?? this.texFieUrl,
    );
  }
}
