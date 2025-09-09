import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sadhana_cart/core/common%20repo/subcategory/subcategory_notifier.dart';
import 'package:sadhana_cart/core/skeletonizer/subcategory_loader.dart';
import 'package:sadhana_cart/features/sub%20category/widget/subcategory_tile.dart';

class SubcategoryPage extends ConsumerStatefulWidget {
  final String categoryName;
  const SubcategoryPage({super.key, required this.categoryName});

  @override
  ConsumerState<SubcategoryPage> createState() => _SubcategoryPageState();
}

class _SubcategoryPageState extends ConsumerState<SubcategoryPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref
          .read(subcategoryProvider.notifier)
          .fetchSubcategoryByCategoryName(categoryName: widget.categoryName);
    });
  }

  @override
  Widget build(BuildContext context) {
    final subcategory = ref.watch(subcategoryProvider);

    if (subcategory.isLoading) {
      return const SubcategoryLoader();
    }
    if (subcategory.error != null) {
      return const Center(child: Text("Error"));
    }
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          widget.categoryName,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: const Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Text(
              "Subcategory",
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SubcategoryTile(),
          ],
        ),
      ),
    );
  }
}
