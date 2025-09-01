import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sadhana_cart/core/disposable/disposable.dart';
import 'package:sadhana_cart/features/profile/model/user_model.dart';
import 'package:sadhana_cart/features/profile/service/user_service.dart';

final userProvider = StateNotifierProvider<UserNotifier, UserModel?>(
  (ref) => UserNotifier(ref),
);

final getCurrentUserProfile = FutureProvider<UserModel?>((ref) async {
  ref.read(loadingProvider.notifier).state = true;
  final data = await UserService.getCurrentUserProfile(ref: ref);
  ref.read(loadingProvider.notifier).state = false;
  return data;
});

class UserNotifier extends StateNotifier<UserModel?> {
  final Ref ref;
  UserNotifier(this.ref) : super(null);

  void fetchCurrentUserProfile() async {
    state = await UserService.getCurrentUserProfile(ref: ref);
  }
}
