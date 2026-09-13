import 'dart:ui';
import 'package:flutter/material.dart';
import '../theme/app_constants.dart';



class GlassContainer extends StatelessWidget {
  final Widget child;
  final double radius;
  final double blurSigma;
  final double overlayOpacity;
  final EdgeInsetsGeometry padding;

  const GlassContainer({
    super.key,
    required this.child,
    this.radius = AppConstants.cornerRadius,
    this.blurSigma = 12,
    this.overlayOpacity = 0.15,
    this.padding = const EdgeInsets.all(16),
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blurSigma, sigmaY: blurSigma),
        child: Container(
          padding: padding,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(overlayOpacity),
            borderRadius: BorderRadius.circular(radius),
            border: Border.all(
              color: Colors.white.withOpacity(0.2),
              width: 1,
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}
