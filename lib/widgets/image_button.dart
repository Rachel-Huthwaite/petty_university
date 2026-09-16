import 'package:flutter/material.dart';

/// A button whose background is one of the pill-shaped PNGs exported from
/// Figma (unpack-button.png, later-button.png, etc.), with a text label
/// centered on top. Used throughout the Unpack flow (Issues 3.2–4.2).
class ImageButton extends StatelessWidget {
  final String assetPath;
  final String label;
  final TextStyle labelStyle;
  final VoidCallback onTap;
  final double width;
  final double height;

  const ImageButton({
    super.key,
    required this.assetPath,
    required this.label,
    required this.labelStyle,
    required this.onTap,
    this.width = 140,
    this.height = 48,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: width,
        height: height,
        child: Stack(
          fit: StackFit.expand,
          alignment: Alignment.center,
          children: [
            Image.asset(assetPath, fit: BoxFit.fill),
            Text(label, style: labelStyle),
          ],
        ),
      ),
    );
  }
}