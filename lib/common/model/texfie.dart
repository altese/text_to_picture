import 'dart:ui';

import 'package:hive/hive.dart';
import 'package:text_to_picture_app/common/theme/text_styles.dart';

part 'texfie.g.dart';

enum TexFieState {
  initial,
  data,
}

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

  @HiveField(4)
  Color? backgoundColor;

  @HiveField(5)
  Fonts? font;

  @HiveField(6)
  FontSizes? fontSize;

  @HiveField(7)
  String? texFieUrl;

  @HiveField(8)
  TexFieState state;

  @HiveField(9)
  Color? fontColor;

  TexFie({
    required this.contents,
    this.title,
    this.author,
    this.backgroundImageUrl,
    this.backgoundColor,
    this.font,
    this.fontSize,
    this.texFieUrl,
    required this.state,
    this.fontColor,
  });

  TexFie copyWith({
    String? contents,
    String? title,
    String? author,
    String? backgroundImageUrl,
    Color? backgoundColor,
    Fonts? font,
    FontSizes? fontSize,
    String? texFieUrl,
    TexFieState? state,
    Color? fontColor,
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
      state: state ?? this.state,
      fontColor: fontColor ?? this.fontColor,
    );
  }
}
