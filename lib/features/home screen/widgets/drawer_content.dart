import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sadhana_cart/core/colors/app_colors.dart';
import 'package:sadhana_cart/core/common%20model/customer/customer_model.dart';
import 'package:sadhana_cart/core/constants/app_images.dart';
import 'package:sadhana_cart/core/helper/navigation_helper.dart';
import 'package:sadhana_cart/features/home%20screen/widgets/settings/view/settings_page.dart';

class DrawerContent extends StatelessWidget {
  final CustomerModel? user;
  const DrawerContent({super.key, this.user});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DrawerHeader(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(width: 10),
              CircleAvatar(
                radius: 40,
                backgroundColor: Colors.grey.shade300,
                backgroundImage: _getImageProvider(user?.profileImage),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: ListTile(
                  title: Text(user?.name ?? "John Doe"),
                  subtitle: Text(user?.email ?? "johndoe@example.com"),
                ),
              ),
            ],
          ),
        ),
        ListTile(
          onTap: () =>
              navigateTo(context: context, screen: const SettingsPage()),
          leading: const Icon(Icons.settings, color: AppColors.tileColor),
          title: const Text(
            "Settings",
            style: TextStyle(
              color: AppColors.tileColor,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        ListTile(
          onTap: () {},
          leading: const Icon(Icons.support_agent, color: AppColors.tileColor),
          title: const Text(
            "Support",
            style: TextStyle(
              color: AppColors.tileColor,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        ListTile(
          onTap: () {},
          leading: const Icon(Icons.info, color: AppColors.tileColor),
          title: const Text(
            "About Us",
            style: TextStyle(
              color: AppColors.tileColor,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  ImageProvider _getImageProvider(String? url) {
    if (url == null || url.isEmpty || !url.startsWith('http')) {
      return const AssetImage(AppImages.noProfile);
    } else {
      return CachedNetworkImageProvider(url);
    }
  }
}
