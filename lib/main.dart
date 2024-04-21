import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:text_to_picture_app/common/model/texfie.dart';
import 'package:text_to_picture_app/common/theme/app_colors.dart';
import 'package:text_to_picture_app/common/theme/text_styles.dart';
import 'package:text_to_picture_app/home/presentation/home_screen.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(TexFieAdapter());
  await Hive.openBox<TexFie>('textfie');

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: AppTextStyles.fontFamily,
        colorScheme: ColorScheme.fromSeed(seedColor: AppColor.primary),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}
