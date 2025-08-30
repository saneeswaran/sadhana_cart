import 'package:flutter/material.dart';
import 'package:sadhana_cart/core/helper/navigation_helper.dart';
import 'package:sadhana_cart/features/favorites/view/favorite_page_mobile.dart';

class AdditionalInfoCard extends StatelessWidget {
  const AdditionalInfoCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade300, width: 1.4),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          _customTile(
            icon: const Icon(Icons.location_on),
            text: "Address",
            onTap: () {},
          ),
          Divider(color: Colors.grey.shade300),
          _customTile(
            icon: const Icon(Icons.wallet),
            text: "Payment Method",
            onTap: () {},
          ),
          Divider(color: Colors.grey.shade300),
          _customTile(
            icon: const Icon(Icons.favorite),
            text: "Wishlist",
            onTap: () {
              navigateTo(context: context, screen: const FavoritePageMobile());
            },
          ),
          Divider(color: Colors.grey.shade300),
          _customTile(
            icon: const Icon(Icons.star),
            text: "Rate this app",
            onTap: () {},
          ),
          Divider(color: Colors.grey.shade300),
          _customTile(
            icon: const Icon(Icons.logout),
            text: "Logout",
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget _customTile({
    required Icon icon,
    required String text,
    required VoidCallback onTap,
    Widget? trailing,
  }) {
    return ListTile(
      leading: icon,
      onTap: onTap,
      title: Text(
        text,
        style: const TextStyle(
          color: Colors.black38,
          fontWeight: FontWeight.w400,
        ),
      ),
      trailing: trailing,
    );
  }
}
