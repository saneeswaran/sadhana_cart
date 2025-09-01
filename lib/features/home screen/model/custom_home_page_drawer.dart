import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sadhana_cart/core/colors/app_colors.dart';
import 'package:sadhana_cart/core/constants/app_images.dart';
import 'package:sadhana_cart/core/disposable/disposable.dart';
import 'package:sadhana_cart/core/widgets/loader.dart';
import 'package:sadhana_cart/features/profile/view%20model/user_notifier.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CustomHomePageDrawer extends ConsumerWidget {
  const CustomHomePageDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userProvider = ref.watch(getCurrentUserProfile);
    final loader = ref.watch(loadingProvider);
    return Drawer(
      child: userProvider.when(
        data: (user) {
          return Column(
            children: [
              DrawerHeader(
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
                        title: loader
                            ? const Skeletonizer(child: Text("             "))
                            : Text(user.name ?? ""),
                        subtitle: loader
                            ? const Skeletonizer(child: Text("             "))
                            : Text(user.email ?? ""),
                      ),
                    ),
                  ],
                ),
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
          );
        },
        error: (error, stackTrace) => Text(error.toString()),
        loading: () => const Loader(),
      ),
    );
  }
}
