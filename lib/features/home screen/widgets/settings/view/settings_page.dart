import 'package:flutter/material.dart';
import 'package:sadhana_cart/core/helper/navigation_helper.dart';
import 'package:sadhana_cart/features/home%20screen/widgets/settings/widgets/notification_page.dart';
import 'package:sadhana_cart/features/home%20screen/widgets/settings/widgets/settings_tile.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Settings",
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            SettingsTile(
              icon: Icons.notifications,
              text: "Notifications",
              onTap: () => navigateTo(
                context: context,
                screen: const NotificationPage(),
              ),
            ),
            SettingsTile(
              icon: Icons.policy,
              text: "Terms of Use",
              onTap: () {},
            ),
            SettingsTile(
              icon: Icons.privacy_tip_outlined,
              text: "Privacy Policy",
              onTap: () {},
            ),
            SettingsTile(icon: Icons.chat, text: "Chat Support", onTap: () {}),
          ],
        ),
      ),
    );
  }
}
