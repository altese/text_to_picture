import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:text_to_picture_app/common/model/texfie.dart';
import 'package:text_to_picture_app/common/theme/app_colors.dart';
import 'package:text_to_picture_app/common/widgets/animation_button.dart';
import 'package:text_to_picture_app/home/presentation/notifiers/texfie_notifier.dart';
import 'package:text_to_picture_app/input_text/presentation/label_chip.dart';

class InputScreen extends ConsumerStatefulWidget {
  const InputScreen({
    super.key,
    required this.texFie,
  });

  final TexFie texFie;

  @override
  ConsumerState<InputScreen> createState() => _InputScreenState();
}

class _InputScreenState extends ConsumerState<InputScreen> {
  late TextEditingController _contentsController;
  late TextEditingController _titleController;
  late TextEditingController _authController;

  @override
  void initState() {
    _contentsController = TextEditingController(
      text: widget.texFie.state == TexFieState.initial
          ? ""
          : widget.texFie.contents,
    );
    _titleController = TextEditingController(
      text:
          widget.texFie.state == TexFieState.initial ? "" : widget.texFie.title,
    );
    _authController = TextEditingController(
      text: widget.texFie.state == TexFieState.initial
          ? ""
          : widget.texFie.author,
    );
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
    // TexFie texFie = ref.read(texFieNotifierProvider);

    // _contentsController = TextEditingController(
    //   text: texFie.state == TexFieState.initial ? null : texFie.contents,
    // );
    // _titleController = TextEditingController(
    //   text: texFie.state == TexFieState.initial ? null : texFie.title,
    // );
    // _authController = TextEditingController(
    //   text: texFie.state == TexFieState.initial ? null : texFie.author,
    // );

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
          child: LayoutBuilder(
            builder: (context, constraint) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraint.maxHeight),
                  child: IntrinsicHeight(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          renderTextField(
                            label: '글귀*',
                            maxLines: 10,
                            textEditingController: _contentsController,
                            onChanged: (value) {
                              print('onChanged');
                              // ref.read(texFieNotifierProvider.notifier).set(
                              //       contents: value,
                              //       // texFieState: TexFieState.data,
                              //     );
                            },
                          ),
                          const SizedBox(height: 30),
                          renderTextField(
                            label: '도서',
                            maxLines: 1,
                            textEditingController: _titleController,
                            onChanged: (value) {
                              // ref.read(texFieNotifierProvider.notifier).set(
                              //       title: value,
                              //       // texFieState: TexFieState.data,
                              //     );
                            },
                          ),
                          const SizedBox(height: 30),
                          renderTextField(
                            label: '작가',
                            maxLines: 1,
                            textEditingController: _authController,
                            onChanged: (value) {
                              // ref.read(texFieNotifierProvider.notifier).set(
                              //       author: value,
                              //       // texFieState: TexFieState.data,
                              //     );
                            },
                          ),
                          const Spacer(),
                          AnimationButton(
                            type: ButtonType.text,
                            upperBound: 0.03,
                            useDelay: true,
                            text: '완료',
                            onTap: () {
                              ref.read(texFieNotifierProvider.notifier).set(
                                    contents: _contentsController.text,
                                    title: _titleController.text,
                                    author: _authController.text,
                                    texFieState: TexFieState.data,
                                  );
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
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
  required Function(String)? onChanged,
  // required Function()? onEditingComplete,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      LabelChip(label: label),
      const SizedBox(height: 10),
      TextField(
        // onEditingComplete: onEditingComplete,
        onChanged: onChanged,
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
        // onChanged: (_) {},
      ),
    ],
  );
}
