import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sadhana_cart/core/common%20repo/favorite/favorite_notifier.dart';
import 'package:sadhana_cart/core/common%20services/favorite/favorite_service.dart';
import 'package:sadhana_cart/core/constants/constants.dart';
import 'package:sadhana_cart/core/widgets/snack_bar.dart';

class FavoriteProductTile extends ConsumerWidget {
  const FavoriteProductTile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Size size = MediaQuery.of(context).size;
    final fav = ref
        .watch(favoriteProvider.notifier)
        .getFavoriteProducts()
        .toList();

    if (fav.isEmpty) {
      return const Expanded(child: Center(child: Text("No Favorites")));
    }
    return Expanded(
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.6,
        ),
        itemCount: fav.length,
        itemBuilder: (context, index) {
          final favorite = fav[index];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  height: size.height * 0.25,
                  width: size.width * 0.4,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    image: DecorationImage(
                      image: CachedNetworkImageProvider(
                        favorite.images[0],
                        cacheKey: favorite.productId,
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                      style: IconButton.styleFrom(
                        backgroundColor: Colors.white,
                        elevation: 1,
                        shape: const CircleBorder(),
                      ),
                      onPressed: () {
                        _likedOnPress(
                          context: context,
                          ref: ref,
                          favoriteId: favorite.productId,
                        );
                      },
                      icon: const Icon(Icons.favorite, color: Colors.red),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  favorite.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  "${Constants.indianCurrency} ${favorite.offerPrice}",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  void _likedOnPress({
    required String favoriteId,
    required WidgetRef ref,
    required BuildContext context,
  }) async {
    final bool isSuccess = await FavoriteService.deleteFavorite(
      favoriteId: favoriteId,
      ref: ref,
    );
    if (isSuccess && context.mounted) {
      successSnackBar(message: "Removed from favorites", context: context);
    }
  }
}
