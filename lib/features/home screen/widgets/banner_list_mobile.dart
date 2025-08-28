import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sadhana_cart/core/constants/app_images.dart';
import 'package:sadhana_cart/core/disposable/disposable.dart';
import 'package:skeletonizer/skeletonizer.dart';

class BannerListMobile extends ConsumerWidget {
  const BannerListMobile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loading = ref.watch(loadingProvider);
    final Size size = MediaQuery.of(context).size;

    return SizedBox(
      height: size.height * 0.3,
      width: size.width,
      child: loading
          ? Skeletonizer(
              child: Container(
                height: size.height * 0.3,
                width: size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.grey[300],
                ),
              ),
            )
          : CarouselSlider.builder(
              itemCount: AppImages.bannerImages.length,
              itemBuilder: (context, index, realIndex) {
                final imagePath = AppImages.bannerImages[index].bannerImage;
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      imagePath,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: Colors.grey[200],
                          alignment: Alignment.center,
                          child: const Icon(Icons.broken_image, size: 40),
                        );
                      },
                    ),
                  ),
                );
              },
              options: CarouselOptions(
                height: size.height * 0.3,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 4),
                autoPlayAnimationDuration: const Duration(milliseconds: 800),
                enlargeCenterPage: true,
                viewportFraction: 1,
                aspectRatio: 16 / 9,
                scrollDirection: Axis.horizontal,
                enableInfiniteScroll: true,
                pauseAutoPlayOnTouch: true,
                scrollPhysics: const BouncingScrollPhysics(),
              ),
            ),
    );
  }
}
