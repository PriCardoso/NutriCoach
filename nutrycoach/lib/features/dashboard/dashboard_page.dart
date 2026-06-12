import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../models/user_profile.dart';

import '../../services/bmi_service.dart';
import '../../services/calorie_service.dart';
import '../../services/water_service.dart';

import '../../widgets/dashboard_header.dart';
import '../../widgets/quick_action_grid.dart';
import '../../widgets/achievement_card.dart';
import '../../widgets/circular_stat_card.dart';
import '../../widgets/main_bottom_navigation.dart';

import '../water/water_page.dart';
import '../weight/weight_page.dart';
import '../progress/progress_page.dart';
import '../profile/edit_profile_page.dart';

import 'dashboard_service.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final _service = DashboardService();

  UserProfile? profile;
  bool loading = true;
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    final result = await _service.loadProfile();
    setState(() {
      profile = result;
      loading = false;
    });
  }

  Future<void> _goToEditProfile() async {
    final updated = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => EditProfilePage(profile: profile!),
      ),
    );
    if (updated == true) loadData();
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (profile == null) {
      return const Scaffold(
        body: Center(child: Text('Complete seu perfil primeiro')),
      );
    }

    final bmi = BMIService.calculate(
      weight: profile!.currentWeight,
      height: profile!.height,
    );

    final water = WaterService.calculate(
      age: profile!.age,
      weight: profile!.currentWeight,
    );

    final bmr = CalorieService.calculateBMR(
      male: profile!.gender == 'Masculino',
      weight: profile!.currentWeight,
      height: profile!.height * 100,
      age: profile!.age,
    );

    final totalWeightToLose =
        (profile!.currentWeight - profile!.targetWeight).abs();

    final progress = totalWeightToLose == 0
        ? 1.0
        : (1 - (totalWeightToLose / profile!.currentWeight)).clamp(0.0, 1.0);

    // Percentuais para os cards circulares (valores normalizados para 0.0–1.0)
    final bmiPercent = (bmi / 40).clamp(0.0, 1.0);
    final waterLiters = water / 1000;
    final waterPercent = (waterLiters / 3.0).clamp(0.0, 1.0);
    final calPercent = (bmr / 3000).clamp(0.0, 1.0);

    final isMobile = MediaQuery.of(context).size.width < 700;

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      bottomNavigationBar: MainBottomNavigation(
        currentIndex: selectedIndex,
        onTap: (index) async {
          setState(() => selectedIndex = index);

          switch (index) {
            case 1:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const WaterPage()),
              );
              break;
            case 2:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ProgressPage()),
              );
              break;
            case 3:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const WeightPage()),
              );
              break;
            case 4:
              await _goToEditProfile();
              break;
          }
        },
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Header ──────────────────────────────────────
              DashboardHeader(
                profile: profile!,
                onEdit: _goToEditProfile,
                onLogout: () async {
                  await Supabase.instance.client.auth.signOut();
                  if (!mounted) return;
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    '/',
                    (route) => false,
                  );
                },
              ),

              const SizedBox(height: 24),

              // ── Resumo de hoje ───────────────────────────────
              const Text(
                'Resumo de Hoje',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),

              GridView.count(
                crossAxisCount: isMobile ? 2 : 4,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 1,
                children: [
                  CircularStatCard(
                    icon: Icons.water_drop,
                    title: 'Água',
                    value: '${waterLiters.toStringAsFixed(1)}L',
                    percent: waterPercent,
                    color: Colors.blue,
                  ),
                  CircularStatCard(
                    icon: Icons.favorite,
                    title: 'IMC',
                    value: bmi.toStringAsFixed(1),
                    percent: bmiPercent,
                    color: Colors.red,
                  ),
                  CircularStatCard(
                    icon: Icons.local_fire_department,
                    title: 'Calorias',
                    value: bmr.toStringAsFixed(0),
                    percent: calPercent,
                    color: Colors.orange,
                  ),
                ],
              ),

              const SizedBox(height: 28),

              // ── Ações rápidas ────────────────────────────────
              const Text(
                'Ações Rápidas',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),

              QuickActionGrid(
                onWater: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const WaterPage()),
                ),
                onWeight: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const WeightPage()),
                ),
                onProgress: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ProgressPage()),
                ),
                onWorkout: () {},
                //onProfile: _goToEditProfile,
              ),

              const SizedBox(height: 28),

              // ── Meta atual ───────────────────────────────────
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Meta Atual',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      LinearProgressIndicator(
                        value: progress,
                        minHeight: 12,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        '${profile!.currentWeight}kg → ${profile!.targetWeight}kg',
                        style: const TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 28),

              // ── Conquistas ───────────────────────────────────
              const Text(
                'Conquistas',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),

              AchievementCard(
                title: 'Primeiro Peso',
                description: 'Peso registrado com sucesso',
                icon: Icons.monitor_weight,
                color: Colors.orange,
                unlocked: true,
              ),
              const SizedBox(height: 12),

              AchievementCard(
                title: 'Meta de Água',
                description: '7 dias hidratando',
                icon: Icons.water_drop,
                color: Colors.blue,
                unlocked: false,
              ),
              const SizedBox(height: 12),

              AchievementCard(
                title: 'Atleta',
                description: '10 treinos concluídos',
                icon: Icons.fitness_center,
                color: Colors.green,
                unlocked: false,
              ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}