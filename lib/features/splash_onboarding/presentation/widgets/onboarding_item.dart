import 'package:flutter/material.dart';

class OnboardingItem extends StatelessWidget {
  final String imagePath;
  final bool isFullScreen;

  const OnboardingItem({
    super.key,
    required this.imagePath,
    this.isFullScreen = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(imagePath),
          fit: isFullScreen ? BoxFit.cover : BoxFit.contain,
        ),
      ),
    );
  }
}