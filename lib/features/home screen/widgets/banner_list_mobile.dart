import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sadhana_cart/core/common%20repo/banner/banner_notifier.dart';
import 'package:sadhana_cart/core/skeletonizer/banner_loader.dart';

class BannerListMobile extends ConsumerWidget {
  const BannerListMobile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Size size = MediaQuery.of(context).size;
    Future.microtask(() {
      ref.read(bannerProvider.notifier).initBanners();
    });

    final bannerState = ref.watch(bannerProvider);

    if (bannerState.isLoading) {
      return const BannerLoader();
    }
    if (bannerState.banner!.isEmpty) {
      return Center(child: Text(bannerState.error!));
    }
    if (bannerState.banner?.length == 1) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: CachedNetworkImage(
          imageUrl: bannerState.banner![0].image,
          fit: BoxFit.cover,
          width: double.infinity,
          errorWidget: (context, error, stackTrace) {
            return Container(
              color: Colors.grey[200],
              alignment: Alignment.center,
              child: const Icon(Icons.broken_image, size: 40),
            );
          },
        ),
      );
    }
    return CarouselSlider(
      items: bannerState.banner!
          .map(
            (e) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: CachedNetworkImage(
                  imageUrl: e.image,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  errorWidget: (context, error, stackTrace) {
                    return Container(
                      color: Colors.grey[200],
                      alignment: Alignment.center,
                      child: const Icon(Icons.broken_image, size: 40),
                    );
                  },
                ),
              ),
            ),
          )
          .toList(),
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
    );
  }
}
