import 'package:flutter/material.dart';
import 'package:sadhana_cart/core/colors/app_colors.dart';
import 'package:sadhana_cart/features/notification/widgets/notification_tile.dart';

class NotificationPageMobile extends StatelessWidget {
  const NotificationPageMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(height: 20),
            Center(
              child: Text(
                "Notifications",
                style: TextStyle(
                  color: AppColors.primaryColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            NotificationTile(),
          ],
        ),
      ),
    );
  }
}
