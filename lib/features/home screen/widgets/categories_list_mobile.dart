import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sadhana_cart/core/colors/app_colors.dart';
import 'package:sadhana_cart/core/common%20repo/category/category_notifier.dart';
import 'package:sadhana_cart/core/disposable/disposable.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CategoriesListMobile extends ConsumerWidget {
  const CategoriesListMobile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final category = ref.watch(categoryProvider);
    final loader = ref.watch(loadingProvider);
    final Size size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height * 0.1,
      width: size.width * 1,
      child: ListView.builder(
        itemCount: category.length,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        physics: const ClampingScrollPhysics(),
        itemBuilder: (context, index) {
          final cat = category[index];
          return loader
              ? Skeletonizer(
                  child: Container(
                    height: size.height * 0.06,
                    width: size.width * 0.14,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.grey.shade300,
                    ),
                  ),
                )
              : Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      height: size.height * 0.06,
                      width: size.width * 0.13,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(
                          color: AppColors.primaryColor,
                          width: 0.9,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          height: size.height * 0.06,
                          width: size.width * 0.12,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: CachedNetworkImageProvider(
                                cat.image,
                                cacheKey: cat.id,
                              ),
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        cat.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: AppColors.onboardButtonColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                  ],
                );
        },
      ),
    );
  }
}
