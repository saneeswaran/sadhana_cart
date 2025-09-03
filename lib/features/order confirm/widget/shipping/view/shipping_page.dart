import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sadhana_cart/core/disposable/disposable.dart';
import 'package:sadhana_cart/core/helper/validation_helper.dart';
import 'package:sadhana_cart/core/widgets/custom_elevated_button.dart';
import 'package:sadhana_cart/core/widgets/custom_text_form_field.dart';
import 'package:sadhana_cart/core/widgets/loader.dart';
import 'package:sadhana_cart/features/order%20confirm/widget/shipping/widget/saved_address_page.dart';
import 'package:sadhana_cart/features/profile/widget/address/model/address_model.dart';

class ShippingPage extends ConsumerStatefulWidget {
  const ShippingPage({super.key});

  @override
  ConsumerState<ShippingPage> createState() => _ShippingPageState();
}

class _ShippingPageState extends ConsumerState<ShippingPage> {
  final nameController = TextEditingController();
  final streetController = TextEditingController();
  final cityController = TextEditingController();
  final stateController = TextEditingController();
  final zipCodeController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    nameController.dispose();
    streetController.dispose();
    cityController.dispose();
    stateController.dispose();
    zipCodeController.dispose();
    phoneNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loader = ref.watch(loadingProvider);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 15.0),
              child: Text(
                "Step 1 of 3",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 25),
              child: Text(
                "Shipping",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    spacing: 20,
                    children: [
                      CustomTextFormField(
                        controller: nameController,
                        labelText: "Name",
                        validator: ValidationHelper.validateTextField(
                          text: "Name",
                        ),
                      ),
                      CustomTextFormField(
                        controller: streetController,
                        labelText: "Street",
                        validator: ValidationHelper.validateTextField(
                          text: "Street",
                        ),
                      ),
                      CustomTextFormField(
                        controller: cityController,
                        labelText: "City",
                        validator: ValidationHelper.validateTextField(
                          text: "City",
                        ),
                      ),

                      CustomTextFormField(
                        controller: stateController,
                        labelText: "State",
                        validator: ValidationHelper.validateTextField(
                          text: "State",
                        ),
                      ),
                      CustomTextFormField(
                        controller: zipCodeController,
                        labelText: "Zip Code",
                        maxLength: 6,
                        keyboardType: TextInputType.number,
                        validator: ValidationHelper.validateTextField(
                          text: "Zip Code",
                        ),
                      ),

                      CustomTextFormField(
                        controller: phoneNumberController,
                        labelText: "Phone Number",
                        keyboardType: TextInputType.number,
                        maxLength: 10,
                        validator: ValidationHelper.validateTextField(
                          text: "Phone Number",
                        ),
                      ),
                      CustomElevatedButton(
                        child: loader
                            ? const Loader()
                            : const Text(
                                "Use Saved Address",
                                style: customElevatedButtonTextStyle,
                              ),
                        onPressed: () async {
                          final AddressModel? selected = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const SavedAddressPage(),
                            ),
                          );

                          if (selected != null) {
                            nameController.text = selected.name ?? "";
                            stateController.text = selected.state;
                            cityController.text = selected.city;
                            streetController.text = selected.streetName;
                            zipCodeController.text = selected.pinCode
                                .toString();
                            phoneNumberController.text = selected.phoneNumber
                                .toString();
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
