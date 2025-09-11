import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sadhana_cart/core/common%20model/product/product_model.dart';
import 'package:sadhana_cart/core/disposable/disposable.dart';
import 'package:sadhana_cart/core/widgets/custom_check_box.dart';
import 'package:sadhana_cart/core/widgets/custom_elevated_button.dart';
import 'package:sadhana_cart/core/widgets/custom_text_button.dart';
import 'package:sadhana_cart/features/order%20confirm/widget/payment/controller/payment_controller.dart';
import 'package:sadhana_cart/features/order%20confirm/widget/payment/widget/payment_option_tile.dart';
import 'package:sadhana_cart/features/profile/widget/address/model/address_model.dart';
import 'package:sadhana_cart/features/profile/widget/address/view%20model/address_notifier.dart';

enum PaymentMethod { cash, online }

class PaymentMainPage extends ConsumerStatefulWidget {
  final ProductModel product;
  const PaymentMainPage({super.key, required this.product});

  @override
  ConsumerState<PaymentMainPage> createState() => _PaymentMainPageState();
}

class _PaymentMainPageState extends ConsumerState<PaymentMainPage> {
  int currentStep = 0;
  PaymentMethod? _selectedMethod;

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
    // Fetch addresses safely after first frame
    Future.microtask(() {
      ref.read(addressprovider.notifier).updateAddress();
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final product = widget.product;
    final paymentController = ref.read(paymentProvider.notifier);

    // Watch address state
    final addressState = ref.watch(addressprovider);
    final AddressModel? address = addressState.addresses.isNotEmpty
        ? addressState.addresses.first
        : null;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Checkout"),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      bottomNavigationBar: Expanded(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: CustomElevatedButton(
            child: Text(
              currentStep == 0 ? "Next" : "Confirm Payment",
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
            onPressed: () {
              if (currentStep == 0) {
                _goToStep(1); // Move to payment step
              } else {
                if (_selectedMethod != null) {
                  if (_selectedMethod == PaymentMethod.cash) {
                    // Cash on Delivery selected
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Payment Selected: Cash On Delivery"),
                      ),
                    );
                  } else if (_selectedMethod == PaymentMethod.online) {
                    // Online Payment selected
                    final acceptedTerms = ref.read(orderAcceptTerms);
                    if (acceptedTerms) {
                      // Amount in paise, example ₹1 = 100 paise
                      paymentController.startPayment(amount: 100);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Please accept Terms & Conditions"),
                        ),
                      );
                    }
                  }
                }
              }
            },
          ),
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
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                            ? const Center(child: CircularProgressIndicator())
                            : address != null
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.person_outlined,
                                        color: Colors.grey[600],
                                      ),
                                      Text(
                                        " ${address.name}",
                                        style: const TextStyle(fontSize: 16),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.phone_outlined,
                                        color: Colors.grey[600],
                                      ),
                                      Text(
                                        " ${address.phoneNumber}",
                                        style: const TextStyle(fontSize: 16),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.location_on_outlined,
                                        color: Colors.grey[600],
                                      ),
                                      Flexible(
                                        child: Text(
                                          "${address.streetName},${address.city},${address.state},${address.pinCode}"
                                              .replaceAll(
                                                ',',
                                                ',\u200B',
                                              ), // zero-width space after commas
                                          style: const TextStyle(fontSize: 16),
                                          softWrap: true,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              )
                            : const Text("No address found"),
                      ),
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                        price: "₹${product.price ?? 0}",
                        selected: _selectedMethod == PaymentMethod.cash,
                        onTap: () {
                          setState(() {
                            _selectedMethod = PaymentMethod.cash;
                          });
                        },
                      ),
                      const SizedBox(height: 16),
                      PaymentOptionTile(
                        title: "Online Payment",
                        description: "Pay now using card or UPI",
                        price: "₹${product.price ?? 0}",
                        selected: _selectedMethod == PaymentMethod.online,
                        onTap: () {
                          setState(() {
                            _selectedMethod = PaymentMethod.online;
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
      ),
    );
  }
}


/*

Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                if (currentStep == 1)
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => _goToStep(0),
                      style: OutlinedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 50),
                      ),
                      child: const Text("Back"),
                    ),
                  ),
                if (currentStep == 1) const SizedBox(width: 16),
                Expanded(
                  child: CustomElevatedButton(
                    child: Text(
                      currentStep == 0 ? "Next" : "Confirm Payment",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    onPressed: () {
                      if (currentStep == 0) {
                        _goToStep(1);
                      } else {
                        if (_selectedMethod != null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                "Payment Selected: ${_selectedMethod == PaymentMethod.cash ? "Cash On Delivery" : "Online Payment"}",
                              ),
                            ),
                          );
                        }
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
          */