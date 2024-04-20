import 'package:flutter/material.dart';
import 'package:text_to_picture_app/common/theme/app_colors.dart';

class MainButton extends StatelessWidget {
  const MainButton({
    super.key,
    required this.text,
    this.isCancle = false,
  });

  final String text;
  final bool isCancle;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            decoration: const BoxDecoration(
              color: AppColor.primary,
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            height: 50,
            child: Center(
              child: Text(
                text,
                style: TextStyle(
                  fontSize: 18,
                  color: isCancle ? Colors.black : Colors.white,
                  fontWeight: isCancle ? FontWeight.w300 : FontWeight.w500,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
