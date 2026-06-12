import 'package:flutter/material.dart';

class QuickActionGrid extends StatelessWidget {
  final VoidCallback onWater;
  final VoidCallback onWeight;
  final VoidCallback onProgress;
  final VoidCallback onWorkout;

  const QuickActionGrid({
    super.key,
    required this.onWater,
    required this.onWeight,
    required this.onProgress,
    required this.onWorkout,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {

        final isMobile =
            constraints.maxWidth < 700;

        return Wrap(
          spacing: 12,
          runSpacing: 12,

          children: [

            _actionCard(
              width: isMobile ? 160 : 190,
              icon: Icons.water_drop,
              color: Colors.blue,
              title: 'Hidratação',
              subtitle: 'Registrar água',
              onTap: onWater,
            ),

            _actionCard(
              width: isMobile ? 160 : 190,
              icon: Icons.monitor_weight,
              color: Colors.orange,
              title: 'Peso',
              subtitle: 'Atualizar peso',
              onTap: onWeight,
            ),

            _actionCard(
              width: isMobile ? 160 : 190,
              icon: Icons.show_chart,
              color: Colors.purple,
              title: 'Evolução',
              subtitle: 'Ver progresso',
              onTap: onProgress,
            ),

            _actionCard(
              width: isMobile ? 160 : 190,
              icon: Icons.fitness_center,
              color: Colors.green,
              title: 'Treinos',
              subtitle: 'Registrar treino',
              onTap: onWorkout,
            ),
          ],
        );
      },
    );
  }

  Widget _actionCard({
    required double width,
    required IconData icon,
    required Color color,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return SizedBox(
      width: width,

      child: InkWell(
        borderRadius:
            BorderRadius.circular(24),

        onTap: onTap,

        child: Container(
          padding:
              const EdgeInsets.all(18),

          decoration: BoxDecoration(
            color: Colors.white,

            borderRadius:
                BorderRadius.circular(
              24,
            ),

            boxShadow: [
              BoxShadow(
                color:
                    Colors.black.withOpacity(
                  0.05,
                ),
                blurRadius: 12,
                offset: const Offset(
                  0,
                  5,
                ),
              ),
            ],
          ),

          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,

            children: [

              Container(
                padding:
                    const EdgeInsets.all(
                  10,
                ),

                decoration: BoxDecoration(
                  color:
                      color.withOpacity(
                    0.15,
                  ),

                  borderRadius:
                      BorderRadius.circular(
                    14,
                  ),
                ),

                child: Icon(
                  icon,
                  color: color,
                ),
              ),

              const SizedBox(height: 14),

              Text(
                title,
                style:
                    const TextStyle(
                  fontWeight:
                      FontWeight.bold,
                  fontSize: 16,
                ),
              ),

              const SizedBox(height: 4),

              Text(
                subtitle,
                style:
                    TextStyle(
                  color:
                      Colors.grey.shade600,
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}