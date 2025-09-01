import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sadhana_cart/core/colors/app_colors.dart';
import 'package:sadhana_cart/core/constants/app_images.dart';
import 'package:sadhana_cart/features/profile/view%20model/user_notifier.dart';

class CustomHomePageDrawer extends StatelessWidget {
  const CustomHomePageDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Consumer(
            builder: (context, ref, child) {
              final user = ref.watch(userProvider);
              return DrawerHeader(
                child: Row(
                  children: [
                    const SizedBox(width: 10),
                    CircleAvatar(
                      backgroundColor: Colors.grey,
                      radius: 40,
                      backgroundImage: CachedNetworkImageProvider(
                        user!.image ?? AppImages.noProfile,
                      ),
                    ),
                    Expanded(
                      child: ListTile(
                        title: Text(user.name ?? ""),
                        subtitle: Text(user.email ?? ""),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          ListTile(
            onTap: () {},
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
            leading: const Icon(
              Icons.support_agent,
              color: AppColors.tileColor,
            ),
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
      ),
    );
  }
}
