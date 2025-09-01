import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sadhana_cart/features/profile/model/user_model.dart';
import 'package:sadhana_cart/features/profile/service/user_service.dart';

final userProvider = StateNotifierProvider<UserNotifier, UserModel?>(
  (ref) => UserNotifier(ref),
);

final getCurrentUserProfile = FutureProvider<UserModel?>((ref) async {
  return await UserService.getCurrentUserProfile();
});

class UserNotifier extends StateNotifier<UserModel?> {
  final Ref ref;
  UserNotifier(this.ref) : super(null);

  void fetchCurrentUserProfile() async {
    state = await UserService.getCurrentUserProfile();
  }
}
