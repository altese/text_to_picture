import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:text_to_picture_app/common/theme/app_colors.dart';
import 'package:text_to_picture_app/common/theme/text_styles.dart';
import 'package:text_to_picture_app/common/widgets/animation_button.dart';
import 'package:text_to_picture_app/home/presentation/circle_image.dart';
import 'package:text_to_picture_app/input_text/input_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColor.bgColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              renderTop(),
              const SizedBox(height: 30),
              renderTexFie(
                context,
                height: size.width - 40,
                bgColor: AppColor.bgGreyColor,
                textColor: AppColor.textColor,
              ),
              const SizedBox(height: 20),
              renderPick(
                children: AppColor.imageBgColors
                    .map((e) => renderItem(color: e))
                    .toList(),
              ),
              renderPick(
                children: Fonts.values
                    .map(
                      (e) => Center(
                        child: renderItem(
                          child: Text(
                            e.displayName,
                            style: AppTextStyles.textStyle14.copyWith(
                              fontFamily: e.name,
                            ),
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
              const SizedBox(height: 20),
              renderBottom(context),
            ],
          ),
        ),
      ),
    );
  }
}

Row renderTop() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      const CircleImage(
        diameter: 50,
        image: NetworkImage(
          'https://kin-phinf.pstatic.net/20220910_23/1662814623235WWQpE_JPEG/FE054733-3554-475D-9E18-054509B8D11F.jpeg?type=w750',
        ),
      ),
      SvgPicture.asset('assets/svgs/app_logo.svg'),
      const Icon(size: 35, Icons.search)
    ],
  );
}

GestureDetector renderTexFie(
  BuildContext context, {
  required double height,
  required Color bgColor,
  required Color textColor,
}) {
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
          pageBuilder: (context, _, __) => const InputScreen(),
        ),
      );
    },
    child: Container(
      padding: const EdgeInsets.all(40),
      height: height,
      decoration: BoxDecoration(
        color: bgColor,
        border: Border.all(color: AppColor.borderColor),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const SizedBox(),
          Text(
            '그렇다면 운명이란 대체 누가 안배해 주는 건가요?\n옳은 선택 같은 건 없어요. 나를 위한 선택만이 있을 뿐.\n저는 늘 그렇게 해왔어요. 이것은 다른 누구도 아닌 \'나\'의 운명이기 때문입니다.',
            style: AppTextStyles.textStyle14.copyWith(
              color: textColor,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '소라의 눈',
                    style: AppTextStyles.textStyle14.copyWith(
                      color: textColor,
                    ),
                  ),
                  Text(
                    '썸머',
                    style: AppTextStyles.textStyle14.copyWith(
                      color: textColor,
                    ),
                  ),
                ],
              ),
              const CircleImage(
                diameter: 50,
                image: NetworkImage(
                  'https://kin-phinf.pstatic.net/20220910_23/1662814623235WWQpE_JPEG/FE054733-3554-475D-9E18-054509B8D11F.jpeg?type=w750',
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

Row renderBottom(BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      TextButton(
        onPressed: () {},
        child: Text(
          'T',
          style: AppTextStyles.textStyle30.copyWith(
            fontFamily: AppTextStyles.fontFamily,
          ),
        ),
      ),
      AnimationButton(
        useDelay: true,
        type: ButtonType.icon,
        icon: const Icon(
          Icons.photo,
          size: 30,
          color: AppColor.bgColor,
        ),
        onTap: () async {
          final PermissionStatus status = await Permission.photos.request();

          if (status == PermissionStatus.granted) {
            final XFile? image =
                await ImagePicker().pickImage(source: ImageSource.gallery);
          } else {
            // ignore: use_build_context_synchronously
            requestPermission(context, status);
          }
        },
      ),
      TextButton(
        onPressed: () {},
        child: Text(
          'F',
          style: AppTextStyles.textStyle30.copyWith(
            fontFamily: AppTextStyles.fontFamily,
          ),
        ),
      ),
    ],
  );
}

void requestPermission(BuildContext context, PermissionStatus status) async {
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
  // }
}

SingleChildScrollView renderPick({
  required List<Widget> children,
}) {
  return SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.3),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: children,
      ),
    ),
  );
}

Padding renderItem({
  Color? color,
  Widget? child,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10),
    child: Container(
      height: 35,
      width: child == null ? 35 : null,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        border: child == null
            ? Border.all(
                color: AppColor.borderColor,
              )
            : null,
      ),
      child: Center(child: child),
    ),
  );
}
