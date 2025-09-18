import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:sadhana_cart/features/order%20confirm/widget/payment/controller/payment_state.dart';

final paymentProvider = StateNotifierProvider<PaymentController, PaymentState>(
  (ref) => PaymentController(),
);

class PaymentController extends StateNotifier<PaymentState> {
  late Razorpay _razorpay;
  bool _isPaymentProcessing = false;

  PaymentController() : super(PaymentState.initial()) {
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }
  void resetPaymentState() {
    state = PaymentState.initial();
    _isPaymentProcessing = false;
  }

  void startPayment({required double amount}) {
    //  state = state.copyWith(isLoading: true);
    state = PaymentState.initial().copyWith(isLoading: true);
    amount = amount * 100;
    var options = {
      'key': 'rzp_live_RF5gE7NCdAsEIs',
      'amount': amount,
      'name': 'Sadhana Cart',
      'description': 'Order Payment',
      'prefill': {'contact': '1234567890', 'email': 'abcd@gmail.com'},
    };

    try {
      _razorpay.open(options);
      log("Razorpay opened for payment of ₹${amount / 100}");
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
      log("Error opening Razorpay: $e");
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    if (_isPaymentProcessing) return; // Prevent multiple triggers
    _isPaymentProcessing = true;

    state = state.copyWith(
      isLoading: false,
      success: true,
      paymentId: response.paymentId,
    );
    log("Payment successful! Payment ID: ${response.paymentId}");
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    if (_isPaymentProcessing) return;
    _isPaymentProcessing = true;
    state = state.copyWith(isLoading: false, error: response.message);
    log(
      "Payment failed or cancelled. Code: ${response.code}, Message: ${response.message}",
    );
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    log("External wallet selected: ${response.walletName}");
  }

  @override
  void dispose() {
    _razorpay.clear();
    super.dispose();
  }
}
