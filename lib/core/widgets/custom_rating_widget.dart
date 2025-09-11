import 'package:flutter/material.dart';
import 'package:flutter_rating/flutter_rating.dart';

Future<void> showRatingDialog({
  required BuildContext context,
  required void Function(double rating, String review) onSubmit,
}) {
  double userRating = 0.0;
  final TextEditingController reviewController = TextEditingController();

  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Rate this Product'),
        content: StatefulBuilder(
          builder: (context, setState) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                StarRating(
                  rating: userRating,
                  size: 36,
                  color: Colors.amber,
                  starCount: 5,
                  allowHalfRating: true,
                  onRatingChanged: (rating) {
                    setState(() {
                      userRating = rating;
                    });
                  },
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: reviewController,
                  maxLines: 3,
                  decoration: const InputDecoration(
                    hintText: 'Write your review...',
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            );
          },
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              final review = reviewController.text.trim();
              if (userRating > 0 && review.isNotEmpty) {
                onSubmit(userRating, review);
                Navigator.pop(context);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Please give rating and review'),
                  ),
                );
              }
            },
            child: const Text('Submit'),
          ),
        ],
      );
    },
  );
}
