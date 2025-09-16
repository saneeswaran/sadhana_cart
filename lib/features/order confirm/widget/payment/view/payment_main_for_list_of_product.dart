import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sadhana_cart/core/common%20model/product/product_model.dart';
import 'package:sadhana_cart/core/common%20repo/cart/cart_notifier.dart';
import 'package:sadhana_cart/core/common%20services/order/order_service.dart';
import 'package:sadhana_cart/core/disposable/disposable.dart';
import 'package:sadhana_cart/core/enums/payment_enum.dart';
import 'package:sadhana_cart/core/helper/navigation_helper.dart';
import 'package:sadhana_cart/core/widgets/custom_check_box.dart';
import 'package:sadhana_cart/core/widgets/custom_elevated_button.dart';
import 'package:sadhana_cart/core/widgets/custom_text_button.dart';
import 'package:sadhana_cart/core/widgets/snack_bar.dart';
import 'package:sadhana_cart/features/order%20confirm/widget/payment/controller/payment_controller.dart';
import 'package:sadhana_cart/features/order%20confirm/widget/payment/controller/payment_state.dart';
import 'package:sadhana_cart/features/order%20confirm/widget/payment/view/payment_success_page.dart';
import 'package:sadhana_cart/features/order%20confirm/widget/payment/view/update_location_page.dart';
import 'package:sadhana_cart/features/order%20confirm/widget/payment/widget/payment_option_tile.dart';
import 'package:sadhana_cart/features/profile/widget/address/model/address_model.dart';
import 'package:sadhana_cart/features/profile/widget/address/view%20model/address_notifier.dart';

class PaymentMainForListOfProduct extends ConsumerStatefulWidget {
  final List<ProductModel> products;
  final double totalAmount;
  const PaymentMainForListOfProduct({
    super.key,
    required this.products,
    required this.totalAmount,
  });

  @override
  ConsumerState<PaymentMainForListOfProduct> createState() =>
      _PaymentMainPageState();
}

class _PaymentMainPageState extends ConsumerState<PaymentMainForListOfProduct> {
  int currentStep = 0;
  String? _selectedMethod;

  final PageController _pageController = PageController();

