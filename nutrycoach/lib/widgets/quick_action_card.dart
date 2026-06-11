import 'package:flutter/material.dart';

class QuickActionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const QuickActionCard({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {

    return InkWell(
      onTap: onTap,

      borderRadius:
          BorderRadius.circular(20),

      child: Container(
        width: 110,
        padding:
            const EdgeInsets.all(16),

        decoration: BoxDecoration(
          color: Colors.white,

          borderRadius:
              BorderRadius.circular(20),

          boxShadow: [
            BoxShadow(
              color:
                  Colors.black.withOpacity(
                0.05,
              ),
              blurRadius: 10,
            ),
          ],
        ),

        child: Column(
          children: [

            Icon(
              icon,
              size: 32,
              color: Colors.green,
            ),

            const SizedBox(height: 10),

            Text(
              title,
              textAlign:
                  TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}