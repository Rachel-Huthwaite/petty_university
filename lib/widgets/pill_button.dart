import 'package:flutter/material.dart';

/// A colored pill button, drawn in code rather than from a PNG asset.
///
/// The exported button PNGs (unpack-button.png, later-button.png, etc.)
/// have uneven transparent padding baked in around the pill shape — a
/// common side effect of exporting glow/shadow layers from Figma — which
/// meant text overlaid on top could never be reliably centered. Drawing
/// the pill in code sidesteps that entirely and gives exact control.
///
/// Used throughout the Unpack flow (Issues 3.2–4.2).
class PillButton extends StatelessWidget {
  final String label;
  final TextStyle labelStyle;
  final Color color;
  final VoidCallback onTap;
  final double width;
  final double height;

  const PillButton({
    super.key,
    required this.label,
    required this.labelStyle,
    required this.color,
    required this.onTap,
    this.width = 140,
    this.height = 48,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: color.withOpacity(0.55),
      borderRadius: BorderRadius.circular(height / 2),
      child: InkWell(
        borderRadius: BorderRadius.circular(height / 2),
        onTap: onTap,
        child: Container(
          width: width,
          height: height,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(height / 2),
            border: Border.all(color: Colors.white.withOpacity(0.25)),
          ),
          child: Text(label, style: labelStyle, textAlign: TextAlign.center),
        ),
      ),
    );
  }
}