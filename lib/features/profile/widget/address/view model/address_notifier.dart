import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sadhana_cart/core/helper/geolocation_helper.dart';
import 'package:sadhana_cart/features/profile/widget/address/model/address_model.dart';
import 'package:sadhana_cart/features/profile/widget/address/service/address_service.dart';

final addressAsync = FutureProvider<List<AddressModel>>((ref) async {
  return await AddressService.fetchAllAddress();
});

final addressprovider =
    StateNotifierProvider<AddressNotifier, List<AddressModel>>(
      (ref) => AddressNotifier(),
    );

final getCurrentLocationProvider = FutureProvider<AddressModel?>((ref) async {
  return await GeolocationHelper.getCurrentLocationAndFillAddressDetails();
});

class AddressNotifier extends StateNotifier<List<AddressModel>> {
  AddressNotifier() : super([]);

  void updateAddress() async {
    state = await AddressService.fetchAllAddress();
  }

  void deleteAddress({required AddressModel address}) {
    state = state.where((e) => e.id != address.id).toList();
  }

  void addAddress({required AddressModel address}) {
    state = [...state, address];
  }
}
