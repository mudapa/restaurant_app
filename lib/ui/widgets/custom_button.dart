import 'package:flutter/material.dart';

import '../../shared/helper.dart';
import '../../shared/style.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Color color;
  const CustomButton({
    super.key,
    required this.text,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: blueColor.withOpacity(0.4),
            offset: const Offset(5, 5),
          ),
        ],
      ),
      child: TextButton(
        onPressed: () {
          toast(
            'Coming Soon!',
            orangeColor,
          );
        },
        child: Text(
          text,
          style: whiteTextStyle.copyWith(
            fontSize: 16,
            fontWeight: semiBold,
          ),
        ),
      ),
    );
  }
}
