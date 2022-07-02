import 'package:flutter/material.dart';

import '../../../../../../shared/theme/app_colors.dart';
import '../../../../../../shared/theme/app_fonts.dart';


class SocialButton extends StatelessWidget {
  final String text;
  final String image;
  final VoidCallback onPress;


  const SocialButton({
    required this.text,
    required this.image,
    required this.onPress,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
        width: double.infinity,
        height: 56,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: AppColors.textGrey,
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              decoration: const BoxDecoration(
                border: Border(
                  right: BorderSide(
                    color: AppColors.textGrey,
                  ),
                ),
              ),
              height: 56,
              width: 56,
              child: Center(
                child: ClipRRect(
                  child: Image.asset(
                    image,
                    width: 24,
                    height: 24,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                padding: const EdgeInsets.only(left: 40),
                child: Text(
                  text,
                  style: AppFonts.textInput,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