  void _goToStep(int step) {
    setState(() {
      currentStep = step;
    });
    _pageController.animateToPage(
      step,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(addressprovider.notifier).updateAddress();
    });
  }

  Future<void> _handlePayment() async {
    final cartNotifier = ref.watch(cartProvider.notifier);
    final totalAmount = cartNotifier.getCartTotalAmount();
    final addressState = ref.read(addressprovider);
    final AddressModel? address = addressState.addresses.isNotEmpty
        ? addressState.addresses.last
        : null;

    if (address == null) {
      showCustomSnackbar(
        context: context,
        message: "Please add an address first.",
        type: ToastType.info,
      );
      return;
    }

    if (_selectedMethod == PaymentEnum.cash.label) {
      showCustomSnackbar(
        context: context,
        message: "Payment Selected: Cash On Delivery",
        type: ToastType.info,
      );

      // Add order to Firestore
      final success = await OrderService.addOrder(
        totalAmount: totalAmount,
        address:
            "${address.title}, ${address.streetName}, ${address.city}, ${address.state}, ${address.pinCode}",
        phoneNumber: address.phoneNumber ?? 0,
        latitude: address.lattitude,
        longitude: address.longitude,
        orderDate: DateTime.now().toString(),
        quantity: 1,
        products: widget.products,
        createdAt: Timestamp.now(),
        ref: ref,
      );

      if (success) {
        log("Order placed successfully (Cash On Delivery)");
        if (!mounted) return;
        showCustomSnackbar(
          context: context,
          message: "Order placed successfully!",
          type: ToastType.success,
        );
      } else {
        log(" Failed to place order (Cash On Delivery)");
        if (!mounted) return;
        showCustomSnackbar(
          context: context,
          message: "Failed to place order",
          type: ToastType.error,
        );
      }

      navigateToReplacement(
        context: context,
        screen: const PaymentSuccessPage(),
      );
    } else if (_selectedMethod == PaymentEnum.online.label) {
      final acceptedTerms = ref.read(orderAcceptTerms);
      if (!acceptedTerms) {
        showCustomSnackbar(
          context: context,
          message: "Please accept Terms & Conditions",
          type: ToastType.info,
        );
        return;
      }

      final paymentController = ref.read(paymentProvider.notifier);
      paymentController.startPayment(amount: totalAmount.toDouble());
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    // Watch address state
    final addressState = ref.watch(addressprovider);
    final AddressModel? address = addressState.addresses.isNotEmpty
        ? addressState.addresses.last
        : null;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Checkout"),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: CustomElevatedButton(
          child: Text(
            currentStep == 0 ? "Next" : "Confirm Payment",
            style: const TextStyle(color: Colors.white, fontSize: 16),
          ),
          onPressed: () {
            if (currentStep == 0) {
              _goToStep(1);
            } else {
              if (_selectedMethod != null) {
                _handlePayment();
              } else {
                showCustomSnackbar(
                  context: context,
                  message: "Please select a payment method",
                  type: ToastType.info,
                );
              }
            }
          },
        ),
      ),
      body: Consumer(
        builder: (context, ref, _) {
          ref.listen<PaymentState>(paymentProvider, (previous, next) async {
            if (next.success) {
              debugPrint("Online Payment Success!");

              // Prepare order details
              final addressState = ref.read(addressprovider);
              final AddressModel? address = addressState.addresses.isNotEmpty
                  ? addressState.addresses.last
                  : null;

              if (address != null) {
                final success = await OrderService.addOrder(
                  totalAmount: widget.totalAmount,
                  address:
                      "${address.title}, ${address.streetName}, ${address.city}, ${address.state}, ${address.pinCode}",
                  phoneNumber: address.phoneNumber ?? 0,
                  latitude: address.lattitude,
                  longitude: address.longitude,
                  orderDate: DateTime.now().toString(),
                  quantity: 1,
                  products: widget.products,
                  createdAt: Timestamp.now(),
                  ref: ref,
                );

                if (success) {
                  log("Order placed successfully");

                  if (context.mounted) {
                    showCustomSnackbar(
                      context: context,
                      message: "Order placed successfully",
                      type: ToastType.success,
                    );
                  }
                } else {
                  log("Failed to place order");
                  if (context.mounted) {
                    showCustomSnackbar(
                      context: context,
                      message: "Failed to place order",
                      type: ToastType.error,
                    );
                  }
                }
              }

              if (context.mounted) {
                navigateToReplacement(
                  context: context,
                  screen: const PaymentSuccessPage(),
                );
              }
            }
          });
          return Column(
            children: [
              // Step indicator
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          InkWell(
                            onTap: () => _goToStep(0),
                            child: CircleAvatar(
                              radius: 15,
                              backgroundColor: currentStep == 0
                                  ? Colors.blue
                                  : Colors.grey,
                              child: const Text(
                                "1",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                          const SizedBox(height: 4),
                          const Text("Step 1"),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 15,
                            backgroundColor: currentStep == 1
                                ? Colors.blue
                                : Colors.grey,
                            child: const Text(
                              "2",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          const SizedBox(height: 4),
                          const Text("Step 2"),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              Expanded(
                child: PageView(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: _pageController,
                  children: [
                    // Step 1: Product + User Details
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Product Tile
                          ListView.builder(
                            itemBuilder: (context, index) {
                              final product = widget.products[index];
                              return Container(
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.grey.shade300,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      height: 90,
                                      width: 60,
                                      color: Colors.grey.shade300,
                                      child:
                                          product.images != null &&
                                              product.images!.isNotEmpty
                                          ? Image.network(
                                              product.images![0],
                                              fit: BoxFit.fitHeight,
                                            )
                                          : null,
                                    ),
                                    const SizedBox(width: 16),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            product.name ?? "Product Name",
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const SizedBox(height: 8),
                                          Text(
                                            "₹ ${product.price ?? 0}",
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                          const SizedBox(height: 20),

                          // User details
                          Container(
                            width: size.width,
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey.shade300),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: addressState.isLoading
                                ? const Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : address != null
                                ? Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.person_outlined,
                                            color: Colors.grey[600],
                                          ),
                                          Text(
                                            " ${address.name}",
                                            style: const TextStyle(
                                              fontSize: 16,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 14),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.phone_outlined,
                                            color: Colors.grey[600],
                                          ),
                                          Text(
                                            " ${address.phoneNumber}",
                                            style: const TextStyle(
                                              fontSize: 16,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 14),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Icon(
                                            Icons.location_city,
                                            color: Colors.grey[600],
                                          ),
                                          Flexible(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  address.title ?? "",
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                  ),
                                                ),
                                                Text(
                                                  "${address.streetName},${address.city},${address.state},${address.pinCode}"
                                                      .replaceAll(
                                                        ',',
                                                        ',\u200B',
                                                      ),
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                  ),
                                                  softWrap: true,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  )
                                : const Text("No address found"),
                          ),
                          GestureDetector(
                            onTap: () {
                              navigateTo(
                                context: context,
                                screen: const UpdateLocationPage(),
                              );
                            },
                            child: Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey.shade300),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Edit Address",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  Icon(
                                    Icons.edit_location_alt_outlined,
                                    color: Colors.blue,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Step 2: Payment Method
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Select Payment Method",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 20),
                          PaymentOptionTile(
                            title: "Cash On Delivery",
                            description: "Pay when you receive your product",
                            price: "₹${widget.totalAmount}",
                            selected: _selectedMethod == PaymentEnum.cash.label,
                            onTap: () {
                              setState(() {
                                _selectedMethod = PaymentEnum.cash.label;
                              });
                            },
                          ),
                          const SizedBox(height: 16),
                          PaymentOptionTile(
                            title: "Online Payment",
                            description: "Pay now using card or UPI",
                            price: "₹${widget.totalAmount}",
                            selected:
                                _selectedMethod == PaymentEnum.online.label,
                            onTap: () {
                              setState(() {
                                _selectedMethod = PaymentEnum.online.label;
                              });
                            },
                          ),
                          Row(
                            children: [
                              const SizedBox(width: 20),
                              Consumer(
                                builder: (context, ref, child) {
                                  final value = ref.watch(orderAcceptTerms);
                                  return CustomCheckBox(
                                    value: value,
                                    onChanged: (newValue) {
                                      ref
                                              .read(orderAcceptTerms.notifier)
                                              .state =
                                          newValue!;
                                    },
                                  );
                                },
                              ),
                              const Text(
                                "I agree to",
                                style: TextStyle(fontSize: 16),
                              ),
                              CustomTextButton(
                                text: "Terms and Conditions",
                                onPressed: () {},
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
