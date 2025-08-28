import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sadhana_cart/core/common%20repo/banner_notifier.dart';
import 'package:sadhana_cart/core/disposable/disposable.dart';
import 'package:skeletonizer/skeletonizer.dart';

class BannerListMobile extends ConsumerWidget {
  const BannerListMobile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final banner = ref.watch(bannerProvider);
    final loading = ref.watch(loadingProvider);
    final Size size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height * 0.3,
      width: size.width * 1,
      child: loading
          ? Skeletonizer(
              child: SizedBox(height: size.height * 0.3, width: size.width * 1),
            )
          : CarouselSlider(
              items: banner.map((e) => Image.network(e.bannerImage)).toList(),
              options: CarouselOptions(
                aspectRatio: 16 / 9,
                scrollPhysics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
              ),
            ),
    );
  }
}
