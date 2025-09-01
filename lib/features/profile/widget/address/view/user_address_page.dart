import 'package:flutter/material.dart';
import 'package:sadhana_cart/core/colors/app_colors.dart';
import 'package:sadhana_cart/core/helper/navigation_helper.dart';
import 'package:sadhana_cart/features/profile/widget/address/widget/add_address_page.dart';

class UserAddressPage extends StatelessWidget {
  const UserAddressPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        elevation: 0.0,
        backgroundColor: AppColors.primaryColor,
        onPressed: () {
          navigateTo(context: context, screen: const AddAddressPage());
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
