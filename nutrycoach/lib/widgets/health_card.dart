import 'package:flutter/material.dart';

class HealthCard extends StatelessWidget {

  final IconData icon;
  final String title;
  final String value;

  const HealthCard({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {

    return Container(
      width: 170,

      padding: const EdgeInsets.all(20),

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius:
            BorderRadius.circular(24),

        boxShadow: [

          BoxShadow(
            color:
                Colors.black12,
            blurRadius: 10,
          ),
        ],
      ),

      child: Column(
        children: [

          Icon(
            icon,
            color: Colors.green,
            size: 36,
          ),

          const SizedBox(height: 12),

          Text(
            value,
            style: const TextStyle(
              fontSize: 24,
              fontWeight:
                  FontWeight.bold,
            ),
          ),

          Text(
            title,
            style: const TextStyle(
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}