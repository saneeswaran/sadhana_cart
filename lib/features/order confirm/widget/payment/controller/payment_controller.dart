import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:sadhana_cart/features/order%20confirm/widget/payment/controller/payment_state.dart';

final paymentProvider = StateNotifierProvider<PaymentController, PaymentState>(
  (ref) => PaymentController(),
);

class PaymentController extends StateNotifier<PaymentState> {
  late Razorpay _razorpay;

  PaymentController() : super(PaymentState.initial()) {
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    _razorpay.clear();
    super.dispose();
  }

  void startPayment({required int amount}) {
    state = state.copyWith(isLoading: true);
    amount = amount * 100;
    var options = {
      'key': 'demokey',
      'amount': amount, // in paise
      'name': 'Sadhana Cart',
      'description': 'Order Payment',
      'prefill': {'contact': '1234567890', 'email': 'abcd@gmail.com'},
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    state = state.copyWith(
      isLoading: false,
      success: true,
      paymentId: response.paymentId,
    );
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    state = state.copyWith(isLoading: false, error: response.message);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Optional handling for wallets
  }
}
