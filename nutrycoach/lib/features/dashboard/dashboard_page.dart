import 'package:flutter/material.dart';
import '../../services/bmi_service.dart';
import '../../services/calorie_service.dart';
import '../../services/water_service.dart';
import '../../models/user_profile.dart';

import 'dashboard_service.dart';
import '../water/water_page.dart';

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
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (profile == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('NutryCoach'),
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
          profile!.gender == 'Masculino',
      weight: profile!.currentWeight,
      height: profile!.height * 100,
      age: profile!.age,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Olá ${profile!.name}',
        ),
      ),

      body: SingleChildScrollView(
        padding:
            const EdgeInsets.all(16),

        child: Column(
          children: [

            _DashboardCard(
              title: 'IMC',
              value:
                  bmi.toStringAsFixed(1),
              subtitle:
                  bmiClassification,
            ),

            const SizedBox(height: 16),

            _DashboardCard(
              title:
                  'Água Recomendada',
              value:
                  '${(water / 1000).toStringAsFixed(1)} L',
              subtitle: 'por dia',
            ),

            const SizedBox(height: 16),

            _DashboardCard(
              title: 'Gasto Basal',
              value:
                  '${bmr.toStringAsFixed(0)} kcal',
              subtitle: 'por dia',
            ),

            const SizedBox(height: 16),

            _DashboardCard(
              title: 'Meta',
              value:
                  '${profile!.currentWeight}kg → ${profile!.targetWeight}kg',
              subtitle:
                  'Faltam ${(profile!.currentWeight - profile!.targetWeight).toStringAsFixed(1)}kg',
            ),

            const SizedBox(height: 24),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.water_drop),
                label: const Text(
                  'Controle de Água',
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const WaterPage(),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DashboardCard extends StatelessWidget {
  final String title;
  final String value;
  final String subtitle;

  const _DashboardCard({
    required this.title,
    required this.value,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding:
            const EdgeInsets.all(20),
        child: Column(
          children: [

            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight:
                    FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            Text(
              value,
              style: const TextStyle(
                fontSize: 28,
                fontWeight:
                    FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            Text(subtitle),
          ],
        ),
      ),
    );
  }
}