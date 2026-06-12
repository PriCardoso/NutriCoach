import 'package:flutter/material.dart';

import '../../models/workout.dart';
import 'workout_service.dart';

class WorkoutPage extends StatefulWidget {
  const WorkoutPage({super.key});

  @override
  State<WorkoutPage> createState() =>
      _WorkoutPageState();
}

class _WorkoutPageState
    extends State<WorkoutPage> {

  final _service = WorkoutService();

  List<Workout> workouts = [];

  bool loading = true;

  @override
  void initState() {
    super.initState();
    loadWorkouts();
  }

  Future<void> loadWorkouts() async {

    final result =
        await _service.loadWorkouts();

    setState(() {
      workouts = result;
      loading = false;
    });
  }

  Future<void> showAddWorkoutDialog() async {

    final nameController =
        TextEditingController();

    final durationController =
        TextEditingController();

    final caloriesController =
        TextEditingController();

    String category =
        'Musculação';

    await showDialog(
      context: context,
      builder: (_) {

        return AlertDialog(
          title:
              const Text('Novo Treino'),

          content:
              SingleChildScrollView(
            child: Column(
              mainAxisSize:
                  MainAxisSize.min,

              children: [

                TextField(
                  controller:
                      nameController,
                  decoration:
                      const InputDecoration(
                    labelText:
                        'Nome',
                  ),
                ),

                const SizedBox(
                  height: 12,
                ),

                DropdownButtonFormField<
                    String>(
                  value: category,

                  items: const [

                    DropdownMenuItem(
                      value:
                          'Musculação',
                      child: Text(
                        'Musculação',
                      ),
                    ),

                    DropdownMenuItem(
                      value:
                          'Cardio',
                      child: Text(
                        'Cardio',
                      ),
                    ),

                    DropdownMenuItem(
                      value:
                          'Corrida',
                      child: Text(
                        'Corrida',
                      ),
                    ),

                    DropdownMenuItem(
                      value:
                          'Bike',
                      child: Text(
                        'Bike',
                      ),
                    ),
                  ],

                  onChanged: (value) {
                    category = value!;
                  },
                ),

                const SizedBox(
                  height: 12,
                ),

                TextField(
                  controller:
                      durationController,
                  keyboardType:
                      TextInputType.number,

                  decoration:
                      const InputDecoration(
                    labelText:
                        'Duração (min)',
                  ),
                ),

                const SizedBox(
                  height: 12,
                ),

                TextField(
                  controller:
                      caloriesController,
                  keyboardType:
                      TextInputType.number,

                  decoration:
                      const InputDecoration(
                    labelText:
                        'Calorias',
                  ),
                ),
              ],
            ),
          ),

          actions: [

            TextButton(
              onPressed: () {
                Navigator.pop(
                  context,
                );
              },
              child:
                  const Text('Cancelar'),
            ),

            ElevatedButton(
              onPressed: () async {

                await _service.addWorkout(
                  name:
                      nameController.text,

                  category:
                      category,

                  duration:
                      int.tryParse(
                            durationController
                                .text,
                          ) ??
                          0,

                  calories:
                      int.tryParse(
                            caloriesController
                                .text,
                          ) ??
                          0,
                );

                if (mounted) {
                  Navigator.pop(
                    context,
                  );
                }

                await loadWorkouts();
              },
              child:
                  const Text('Salvar'),
            ),
          ],
        );
      },
    );
  }

  IconData getWorkoutIcon(
    String category,
  ) {

    switch (category) {

      case 'Musculação':
        return Icons.fitness_center;

      case 'Corrida':
        return Icons.directions_run;

      case 'Bike':
        return Icons.directions_bike;

      default:
        return Icons.favorite;
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title:
            const Text('Meus Treinos'),
      ),

      floatingActionButton:
          FloatingActionButton(
        onPressed:
            showAddWorkoutDialog,

        child:
            const Icon(Icons.add),
      ),

      body: loading

          ? const Center(
              child:
                  CircularProgressIndicator(),
            )

          : workouts.isEmpty

              ? const Center(
                  child: Text(
                    'Nenhum treino cadastrado',
                  ),
                )

              : ListView.builder(
                  padding:
                      const EdgeInsets.all(
                    16,
                  ),

                  itemCount:
                      workouts.length,

                  itemBuilder:
                      (context, index) {

                    final workout =
                        workouts[index];

                    return Card(
                      margin:
                          const EdgeInsets.only(
                        bottom: 12,
                      ),

                      child: ListTile(

                        leading: CircleAvatar(
                          child: Icon(
                            getWorkoutIcon(
                              workout.category,
                            ),
                          ),
                        ),

                        title: Text(
                          workout.name,
                        ),

                        subtitle: Text(
                          '${workout.durationMinutes} min • ${workout.caloriesBurned} kcal',
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}