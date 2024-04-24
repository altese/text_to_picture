import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:app_settings/app_settings.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:text_to_picture_app/common/model/texfie.dart';
import 'package:text_to_picture_app/common/theme/app_colors.dart';
import 'package:text_to_picture_app/common/theme/text_styles.dart';
import 'package:text_to_picture_app/common/widgets/animation_button.dart';
import 'package:text_to_picture_app/home/presentation/notifiers/texfie_notifier.dart';
import 'package:text_to_picture_app/input_text/input_screen.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final GlobalKey _globalKey = GlobalKey();

  Future<Uint8List> _capturePng() async {
    try {
      RenderRepaintBoundary boundary = _globalKey.currentContext!
          .findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      Uint8List pngBytes = byteData!.buffer.asUint8List();
      // String base64 = base64Encode(pngBytes);

      _galleySaver(pngBytes);
      return pngBytes;
    } catch (e) {
      print(e.toString());
      return Uint8List(0);
    }
  }

  Future<bool> _checkStoragePermission() async {
    PermissionStatus status;
    if (Platform.isAndroid) {
      final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
      final AndroidDeviceInfo info = await deviceInfoPlugin.androidInfo;
      if ((info.version.sdkInt) >= 33) {
        status = await Permission.manageExternalStorage.request();
      } else {
        status = await Permission.storage.request();
      }
    } else {
      status = await Permission.storage.request();
    }

    switch (status) {
      case PermissionStatus.denied:
        return false;
      case PermissionStatus.granted:
        return true;
      case PermissionStatus.restricted:
        return false;
      case PermissionStatus.limited:
        return true;
      case PermissionStatus.permanentlyDenied:
        return false;
      case PermissionStatus.provisional:
        return false;
    }
  }

  void _galleySaver(Uint8List imageBytes) async {
    final status = await _checkStoragePermission();

    print(status);

    if (status) {
      await ImageGallerySaver.saveImage(
        Uint8List.fromList(imageBytes),
        quality: 100,
      );
    } else {
      await Permission.storage.request();
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    print('build');

    return Scaffold(
      backgroundColor: AppColor.bgColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Top(onPressed: _capturePng),
                const SizedBox(height: 30),
                renderTexFie(
                  context,
                  height: size.width - 40,
                  textColor: AppColor.textColor,
                  ref: ref,
                  key: _globalKey,
                ),
                const SizedBox(height: 20),
                renderPick(
                    datas: AppColor.imageBgColors, type: OptionType.color),
                const SizedBox(height: 10),
                renderPick(datas: Fonts.values, type: OptionType.fontFamily),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      onPressed: () {
                        //
                      },
                      icon: SvgPicture.asset('assets/svgs/font_black.svg'),
                    ),
                    renderPick(
                        datas: FontSizes.values, type: OptionType.fontSize),
                    IconButton(
                      onPressed: () {
                        //
                      },
                      icon: SvgPicture.asset('assets/svgs/font_white.svg'),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                renderBottom(context, ref),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Top extends StatefulWidget {
  const Top({
    super.key,
    required this.onPressed,
  });

  final Future<Uint8List> Function() onPressed;

  @override
  State<Top> createState() => _TopState();
}

class _TopState extends State<Top> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      // mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // const CircleImage(
        //   diameter: 50,
        //   image: NetworkImage(
        //     'https://kin-phinf.pstatic.net/20220910_23/1662814623235WWQpE_JPEG/FE054733-3554-475D-9E18-054509B8D11F.jpeg?type=w750',
        //   ),
        // ),
        const SizedBox(width: 45),
        SvgPicture.asset('assets/svgs/app_logo.svg'),
        IconButton(
          onPressed: () async {
            print('onPressed');
            widget.onPressed();
          },
          icon: const Icon(Icons.save_alt),
        ),
      ],
    );
  }
}

int _setMaxLines(
  BuildContext context, {
  required double imageHeight,
  required TexFie texFie,
  // required double lineHeight,
}) {
  int maxLines = ((imageHeight - 60) ~/ texFie.fontSize!.lineHeight);

  final width = MediaQuery.of(context).size.width;

  print(
      '폰 너비: $width, imageHeight: ${imageHeight - 60 - 20}, lineHeight: ${texFie.fontSize!.lineHeight} maxLines: $maxLines');

  if (texFie.author == '' && texFie.title == '') {
    return maxLines;
  } else if (texFie.author != '' && texFie.title != '') {
    return maxLines - 2;
  } else {
    return maxLines - 1;
  }
}

