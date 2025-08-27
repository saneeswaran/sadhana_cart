import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class RoundedSigninButton extends StatelessWidget {
  final String imagePath;
  final VoidCallback onTap;
  const RoundedSigninButton({
    super.key,
    required this.imagePath,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return InkWell(
      onTap: onTap,
      child: Container(
        height: size.height * 0.1,
        width: size.width * 0.3,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          shape: BoxShape.circle,
        ),
        child: SvgPicture.asset(imagePath, fit: BoxFit.contain),
      ),
    );
  }
}
