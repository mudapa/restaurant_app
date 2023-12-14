import 'package:animated_button/animated_button.dart';
import 'package:flutter/material.dart';

import '../../shared/style.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Color color;
  final Function() onPressed;
  const CustomButton({
    super.key,
    required this.text,
    required this.color,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedButton(
      color: color,
      width: MediaQuery.of(context).size.width / 3,
      onPressed: onPressed,
      child: Text(
        text,
        style: whiteTextStyle.copyWith(
          fontSize: 16,
          fontWeight: semiBold,
        ),
      ),
    );
  }
}