GestureDetector renderTexFie(
  BuildContext context, {
  required double height,
  required Color textColor,
  required WidgetRef ref,
  required Key key,
}) {
  final texFie = ref.watch(texFieNotifierProvider);

  DecorationImage? backgroundImage =
      texFie.backgroundImageUrl != '' && texFie.backgroundImageUrl != null
          ? DecorationImage(
              image: FileImage(File(texFie.backgroundImageUrl!)),
              fit: BoxFit.cover,
            )
          : null;

  print(backgroundImage ?? 'backgroundImage is null');

  return GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 300),
          transitionsBuilder: (context, animation1, animation2, child) {
            return FadeTransition(
              opacity: animation1,
              child: child,
            );
          },
          pageBuilder: (context, _, __) => InputScreen(texFie: texFie),
        ),
      );
    },
    child: RepaintBoundary(
      key: key,
      child: Container(
        padding: const EdgeInsets.all(30),
        height: height,
        decoration: BoxDecoration(
          color: texFie.backgoundColor,
          border: Border.all(color: AppColor.borderColor),
          image: backgroundImage,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const SizedBox(),
            Text(
              texFie.contents,
              style: TextStyle(
                // color: texFie.fontColor,
                fontSize: texFie.fontSize!.fontSize,
                fontFamily: texFie.font!.name,
              ),
              maxLines: _setMaxLines(
                context,
                imageHeight: height,
                texFie: texFie,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (texFie.title != '')
                      Text(
                        texFie.title!,
                        style: AppTextStyles.textStyle14.copyWith(
                          // color: texFie.fontColor,
                          fontFamily: texFie.font!.name,
                        ),
                      ),
                    if (texFie.author != '')
                      Text(
                        texFie.author!,
                        style: AppTextStyles.textStyle14.copyWith(
                          // color: texFie.fontColor,
                          fontFamily: texFie.font!.name,
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}

Row renderBottom(BuildContext context, WidgetRef ref) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      AnimationButton(
        useDelay: true,
        type: ButtonType.icon,
        icon: const Icon(
          Icons.photo,
          size: 30,
          color: AppColor.bgColor,
        ),
        onTap: () async {
          try {
            final XFile? image =
                await ImagePicker().pickImage(source: ImageSource.gallery);

            if (image != null) {
              ref
                  .read(texFieNotifierProvider.notifier)
                  .set(backgroundImageUrl: image.path);
            }
          } catch (e) {
            // ignore: use_build_context_synchronously
            requestPermission(context);
          }
        },
      ),
    ],
  );
}

void requestPermission(BuildContext context) async {
  await showGeneralDialog(
    context: context,
    // barrierDismissible: true,
    pageBuilder: (
      BuildContext context,
      Animation animation,
      Animation secondaryAnimation,
    ) {
      return Center(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12.0),
          child: Material(
            child: Container(
              width: MediaQuery.of(context).size.width - 40,
              color: Colors.white,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(
                      right: 40,
                      left: 40,
                      top: 20,
                      bottom: 15,
                    ),
                    child: Column(
                      children: [
                        Text('안내', style: AppTextStyles.textStyle18),
                        SizedBox(height: 20),
                        Text(
                          '이미지를 사용하기 위해서는 갤러리 접근을 허용해야 해요.',
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  const Divider(thickness: 0.7),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      AppSettings.openAppSettings(
                        type: AppSettingsType.settings,
                      );
                    },
                    child: const Text('확인'),
                  ),
                  const SizedBox(height: 5)
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}

SingleChildScrollView renderPick({
  required List<dynamic> datas,
  required OptionType type,
}) {
  final conversedDatas = type == OptionType.color
      ? datas as List<Color>
      : type == OptionType.fontSize
          ? datas as List<FontSizes>
          : datas as List<Fonts>;

  return SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.3),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: conversedDatas
            .map((e) => OptionItem(
                  type: type,
                  data: e,
                ))
            .toList(),
      ),
    ),
  );
}

enum OptionType { color, fontFamily, fontSize }

class OptionItem<T> extends ConsumerWidget {
  const OptionItem({
    required this.type,
    required this.data,
    super.key,
  });

  final OptionType type;
  final T data;

  Color? setColor() {
    if (type == OptionType.color) {
      final conversedData = data as Color;
      return conversedData;
    }
    return null;
  }

  (String label, FontSizes fontSize, Fonts fontFamily) setFont() {
    if (type == OptionType.fontSize) {
      final conversedData = data as FontSizes;
      return (conversedData.displayName, conversedData, Fonts.maruburi);
    } else {
      final conversedData = data as Fonts;
      return (
        conversedData.displayName,
        FontSizes.medium,
        conversedData,
      );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () {
        print('set backgroundImageUrl: null');
        if (type == OptionType.color) {
          ref.read(texFieNotifierProvider.notifier).set(
                backgoundColor: setColor(),
                backgroundImageUrl: '',
              );
        } else if (type == OptionType.fontFamily) {
          ref.read(texFieNotifierProvider.notifier).set(font: setFont().$3);
        } else {
          ref.read(texFieNotifierProvider.notifier).set(fontSize: setFont().$2);
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Container(
          height: 35,
          width: type == OptionType.color ? 35 : null,
          decoration: BoxDecoration(
            color: setColor(),
            shape: BoxShape.circle,
            border: type == OptionType.color
                ? Border.all(color: AppColor.borderColor)
                : null,
          ),
          child: type == OptionType.color
              ? null
              : Center(
                  child: Text(
                    setFont().$1,
                    style: TextStyle(
                      fontFamily: setFont().$3.name,
                      fontSize: setFont().$2.fontSize,
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
