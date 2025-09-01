import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sadhana_cart/features/profile/widget/address/model/address_model.dart';

class AddressNotifier extends StateNotifier<List<AddressModel>> {
  AddressNotifier() : super([]);
}
