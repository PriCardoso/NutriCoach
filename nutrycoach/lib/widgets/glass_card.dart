import 'dart:ui';

import 'package:flutter/material.dart';

class GlassCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final double borderRadius;

  const GlassCard({
    super.key,
    required this.child,
    this.padding,
    this.borderRadius = 28,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius:
          BorderRadius.circular(
        borderRadius,
      ),

      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 12,
          sigmaY: 12,
        ),

        child: Container(
          width: double.infinity,

          padding:
              padding ??
              const EdgeInsets.all(20),

          decoration: BoxDecoration(
            color:
                Colors.white.withOpacity(
              0.65,
            ),

            borderRadius:
                BorderRadius.circular(
              borderRadius,
            ),

            border: Border.all(
              color:
                  Colors.white.withOpacity(
                0.8,
              ),
            ),

            boxShadow: [
              BoxShadow(
                color:
                    Colors.black.withOpacity(
                  0.05,
                ),
                blurRadius: 20,
                offset: const Offset(
                  0,
                  8,
                ),
              ),
            ],
          ),

          child: child,
        ),
      ),
    );
  }
}