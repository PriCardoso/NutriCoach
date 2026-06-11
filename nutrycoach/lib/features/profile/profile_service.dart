import 'package:supabase_flutter/supabase_flutter.dart';

import '../../models/user_profile.dart';
import 'package:flutter/foundation.dart';

class ProfileService {
  final _supabase = Supabase.instance.client;

 Future<void> saveProfile(
  UserProfile profile,
) async {

  try {

    final result =
        await _supabase
            .from('profiles')
            .upsert(
              profile.toMap(),
            )
            .select();

    print(
    'SAVE PROFILE => $result',
  );

  } catch (e) {

    print(
    'ERRO PROFILE => $e',
  );

    rethrow;
  }
}

  Future<UserProfile?> getProfile() async {
    final user = _supabase.auth.currentUser;

    if (user == null) return null;

    final response = await _supabase
        .from('profiles')
        .select()
        .eq('id', user.id)
        .maybeSingle();

    if (response == null) return null;

    return UserProfile.fromMap(response);
  }

  User? get currentUser =>
    Supabase.instance.client.auth.currentUser;
}