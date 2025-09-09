import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class SubcategoryLoader extends StatelessWidget {
  const SubcategoryLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Skeletonizer(
        child: ListView.builder(
          itemCount: 10,
          scrollDirection: Axis.horizontal,
          physics: const AlwaysScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey,
              ),
            );
          },
        ),
      ),
    );
  }
}
