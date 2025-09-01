import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sadhana_cart/core/constants/app_images.dart';
import 'package:sadhana_cart/core/helper/navigation_helper.dart';
import 'package:sadhana_cart/features/profile/service/user_service.dart';
import 'package:sadhana_cart/features/profile/view%20model/user_notifier.dart';
import 'package:sadhana_cart/features/profile/widget/edit_profile_settings.dart';

class ProfileCard extends ConsumerWidget {
  const ProfileCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Size size = MediaQuery.of(context).size;
    final user = ref.watch(userProvider);
    return Container(
      height: size.height * 0.15,
      width: size.width * 1,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            height: size.height * 0.1,
            width: size.width * 0.3,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: CachedNetworkImageProvider(
                  AppImages.noProfile,
                  cacheKey: AppImages.noProfile,
                ),
              ),
            ),
          ),
          Expanded(
            child: ListTile(
              onTap: () async {
                final userid = FirebaseAuth.instance.currentUser!.uid;
                final data = await UserService.getCurrentUserProfile();
                log(userid.toString());
                log(data.toString());
              },
              title: Text(user?.name ?? ""),
              subtitle: Text(user?.email ?? ""),
              trailing: IconButton(
                onPressed: () {
                  navigateTo(
                    context: context,
                    screen: const EditProfileSettings(),
                  );
                },
                icon: const Icon(Icons.settings),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
