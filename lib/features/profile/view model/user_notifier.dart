import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sadhana_cart/core/common%20model/customer/customer_model.dart';
import 'package:sadhana_cart/features/profile/service/user_service.dart';

final userProvider = StateNotifierProvider<UserNotifier, CustomerModel?>(
  (ref) => UserNotifier(ref),
);

final getCurrentUserProfile = FutureProvider<CustomerModel?>((ref) async {
  return await UserService.getCurrentUserProfile();
});

class UserNotifier extends StateNotifier<CustomerModel?> {
  final Ref ref;
  UserNotifier(this.ref) : super(null);

  void fetchCurrentUserProfile() async {
    state = await UserService.getCurrentUserProfile();
  }
}
