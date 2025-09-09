import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class SubcategoryLoader extends StatelessWidget {
  const SubcategoryLoader({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Skeletonizer(
      child: Scaffold(
        appBar: AppBar(title: const Text("Subcategory"), centerTitle: true),
        body: Padding(
          padding: const EdgeInsets.only(top: 50),
          child: SizedBox(
            height: 60,
            width: double.infinity,
            child: ListView.builder(
              itemCount: 10,
              scrollDirection: Axis.horizontal,
              physics: const AlwaysScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 10,
                  ),
                  height: 100,
                  width: size.width * 0.2,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
