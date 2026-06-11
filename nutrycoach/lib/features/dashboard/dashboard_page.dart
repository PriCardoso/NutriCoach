import 'package:flutter/material.dart';

import '../../models/user_profile.dart';
import '../../services/bmi_service.dart';
import '../../services/calorie_service.dart';
import '../../services/water_service.dart';

import '../../widgets/dashboard_card.dart';
import '../../widgets/quick_action_card.dart';

import '../water/water_page.dart';
import 'dashboard_service.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() =>
      _DashboardPageState();
}

class _DashboardPageState
    extends State<DashboardPage> {
  final _service = DashboardService();

  UserProfile? profile;

  bool loading = true;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    final result =
        await _service.loadProfile();

    setState(() {
      profile = result;
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const Scaffold(
        body: Center(
          child:
              CircularProgressIndicator(),
        ),
      );
    }

    if (profile == null) {
      return Scaffold(
        appBar: AppBar(
          title:
              const Text('NutryCoach'),
        ),
        body: const Center(
          child: Text(
            'Complete seu perfil primeiro',
          ),
        ),
      );
    }

    final bmi = BMIService.calculate(
      weight: profile!.currentWeight,
      height: profile!.height,
    );

    final bmiClassification =
        BMIService.classification(bmi);

    final water =
        WaterService.calculate(
      age: profile!.age,
      weight: profile!.currentWeight,
    );

    final bmr =
        CalorieService.calculateBMR(
      male:
          profile!.gender ==
              'Masculino',
      weight: profile!.currentWeight,
      height: profile!.height * 100,
      age: profile!.age,
    );

    final progressWeight =
        ((profile!.currentWeight -
                    profile!
                        .targetWeight)
                .abs() /
            profile!.currentWeight)
            .clamp(0.0, 1.0);

    return Scaffold(
      backgroundColor:
          const Color(0xFFF8FAFC),

      body: SafeArea(
        child: SingleChildScrollView(
          padding:
              const EdgeInsets.all(16),

          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment
                    .start,

            children: [
              /// HEADER

              Container(
                width: double.infinity,

                padding:
                    const EdgeInsets.all(
                  24,
                ),

                decoration:
                    BoxDecoration(
                  gradient:
                      const LinearGradient(
                    colors: [
                      Color(
                        0xFF22C55E,
                      ),
                      Color(
                        0xFF16A34A,
                      ),
                    ],
                  ),

                  borderRadius:
                      BorderRadius
                          .circular(
                    24,
                  ),
                ),

                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment
                          .start,

                  children: [
                    const CircleAvatar(
                      radius: 30,
                      child: Icon(
                        Icons.person,
                        size: 32,
                      ),
                    ),

                    const SizedBox(
                      height: 16,
                    ),

                    Text(
                      'Olá ${profile!.name} 👋',
                      style:
                          const TextStyle(
                        color:
                            Colors.white,
                        fontSize: 24,
                        fontWeight:
                            FontWeight
                                .bold,
                      ),
                    ),

                    Text(
                      profile!.goal,
                      style:
                          const TextStyle(
                        color:
                            Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(
                height: 24,
              ),

              /// MOTIVAÇÃO

              Container(
                width: double.infinity,

                padding:
                    const EdgeInsets.all(
                  20,
                ),

                decoration:
                    BoxDecoration(
                  gradient:
                      const LinearGradient(
                    colors: [
                      Color(
                        0xFF22C55E,
                      ),
                      Color(
                        0xFF4ADE80,
                      ),
                    ],
                  ),

                  borderRadius:
                      BorderRadius
                          .circular(
                    24,
                  ),
                ),

                child: const Column(
                  crossAxisAlignment:
                      CrossAxisAlignment
                          .start,

                  children: [
                    Text(
                      '💪 Continue assim!',
                      style:
                          TextStyle(
                        color:
                            Colors.white,
                        fontSize: 22,
                        fontWeight:
                            FontWeight
                                .bold,
                      ),
                    ),

                    SizedBox(
                      height: 8,
                    ),

                    Text(
                      'Pequenos passos todos os dias geram grandes resultados.',
                      style:
                          TextStyle(
                        color:
                            Colors.white,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(
                height: 24,
              ),

              const Text(
                'Ações rápidas',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight:
                      FontWeight.bold,
                ),
              ),

              const SizedBox(
                height: 12,
              ),

              SingleChildScrollView(
                scrollDirection:
                    Axis.horizontal,

                child: Row(
                  children: [
                    QuickActionCard(
                      icon:
                          Icons.water_drop,
                      title: 'Água',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (_) =>
                                    const WaterPage(),
                          ),
                        );
                      },
                    ),

                    const SizedBox(
                      width: 12,
                    ),

                    QuickActionCard(
                      icon:
                          Icons.monitor_weight,
                      title: 'Peso',
                      onTap: () {},
                    ),

                    const SizedBox(
                      width: 12,
                    ),

                    QuickActionCard(
                      icon: Icons
                          .fitness_center,
                      title: 'Treinos',
                      onTap: () {},
                    ),

                    const SizedBox(
                      width: 12,
                    ),

                    QuickActionCard(
                      icon:
                          Icons.restaurant,
                      title:
                          'Nutrição',
                      onTap: () {},
                    ),
                  ],
                ),
              ),

              const SizedBox(
                height: 24,
              ),

              /// META

              Container(
                padding:
                    const EdgeInsets.all(
                  20,
                ),

                decoration:
                    BoxDecoration(
                  color: Colors.white,

                  borderRadius:
                      BorderRadius
                          .circular(
                    24,
                  ),
                ),

                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment
                          .start,

                  children: [
                    const Text(
                      'Progresso da Meta',
                      style:
                          TextStyle(
                        fontSize: 18,
                        fontWeight:
                            FontWeight
                                .bold,
                      ),
                    ),

                    const SizedBox(
                      height: 16,
                    ),

                    LinearProgressIndicator(
                      value:
                          progressWeight,
                      minHeight: 12,
                    ),

                    const SizedBox(
                      height: 12,
                    ),

                    Text(
                      '${profile!.currentWeight} kg → ${profile!.targetWeight} kg',
                    ),
                  ],
                ),
              ),

              const SizedBox(
                height: 24,
              ),

              DashboardCard(
                icon:
                    Icons.favorite,
                title: 'IMC',
                value:
                    bmi.toStringAsFixed(
                  1,
                ),
                subtitle:
                    bmiClassification,
              ),

              const SizedBox(
                height: 16,
              ),

              DashboardCard(
                icon:
                    Icons.water_drop,
                title: 'Água',
                value:
                    '${(water / 1000).toStringAsFixed(1)} L',
                subtitle:
                    'Meta diária',
              ),

              const SizedBox(
                height: 16,
              ),

              DashboardCard(
                icon: Icons
                    .local_fire_department,
                title:
                    'Gasto Basal',
                value:
                    '${bmr.toStringAsFixed(0)} kcal',
                subtitle:
                    'por dia',
              ),

              const SizedBox(
                height: 16,
              ),

              DashboardCard(
                icon: Icons.flag,
                title: 'Meta',
                value:
                    '${profile!.currentWeight} → ${profile!.targetWeight}',
                subtitle:
                    'Objetivo atual',
              ),
            ],
          ),
        ),
      ),
    );
  }
}