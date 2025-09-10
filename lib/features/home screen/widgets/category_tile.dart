import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
<<<<<<< HEAD
import 'package:sadhana_cart/core/common%20repo/dummy_product.dart';
import 'package:sadhana_cart/core/ui_template/catagories/category_list_page.dart';
=======
import 'package:sadhana_cart/core/common%20repo/category/category_notifier.dart';
>>>>>>> 765a30664c52cb183c2304584bf5a6dcc740c6f6

class CategoryTile extends ConsumerWidget {
  const CategoryTile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final categories = ref.watch(categoryProvider);
    return SizedBox(
      height: size.height * 0.2,
      width: size.width,
      child: ListView.builder(
        itemCount: categories.length,
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        itemBuilder: (context, index) {
          final category = categories[index];

          return GestureDetector(
<<<<<<< HEAD
            onTap: () {
              // Collect all products under this category
              final categoryProducts = category.subcategories
                  .expand((subcat) => subcat.products)
                  .toList();

              // Navigate to CategoryListPage with filtered products
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CategoryListPage(
                    title: category.name,
                    products: categoryProducts,
                  ),
                ),
              );
            },
=======
            onTap: () {},
>>>>>>> 765a30664c52cb183c2304584bf5a6dcc740c6f6
            child: Container(
              margin: const EdgeInsets.only(right: 12),
              width: size.width * 0.35,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12.withOpacity(0.05),
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(12),
                      ),
                      child: CachedNetworkImage(
                        imageUrl: category.image,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    alignment: Alignment.center,
                    child: Text(
                      category.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
