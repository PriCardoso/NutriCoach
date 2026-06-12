import 'package:flutter/material.dart';

import '../models/user_profile.dart';
import 'glass_card.dart';

class DashboardHeader extends StatelessWidget {
  final UserProfile profile;
  final VoidCallback onEdit;
  final VoidCallback onLogout;

  const DashboardHeader({
    super.key,
    required this.profile,
    required this.onEdit,
    required this.onLogout,
  });

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      child: Row(
        children: [

          /// Avatar

          Container(
            width: 70,
            height: 70,

            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  Color(0xFF22C55E),
                  Color(0xFF16A34A),
                ],
              ),

              borderRadius:
                  BorderRadius.circular(20),
            ),

            child: const Icon(
              Icons.person,
              color: Colors.white,
              size: 38,
            ),
          ),

          const SizedBox(width: 16),

          /// Dados

          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [

                Text(
                  'Olá, ${profile.name} 👋',
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight:
                        FontWeight.bold,
                    color: Color(0xFF0F172A),
                  ),
                ),

                const SizedBox(height: 6),

                Text(
                  profile.goal,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 15,
                  ),
                ),

                const SizedBox(height: 10),

                Container(
                  padding:
                      const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),

                  decoration: BoxDecoration(
                    color:
                        const Color(0xFFDCFCE7),

                    borderRadius:
                        BorderRadius.circular(
                      30,
                    ),
                  ),

                  child: const Text(
                    'Meta ativa',
                    style: TextStyle(
                      color:
                          Color(0xFF166534),
                      fontWeight:
                          FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),

          /// Botões

          Column(
            children: [

              IconButton(
                onPressed: onEdit,
                icon: const Icon(
                  Icons.edit,
                ),
              ),

              IconButton(
                onPressed: onLogout,
                icon: const Icon(
                  Icons.logout,
                  color: Colors.red,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}