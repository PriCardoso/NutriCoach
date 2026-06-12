import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import 'glass_card.dart';

class CircularStatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final double percent;
  final Color color;

  const CircularStatCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    required this.percent,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      child: Column(
        children: [

          Icon(
            icon,
            color: color,
            size: 30,
          ),

          const SizedBox(height: 12),

          CircularPercentIndicator(
            radius: 45,
            lineWidth: 8,
            percent: percent.clamp(0.0, 1.0),
            animation: true,
            animationDuration: 1200,

            center: Text(
              value,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),

            progressColor: color,
            backgroundColor:
                Colors.grey.shade300,

            circularStrokeCap:
                CircularStrokeCap.round,
          ),

          const SizedBox(height: 12),

          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }
}