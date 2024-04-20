import 'package:flutter/material.dart';
import 'package:text_to_picture_app/common/theme/app_colors.dart';
import 'package:text_to_picture_app/common/widgets/animation_button.dart';
import 'package:text_to_picture_app/input_text/presentation/label_chip.dart';

class InputScreen extends StatefulWidget {
  const InputScreen({super.key});

  @override
  State<InputScreen> createState() => _InputScreenState();
}

class _InputScreenState extends State<InputScreen> {
  late TextEditingController _contentsController;
  late TextEditingController _titleController;
  late TextEditingController _authController;

  @override
  void initState() {
    _contentsController = TextEditingController();
    _titleController = TextEditingController();
    _authController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _contentsController.dispose();
    _titleController.dispose();
    _authController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bgColor,
      appBar: AppBar(
        backgroundColor: AppColor.bgColor,
        elevation: 0,
      ),
      body: SafeArea(
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: FocusScope.of(context).unfocus,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                renderTextField(
                  label: '글귀',
                  maxLines: 10,
                  textEditingController: _titleController,
                ),
                const SizedBox(height: 30),
                renderTextField(
                  label: '도서',
                  maxLines: 1,
                  textEditingController: _titleController,
                ),
                const SizedBox(height: 30),
                renderTextField(
                  label: '작가',
                  maxLines: 1,
                  textEditingController: _authController,
                ),
                const Spacer(),
                AnimationButton(
                  type: ButtonType.text,
                  upperBound: 0.03,
                  text: '완료',
                  onTap: () {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Column renderTextField({
  required String label,
  required int maxLines,
  required TextEditingController textEditingController,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      LabelChip(label: label),
      const SizedBox(height: 10),
      TextField(
        controller: textEditingController,
        maxLines: maxLines,
        decoration: const InputDecoration(
          fillColor: AppColor.bgGreyColor,
          filled: true,
          contentPadding: EdgeInsets.all(10),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(
              color: AppColor.borderColor,
              width: 0.7,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(
              color: AppColor.primary,
              width: 0.7,
            ),
          ),
        ),
        onChanged: (_) {},
      ),
    ],
  );
}
