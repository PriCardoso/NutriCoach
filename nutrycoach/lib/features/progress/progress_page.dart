import 'package:flutter/material.dart';

import 'progress_service.dart';

class ProgressPage extends StatefulWidget {
  const ProgressPage({super.key});

  @override
  State<ProgressPage> createState() =>
      _ProgressPageState();
}

class _ProgressPageState
    extends State<ProgressPage> {

  final service =
      ProgressService();

  final weightController =
      TextEditingController();

  final chestController =
      TextEditingController();

  final waistController =
      TextEditingController();

  final abdomenController =
      TextEditingController();

  final hipController =
      TextEditingController();

  final armController =
      TextEditingController();

  final thighController =
      TextEditingController();

  bool loading = false;

  Future<void> save() async {

    setState(() {
      loading = true;
    });

    await service.saveProgress(
      weight:
          double.tryParse(
            weightController.text,
          ) ??
          0,

      chest:
          double.tryParse(
            chestController.text,
          ) ??
          0,

      waist:
          double.tryParse(
            waistController.text,
          ) ??
          0,

      abdomen:
          double.tryParse(
            abdomenController.text,
          ) ??
          0,

      hip:
          double.tryParse(
            hipController.text,
          ) ??
          0,

      arm:
          double.tryParse(
            armController.text,
          ) ??
          0,

      thigh:
          double.tryParse(
            thighController.text,
          ) ??
          0,
    );

    if (mounted) {

      ScaffoldMessenger.of(context)
          .showSnackBar(
        const SnackBar(
          content: Text(
            'Progresso salvo!',
          ),
        ),
      );

      Navigator.pop(context);
    }
  }

  Widget buildField(
    String label,
    TextEditingController controller,
  ) {
    return Padding(
      padding:
          const EdgeInsets.only(
        bottom: 12,
      ),
      child: TextField(
        controller: controller,
        keyboardType:
            TextInputType.number,

        decoration: InputDecoration(
          labelText: label,
          border:
              OutlineInputBorder(
            borderRadius:
                BorderRadius.circular(
              16,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Registrar Evolução',
        ),
      ),

      body: SingleChildScrollView(
        padding:
            const EdgeInsets.all(16),

        child: Column(
          children: [

            buildField(
              'Peso',
              weightController,
            ),

            buildField(
              'Peito',
              chestController,
            ),

            buildField(
              'Cintura',
              waistController,
            ),

            buildField(
              'Abdômen',
              abdomenController,
            ),

            buildField(
              'Quadril',
              hipController,
            ),

            buildField(
              'Braço',
              armController,
            ),

            buildField(
              'Coxa',
              thighController,
            ),

            const SizedBox(
              height: 24,
            ),

            SizedBox(
              width:
                  double.infinity,

              child: ElevatedButton(
                onPressed:
                    loading
                        ? null
                        : save,

                child: Text(
                  loading
                      ? 'Salvando...'
                      : 'Salvar Evolução',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}