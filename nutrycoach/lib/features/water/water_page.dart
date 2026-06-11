import 'package:flutter/material.dart';

import '../../models/water_log.dart';
import '../../services/water_service.dart';
import 'water_service.dart';

class WaterPage extends StatefulWidget {
  const WaterPage({super.key});

  @override
  State<WaterPage> createState() =>
      _WaterPageState();
}

class _WaterPageState
    extends State<WaterPage> {

  final service =
      WaterTrackingService();

  List<WaterLog> logs = [];

  bool loading = true;

  double goalMl = 2800;

  @override
  void initState() {
    super.initState();
    loadLogs();
  }

  Future<void> loadLogs() async {

    final result =
        await service.getTodayWaterLogs();

    setState(() {
      logs = result;
      loading = false;
    });
  }

  Future<void> addWater(
    int amount,
  ) async {

    try {

  await service.addWater(amount);

  await loadLogs();

  if (mounted) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '$amount ml adicionados',
        ),
      ),
    );
  }

} catch (e) {

  if (mounted) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          e.toString(),
        ),
      ),
    );
  }
}
  }

  @override
  Widget build(BuildContext context) {

    final consumed =
        logs.fold<int>(
      0,
      (sum, item) =>
          sum + item.amountMl,
    );

    final progress =
        consumed / goalMl;

    return Scaffold(
      appBar: AppBar(
        title:
            const Text('Hidratação'),
      ),
      body: Padding(
        padding:
            const EdgeInsets.all(16),
        child: Column(
          children: [

            Text(
              '${(consumed / 1000).toStringAsFixed(1)} L',
              style:
                  const TextStyle(
                fontSize: 36,
                fontWeight:
                    FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            LinearProgressIndicator(
              value: progress > 1
                  ? 1
                  : progress,
            ),

            const SizedBox(height: 8),

            Text(
              '${goalMl.toInt()} ml por dia',
            ),

            const SizedBox(height: 30),

            Wrap(
              spacing: 12,
              children: [

                ElevatedButton(
                  onPressed: () =>
                      addWater(200),
                  child:
                      const Text('+200ml'),
                ),

                ElevatedButton(
                  onPressed: () =>
                      addWater(300),
                  child:
                      const Text('+300ml'),
                ),

                ElevatedButton(
                  onPressed: () =>
                      addWater(500),
                  child:
                      const Text('+500ml'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}