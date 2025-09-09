import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sadhana_cart/core/common%20repo/subcategory/subcategory_notifier.dart';

class SubcategoryPage extends ConsumerStatefulWidget {
  final String categoryName;
  const SubcategoryPage({super.key, required this.categoryName});

  @override
  ConsumerState<SubcategoryPage> createState() => _SubcategoryPageState();
}

class _SubcategoryPageState extends ConsumerState<SubcategoryPage> {
  @override
  void initState() {
    Future.microtask(() {
      ref.read(getSpecificSubcategoryByCategoryProvider(widget.categoryName));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
