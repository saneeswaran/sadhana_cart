import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sadhana_cart/core/common%20model/order/order_model.dart';
import 'package:sadhana_cart/core/common%20model/product/product_model.dart';
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

class PaymentMainPage extends ConsumerStatefulWidget {
  final ProductModel product;
  const PaymentMainPage({super.key, required this.product});

  @override
  ConsumerState<PaymentMainPage> createState() => _PaymentMainPageState();
}

class _PaymentMainPageState extends ConsumerState<PaymentMainPage> {
  int currentStep = 0;
  PaymentEnum? _selectedMethod;

  // Loading
  bool isLoading = false;

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
    // Fetch addresses
    Future.microtask(() {
      ref.read(addressprovider.notifier).updateAddress();
    });
  }

  Future<void> _handlePayment() async {
    setState(() {
      isLoading = true;
    });
    final addressState = ref.read(addressprovider);
    final AddressModel? address = addressState.addresses.isNotEmpty
        ? addressState.addresses.last
        : null;

    if (address == null) {
      showCustomSnackbar(
        context: context,
        message: "Please select address first!",
        type: ToastType.info,
      );

      return;
    }

    if (_selectedMethod == PaymentEnum.cash) {
      // COD flow (save order + purchased products)
      try {
        // Log only the selected product
        log("Purchased Product Details: ${widget.product.toMap()}");

        // Save purchased product into Firestore
        await OrderService.savePurchasedProducts(
          products: [widget.product],
          address: address,
          paymentMethod: "COD",
        );

        if (!mounted) return;
        showCustomSnackbar(
          context: context,
          message: "Order placed successfully!",
          type: ToastType.success,
        );

        navigateToReplacement(
          context: context,
          screen: const PaymentSuccessPage(),
        );
      } catch (e) {
        log("COD error: $e");
        showCustomSnackbar(
          context: context,
          message: "Order placed successfully!",
          type: ToastType.error,
        );
      }
    } else if (_selectedMethod == PaymentEnum.online) {
      setState(() {
        isLoading = false;
      });
      // Online payment flow
      final acceptedTerms = ref.read(orderAcceptTerms);
      if (!acceptedTerms) {
        showCustomSnackbar(
          context: context,
          message: "Please accept terms",
          type: ToastType.info,
        );
        return;
      }

      final paymentController = ref.read(paymentProvider.notifier);
      paymentController.startPayment(
        amount: (widget.product.offerprice ?? 0).toDouble(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final product = widget.product;
    // final paymentController = ref.read(paymentProvider.notifier);

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
        child: isLoading
            ? Container(
                height: MediaQuery.of(context).size.height * 0.07,
                width: MediaQuery.of(context).size.height * 0.07,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(32),
                ),
                child: const Center(
                  child: CircularProgressIndicator(color: Colors.white),
                ),
              )
            : CustomElevatedButton(
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
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Please select a payment method"),
                        ),
                      );
                    }
                  }
                },
              ),
      ),
      body: Consumer(
        builder: (context, ref, _) {
          final OrderProductModel model = OrderProductModel(
            productid: widget.product.productid!,
            name: widget.product.name!,
            price: (widget.product.offerprice ?? 0.0).toDouble(),
            stock: widget.product.stock ?? 0,
            quantity: 1,
          );
          ref.listen<PaymentState>(paymentProvider, (previous, next) async {
            if (next.success) {
              debugPrint("Online Payment Success!");

              // Prepare order details
              final addressState = ref.read(addressprovider);
              final AddressModel? address = addressState.addresses.isNotEmpty
                  ? addressState.addresses.last
                  : null;

              if (address != null) {
                final success = await OrderService.addSingleOrder(
                  totalAmount: (widget.product.offerprice ?? 0.0).toDouble(),
                  address:
                      "${address.title}, ${address.streetName}, ${address.city}, ${address.state}, ${address.pinCode}",
                  phoneNumber: address.phoneNumber ?? 0,
                  latitude: address.lattitude,
                  longitude: address.longitude,
                  quantity: 1,
                  products: [model],
                  createdAt: Timestamp.now(),
                  ref: ref,
                );

                if (success) {
                  log(
                    "Order placed successfully for product: ${widget.product.name}",
                  );

                  if (context.mounted) {
                    showCustomSnackbar(
                      context: context,
                      message: "Order placed successfully",
                      type: ToastType.success,
                    );
                  }
                } else {
                  log(
                    "Failed to place order for product: ${widget.product.name}",
                  );
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
                                  ? Colors.black
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
                                ? Colors.black
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
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey.shade300),
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
                                        "₹ ${product.offerprice ?? 0}",
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
                          ),
                          const SizedBox(height: 16),

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
                                      const SizedBox(height: 16),
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
                          const SizedBox(height: 14),
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
                            price: "₹${product.offerprice ?? 0}",
                            selected: _selectedMethod == PaymentEnum.cash,
                            onTap: () {
                              setState(() {
                                _selectedMethod = PaymentEnum.cash;
                              });
                            },
                          ),
                          const SizedBox(height: 16),
                          PaymentOptionTile(
                            title: "Online Payment",
                            description: "Pay now using card or UPI",
                            price: "₹${product.offerprice ?? 0}",
                            selected: _selectedMethod == PaymentEnum.online,
                            onTap: () {
                              setState(() {
                                _selectedMethod = PaymentEnum.online;
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
