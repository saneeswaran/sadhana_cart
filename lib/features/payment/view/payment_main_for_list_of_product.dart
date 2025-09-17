import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sadhana_cart/core/colors/app_color.dart';
import 'package:sadhana_cart/core/common%20model/cart/cart_model.dart';
import 'package:sadhana_cart/core/common%20model/order/order_model.dart';
import 'package:sadhana_cart/core/common%20model/product/product_model.dart';
import 'package:sadhana_cart/core/common%20model/product/size_variant.dart';
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
import 'package:sadhana_cart/features/order%20confirm/widget/payment/widget/payment_option_tile.dart';
import 'package:sadhana_cart/features/payment/service/payment_service.dart';
import 'package:sadhana_cart/features/payment/view/order_address.dart';
import 'package:sadhana_cart/features/profile/widget/address/model/address_model.dart';
import 'package:sadhana_cart/features/profile/widget/address/view%20model/address_notifier.dart';

class PaymentMainForListOfProduct extends ConsumerStatefulWidget {
  final List<ProductModel> products;
  final List<CartModel> cart;
  final double totalAmount;

  const PaymentMainForListOfProduct({
    super.key,
    required this.cart,
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

  @override
  Widget build(BuildContext context) {
    // Build orderProduct list here once per build
    final List<OrderProductModel> orderProduct = [];

    for (int i = 0; i < widget.cart.length; i++) {
      final CartModel cartItem = widget.cart[i];
      final ProductModel product = widget.products[i];

      final pricePerItem = product.offerprice ?? 0.0;
      final totalPrice = cartItem.quantity * pricePerItem;

      final OrderProductModel model = OrderProductModel(
        productid: product.productid!,
        name: product.name!,
        price: totalPrice.toDouble(),
        stock: product.stock ?? 0,
        quantity: cartItem.quantity,
        sizevariants: [
          SizeVariant(size: cartItem.size ?? "", stock: cartItem.quantity),
        ],
      );

      orderProduct.add(model);
    }

    // Listen to payment state changes
    ref.listen<PaymentState>(paymentProvider, (previous, next) async {
      if (next.success) {
        debugPrint("Online Payment Success!");

        // Make sure addresses are up to date
        final addressState = ref.read(addressprovider);
        if (addressState.addresses.isEmpty) {
          await ref.read(addressprovider.notifier).updateAddress();
        }
        final updatedAddressState = ref.read(addressprovider);
        final AddressModel? address = updatedAddressState.addresses.isNotEmpty
            ? updatedAddressState.addresses.first
            : null;

        if (address != null) {
          final success = await OrderService.addMultipleProductOrder(
            totalAmount: widget.totalAmount,
            address:
                "${address.title}, ${address.streetName}, ${address.city}, ${address.state}, ${address.pinCode}",
            phoneNumber: address.phoneNumber ?? 0,
            latitude: address.lattitude,
            longitude: address.longitude,
            orderDate: DateTime.now().toString(),
            quantity: 1,
            products: orderProduct,
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
        } else {
          log("Address is null or empty");
          if (context.mounted) {
            showCustomSnackbar(
              context: context,
              message: "Address not found. Please add an address.",
              type: ToastType.error,
            );
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

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Checkout",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
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
                PaymentService.handlePayment(
                  context: context,
                  selectedMethod: _selectedMethod!,
                  products: orderProduct,
                  quantity: 1,
                  ref: ref,
                );
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
      body: Column(
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
                              ? AppColor.dartPrimaryColor
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
                            ? AppColor.dartPrimaryColor
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

          // PageView with steps
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
                      Expanded(
                        child: ListView.builder(
                          itemCount: widget.products.length,
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            final product = widget.products[index];
                            final cart = widget.cart[index];
                            final pricePerItem = product.offerprice ?? 0.0;
                            final specificProductPrice =
                                cart.quantity * pricePerItem;
                            return Container(
                              margin: const EdgeInsets.all(5),
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.shade300,
                                    blurRadius: 5,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Row(
                                children: [
                                  SizedBox(
                                    height: 90,
                                    width: 60,
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
                                          "₹ ${pricePerItem.toStringAsFixed(2)} x ${cart.quantity} = ₹ ${specificProductPrice.toStringAsFixed(2)}",
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
                      ),

                      // User details / Address widget
                      const OrderAddress(),
                      // You can add an edit address button here if needed
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
                        selected: _selectedMethod == PaymentEnum.online.label,
                        onTap: () {
                          setState(() {
                            _selectedMethod = PaymentEnum.online.label;
                          });
                        },
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          const SizedBox(width: 20),
                          Consumer(
                            builder: (context, ref, child) {
                              final value = ref.watch(orderAcceptTerms);
                              return CustomCheckBox(
                                value: value,
                                onChanged: (newValue) {
                                  ref.read(orderAcceptTerms.notifier).state =
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
                            onPressed: () {
                              // Implement navigation to terms page here
                            },
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
      ),
    );
  }
}
