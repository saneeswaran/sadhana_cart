import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sadhana_cart/features/profile/widget/payment/view%20model/wallet_loading_page.dart';
import 'package:sadhana_cart/features/profile/widget/payment/view%20model/wallet_notifier.dart';

class ListWalletPage extends ConsumerWidget {
  const ListWalletPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final walletData = ref.watch(walletStateProvider);

    Future.microtask(() {
      ref.read(walletStateProvider.notifier).fetchWallet();
    });

    if (walletData.isLoading) {
      return const WalletLoadingPage();
    }

    if (walletData.error!.isNotEmpty) {
      return Center(child: Text(walletData.error.toString()));
    }
    return Expanded(
      child: CarouselSlider(
        items: walletData.wallet
            .map(
              (e) => CreditCardWidget(
                cardNumber: e.maskedNumber,
                expiryDate: e.expiryDate,
                cardHolderName: e.cardHolderName,
                cvvCode: e.paymentToken,
                showBackView: false,
                onCreditCardWidgetChange: (_) {},
              ),
            )
            .toList(),
        options: CarouselOptions(
          height: 200,
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
