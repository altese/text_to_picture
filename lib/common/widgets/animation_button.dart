import 'package:flutter/material.dart';
import 'package:text_to_picture_app/common/theme/app_colors.dart';

enum ButtonType { text, icon }

class AnimationButton extends StatefulWidget {
  const AnimationButton({
    super.key,
    required this.type,
    this.text,
    this.icon,
    required this.onTap,
    this.useDelay = false,
    this.upperBound = 0.1,
  });

  final ButtonType type;
  final String? text;
  final Icon? icon;
  final void Function() onTap;
  final bool useDelay;
  final double upperBound;

  @override
  State<AnimationButton> createState() => _AnimationButtonState();
}

class _AnimationButtonState extends State<AnimationButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  double _scale = 1;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
      lowerBound: 0.0,
      upperBound: widget.upperBound,
    )..addListener(() {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTapDown() {
    _controller.forward();
  }

  void _onTapUp() {
    _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    _scale = 1 + _controller.value;
    return GestureDetector(
      onTap: () async {
        await tapAnimation();
        widget.onTap();
      },
      child: Transform.scale(
        scale: _scale,
        child: widget.type == ButtonType.text
            ? _MainButton(text: widget.text!)
            : _IconButton(icon: widget.icon!),
      ),
    );
  }

  Future<void> tapAnimation() async {
    _onTapDown();
    await Future.delayed(const Duration(milliseconds: 200))
        .then((_) => _onTapUp());
    if (widget.useDelay) {
      await Future.delayed(const Duration(milliseconds: 100));
    }
  }
}

class _MainButton extends StatelessWidget {
  const _MainButton({
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

class _IconButton extends StatelessWidget {
  const _IconButton({
    required this.icon,
  });

  final Icon icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: 60,
      decoration: const BoxDecoration(
        color: AppColor.primary,
        shape: BoxShape.circle,
      ),
      child: const Icon(
        Icons.photo,
        size: 30,
        color: AppColor.bgColor,
      ),
    );
  }
}
