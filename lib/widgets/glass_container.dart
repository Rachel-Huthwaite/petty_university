import 'dart:ui';
import 'package:flutter/material.dart';
import '../theme/app_constants.dart';



class GlassContainer extends StatelessWidget {
  final Widget child;
  final double radius;
  final BorderRadius? customBorderRadius;
  final double blurSigma;
  final double overlayOpacity;
  final Color overlayColor;
  final EdgeInsetsGeometry padding;

  const GlassContainer({
    super.key,
    required this.child,
    this.radius = AppConstants.cornerRadius,
    this.customBorderRadius,
    this.blurSigma = 16,
    this.overlayOpacity = 0.2,
    this.overlayColor = Colors.black,
    this.padding = const EdgeInsets.all(16),
  });

  @override
  Widget build(BuildContext context) {
    final effectiveRadius = customBorderRadius ?? BorderRadius.circular(radius);

    return ClipRRect(
      borderRadius: effectiveRadius,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blurSigma, sigmaY: blurSigma),
        child: Container(
          padding: padding,
          decoration: BoxDecoration(
            color: overlayColor.withOpacity(overlayOpacity),
            borderRadius: effectiveRadius,
          ),
          child: child,
        ),
      ),
    );
  }
}
