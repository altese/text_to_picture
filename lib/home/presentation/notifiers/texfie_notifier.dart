import 'dart:math';
import 'dart:ui';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:text_to_picture_app/common/data/dummy_book.dart';
import 'package:text_to_picture_app/common/model/texfie.dart';
import 'package:text_to_picture_app/common/theme/app_colors.dart';
import 'package:text_to_picture_app/common/theme/text_styles.dart';

final texFieNotifierProvider =
    StateNotifierProvider<TexFieNotifier, TexFie>((ref) {
  return TexFieNotifier();
});

class TexFieNotifier extends StateNotifier<TexFie> {
  TexFieNotifier()
      : super(
          TexFie(
            contents: '',
            title: '',
            author: '',
            backgoundColor: AppColor.imageBgColors[5],
            font: Fonts.maruburi,
            fontSize: 14,
          ),
        ) {
    initTexFie();
  }

  void initTexFie() {
    int randomIndex = Random().nextInt(DummyBooks.list.length);
    Book book = DummyBooks.list[randomIndex];

    state = state.copyWith(
      contents: book.content,
      title: book.title,
      author: book.author,
      backgoundColor: AppColor.imageBgColors[5],
      font: Fonts.maruburi,
      fontSize: 14,
    );
  }

  void pickOptions({
    String? contents,
    String? title,
    String? author,
    String? backgroundImageUrl,
    Color? backgoundColor,
    Fonts? font,
    double? fontSize,
    String? texFieUrl,
  }) {
    state = state.copyWith(
      contents: contents,
      title: title,
      author: author,
      backgroundImageUrl: backgroundImageUrl,
      backgoundColor: backgoundColor,
      font: font,
      fontSize: fontSize,
      texFieUrl: texFieUrl,
    );
  }
}
