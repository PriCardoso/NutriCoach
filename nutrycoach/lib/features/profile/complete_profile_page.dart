import 'package:flutter/material.dart';

import '../../models/user_profile.dart';
import 'profile_service.dart';
import '../dashboard/dashboard_page.dart';

class CompleteProfilePage extends StatefulWidget {
  const CompleteProfilePage({super.key});

  @override
  State<CompleteProfilePage> createState() =>
      _CompleteProfilePageState();
}

class _CompleteProfilePageState
    extends State<CompleteProfilePage> {

  final _nameController = TextEditingController();
  final _heightController = TextEditingController();
  final _weightController = TextEditingController();
  final _targetWeightController =
      TextEditingController();

  final _service = ProfileService();

  DateTime? birthDate;

  String gender = 'Feminino';

  String goal = 'Emagrecer';

  String activityLevel =
      'Levemente ativo';

  bool loading = false;

  Future<void> saveProfile() async {

    try {

      setState(() {
        loading = true;
      });

      //final user =
      //    _service.currentUser;

      final user = _service.currentUser;
        debugPrint(
        'USER ID => ${user?.id}',
        );

        debugPrint(
        'USUARIO LOGADO => ${user?.id}',
        );

        if (user == null) {
        throw Exception(
            'Usuário não encontrado. Faça login novamente.',
        );
        }

        final profile = UserProfile(
          id: user!.id,
          name: _nameController.text,
          gender: gender,
          birthDate: birthDate,

          height: double.tryParse(
            _heightController.text.replaceAll(',', '.'),
          ) ?? 0,

          currentWeight: double.tryParse(
            _weightController.text.replaceAll(',', '.'),
          ) ?? 0,

          targetWeight: double.tryParse(
            _targetWeightController.text.replaceAll(',', '.'),
          ) ?? 0,

          activityLevel: activityLevel,
          goal: goal,
        );

      debugPrint(
        profile.toMap().toString(),
        );

      await _service.saveProfile(
        profile,
      );

      if (!mounted) return;

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder:
              (_) =>
                  const DashboardPage(),
        ),
        (_) => false,
      );
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

  Future<void> selectBirthDate() async {

    final date =
        await showDatePicker(
      context: context,
      firstDate:
          DateTime(1950),
      lastDate:
          DateTime.now(),
      initialDate:
          DateTime(2000),
    );

    if (date == null) return;

    setState(() {
      birthDate = date;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Complete seu Perfil',
        ),
      ),
      body: SingleChildScrollView(
        padding:
            const EdgeInsets.all(20),
        child: Column(
          children: [

            TextField(
              controller:
                  _nameController,
              decoration:
                  const InputDecoration(
                labelText: 'Nome',
              ),
            ),

            const SizedBox(
              height: 16,
            ),

            TextField(
              controller:
                  _heightController,
              keyboardType:
                  TextInputType.number,
              decoration:
                  const InputDecoration(
                labelText:
                    'Altura (m)',
              ),
            ),

            const SizedBox(
              height: 16,
            ),

            TextField(
              controller:
                  _weightController,
              keyboardType:
                  TextInputType.number,
              decoration:
                  const InputDecoration(
                labelText:
                    'Peso Atual',
              ),
            ),

            const SizedBox(
              height: 16,
            ),

            TextField(
              controller:
                  _targetWeightController,
              keyboardType:
                  TextInputType.number,
              decoration:
                  const InputDecoration(
                labelText:
                    'Peso Meta',
              ),
            ),

            const SizedBox(
              height: 16,
            ),

            ListTile(
              title: Text(
                birthDate == null
                    ? 'Selecionar Data de Nascimento'
                    : birthDate
                        .toString()
                        .split(' ')
                        .first,
              ),
              trailing:
                  const Icon(
                Icons.calendar_month,
              ),
              onTap:
                  selectBirthDate,
            ),

            const SizedBox(
              height: 24,
            ),

            SizedBox(
              width:
                  double.infinity,
              child:
                  ElevatedButton(
                onPressed:
                    loading
                        ? null
                        : saveProfile,
                child: Text(
                  loading
                      ? 'Salvando...'
                      : 'Finalizar Cadastro',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}