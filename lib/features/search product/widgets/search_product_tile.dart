import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:collection/collection.dart';
import 'package:sadhana_cart/core/common%20model/product/product_model.dart';
import 'package:sadhana_cart/core/common%20repo/favorite/fav_model_notifier.dart';
import 'package:sadhana_cart/core/common%20services/favorite/favorite_service.dart';
import 'package:sadhana_cart/core/widgets/snack_bar.dart';
import 'package:sadhana_cart/core/constants/constants.dart';

class SearchProductTile extends ConsumerWidget {
  final ScrollController? controller; // ✅ Added
  final List<ProductModel> products;
  final bool isLoadingMore;
  final void Function(ProductModel)? onTap;

  const SearchProductTile({
    super.key,
    this.controller,
    required this.products,
    this.onTap,
    this.isLoadingMore = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Size size = MediaQuery.of(context).size;

    if (products.isEmpty) {
      return const Center(child: Text("No products found"));
    }

    return GridView.builder(
      controller: controller, // ✅ use controller for pagination
      physics: const BouncingScrollPhysics(),
      shrinkWrap: true,
      itemCount: isLoadingMore ? products.length + 1 : products.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.65,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemBuilder: (context, index) {
        if (index >= products.length) {
          return const Center(child: CircularProgressIndicator());
        }

        final product = products[index];

        return GestureDetector(
          onTap: () => onTap?.call(product),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: size.height * 0.22,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  image: product.images != null && product.images!.isNotEmpty
                      ? DecorationImage(
                          image: CachedNetworkImageProvider(
                            product.images!.first,
                            cacheKey: product.productid,
                          ),
                          fit: BoxFit.cover,
                        )
                      : null,
                  color: product.images == null || product.images!.isEmpty
                      ? Colors.grey.shade200
                      : null,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      blurRadius: 6,
                      offset: const Offset(2, 4),
                    ),
                  ],
                ),
                child: Align(
                  alignment: Alignment.topRight,
                  child: Consumer(
                    builder: (context, ref, child) {
                      final favSet = ref.watch(favoriteModelProvider);
                      final model = favSet.firstWhereOrNull(
                        (e) => e.productid == product.productid,
                      );

                      final favoriteId = model?.favoriteId;

                      return IconButton(
                        style: IconButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: const CircleBorder(),
                        ),
                        onPressed: () async {
                          if (favoriteId == null) return;

                          final bool isSuccess =
                              await FavoriteService.deleteFavorite(
                                favoriteId: favoriteId,
                                product: product,
                                ref: ref,
                              );

                          if (isSuccess && context.mounted) {
                            showCustomSnackbar(
                              type: ToastType.success,
                              message: "Removed from favorites",
                              context: context,
                            );
                          }
                        },
                        icon: Icon(
                          Icons.favorite,
                          color: favoriteId != null ? Colors.red : Colors.grey,
                        ),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                product.name ?? '',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                "${Constants.indianCurrency} ${product.price?.toStringAsFixed(0) ?? '0'}",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
