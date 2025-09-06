import 'package:flutter/material.dart';
import 'package:sadhana_cart/core/colors/app_colors.dart';

class CustomProgressIndicator extends StatelessWidget {
  final List<Map<String, dynamic>> ratingData;

  const CustomProgressIndicator({super.key, required this.ratingData});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: ratingData.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final rating = ratingData[index];
        final ratingStars = rating['stars'];
        final percentage = rating['percentage'] / 100.0;

        return Row(
          children: [
            Text(
              "$ratingStars",
              style: const TextStyle(
                color: AppColors.onboardButtonColor,
                fontSize: 16,
              ),
            ),
            const Icon(Icons.star, color: AppColors.ratingColor),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: LinearProgressIndicator(
                  value: percentage,
                  backgroundColor: AppColors.switchTileColor,
                  valueColor: const AlwaysStoppedAnimation<Color>(
                    AppColors.ratingColor,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            // Percentage text
            Text(
              "${(percentage * 100).toStringAsFixed(0)}%",
              style: const TextStyle(
                color: AppColors.ratingColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        );
      },
    );
  }
}
