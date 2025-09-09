import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sadhana_cart/core/common%20repo/subcategory/subcategory_notifier.dart';
import 'package:sadhana_cart/core/skeletonizer/subcategory_loader.dart';

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
    ref
        .read(subcategoryProvider.notifier)
        .fetchSubcategoryByCategoryName(categoryName: widget.categoryName);
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
    return Scaffold();
  }
}
