import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sadhana_cart/core/colors/app_colors.dart';
import 'package:sadhana_cart/core/helper/navigation_helper.dart';
import 'package:sadhana_cart/features/profile/widget/address/view%20model/address_notifier.dart';
import 'package:sadhana_cart/features/profile/widget/address/widget/add_address_page.dart';
import 'package:sadhana_cart/features/profile/widget/address/widget/user_address_data.dart';

class UserAddressPage extends StatelessWidget {
  const UserAddressPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Saved Addresses",
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        elevation: 0.0,
        backgroundColor: AppColors.primaryColor,
        onPressed: () {
          navigateTo(context: context, screen: const AddAddressPage());
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: Consumer(
        builder: (context, ref, child) {
          final addressLoader = ref.watch(addressAsync);
          return addressLoader.when(
            data: (data) {
              return data.isEmpty
                  ? const Center(child: Text("No Address"))
                  : ListView.builder(
                      itemCount: data.length,
                      shrinkWrap: true,
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return UserAddressData(address: data[index]);
                      },
                    );
            },
            error: (error, stackTrce) => Center(child: Text(error.toString())),
            loading: () => ListView.builder(
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              itemBuilder: (context, index) {
                return const ListTile();
              },
            ),
          );
        },
      ),
    );
  }
}
