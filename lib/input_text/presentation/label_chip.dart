import 'package:flutter/material.dart';
import 'package:text_to_picture_app/common/theme/app_colors.dart';
import 'package:text_to_picture_app/common/theme/text_styles.dart';

class LabelChip extends StatelessWidget {
  const LabelChip({
    super.key,
    required this.label,
  });

  final String label;

  @override
  Widget build(BuildContext context) {
    return
        // Container(
        //   width: 100,
        //   height: 30,
        //   decoration: const BoxDecoration(
        //     color: AppColor.chipColor,
        //     borderRadius: BorderRadius.all(Radius.circular(20)),
        //   ),
        //   child:
        // Center(
        // child:
        Text(
      label,
      style: AppTextStyles.textStyle18.copyWith(
        color: AppColor.textColor,
      ),
      // ),
      // ),
    );
  }
}
