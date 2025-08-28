import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sadhana_cart/features/profile/model/user_model.dart';
import 'package:sadhana_cart/features/profile/service/user_service.dart';

final userProvider = StateNotifierProvider<UserNotifier, UserModel?>(
  (ref) => UserNotifier()..fetchCurrentUserProfile(),
);

class UserNotifier extends StateNotifier<UserModel?> {
  UserNotifier() : super(null);

  void fetchCurrentUserProfile() async {
    state = await UserService.getCurrentUserProfile();
  }
}
