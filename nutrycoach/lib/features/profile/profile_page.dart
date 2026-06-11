import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../models/user_profile.dart';
import 'profile_service.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  final _service = ProfileService();

  final _nameController = TextEditingController();
  final _heightController = TextEditingController();
  final _weightController = TextEditingController();
  final _targetWeightController = TextEditingController();

  String goal = 'Emagrecer';
  String gender = 'Feminino';
  String activityLevel = 'Levemente ativo';

  bool loading = false;

  @override
  void initState() {
    super.initState();
    loadProfile();
  }

  Future<void> loadProfile() async {
    final profile = await _service.getProfile();

    if (profile == null) return;

    _nameController.text = profile.name;
    _heightController.text = profile.height.toString();
    _weightController.text = profile.currentWeight.toString();
    _targetWeightController.text = profile.targetWeight.toString();

    setState(() {
      goal = profile.goal;
      gender = profile.gender;
      activityLevel = profile.activityLevel;
    });
  }

  Future<void> saveProfile() async {
    setState(() {
      loading = true;
    });

    try {
      final user = Supabase.instance.client.auth.currentUser;

      if (user == null) {
        throw Exception('Usuário não autenticado');
      }

      final profile = UserProfile(
        id: user.id,
        name: _nameController.text,
        gender: gender,
        height: double.tryParse(_heightController.text) ?? 0,
        currentWeight: double.tryParse(_weightController.text) ?? 0,
        targetWeight: double.tryParse(_targetWeightController.text) ?? 0,
        activityLevel: activityLevel,
        goal: goal,
      );

      await _service.saveProfile(profile);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Perfil salvo com sucesso'),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString()),
          ),
        );
      }
    }

    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Meu Perfil'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Nome',
              ),
            ),

            const SizedBox(height: 16),

            DropdownButtonFormField<String>(
              value: gender,
              items: const [
                DropdownMenuItem(
                  value: 'Feminino',
                  child: Text('Feminino'),
                ),
                DropdownMenuItem(
                  value: 'Masculino',
                  child: Text('Masculino'),
                ),
              ],
              onChanged: (value) {
                setState(() {
                  gender = value!;
                });
              },
            ),

            const SizedBox(height: 16),

            TextField(
              controller: _heightController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Altura (m)',
              ),
            ),

            const SizedBox(height: 16),

            TextField(
              controller: _weightController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Peso Atual (kg)',
              ),
            ),

            const SizedBox(height: 16),

            TextField(
              controller: _targetWeightController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Peso Meta (kg)',
              ),
            ),

            const SizedBox(height: 16),

            DropdownButtonFormField<String>(
              value: activityLevel,
              items: const [
                DropdownMenuItem(
                  value: 'Sedentário',
                  child: Text('Sedentário'),
                ),
                DropdownMenuItem(
                  value: 'Levemente ativo',
                  child: Text('Levemente ativo'),
                ),
                DropdownMenuItem(
                  value: 'Moderadamente ativo',
                  child: Text('Moderadamente ativo'),
                ),
                DropdownMenuItem(
                  value: 'Muito ativo',
                  child: Text('Muito ativo'),
                ),
              ],
              onChanged: (value) {
                setState(() {
                  activityLevel = value!;
                });
              },
            ),

            const SizedBox(height: 16),

            DropdownButtonFormField<String>(
              value: goal,
              items: const [
                DropdownMenuItem(
                  value: 'Emagrecer',
                  child: Text('Emagrecer'),
                ),
                DropdownMenuItem(
                  value: 'Hipertrofia',
                  child: Text('Hipertrofia'),
                ),
                DropdownMenuItem(
                  value: 'Manutenção',
                  child: Text('Manutenção'),
                ),
              ],
              onChanged: (value) {
                setState(() {
                  goal = value!;
                });
              },
            ),

            const SizedBox(height: 24),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: loading ? null : saveProfile,
                child: Text(
                  loading
                      ? 'Salvando...'
                      : 'Salvar Perfil',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}