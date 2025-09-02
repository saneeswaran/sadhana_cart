import 'package:flutter/material.dart';
import 'package:sadhana_cart/features/home%20screen/widgets/settings/widgets/settings_tile.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            SettingsTile(
              icon: Icons.notifications,
              text: "Notifications",
              onTap: () {},
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
