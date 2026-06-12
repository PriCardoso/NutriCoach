import 'package:flutter/material.dart';

import '../../models/weight_log.dart';
import 'weight_service.dart';

class WeightPage extends StatefulWidget {
  const WeightPage({super.key});

  @override
  State<WeightPage> createState() =>
      _WeightPageState();
}

class _WeightPageState
    extends State<WeightPage> {

  final _service = WeightService();

  List<WeightLog> weights = [];

  bool loading = true;

  @override
  void initState() {
    super.initState();
    loadWeights();
  }

  Future<void> loadWeights() async {

    final result =
        await _service.getWeights();

    setState(() {
      weights = result;
      loading = false;
    });
  }

  Future<void> addWeightDialog() async {

    final controller =
        TextEditingController();

    await showDialog(
      context: context,
      builder: (_) {

        return AlertDialog(

          title:
              const Text('Nova Pesagem'),

          content: TextField(
            controller: controller,
            keyboardType:
                const TextInputType.numberWithOptions(
              decimal: true,
            ),
            decoration:
                const InputDecoration(
              labelText: 'Peso (kg)',
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

                final weight =
                    double.tryParse(
                          controller.text
                              .replaceAll(
                                ',',
                                '.',
                              ),
                        ) ??
                        0;

                if (weight <= 0) {
                  return;
                }

                await _service.addWeight(
                  weight,
                );

                if (mounted) {
                  Navigator.pop(
                    context,
                  );
                }

                await loadWeights();
              },
              child:
                  const Text('Salvar'),
            ),
          ],
        );
      },
    );
  }

  String formatDate(
    DateTime date,
  ) {
    return '${date.day.toString().padLeft(2, '0')}/'
        '${date.month.toString().padLeft(2, '0')}/'
        '${date.year}';
  }

  @override
  Widget build(BuildContext context) {

    final latestWeight =
        weights.isNotEmpty
            ? weights.first.weight
            : null;

    return Scaffold(

      appBar: AppBar(
        title:
            const Text('Controle de Peso'),
      ),

      floatingActionButton:
          FloatingActionButton(
        onPressed: addWeightDialog,
        child:
            const Icon(Icons.add),
      ),

      body: loading

          ? const Center(
              child:
                  CircularProgressIndicator(),
            )

          : Column(

              children: [

                Container(
                  width: double.infinity,

                  margin:
                      const EdgeInsets.all(
                    16,
                  ),

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
                        BorderRadius.circular(
                      24,
                    ),
                  ),

                  child: Column(
                    children: [

                      const Icon(
                        Icons.monitor_weight,
                        color: Colors.white,
                        size: 48,
                      ),

                      const SizedBox(
                        height: 12,
                      ),

                      Text(
                        latestWeight == null
                            ? '--'
                            : '${latestWeight.toStringAsFixed(1)} kg',
                        style:
                            const TextStyle(
                          color:
                              Colors.white,
                          fontSize: 32,
                          fontWeight:
                              FontWeight.bold,
                        ),
                      ),

                      const SizedBox(
                        height: 8,
                      ),

                      const Text(
                        'Última pesagem',
                        style: TextStyle(
                          color:
                              Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ),

                Expanded(

                  child:
                      weights.isEmpty

                          ? const Center(
                              child: Text(
                                'Nenhuma pesagem registrada',
                              ),
                            )

                          : ListView.builder(

                              padding:
                                  const EdgeInsets.symmetric(
                                horizontal:
                                    16,
                              ),

                              itemCount:
                                  weights.length,

                              itemBuilder:
                                  (
                                    context,
                                    index,
                                  ) {

                                final item =
                                    weights[index];

                                return Card(

                                  margin:
                                      const EdgeInsets.only(
                                    bottom:
                                        12,
                                  ),

                                  child:
                                      ListTile(

                                    leading:
                                        const CircleAvatar(
                                      child:
                                          Icon(
                                        Icons.monitor_weight,
                                      ),
                                    ),

                                    title:
                                        Text(
                                      '${item.weight.toStringAsFixed(1)} kg',
                                    ),

                                    subtitle:
                                        Text(
                                      formatDate(
                                        item.createdAt,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                ),
              ],
            ),
    );
  }
}