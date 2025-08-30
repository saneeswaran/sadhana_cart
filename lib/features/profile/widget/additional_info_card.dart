import 'package:flutter/material.dart';

class AdditionalInfoCard extends StatelessWidget {
  const AdditionalInfoCard({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 6,
      width: size.height * 1,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        border: Border.all(color: Colors.grey, width: 1.4),
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
          const Divider(color: Colors.grey),
          _customTile(
            icon: const Icon(Icons.wallet),
            text: "Payment Method",
            onTap: () {},
          ),
          const Divider(color: Colors.grey),
          _customTile(
            icon: const Icon(Icons.favorite),
            text: "Wishlist",
            onTap: () {},
          ),
          const Divider(color: Colors.grey),
          _customTile(
            icon: const Icon(Icons.star),
            text: "Rate this app",
            onTap: () {},
          ),
          const Divider(color: Colors.grey),
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
      title: Text(
        text,
        style: const TextStyle(
          color: Colors.black38,
          fontWeight: FontWeight.bold,
        ),
      ),
      trailing: trailing,
    );
  }
}
