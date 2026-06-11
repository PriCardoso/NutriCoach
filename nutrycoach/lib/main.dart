import 'package:flutter/material.dart';

import 'features/profile/profile_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'features/auth/auth_gate.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://yrqdmxtbzegpddkwxmcg.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InlycWRteHRiemVncGRka3d4bWNnIiwicm9sZSI6ImFub24iLCJpYXQiOjE3ODExNTEwNDYsImV4cCI6MjA5NjcyNzA0Nn0.vpLQQTIZMt60-hjR7GBzkZBU4sEj7rqY8hZW1PsSFcM',
  );

  runApp(const NutryCoachApp());
}

class NutryCoachApp extends StatelessWidget {
  const NutryCoachApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NutryCoach',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.green,
        ),
        useMaterial3: true,
      ),
      home: const AuthGate(),
    );
  }
}