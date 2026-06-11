import '../../models/user_profile.dart';
import '../profile/profile_service.dart';

class DashboardService {
  final _profileService = ProfileService();

  Future<UserProfile?> loadProfile() async {
    return await _profileService.getProfile();
  }
}