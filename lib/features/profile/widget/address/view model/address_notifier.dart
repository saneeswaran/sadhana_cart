import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sadhana_cart/features/profile/widget/address/model/address_model.dart';
import 'package:sadhana_cart/features/profile/widget/address/service/address_service.dart';

final addressAsync = FutureProvider<List<AddressModel>>((ref) async {
  return await AddressService.fetchAllAddress();
});

final addressprovider =
    StateNotifierProvider<AddressNotifier, List<AddressModel>>(
      (ref) => AddressNotifier(),
    );

class AddressNotifier extends StateNotifier<List<AddressModel>> {
  AddressNotifier() : super([]);

  void updateAddress() async {
    state = await AddressService.fetchAllAddress();
  }

  void deleteAddress({required String id}) {
    state = state.where((e) => e.id != id).toList();
  }
}
