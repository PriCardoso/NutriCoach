import 'package:flutter/material.dart';

import '../../models/user_profile.dart';
import 'profile_service.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({
    super.key,
    required this.profile,
  });

  final UserProfile profile;

  @override
  State<EditProfilePage> createState() =>
      _EditProfilePageState();
}

class _EditProfilePageState
    extends State<EditProfilePage> {

  final _service = ProfileService();

  late TextEditingController nameController;
  late TextEditingController heightController;
  late TextEditingController weightController;
  late TextEditingController targetWeightController;

  late String gender;
  late String goal;
  late String activityLevel;

  bool loading = false;

  @override
  void initState() {
    super.initState();

    nameController =
        TextEditingController(
      text: widget.profile.name,
    );

    heightController =
        TextEditingController(
      text: widget.profile.height.toString(),
    );

    weightController =
        TextEditingController(
      text:
          widget.profile.currentWeight
              .toString(),
    );

    targetWeightController =
        TextEditingController(
      text:
          widget.profile.targetWeight
              .toString(),
    );

    gender = widget.profile.gender;
    goal = widget.profile.goal;
    activityLevel =
        widget.profile.activityLevel;
  }

  Future<void> save() async {

    try {

      setState(() {
        loading = true;
      });

      final profile = UserProfile(
        id: widget.profile.id,
        name: nameController.text,
        gender: gender,
        birthDate:
            widget.profile.birthDate,
        height:
            double.tryParse(
                  heightController.text,
                ) ??
                0,
        currentWeight:
            double.tryParse(
                  weightController.text,
                ) ??
                0,
        targetWeight:
            double.tryParse(
                  targetWeightController.text,
                ) ??
                0,
        activityLevel:
            activityLevel,
        goal: goal,
      );

      await _service.saveProfile(
        profile,
      );

      if (!mounted) return;

      Navigator.pop(context, true);

    } catch (e) {

      ScaffoldMessenger.of(context)
          .showSnackBar(
        SnackBar(
          content: Text(
            e.toString(),
          ),
        ),
      );
    }

    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Editar Perfil',
        ),
      ),
      body: SingleChildScrollView(
        padding:
            const EdgeInsets.all(20),
        child: Column(
          children: [

            TextField(
              controller:
                  nameController,
              decoration:
                  const InputDecoration(
                labelText: 'Nome',
              ),
            ),

            const SizedBox(height: 16),

            TextField(
              controller:
                  heightController,
              keyboardType:
                  TextInputType.number,
              decoration:
                  const InputDecoration(
                labelText:
                    'Altura (m)',
              ),
            ),

            const SizedBox(height: 16),

            TextField(
              controller:
                  weightController,
              keyboardType:
                  TextInputType.number,
              decoration:
                  const InputDecoration(
                labelText:
                    'Peso Atual',
              ),
            ),

            const SizedBox(height: 16),

            TextField(
              controller:
                  targetWeightController,
              keyboardType:
                  TextInputType.number,
              decoration:
                  const InputDecoration(
                labelText:
                    'Peso Meta',
              ),
            ),

            const SizedBox(height: 24),

            SizedBox(
              width:
                  double.infinity,
              child:
                  ElevatedButton(
                onPressed:
                    loading
                        ? null
                        : save,
                child: Text(
                  loading
                      ? 'Salvando...'
                      : 'Salvar Alterações',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}