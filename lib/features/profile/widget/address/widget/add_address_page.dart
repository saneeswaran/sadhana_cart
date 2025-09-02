import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sadhana_cart/core/disposable/disposable.dart';
import 'package:sadhana_cart/core/helper/navigation_helper.dart';
import 'package:sadhana_cart/core/widgets/custom_drop_down.dart';
import 'package:sadhana_cart/core/widgets/custom_elevated_button.dart';
import 'package:sadhana_cart/core/widgets/custom_text_form_field.dart';
import 'package:sadhana_cart/core/widgets/loader.dart';
import 'package:sadhana_cart/features/profile/widget/address/model/address_helper.dart';
import 'package:sadhana_cart/features/profile/widget/address/service/address_service.dart';

class AddAddressPage extends StatefulWidget {
  const AddAddressPage({super.key});

  @override
  State<AddAddressPage> createState() => _AddAddressPageState();
}

class _AddAddressPageState extends State<AddAddressPage> {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final streetNameController = TextEditingController();
  final cityController = TextEditingController();
  final stateController = TextEditingController();
  final zipCodeController = TextEditingController();
  final phoneNumberController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    streetNameController.dispose();
    cityController.dispose();
    stateController.dispose();
    zipCodeController.dispose();
    phoneNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Add Address here",
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Consumer(
              builder: (context, ref, child) {
                final icon = ref.watch(userAdderssIconProvider);
                final title = ref.watch(userAddressTitleProvider);
                final loader = ref.watch(loadingProvider);
                return AbsorbPointer(
                  absorbing: loader,
                  child: Column(
                    spacing: 20,
                    children: [
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            child: CustomDropDown<String>(
                              items: AddressHelper.addressPlaces
                                  .map(
                                    (e) => DropdownMenuItem<String>(
                                      value: e,
                                      child: Text(e),
                                    ),
                                  )
                                  .toList(),
                              onChanged: (value) =>
                                  ref
                                          .read(
                                            userAddressTitleProvider.notifier,
                                          )
                                          .state =
                                      value ?? "Home",
                              value: title,
                              labelText: "Select Address Type",
                            ),
                          ),
                          const SizedBox(width: 40),
                          Expanded(
                            child: CustomDropDown<IconData>(
                              items: AddressHelper.icons
                                  .map(
                                    (e) => DropdownMenuItem<IconData>(
                                      value: e,
                                      child: Icon(e),
                                    ),
                                  )
                                  .toList(),
                              onChanged: (value) =>
                                  ref
                                          .read(
                                            userAdderssIconProvider.notifier,
                                          )
                                          .state =
                                      value ?? Icons.home,
                              value: icon,
                              labelText: "Select Address Icon",
                            ),
                          ),
                        ],
                      ),
                      CustomTextFormField(
                        controller: nameController,
                        labelText: "Name",
                      ),
                      CustomTextFormField(
                        controller: streetNameController,
                        labelText: "Street Name",
                      ),
                      CustomTextFormField(
                        controller: cityController,
                        labelText: "City",
                      ),
                      CustomTextFormField(
                        controller: stateController,
                        labelText: "State",
                      ),
                      CustomTextFormField(
                        controller: zipCodeController,
                        keyboardType: TextInputType.number,
                        maxLength: 6,
                        labelText: "Zip Code",
                      ),
                      CustomTextFormField(
                        controller: phoneNumberController,
                        keyboardType: TextInputType.number,
                        maxLength: 10,
                        labelText: "Phone Number",
                      ),

                      const SizedBox(height: 30),
                      CustomElevatedButton(
                        child: const Text(
                          "Get Current Location",
                          style: customElevatedButtonTextStyle,
                        ),
                        onPressed: () {},
                      ),
                      CustomElevatedButton(
                        child: loader
                            ? const Loader()
                            : const Text(
                                "Save",
                                style: customElevatedButtonTextStyle,
                              ),
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            final bool isSuccess =
                                await AddressService.addAddress(
                                  context: context,
                                  name: nameController.text.trim(),
                                  streetName: streetNameController.text.trim(),
                                  city: cityController.text.trim(),
                                  state: stateController.text.trim(),
                                  title: title,
                                  pinCode: int.parse(
                                    zipCodeController.text.trim(),
                                  ),
                                  phoneNumber: int.parse(
                                    phoneNumberController.text.trim(),
                                  ),
                                  icon: icon,
                                  ref: ref,
                                );
                            if (isSuccess && context.mounted) {
                              navigateBack(context: context);
                            }
                          }
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
